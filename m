Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A550C4538A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbhKPRnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:43:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238906AbhKPRnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637084407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nr+r2xGROsXNBH9KeOUTHUo6tYTD1I9AjqYWE2OJRlU=;
        b=eqb4X7fV0LNXQT6/T2W3nkMKBMTh5F/+8QOXSSOc+4wCK1OgGsuan90v1tNXFjwwHh505o
        NiU6g9Io9XPeBbxAg5e474IsuPqYdFDZnkOxS7S+gmPTaLsqIYfb4Azx8Ct3RNxzjt9hCZ
        4wm9HFDdf71hjUCMIZq693o/DPbuq8c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-xul5daacNmObEPW47g2X5w-1; Tue, 16 Nov 2021 12:40:03 -0500
X-MC-Unique: xul5daacNmObEPW47g2X5w-1
Received: by mail-wr1-f71.google.com with SMTP id b1-20020a5d6341000000b001901ddd352eso3918562wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 09:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nr+r2xGROsXNBH9KeOUTHUo6tYTD1I9AjqYWE2OJRlU=;
        b=bVZeXF+loWLWXZVnm5hQtoOQnJYC7QCHcclg6lTxDK+q2JZ6kjapENxusNNVnLounY
         x7bmLIlj5cxNpFtOyih1r0y250iap8Dwbc6h+afYdnVh+mbCTIAKMQb6v4LIFinx9f9S
         DF7B7OqpSgnz8CAKohxuSFb06tBYoE4ZMmVZHNU7FCUueGMRET3uXJssxQEGlfoWrnuQ
         089mD0VDqCJv1BquWdDsCyTac7knUL2ErJVTS6jwFoJWtL2Xf8DhrNiAq1BIjLKnwXYk
         8tFUaiH99gd26bl5syfF88wp/xYm7P8yHV/3pxRSSjJ6aBXN3SDYDeSjRVFe2AEpdX6T
         70YA==
X-Gm-Message-State: AOAM5315WUowjhEhH5DRgM7aj87Ip9pPwmO8SzIQuIZ5dNmfD5xgWvN1
        BGi6ut+NYaNsAaUX9ZtENLqwBtBqpVGQsc+vpy+XPiQ9BtiXUNzLPrjhjEg4FbTALwKSvlRO/kc
        F6tOwrs7sziYu75lYroCiOoR/
X-Received: by 2002:a05:600c:4f10:: with SMTP id l16mr9855682wmq.47.1637084401711;
        Tue, 16 Nov 2021 09:40:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIaqukIZg2H4AH04sfIIA67Str6EuFC/VMDJ9CEaTdZiKqNmNI+IZ5i0hXoAFbt+HoaWJyvQ==
X-Received: by 2002:a05:600c:4f10:: with SMTP id l16mr9855643wmq.47.1637084401466;
        Tue, 16 Nov 2021 09:40:01 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c6:4a17:4f01:3a16:ae0:112c:ba92])
        by smtp.gmail.com with ESMTPSA id n1sm3718108wmq.6.2021.11.16.09.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 09:40:01 -0800 (PST)
Date:   Tue, 16 Nov 2021 17:39:59 +0000
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Jun Miao <jun.miao@intel.com>
Cc:     paulmck@kernel.org, urezki@gmail.com, elver@google.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, jianwei.hu@windriver.com
Subject: Re: [V2][PATCH] rcu: avoid alloc_pages() when recording stack
Message-ID: <20211116173959.osdzlvv7niyxthd6@localhost.localdomain>
References: <1637018582-10788-1-git-send-email-jun.miao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637018582-10788-1-git-send-email-jun.miao@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/11/21 07:23, Jun Miao wrote:
> The default kasan_record_aux_stack() calls stack_depot_save() with GFP_NOWAIT,
> which in turn can then call alloc_pages(GFP_NOWAIT, ...).  In general, however,
> it is not even possible to use either GFP_ATOMIC nor GFP_NOWAIT in certain
> non-preemptive contexts/RT kernel including raw_spin_locks (see gfp.h and ab00db216c9c7).
> Fix it by instructing stackdepot to not expand stack storage via alloc_pages()
> in case it runs out by using kasan_record_aux_stack_noalloc().
> 
> Jianwei Hu reported:
> BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 15319, name: python3
> INFO: lockdep is turned off.
> irq event stamp: 0
>   hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>   hardirqs last disabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
>   softirqs last  enabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
>   softirqs last disabled at (0): [<0000000000000000>] 0x0
>   CPU: 6 PID: 15319 Comm: python3 Tainted: G        W  O 5.15-rc7-preempt-rt #1
>   Hardware name: Supermicro SYS-E300-9A-8C/A2SDi-8C-HLN4F, BIOS 1.1b 12/17/2018
>   Call Trace:
>     show_stack+0x52/0x58
>     dump_stack+0xa1/0xd6
>     ___might_sleep.cold+0x11c/0x12d
>     rt_spin_lock+0x3f/0xc0
>     rmqueue+0x100/0x1460
>     rmqueue+0x100/0x1460
>     mark_usage+0x1a0/0x1a0
>     ftrace_graph_ret_addr+0x2a/0xb0
>     rmqueue_pcplist.constprop.0+0x6a0/0x6a0
>      __kasan_check_read+0x11/0x20
>      __zone_watermark_ok+0x114/0x270
>      get_page_from_freelist+0x148/0x630
>      is_module_text_address+0x32/0xa0
>      __alloc_pages_nodemask+0x2f6/0x790
>      __alloc_pages_slowpath.constprop.0+0x12d0/0x12d0
>      create_prof_cpu_mask+0x30/0x30
>      alloc_pages_current+0xb1/0x150
>      stack_depot_save+0x39f/0x490
>      kasan_save_stack+0x42/0x50
>      kasan_save_stack+0x23/0x50
>      kasan_record_aux_stack+0xa9/0xc0
>      __call_rcu+0xff/0x9c0
>      call_rcu+0xe/0x10
>      put_object+0x53/0x70
>      __delete_object+0x7b/0x90
>      kmemleak_free+0x46/0x70
>      slab_free_freelist_hook+0xb4/0x160
>      kfree+0xe5/0x420
>      kfree_const+0x17/0x30
>      kobject_cleanup+0xaa/0x230
>      kobject_put+0x76/0x90
>      netdev_queue_update_kobjects+0x17d/0x1f0
>      ... ...
>      ksys_write+0xd9/0x180
>      __x64_sys_write+0x42/0x50
>      do_syscall_64+0x38/0x50
>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Links: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/kasan.h?id=7cb3007ce2da27ec02a1a3211941e7fe6875b642
> Fixes: 84109ab58590 ("rcu: Record kvfree_call_rcu() call stack for KASAN")
> Fixes: 26e760c9a7c8 ("rcu: kasan: record and print call_rcu() call stack")
> Reported-by: Jianwei Hu <jianwei.hu@windriver.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Jun Miao <jun.miao@intel.com>
> ---

I gave this a quick try on RT. No splats. Nice!

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

