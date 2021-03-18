Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7182340EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhCRUDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:03:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:34858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhCRUCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:02:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1FE62ACA8;
        Thu, 18 Mar 2021 20:02:43 +0000 (UTC)
Date:   Thu, 18 Mar 2021 13:02:33 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     benh@kernel.crashing.org, Davidlohr Bueso <dbueso@suse.de>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        longman@redhat.com, mingo@redhat.com, mpe@ellerman.id.au,
        paulus@samba.org, peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH 3/3] powerpc/qspinlock: Use generic smp_cond_load_relaxed
Message-ID: <20210318200233.zov3wbugbgbj4f73@offworld>
References: <20210309015950.27688-1-dave@stgolabs.net>
 <20210309015950.27688-4-dave@stgolabs.net>
 <1615870473.h7h4jetmjb.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1615870473.h7h4jetmjb.astroid@bobo.none>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, Nicholas Piggin wrote:

>One request, could you add a comment in place that references
>smp_cond_load_relaxed() so this commit can be found again if
>someone looks at it? Something like this
>
>/*
> * smp_cond_load_relaxed was found to have performance problems if
> * implemented with spin_begin()/spin_end().
> */

Sure, let me see where I can fit that in and send out a v2.

Similarly, but unrelated to this patch, is there any chance we could
remove the whole spin_until_cond() machinery and make it specific to
powerpc? This was introduced in 2017 and doesn't really have any users
outside of powerpc, except for these:

drivers/firmware/arm_scmi/driver.c:             spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
drivers/firmware/arm_scmi/shmem.c:      spin_until_cond(ioread32(&shmem->channel_status) &
drivers/net/ethernet/xilinx/ll_temac_main.c:    spin_until_cond(hard_acs_rdy_or_timeout(lp, timeout));

... which afaict only the xilinx one can actually build on powerpc.
Regardless, these could be converted to smp_cond_load_relaxed(), being
the more standard way to do optimized busy-waiting, caring more about
the family of barriers than ad-hoc SMT priorities. Of course, I have
no way of testing any of these changes.

>I wonder if it should have a Fixes: tag to the original commit as
>well.

I'm not sure either. I've actually been informed recently of other
workloads that benefit from the revert on large Power9 boxes. So I'll
go ahead and add it.

>
>Otherwise,
>
>Acked-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Davidlohr
