Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1874E3BDDDB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 21:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhGFTNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 15:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhGFTNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:13:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18540C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 12:10:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c15so12561832pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 12:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7oV0ZSYNnlAyW14j31IWfCZB8bVAKuRWNWStdCvUjXk=;
        b=UMIqyKccdlLQQtwLZRueSGdJSYkBbZanLIGTHewjAej8JLIdemHkSMMy5gMgXk/m/b
         Jp+mPza1E9qaXU5/iw7h5FpCuEmNQ9L4qh8LK4ngKQfT9L5vukiPi/0R/k2Q+I2x0D6S
         DxIHQW3R3NmTu8lkxTo5kGdEqfbYWwAuBLIrGCQ++Y7OPyEns/A0naSezlybAftna0l4
         NmEKIqCyBWNe3O3/4UTYG/cVBmUT1v2ZG15N2dEI+PqDB5O0VNRWOKhAesA4b2TBlTXW
         gajNoBI94sPMsm3h1o3ykAJvvg9fGao+uqxKACvZKqm/4bVVVkBcwzK8TlVIn82dzG+H
         3YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7oV0ZSYNnlAyW14j31IWfCZB8bVAKuRWNWStdCvUjXk=;
        b=C0fPUyyRR1YcF4e90WPg9h4JrEWPiihmptZMPq51xruKH9PbyPky5rrB/UpZPAhevy
         CLcEg4Ckfr2tDtEhxhV83Aq+Ekr6GpNYRxoOFTp01GnQfCMo37k2hsp5N6gIsNlu6URZ
         UUsLwr3/+gqAuwHQhmew+I7yEI5UaqDhv/uhl20vNSBOCth750jokElhlnZfdCHcQLHd
         P+W/vcOcMTqfPRfTcAm9TejCD6znQN/lNZvqPUgbxCJifYIx3gA/fZIHXxQfctZiQIwM
         zYF9lDVFLqq468dSF4OmPATAHxnlXkHo/dW9EOOy6wcHlFdNM+cQzTB2MDtPZQjlQw+D
         XCrw==
X-Gm-Message-State: AOAM5312TctGrATBc+ri8yeuO4lmcuY15Ww2fqZSN+RSvPPxX7OnuAqh
        OR4dJlv7x9Fg+uMIeuZriyeR1g==
X-Google-Smtp-Source: ABdhPJxDx9rhMSrtFZpfTqBSrtc20HCKJNq1/7bHrKN5piHoEsyPm6Hf4KDlMWx96sBZ4cetfY0iYg==
X-Received: by 2002:a17:902:da85:b029:129:b7a8:6ef8 with SMTP id j5-20020a170902da85b0290129b7a86ef8mr2201073plx.77.1625598637479;
        Tue, 06 Jul 2021 12:10:37 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 30sm4311085pgq.31.2021.07.06.12.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 12:10:36 -0700 (PDT)
Date:   Tue, 06 Jul 2021 12:10:36 -0700 (PDT)
X-Google-Original-Date: Mon, 05 Jul 2021 20:54:20 PDT (-0700)
Subject:     Re: [PATCH] riscv: ptrace: add argn syntax
In-Reply-To: <20210620120151.17860-1-huan.xie@suse.com>
CC:     oleg@redhat.com, Paul Walmsley <paul.walmsley@sifive.com>,
        caou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, chongguiguzi@gmail.com,
        huan.xie@suse.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     chongguiguzi@gmail.com
Message-ID: <mhng-f13a3289-d21f-4f4a-a019-af8f3f56ae6c@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2021 05:01:51 PDT (-0700), chongguiguzi@gmail.com wrote:
> This enables ftrace kprobe events to access kernel function
> arguments via $argN syntax.
>
> Signed-off-by: Jeff Xie <huan.xie@suse.com>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/ptrace.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 18ec0f9bb8d5..f9246a7d0a31 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -88,6 +88,7 @@ config RISCV
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> +	select HAVE_FUNCTION_ARG_ACCESS_API
>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select IRQ_DOMAIN
> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
> index 09ad4e923510..fdb59ee405ee 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -141,6 +141,37 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
>
>  	return *(unsigned long *)((unsigned long)regs + offset);
>  }
> +
> +/**
> + * regs_get_kernel_argument() - get Nth function argument in kernel
> + * @regs:       pt_regs of that context
> + * @n:          function argument number (start from 0)
> + *
> + * regs_get_argument() returns @n th argument of the function call.
> + *
> + * Note you can get the parameter correctly if the function has no
> + * more than eight arguments.
> + */
> +static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
> +						unsigned int n)
> +{
> +#define NR_REG_ARGUMENTS 8
> +	static const unsigned int argument_offs[] = {
> +		offsetof(struct pt_regs, a0),
> +		offsetof(struct pt_regs, a1),
> +		offsetof(struct pt_regs, a2),
> +		offsetof(struct pt_regs, a3),
> +		offsetof(struct pt_regs, a4),
> +		offsetof(struct pt_regs, a5),
> +		offsetof(struct pt_regs, a6),
> +		offsetof(struct pt_regs, a7),
> +	};
> +
> +	if (n < NR_REG_ARGUMENTS)
> +		return regs_get_register(regs, argument_offs[n]);
> +	return 0;
> +}
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_RISCV_PTRACE_H */

This is on for-next.  I cleaned it up a bit to avoid leaking that 
#define.
