Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C223A4C86
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFLD6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLD6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:58:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD18C061767
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:55:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h12so6042419pfe.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=OBgHgvMUoAyJJHJDZalDtHjcCyRI0iHp+vvdhmh2FIU=;
        b=e1LnunDq90BOgvFBM+DkGVmeY9/YNQ2kFPstTuUNTqgVMj0TnDDbudA+9PQsIU7Hv2
         aGWzaUUXtswWJXl9tQucg1PY6fxHIPjdenGSS2X6cvkvmvxigPNqklQwmwMggKbPANlG
         MDSQp3dgxS3OPfsO+wkKqRjIMw4EjAKW1F0SDOAv+fVkD2XuXp+Dq7B0fHvO3vvoZq4B
         sLo9KfE+HK/GbelfnHYJq+IRT7v6KQeIcrAtKpudKvtV3N4LEpJFXN/5iZdUcQU+VXMf
         VwHqdfnAEPqkVLI92mjkWp8nIa99aUxTihWJECQJAcY6ND8gV/kJlpNQILCGR6hhVYrb
         TMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=OBgHgvMUoAyJJHJDZalDtHjcCyRI0iHp+vvdhmh2FIU=;
        b=qDdY7yDCXBDosyUfO3juCEl+3AMK5rd1CJnhRRX0QnTwgsafLWxzT7LN1IanwPaQ59
         ejOWwvvHm5SaiB3Eo7Xgje7fYu5DQrQJWkqi2T2abZuYm6kmsSLDOYylB5g6fMOPGSs2
         gWmNGlW0F277g6BUIHhX5Vl9afrSxZCuueAPMoV5q3e1e9zg0V1dliXpqweBFhL7r+CB
         uanrd3OkEscLa5tnVhlPDdiBewqEJncPlCqOgP8I5aw5KtucaE+PWERCjp/0uZVHYfEW
         7DNLpODi923P9Ua8GsqekurX54kNuZ1ndZEavYYgmzU9PAsipI9CdTZJVgMs4SJ+Wjuf
         evNQ==
X-Gm-Message-State: AOAM530UrFGEHliEijsKParqHs2YevI3CPEj76aduhrAAfxD34lFVPrS
        hSF7V/QKD5U8+6aRwVwXioJ1MQ==
X-Google-Smtp-Source: ABdhPJyypsRXQ8z0u6aFQf73imQPZN0k8d8xQMcoRVZfS5VxiexXQXbCL1WQ4EdQgwz+tmo11GKCbw==
X-Received: by 2002:a63:dd4a:: with SMTP id g10mr6700247pgj.144.1623470147746;
        Fri, 11 Jun 2021 20:55:47 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f17sm6518738pgm.37.2021.06.11.20.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:55:47 -0700 (PDT)
Date:   Fri, 11 Jun 2021 20:55:47 -0700 (PDT)
X-Google-Original-Date: Fri, 11 Jun 2021 20:54:39 PDT (-0700)
Subject:     Re: [PATCH] riscv: mm: Remove va_kernel_xip_pa_offset symbol from !XIP case
In-Reply-To: <20210603205237.645607ca@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alex@ghiti.fr, vitaly.wool@konsulko.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-8f445bdf-66ea-44cb-8f2b-bffd3a5b76c2@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Jun 2021 05:52:37 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> The va_kernel_xip_pa_offset is only accessed for XIP case, so make it
> only available for XIP.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/mm/init.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index ae32f78207f0..ca2826778989 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -194,10 +194,8 @@ EXPORT_SYMBOL(va_kernel_pa_offset);
>  #endif
>  #ifdef CONFIG_XIP_KERNEL
>  #define va_kernel_pa_offset    (*((unsigned long *)XIP_FIXUP(&va_kernel_pa_offset)))
> -#endif
>  unsigned long va_kernel_xip_pa_offset __ro_after_init;
>  EXPORT_SYMBOL(va_kernel_xip_pa_offset);
> -#ifdef CONFIG_XIP_KERNEL
>  #define va_kernel_xip_pa_offset        (*((unsigned long *)XIP_FIXUP(&va_kernel_xip_pa_offset)))
>  #endif
>  unsigned long pfn_base __ro_after_init;

This is used outside of XIP now.
