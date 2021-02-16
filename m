Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D40031CA9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBPMhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:37:14 -0500
Received: from mail.zx2c4.com ([104.131.123.232]:41916 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229970AbhBPMhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1613478985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvWPHeRu5Ta1ITtaL534RRLVGoWOubmd/7MZ9yEeUuQ=;
        b=RztHKShYzf7YfqsFFHTiHt5XfOXMGAQWWz4aq25hqQR7BL2pEWME2ODedVDqAgZQfipe7S
        7083DgElJ+0Ye50xK5cbZuWUO5tQOruU8TxJFZqy0moj/h1MQVFMMmUeSXlPNOVNuOgWg4
        GzIWcuSv/otj0byrIY1Euv0l7PXSK2M=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f12447e9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 16 Feb 2021 12:36:25 +0000 (UTC)
Date:   Tue, 16 Feb 2021 13:36:22 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Tibor Bana <bana.tibor@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, valdis.kletnieks@vt.edu,
        Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org
Subject: Re: [regression -next0117] What is kcompactd and why is he eating
 100% of my cpu?
Message-ID: <YCu8RuhvU1Env7OF@zx2c4.com>
References: <20190126200005.GB27513@amd>
 <12171.1548557813@turing-police.cc.vt.edu>
 <20190127141556.GB9565@techsingularity.net>
 <20190127160027.GA9340@amd>
 <13417.1548624994@turing-police.cc.vt.edu>
 <20190128091627.GA27972@quack2.suse.cz>
 <14875.1548810399@turing-police.cc.vt.edu>
 <9618.1548822577@turing-police.cc.vt.edu>
 <20190130104020.GE9565@techsingularity.net>
 <20210125195438.c8d0e7980da0c2931d4f3056@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125195438.c8d0e7980da0c2931d4f3056@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 07:54:38PM +0100, Tibor Bana wrote:
> Greetings!
> 
> I don't know if it still actual, but I am strugling with this problem right now and searching the internet for solutions.
> I read the thread and saw that you are strugling to reproduce the problem, and I can reproduce it almost every day.
> 
> - Install vmware player, and a linux guest. 
> - Configure the virtual machine to have a good amount of memory and cpu
> - run resource intensive tasks on the guest
> - when the host used up almost it's all memory and start to reuse caches kcompactd will kick in.
> 
> As I know the problem is related to transparent huge pages, but I tried to disable it. 
> Today I saw the problem again and kcompactd shown an interesting status in top. It hasn't used any memory, all zeroes but it used up one core completely. 
> 
> My machine is a core-i7 with 4 physical cores and hyper threading and 24GB Memory
> 5.9.11-arch2-1 #1 SMP PREEMPT Sat, 28 Nov 2020 02:07:22 +0000 x86_64 GNU/Linux

Another anecdote: 5.11.0, 64 gigs of ram. If I run QEMU/KVM for a VM
with 16 gigs at the same time as a VMware VM with 16 gigs of ram,
kcompact goes wild and both VMs get really slow. The key here is running
KVM at the same time as VMware.

