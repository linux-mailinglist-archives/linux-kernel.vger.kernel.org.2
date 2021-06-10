Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55BB3A31A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFJREN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhFJREK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:04:10 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 10:02:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so4239005pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 10:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DFno52efUHRX/mrHIdXIM5EVWDxxcdBxCPj4akxqiI4=;
        b=T34zxBzdrnXEUe75kxZbRkp8BKqAYn2Ot8WZ66CBEOeeXK6pJfW6HatSmjR7SVJTGq
         n8gVA4JejqRmjT2O2LFf9acKlBb+HuH7awYhFpOkgjAKna1zcVBguLbpu3KpghefAi6R
         REfHIVvnRWGaYfllJ1fs+Ubpx6LdKGUVCLGgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DFno52efUHRX/mrHIdXIM5EVWDxxcdBxCPj4akxqiI4=;
        b=BbuLEpZrvkpAcWLnQFPv2S89cOEHlYjL9dKRMNp909gKnMrJrKMSHQ5/ezjBPQrBdk
         nXw1E7QD1D2ZJ0G1i4JrGZdvR3k4gtcWR+ejA7wrlWyJnA/EH9vyWCFmSyznG4f4KGet
         yo4KBg/X8WNAJHWQuNnE2ZRsx94ETpBrt2FaiX9iB7jY/AFp+npSJYvyvgOaokSHztow
         axUjwxj1qTdbrTtm4ysWagd2hqDe8Fa+HJbtk2w65RnYQxP1jBUCaehfcZpBr7IRwDH3
         rUgUKUEAPuYgL+vGAjQVB/dxJFRhLxHwift8N+o+ajoiNaB+O7b1cMEy78k/u4HkFQ/W
         SANw==
X-Gm-Message-State: AOAM53332XRPIUNsASxV8GB6gI6F5WBfGHoG7pVMu329ziT7RNtMi2Ul
        fRik0xZfFVGQmAwMgAGFxpzJYg==
X-Google-Smtp-Source: ABdhPJzBCZjTolox13lXzWEEStyCPpStfGYIEo9IC0Ld9oywhvQz6F3CPrQ0wrEIEwtP/0Rjhs+UrQ==
X-Received: by 2002:a17:902:ee8c:b029:fe:dc5f:564 with SMTP id a12-20020a170902ee8cb02900fedc5f0564mr5756641pld.71.1623344534061;
        Thu, 10 Jun 2021 10:02:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o16sm2885105pfu.75.2021.06.10.10.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:02:13 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:02:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Subject: Re: [PATCH] ARC: fix CONFIG_HARDENED_USERCOPY
Message-ID: <202106101001.C736237@keescook>
References: <20210609221211.2457203-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609221211.2457203-1-vgupta@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 03:12:11PM -0700, Vineet Gupta wrote:
> Currently enabling this triggers a warning
> 
> | usercopy: Kernel memory overwrite attempt detected to kernel text (offset 155633, size 11)!
> | usercopy: BUG: failure at mm/usercopy.c:99/usercopy_abort()!
> |
> |gcc generated __builtin_trap
> |Path: /bin/busybox
> |CPU: 0 PID: 84 Comm: init Not tainted 5.4.22
> |
> |[ECR ]: 0x00090005 => gcc generated __builtin_trap
> |[EFA ]: 0x9024fcaa
> |[BLINK ]: usercopy_abort+0x8a/0x8c
> |[ERET ]: memfd_fcntl+0x0/0x470
> |[STAT32]: 0x80080802 : IE K
> |BTA: 0x901ba38c SP: 0xbe161ecc FP: 0xbf9fe950
> |LPS: 0x90677408 LPE: 0x9067740c LPC: 0x00000000
> |r00: 0x0000003c r01: 0xbf0ed280 r02: 0x00000000
> |r03: 0xbe15fa30 r04: 0x00d2803e r05: 0x00000000
> |r06: 0x675d7000 r07: 0x00000000 r08: 0x675d9c00
> |r09: 0x00000000 r10: 0x0000035c r11: 0x61206572
> |r12: 0x9024fcaa r13: 0x0000000b r14: 0x0000000b
> |r15: 0x00000000 r16: 0x90169ffc r17: 0x90168000
> |r18: 0x00000000 r19: 0xbf092010 r20: 0x00000001
> |r21: 0x00000011 r22: 0x5ffffff1 r23: 0x90169ff1
> |r24: 0xbe196c00 r25: 0xbf0ed280
> |
> |Stack Trace:
> | memfd_fcntl+0x0/0x470
> | usercopy_abort+0x8a/0x8c
> | __check_object_size+0x10e/0x138
> | copy_strings+0x1f4/0x38c
> | __do_execve_file+0x352/0x848
> | EV_Trap+0xcc/0xd0

What was the root cause here? Was it that the init section gets freed
and reused for kmalloc?

> 
> Fixes: https://github.com/foss-for-synopsys-dwc-arc-processors/linux/issues/15
> Reported-by: Evgeniy Didin <didin@synopsys.com>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/arc/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
> index 33ce59d91461..e2146a8da195 100644
> --- a/arch/arc/kernel/vmlinux.lds.S
> +++ b/arch/arc/kernel/vmlinux.lds.S
> @@ -57,7 +57,6 @@ SECTIONS
>  	.init.ramfs : { INIT_RAM_FS }
>  
>  	. = ALIGN(PAGE_SIZE);
> -	_stext = .;
>  
>  	HEAD_TEXT_SECTION
>  	INIT_TEXT_SECTION(L1_CACHE_BYTES)
> @@ -83,6 +82,7 @@ SECTIONS
>  
>  	.text : {
>  		_text = .;
> +		_stext = .;
>  		TEXT_TEXT
>  		SCHED_TEXT
>  		CPUIDLE_TEXT
> -- 
> 2.25.1
> 

-- 
Kees Cook
