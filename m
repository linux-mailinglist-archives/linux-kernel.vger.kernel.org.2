Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41EB323AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhBXKgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhBXKgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:36:39 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF85C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 02:35:59 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o38so1162830pgm.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 02:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbU5JqF5O/jxabEU4ZkkSAxF3eGRnGgv5x+oMdYN6aw=;
        b=GILqXBmjKeEvSLS6njRy34ACNo+mcOQm3j6GMxmr+2H5Ylf/SistVWqVviIpAw4TAr
         dWK/3SnLBCIK8ixVnbDR7yY8HCiIgqigavNNk6F4hiyZuQMSUvAJ38zcjBdsg7yVdKfP
         kQlSTEC5xYArWbhFG4arD4OD+Kr23N4eS/7a+c8B5rgkZqMM6uw9pQCRbKQaz7tAm0CH
         SX8r5z4hliar/1tmtPzrvE8NLgUioIX/vAbD20FqN3G+C7VT4qVZjmGC6VLQFwqBRmOm
         Ym1xi21pusbkHNGoBzy7OhN8QQy3UX6618YlLdPe46D4p2YFloWC+ygHq+DH9zk0GR6x
         5v0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbU5JqF5O/jxabEU4ZkkSAxF3eGRnGgv5x+oMdYN6aw=;
        b=ZK5rcgAXpvdWIwi1Lce2DRf4cXzyHACGUsSg7z86lWSPTX+H9DfG0MzoSJDpEG0Egk
         XnTIJTyadOM5n5MZfSrZ7IdxcHOhnb4fD0cWwKwCLmmwLIOK7/Xeb0SO/BA68ZDgqADo
         oUInZkCaO9fvokAtpDMA5cxp+L14QvdDWbeft2gxNmBfdYic7hKXf2CGWePgmyvLKct6
         grlO0akRwLSLy+EKHfXqHXTZXoztWwkqaOHwsF18k+iMJzGHm438KneHEYt1BOetfepb
         xL2i/8oXiRfNRm+wT0nUMo7NvMxPD1Z20wCmtMb+GOBNfwx3G1S85YasTFYly62ruP4F
         WUDw==
X-Gm-Message-State: AOAM533z1f6k2dE592mcDSIIssQBL2Hwc9c75pmBcl6uX39OGzkCDp4A
        Kswo0r2mZXjKawy1uXS49NyfV1Re/VJ3fb7Xy1A=
X-Google-Smtp-Source: ABdhPJymUOSuijHzHlZBJZH9Hnb/uSwF4efqnyOiTXf2ipTzFGivrDW4ohpkRTn/F8OHB3yEkJfpMmL2niGoW4g3cj8=
X-Received: by 2002:a62:1dcc:0:b029:1ed:6bc0:8cbf with SMTP id
 d195-20020a621dcc0000b02901ed6bc08cbfmr19337326pfd.34.1614162959072; Wed, 24
 Feb 2021 02:35:59 -0800 (PST)
MIME-Version: 1.0
References: <1609738534-14369-1-git-send-email-liang26812@gmail.com>
In-Reply-To: <1609738534-14369-1-git-send-email-liang26812@gmail.com>
From:   liang wang <liang26812@gmail.com>
Date:   Wed, 24 Feb 2021 18:35:47 +0800
Message-ID: <CAG_0j0D9Vhc5F659ZrORLD4vh56MtGK8Zf4V1Ex3nXOjkLL1gg@mail.gmail.com>
Subject: [PATCH] [RFC]ARM: ftrace: pause/unpause function graph tracer in cpu_suspend()
To:     linux@armlinux.org.uk
Cc:     akpm@linux-foundation.org, rppt@kernel.org, geert@linux-m68k.org,
        penberg@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all

On Mon, 4 Jan 2021 at 13:35, Louis Wang <liang26812@gmail.com> wrote:
>
> From: "louis.wang1" <louis.wang1@unisoc.com>
>
> Enabling function_graph tracer on ARM causes kernel panic, because the
> function graph tracer updates the "return address" of a function in order
> to insert a trace callback on function exit, it saves the function's
> original return address in a return trace stack, but cpu_suspend() may not
> return through the normal return path.
>
> cpu_suspend() will resume directly via the cpu_resume path, but the return
> trace stack has been set-up by the subfunctions of cpu_suspend(), which
> makes the "return address" inconsistent with cpu_suspend().
>
> This patch refers to Commit de818bd4522c40ea02a81b387d2fa86f989c9623
> ("arm64: kernel: pause/unpause function graph tracer in cpu_suspend()"),
> fixes the issue by pausing/resuming the function graph tracer on the thread
> executing cpu_suspend(), so that the function graph tracer state is kept
> consistent across functions that enter power down states and never return
> by effectively disabling graph tracer while they are executing.
>
> Signed-off-by: louis.wang1 <louis.wang1@unisoc.com>
> ---
>  arch/arm/kernel/suspend.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
> index 24bd205..43f0a3e 100644
> --- a/arch/arm/kernel/suspend.c
> +++ b/arch/arm/kernel/suspend.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/ftrace.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/mm_types.h>
> @@ -26,12 +27,22 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
>                 return -EINVAL;
>
>         /*
> +        * Function graph tracer state gets incosistent when the kernel
> +        * calls functions that never return (aka suspend finishers) hence
> +        * disable graph tracing during their execution.
> +        */
> +       pause_graph_tracing();
> +
> +       /*
>          * Provide a temporary page table with an identity mapping for
>          * the MMU-enable code, required for resuming.  On successful
>          * resume (indicated by a zero return code), we need to switch
>          * back to the correct page tables.
>          */
>         ret = __cpu_suspend(arg, fn, __mpidr);
> +
> +       unpause_graph_tracing();
> +
>         if (ret == 0) {
>                 cpu_switch_mm(mm->pgd, mm);
>                 local_flush_bp_all();
> @@ -45,7 +56,13 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
>  int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
>  {
>         u32 __mpidr = cpu_logical_map(smp_processor_id());
> -       return __cpu_suspend(arg, fn, __mpidr);
> +       int ret;
> +
> +       pause_graph_tracing();
> +       ret = __cpu_suspend(arg, fn, __mpidr);
> +       unpause_graph_tracing();
> +
> +       return ret;
>  }
>  #define        idmap_pgd       NULL
>  #endif
> --
> 2.7.4
>
ftrace function_graph tracer always cause kernel panic on my ARM device with
multiple CPUs, I found a solution for the problem on ARM64, refers to
the patch above,
I was wondering why this bugfix on ARM64 hasn't been upstreamed to ARM,
Does anyone have a similar problem and can share information with me?
Thanks.
