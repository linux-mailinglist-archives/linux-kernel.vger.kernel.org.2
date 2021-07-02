Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10E43BA4E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 23:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhGBVCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:02:48 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:46055 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhGBVCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:02:45 -0400
Received: by mail-io1-f53.google.com with SMTP id g3so11253257iok.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 14:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eJiGAN6TDR6lmwiAYmh3I6OaAmocOou8J1w1pSB9/H0=;
        b=lbVthRRCmFZfD0iM1GHuOEgDpJwG1VR/hp5ZZXovao5T6OksAfswDXK/rK+Lf+6opv
         /Kv3NOGLG7DE6j01QV9qYKHkIQwVXl5gC6GEIkJeAgThk+SrW3CsrUbkpGGNG+RSrbIh
         cwfZDZCfOzhhzh786/5moQ33kt1+DpZrstOMBps4murstRWPL+Ls+doce1mDaILNdIgD
         Kp+WEp2mJutjfBCnFutINATovBp7QOg2OfCsRddXIEcH2kQUXHUfmB7FcbDTtllavFdg
         OyiGECRE3aaQJ6bcayUq2NguLExQJw9wUCxOhLzScmPRiPjDIOzwBtjVyzhkJtPOUOH8
         kLxg==
X-Gm-Message-State: AOAM530Ye73TlCRLHN8xPmrJMur5EDavIScIVA31dDyyR3dlUj+gUH5N
        9GeatpBvqaOnrSvE4J2hRL8=
X-Google-Smtp-Source: ABdhPJyHMRv1obezn+AfX6bOyzQG76tl7I6rKmaqgrj+MqxqdnHnoP4BX96FwzKWiO449bdx4Qvc6Q==
X-Received: by 2002:a5d:9c86:: with SMTP id p6mr1445235iop.24.1625259612732;
        Fri, 02 Jul 2021 14:00:12 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id o7sm2331377ilt.29.2021.07.02.14.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:00:12 -0700 (PDT)
Date:   Fri, 2 Jul 2021 21:00:11 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] percpu: implement partial chunk depopulation
Message-ID: <YN9+W+81xaMeckMi@google.com>
References: <20210419225047.3415425-1-dennis@kernel.org>
 <20210419225047.3415425-4-dennis@kernel.org>
 <20210702191140.GA3166599@roeck-us.net>
 <YN9s5HLjNeb1lxMK@google.com>
 <dc349738-544c-34a1-748f-4e1a2c595a20@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc349738-544c-34a1-748f-4e1a2c595a20@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 01:28:18PM -0700, Guenter Roeck wrote:
> On 7/2/21 12:45 PM, Dennis Zhou wrote:
> > Hello,
> > 
> > On Fri, Jul 02, 2021 at 12:11:40PM -0700, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > On Mon, Apr 19, 2021 at 10:50:46PM +0000, Dennis Zhou wrote:
> > > > From: Roman Gushchin <guro@fb.com>
> > > > 
> > > > This patch implements partial depopulation of percpu chunks.
> > > > 
> > > > As of now, a chunk can be depopulated only as a part of the final
> > > > destruction, if there are no more outstanding allocations. However
> > > > to minimize a memory waste it might be useful to depopulate a
> > > > partially filed chunk, if a small number of outstanding allocations
> > > > prevents the chunk from being fully reclaimed.
> > > > 
> > > > This patch implements the following depopulation process: it scans
> > > > over the chunk pages, looks for a range of empty and populated pages
> > > > and performs the depopulation. To avoid races with new allocations,
> > > > the chunk is previously isolated. After the depopulation the chunk is
> > > > sidelined to a special list or freed. New allocations prefer using
> > > > active chunks to sidelined chunks. If a sidelined chunk is used, it is
> > > > reintegrated to the active lists.
> > > > 
> > > > The depopulation is scheduled on the free path if the chunk is all of
> > > > the following:
> > > >    1) has more than 1/4 of total pages free and populated
> > > >    2) the system has enough free percpu pages aside of this chunk
> > > >    3) isn't the reserved chunk
> > > >    4) isn't the first chunk
> > > > If it's already depopulated but got free populated pages, it's a good
> > > > target too. The chunk is moved to a special slot,
> > > > pcpu_to_depopulate_slot, chunk->isolated is set, and the balance work
> > > > item is scheduled. On isolation, these pages are removed from the
> > > > pcpu_nr_empty_pop_pages. It is constantly replaced to the
> > > > to_depopulate_slot when it meets these qualifications.
> > > > 
> > > > pcpu_reclaim_populated() iterates over the to_depopulate_slot until it
> > > > becomes empty. The depopulation is performed in the reverse direction to
> > > > keep populated pages close to the beginning. Depopulated chunks are
> > > > sidelined to preferentially avoid them for new allocations. When no
> > > > active chunk can suffice a new allocation, sidelined chunks are first
> > > > checked before creating a new chunk.
> > > > 
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > Co-developed-by: Dennis Zhou <dennis@kernel.org>
> > > > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > > 
> > > This patch results in a number of crashes and other odd behavior
> > > when trying to boot mips images from Megasas controllers in qemu.
> > > Sometimes the boot stalls, but I also see various crashes.
> > > Some examples and bisect logs are attached.
> > 
> > Ah, this doesn't look good.. Do you have a reproducer I could use to
> > debug this?
> > 
> 
> I copied the relevant information to http://server.roeck-us.net/qemu/mips/.
> 

This is perfect! I'm able to reproduce it.

> run.sh - qemu command (I tried with qemu 6.0 and 4.2.1)
> rootfs.ext2 - root file system
> config - complete configuration
> defconfig - shortened configuration
> vmlinux - a crashing kernel image (v5.13-7637-g3dbdb38e2869, with above configuration)
> 
> Interestingly, the crash doesn't always happen at the same location, even
> with the same image. Some memory corruption, maybe ?
> 

Well a few factors matter, percpu gets placed in random places. Percpu
allocations may happen in different order and this will cause different
freeing patterns. Then the problem patch may free the wrong backing
page.

I'm working on it, x86 doesn't seem to have any immediate issues
(fingers crossed) so it must be some delta here.

> Hope this helps. Please let me know if I can provide anything else.
> 
> Thanks,
> Guenter

Thanks,
Dennis
