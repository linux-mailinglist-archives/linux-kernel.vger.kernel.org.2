Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259313FC772
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhHaMnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:43:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59578 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhHaMnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:43:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 275FC20171;
        Tue, 31 Aug 2021 12:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630413741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMFKwbC3zRI4Wv+OmNAS31FmyM1+OTPb9o9hVf120vk=;
        b=UbjCC0mSM8iBeCTkvm52RNf/mfcTeQFjHfrfCJnfCbkdTDL4Ic4GcpCTgFVGN4IZxd8Xxa
        1cKsLcQNCS2HGilU8n8aN0385BPhfDjLrnzLych2QtGXRHJZGCFO8+jOQl1XnmSR/8FEtA
        pJt3/EaPUTG8WcHrKSX0k+37Ma6NVrE=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CDCB4A3B92;
        Tue, 31 Aug 2021 12:42:20 +0000 (UTC)
Date:   Tue, 31 Aug 2021 14:42:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     =?utf-8?B?7J207Jqp7YOd?= <ytk.lee@samsung.com>
Cc:     "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: use kvmalloc instead of kmalloc for devkmsg_user
Message-ID: <YS4jqsSlD7UySNRA@alley>
References: <CGME20210830071701epcms1p70f72ae10940bc407a3c33746d20da771@epcms1p7>
 <20210830071701epcms1p70f72ae10940bc407a3c33746d20da771@epcms1p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210830071701epcms1p70f72ae10940bc407a3c33746d20da771@epcms1p7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-08-30 16:17:01, 이용택 wrote:
> Size of struct devkmsg_user increased to 16784 by commit 896fbe20b4e2
> ("printk: use the lockless ringbuffer") so order3(32kb) is needed for
> kmalloc. Under stress conditions the kernel may temporary fail to
> allocate 32k with kmalloc. Use kvmalloc instead of kmalloc to aviod
> this issue.
> 
> qseecomd invoked oom-killer: gfp_mask=0x40cc0(GFP_KERNEL|__GFP_COMP), order=3, oom_score_adj=-1000
> Call trace:
>  dump_backtrace+0x0/0x34c
>  dump_stack_lvl+0xd4/0x16c
>  dump_header+0x5c/0x338
>  out_of_memory+0x374/0x4cc
>  __alloc_pages_slowpath+0xbc8/0x1130
>  __alloc_pages_nodemask+0x170/0x1b0
>  kmalloc_order+0x5c/0x24c
>  devkmsg_open+0x1f4/0x558
>  memory_open+0x94/0xf0
>  chrdev_open+0x288/0x3dc
>  do_dentry_open+0x2b4/0x618
>  path_openat+0xce4/0xfa8
>  do_filp_open+0xb0/0x164
>  do_sys_openat2+0xa8/0x264
>  __arm64_sys_openat+0x70/0xa0
>  el0_svc_common+0xc4/0x270
>  el0_svc+0x34/0x9c
>  el0_sync_handler+0x88/0xf0
>  el0_sync+0x1bc/0x200
> 
>  DMA32: 4521*4kB (UMEC) 1377*8kB (UMECH) 73*16kB (UM) 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 30268kB
>  Normal: 2490*4kB (UMEH) 277*8kB (UMH) 27*16kB (UH) 1*32kB (H) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12640kB
> 
> Signed-off-by: Yong-Taek Lee <ytk.lee@samsung.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
