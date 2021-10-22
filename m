Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EDF436FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhJVCMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbhJVCMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:12:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58024C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:10:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v8so2275689pfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=63LLGcNrSHICMPxfrFhhO/ncuY24wCK/wFBK8O3kD9U=;
        b=SX7l0NL2MhvXY/ndkNcFX5wCMFaS9QP/AzblI8HG5eLaYkfbRAjRdBLvxsWuRTyqqX
         nvnpqIF+0/Vcx9WYwMpFtquXHqiL8d1+jOTfzy7TB6+WqhdFPBOPH5wKBAWQPWG4bQAA
         AI8qHTfLlTPFul3eOBIM2Zrbb861CsXbp1sV5aEkIT8Br8Cv60hHkqiUXBrzp4Cy+y3f
         m9xJJX4WF5K0Kd2aFeieeeMIu+9IcGRJh8047snjT5h2FwOq12YSx+mNQr6EudTBZsEw
         Dnsx1uTyeYLdPfrRX45LCb/alp07Aswpc+yLzgT8IeQkUvHTx/DYdYRHZaHI4PcBSiZj
         wO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=63LLGcNrSHICMPxfrFhhO/ncuY24wCK/wFBK8O3kD9U=;
        b=g3rShY+DNUFA/5rvDWnPNVdEkaSIM0jdPn0344D72Ry3vx64LGidRjXvoySlM/90kn
         63fsImUsrPviPmIi/a0Nj079E9f6dq8VLdd3VOTNplwxrHfrAG4Ytt5+ofhXQtw99onO
         RvYxIwXGPyx+fl8Rtsl+GKLZMKWJjoDq+UmXzOiHTkkHSm28dBdi2ZYom4Cg7A0hSy5V
         +SQ7Rku2vEN7dFl/mYwvLFTmJZ2Yh8/kkBpPL8V3d5r2Zhd4mndgwCY0lrpurd42KP8Z
         gp+KJ7xCXjimWJy7L5WM3eNvClxvpomjzdqSQnj2hNRLUC6hFnEPlATCjXOJyvyxrfDM
         VSWQ==
X-Gm-Message-State: AOAM532/YLOFR5+qfaCVUvBHpw3gRpAoSpn7F6+YjaumdlGbsVgt6SaW
        qPUmat/riRvtbgFTWjcZMA==
X-Google-Smtp-Source: ABdhPJyildBFTT0B2z8bU839smDV4Nr9E9UahZIJh9FLDBRBjX4aAck9hGhcr6P8RdkhFpCd8fizbw==
X-Received: by 2002:a05:6a00:1945:b0:44c:a955:35ea with SMTP id s5-20020a056a00194500b0044ca95535eamr9258425pfk.85.1634868635865;
        Thu, 21 Oct 2021 19:10:35 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id oa4sm7767771pjb.13.2021.10.21.19.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 19:10:35 -0700 (PDT)
Date:   Fri, 22 Oct 2021 10:10:26 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, nickhu@andestech.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        tsbogend@alpha.franken.de, vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 05/15] irq: add generic_handle_arch_irq()
Message-ID: <YXIdkj2x0+yw+TIf@piliu.users.ipa.redhat.com>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021180236.37428-6-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 07:02:26PM +0100, Mark Rutland wrote:
> Several architectures select GENERIC_IRQ_MULTI_HANDLER and branch to
> handle_arch_irq() without performing any entry accounting.
> 
> Add a generic wrapper to handle the commoon irqentry work when invoking
> handle_arch_irq(). Where an architecture needs to perform some entry
> accounting itself, it will need to invoke handle_arch_irq() itself.
> 
> In subsequent patches it will become the responsibilty of the entry code
> to set the irq regs when entering an IRQ (rather than deferring this to
> an irqchip handler), so generic_handle_arch_irq() is made to set the irq
> regs now. This can be redundant in some cases, but is never harmful as
> saving/restoring the old regs nests safely.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/irq/handle.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index 221d80c31e94..27182003b879 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -14,6 +14,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel_stat.h>
>  
> +#include <asm/irq_regs.h>
> +
>  #include <trace/events/irq.h>
>  
>  #include "internals.h"
> @@ -226,4 +228,20 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>  	handle_arch_irq = handle_irq;
>  	return 0;
>  }
> +
> +/**
> + * generic_handle_arch_irq - root irq handler for architectures which do no
> + *                           entry accounting themselves
> + * @regs:	Register file coming from the low-level handling code
> + */
> +asmlinkage void noinstr generic_handle_arch_irq(struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs;
> +
> +	irq_enter();
> +	old_regs = set_irq_regs(regs);
> +	handle_arch_irq(regs);

After all involved arches call generic_handle_arch_irq(), can
handle_arch_irq be encapsulated by declaring as static?

Two places need to be fixed for this purpose:
-1. absorb the logic about handle_arch_irq in arm64/kernel/irq.c
-2. In arm, setup_arch(), 
    #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
            handle_arch_irq = mdesc->handle_irq;
    #endif


Thanks,

	Pingfan
