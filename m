Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4E73A3DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFKIMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:12:54 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:43559 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhFKIMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:12:52 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id E11B618E016
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:10:53 +0100 (IST)
Received: (qmail 5519 invoked from network); 11 Jun 2021 08:10:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Jun 2021 08:10:53 -0000
Date:   Fri, 11 Jun 2021 09:10:52 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm/page_alloc: Allow high-order pages to be stored
 on the per-cpu lists
Message-ID: <20210611081052.GZ30378@techsingularity.net>
References: <20210603142220.10851-1-mgorman@techsingularity.net>
 <20210603142220.10851-3-mgorman@techsingularity.net>
 <88FCC7AA-FAAA-4B87-B382-50BD54B2886B@nvidia.com>
 <20210610111821.GY30378@techsingularity.net>
 <3B44DF44-5669-40B6-A122-011F1A749FAA@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3B44DF44-5669-40B6-A122-011F1A749FAA@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 07:40:47AM -0400, Zi Yan wrote:
> >> My kernel config is attached and my qemu command is:
> >>
> >> qemu-system-x86_64 -kernel ~/repos/linux-1gb-thp/arch/x86/boot/bzImage \
> >>     -drive file=~/qemu-image/vm.qcow2,if=virtio \
> >>     -append "nokaslr root=/dev/vda1 rw console=ttyS0 " \
> >>     -pidfile vm.pid \
> >>     -netdev user,id=mynet0,hostfwd=tcp::11022-:22 \
> >>     -device virtio-net-pci,netdev=mynet0 \
> >>     -m 16g -smp 6 -cpu host -enable-kvm -nographic \
> >>     -machine hmat=on -object memory-backend-ram,size=8g,id=m0 \
> >>     -object memory-backend-ram,size=8g,id=m1 \
> >>     -numa node,memdev=m0,nodeid=0 -numa node,memdev=m1,nodeid=1
> >>
> >> The attached config has THP disabled. The VM cannot boot with THP enabled,
> >> either.
> >>
> >
> > There is not a lot of information to go on here. Can you confirm that a
> > revert of that specific patch from mmotm-2021-06-07-18-33 also boots? It
> > sounds like your console log is empty, does anything useful appear if
> > you add "earlyprintk=serial,ttyS0,115200" to the kernel command line?
> 
> Sure. I can confirm that reverting the patch makes the VM boot.
> The important information I forgot to mention is that after I remove
> the NUMA setting in the QEMU, the VM can boot too.
> 
> earlyprintk gave the error message (page out of zone boundary) when the VM could not boot:
> 

Ok, thanks, that helps. For a page to be out of boundary, I either have
completely screwed the zone handling for PCP or, more likely, pages are
leaking onto the boot pagesets because of the batch count handling. It's
weird I did not see this on NUMA machines but nevertheless, I'll go
find it. It should not take long.

-- 
Mel Gorman
SUSE Labs
