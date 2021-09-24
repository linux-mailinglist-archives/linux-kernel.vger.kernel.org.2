Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4EA4176CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346773AbhIXOeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhIXOeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:34:04 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18800C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 07:32:31 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id h2so6180013ybi.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCjQZcVJmjPWZioCoH0GfM/uPKlpTelBzg4TO/HnFhI=;
        b=UYF+YUVwUcVhe3APQrnO15JByJbbU4EgOO2uJm9IYny9sOz2Wp3B4ktp3/XRxtjVA8
         LBLncoyj+R0eNm3k6f5LScAiuSvA2alqziPikFWG5qzp8NiIki0ikLwVXSHI7SEEvj9N
         YHxy21e6PDoCCr+vpzcgFuicZxW9Dgb5vzRVF15J2YkqQ3D3NL/6Z9DD/oVISSgYzRxr
         NQI8iiMp/cm5D2D6dCMqhGzcOT2lus24afyFKjnYVae+V88oThBgR2fuwpgZfIVnsZmo
         PGj6j4m6SaiFEMr+vPK3ozX2nHJG445XF08IdhB+bOwbScZc4KcdXDWqnz+asjRexSNY
         SYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCjQZcVJmjPWZioCoH0GfM/uPKlpTelBzg4TO/HnFhI=;
        b=2ySzJKuTTRRsHJu9L0MJmiuAUFD3ZmeeGmd78e4uhGLrGsZU3uSDPCT3Tqol8A0P5x
         r2B4uayVGVjoH/097G6NC5oj8kLdaWe/uIujL6q1QL02h65HYXiIhcFHsse+B7HS2HbK
         0uZ9mJYMDx0u6l/oQG3eecrP4e3X006OOb7I/1ONiHypm1mdAdDTlWdJcuV6mJYjS50C
         iC8TQyWe9sP3UAiGWTx865TZGyLYyZwL49ObBrjaOBnCuNNSuVTOrEuM8qqxR3g8jkj0
         /16rhfXGfVYsjFAtzDQgYkLZHtIAnpIjIGb7Zvw3Q7hkDVm/cZeSAhUKquiubjRcByRC
         +UeA==
X-Gm-Message-State: AOAM533ryYLfn22QQWqnAG5fc8nzh2ILFZZvWB3+/wUkv8v4qfmHNC67
        QA2X8uaramx78sFjl+pVTD5vRVJAXX0O9n8DZDBYkNALp2k=
X-Google-Smtp-Source: ABdhPJzIlLF34YGWfPvgQ9nBPguvg4Rp0wtZnARw0kUV7S/YfbpAZoEuMNhdGf3E0DXLWY87heVqiceD4P05RLyXKcU=
X-Received: by 2002:a5b:286:: with SMTP id x6mr12728856ybl.59.1632493950045;
 Fri, 24 Sep 2021 07:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210923095316.13867-1-yee.lee@mediatek.com>
In-Reply-To: <20210923095316.13867-1-yee.lee@mediatek.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 24 Sep 2021 07:32:19 -0700
Message-ID: <CABCJKudkcxtDX89hXRTv7osFOxqMsvv=OK5BpcO4-xPHrQB9dg@mail.gmail.com>
Subject: Re: [PATCH] scs: Release kasan vmalloc poison in scs_free process
To:     yee.lee@mediatek.com
Cc:     LKML <linux-kernel@vger.kernel.org>, nicholas.Tang@mediatek.com,
        Kuan-Ying.lee@mediatek.com, chinwen.chang@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 23, 2021 at 2:53 AM <yee.lee@mediatek.com> wrote:
>
> From: Yee Lee <yee.lee@mediatek.com>
>
> Since scs allocation has been moved to vmalloc region, the
> shadow stack is protected by kasan_posion_vmalloc.
> However, the vfree_atomic operation needs to access
> its context for scs_free process and causes kasan error
> as the dump info below.
>
> This patch Adds kasan_unpoison_vmalloc() before vfree_atomic,
> which aligns to the prior flow as using kmem_cache.
> The vmalloc region will go back posioned in the following
> vumap() operations.
>
>  ==================================================================
>  BUG: KASAN: vmalloc-out-of-bounds in llist_add_batch+0x60/0xd4
>  Write of size 8 at addr ffff8000100b9000 by task kthreadd/2
>
>  CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.15.0-rc2-11681-(skip)
>  Hardware name: linux,dummy-virt (DT)
>  Call trace:
>   dump_backtrace+0x0/0x43c
>   show_stack+0x1c/0x2c
>   dump_stack_lvl+0x68/0x84
>   print_address_description+0x80/0x394
>   kasan_report+0x180/0x1dc
>   __asan_report_store8_noabort+0x48/0x58
>   llist_add_batch+0x60/0xd4
>   vfree_atomic+0x60/0xe0
>   scs_free+0x1dc/0x1fc
>   scs_release+0xa4/0xd4
>   free_task+0x30/0xe4
>   __put_task_struct+0x1ec/0x2e0
>   delayed_put_task_struct+0x5c/0xa0
>   rcu_do_batch+0x62c/0x8a0
>   rcu_core+0x60c/0xc14
>   rcu_core_si+0x14/0x24
>   __do_softirq+0x19c/0x68c
>   irq_exit+0x118/0x2dc
>   handle_domain_irq+0xcc/0x134
>   gic_handle_irq+0x7c/0x1bc
>   call_on_irq_stack+0x40/0x70
>   do_interrupt_handler+0x78/0x9c
>   el1_interrupt+0x34/0x60
>   el1h_64_irq_handler+0x1c/0x2c
>   el1h_64_irq+0x78/0x7c
>   _raw_spin_unlock_irqrestore+0x40/0xcc
>   sched_fork+0x4f0/0xb00
>   copy_process+0xacc/0x3648
>   kernel_clone+0x168/0x534
>   kernel_thread+0x13c/0x1b0
>   kthreadd+0x2bc/0x400
>   ret_from_fork+0x10/0x20
>
>  Memory state around the buggy address:
>   ffff8000100b8f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>   ffff8000100b8f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>  >ffff8000100b9000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>                     ^
>   ffff8000100b9080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>   ffff8000100b9100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>  ==================================================================
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> CC: Will Deacon <will@kernel.org>
> CC: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> ---
>  kernel/scs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/scs.c b/kernel/scs.c
> index e2a71fc82fa0..25c0d8e416e6 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -68,6 +68,7 @@ void scs_free(void *s)
>
>         __scs_account(s, -1);
>
> +       kasan_unpoison_vmalloc(s, SCS_SIZE);

Thanks for the patch! I believe I had this in the original vmap SCS
series, but Will pointed out that unpoisoning shouldn't be necessary
before vfree_atomic() and I don't remember seeing this KASAN error
back then. I wonder if something changed there? Either way, the patch
looks good to me.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
