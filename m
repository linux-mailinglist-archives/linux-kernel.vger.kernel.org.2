Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6A2333486
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 05:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhCJErp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 23:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhCJErc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 23:47:32 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2D3C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 20:47:31 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j6so7859617plx.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 20:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=V8CovqO2r2c3lZFxI+Vlz80bG5YIFGmxCrj/XPBe6Sw=;
        b=tcRWTtQJwyQCDK5Db+d9WbORhnitIMEgAhGeA8awjiVyQlNhU2iFat9SLNzn0ZYU22
         7TN2//+Jr0Q8dWOHFEzlaxej5pcUQoIG+gqUMTjsW6U8eK+2ZBhShZkJZ0wNSNzgQImZ
         rUBsoqUSJxXKHyURNg054vZ5S4aQizqtRcAf0gL8NoC8DCckCFNM4h/aYJg6CacmumZu
         Ou5efOjgv5CIfdYvJoC/+joeN4r0ICEt90ROswhSwPnrGULUgXUeJFU5yx0no05QmGd0
         IvTZ9vYuJlM9lDiCWyLWUtH9dfBdJIwK47bHFyPzn83ouXlUreBso3eA9HZf3IpSf5Z0
         GqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=V8CovqO2r2c3lZFxI+Vlz80bG5YIFGmxCrj/XPBe6Sw=;
        b=H1aDpBhMi+4ZWnfyDb/bEh5ZBWVZCQtMcuwGdaa1UlBDgNLu69fjIG2TpzdPnRg8Tx
         OgE+eEZ5PN3ds1MRevEhWLbyOpLe0y235bmaW5gPCV9We/ehOXGzjH7wqJhSvMa81I4c
         CNenD5sMC5c1MdkMKOtYWwl6o5DGQntuSW5wQICfWyY7Av5MD9J49kt15ILJU74Au6gh
         aJc54w11IYrnPFk2SsmtnswtD3iR6dWH4/5kTXDgTi9nobvmJWIqW/ejONagzSZpOL8P
         w2jIfl3J5os/UmZ4J7tqtln60zwx6VJ2Qtjwx3ERnz4jix3DmJSwbjpSjan87FWdax5o
         9LfQ==
X-Gm-Message-State: AOAM53092jGWSt1NJH8hCJp7S5y6a5Zy/akg8/wb/+le1JfKjGF5ooOw
        8VgP1QtttjXy60LgZ8uDeS/iWQ==
X-Google-Smtp-Source: ABdhPJzpFUiJudJafEmd5UfrnkjeEeW49aL4mN5nGImsEab1r6oCo1IahjaNCjeP0HQ9zUe/rrs5LA==
X-Received: by 2002:a17:90a:990a:: with SMTP id b10mr1583598pjp.178.1615351651352;
        Tue, 09 Mar 2021 20:47:31 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 3sm4428818pjk.26.2021.03.09.20.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 20:47:30 -0800 (PST)
Date:   Tue, 09 Mar 2021 20:47:30 -0800 (PST)
X-Google-Original-Date: Tue, 09 Mar 2021 20:46:23 PST (-0800)
Subject:     Re: [PATCH 1/9] riscv: traps: Fix no prototype warnings
In-Reply-To: <20210305113332.428048-2-sunnanyong@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunnanyong@huawei.com
Message-ID: <mhng-31d44427-3d4a-4e15-aeae-5bbb8b271349@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Mar 2021 03:33:24 PST (-0800), sunnanyong@huawei.com wrote:
> Fix all W=1 compilation warnings:'no previous prototype for' in arch/riscv/kernel/traps.c:
> arch/riscv/kernel/traps.c:96:15: warning: no previous prototype for ‘do_trap_unknown’ [-Wmissing-prototypes]
>    96 | DO_ERROR_INFO(do_trap_unknown,
>       |               ^~~~~~~~~~~~~~~
> arch/riscv/kernel/traps.c:91:27: note: in definition of macro ‘DO_ERROR_INFO’
>    91 | asmlinkage __visible void name(struct pt_regs *regs)   \
>       |                           ^~~~
> arch/riscv/kernel/traps.c:98:15: warning: no previous prototype for ‘do_trap_insn_misaligned’ [-Wmissing-prototypes]
>    98 | DO_ERROR_INFO(do_trap_insn_misaligned,
>       |               ^~~~~~~~~~~~~~~~~~~~~~~
> arch/riscv/kernel/traps.c:91:27: note: in definition of macro ‘DO_ERROR_INFO’
>    91 | asmlinkage __visible void name(struct pt_regs *regs)   \
>       |                           ^~~~
> arch/riscv/kernel/traps.c:100:15: warning: no previous prototype for ‘do_trap_insn_fault’ [-Wmissing-prototypes]
> ...
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>  arch/riscv/include/asm/asm-prototypes.h | 16 ++++++++++++++++
>  arch/riscv/kernel/traps.c               |  1 +
>  2 files changed, 17 insertions(+)
>
> diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
> index 27e005fca584..6d81abf5d9f8 100644
> --- a/arch/riscv/include/asm/asm-prototypes.h
> +++ b/arch/riscv/include/asm/asm-prototypes.h
> @@ -9,4 +9,20 @@ long long __lshrti3(long long a, int b);
>  long long __ashrti3(long long a, int b);
>  long long __ashlti3(long long a, int b);
>
> +
> +#define DECLARE_DO_ERROR_INFO(name)	asmlinkage void name(struct pt_regs *regs);

This triggers checkpatch.

> +
> +DECLARE_DO_ERROR_INFO(do_trap_unknown)
> +DECLARE_DO_ERROR_INFO(do_trap_insn_misaligned)
> +DECLARE_DO_ERROR_INFO(do_trap_insn_fault)
> +DECLARE_DO_ERROR_INFO(do_trap_insn_illegal)
> +DECLARE_DO_ERROR_INFO(do_trap_load_fault)
> +DECLARE_DO_ERROR_INFO(do_trap_load_misaligned)
> +DECLARE_DO_ERROR_INFO(do_trap_store_misaligned)
> +DECLARE_DO_ERROR_INFO(do_trap_store_fault)
> +DECLARE_DO_ERROR_INFO(do_trap_ecall_u)
> +DECLARE_DO_ERROR_INFO(do_trap_ecall_s)
> +DECLARE_DO_ERROR_INFO(do_trap_ecall_m)
> +DECLARE_DO_ERROR_INFO(do_trap_break)
> +
>  #endif /* _ASM_RISCV_PROTOTYPES_H */
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 3ed2c23601a0..0879b5df11b9 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/irq.h>
>
> +#include <asm/asm-prototypes.h>
>  #include <asm/bug.h>
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
