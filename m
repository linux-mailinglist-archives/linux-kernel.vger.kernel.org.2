Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189C136E4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbhD2G0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbhD2G0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:26:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D49C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:25:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p17so8294455plf.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5V9zWyCsSWRyBJB2YSVQw8NdRmiQnJFEEv4u2i4PnwY=;
        b=xYVcMr3ofFj5i8PN9JdEri3Np4iIZw7dwiY5dz3koxZHQZlw6qzIesVy9Tdm5nptCX
         q/6WRreGc6Ecx/7uH7e3QEoo5pnDlT6dLo0EfFdoDEHyYlSCwICDB7IXLWOIfe69X7Oq
         lHXQc3gh2RDvIXAxvti9Q13W5P9YtDyOU3gXNZ2plvz4UZM7r6cWtebTdcdbsSemWZL6
         o2+YmBGdpAQcw65K2jsvfqaRoYMnVcVEBqdqEGXVvqJW/5+kBV5/hhhSHt2WPOFJi81V
         WGa7QQKqizVxyyHcW2ng8rD/z3y0XwlGsueD86iKNz8e9UOaeN56QIa4LsXBeAb5VTN+
         vS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5V9zWyCsSWRyBJB2YSVQw8NdRmiQnJFEEv4u2i4PnwY=;
        b=fpCdGn1U4h3KsvMcXAmuW639XaC2cYCTthE7OvkkdXmg9lkVmmCnBfFoD6556qFtpg
         TynxmyDzof03pfFhsl0x7+km4R5C+UlxceMNuCc+GqA7dQMPYuNI1Akm/mIsCmsTLFgr
         TbfcncXyZkHBHjQiMzvaAcxmRuHeQ/V8/cr6u/k8IpsgvziE+Wwp52icox/vpM1kNvqh
         GagChBd3Biy37SS7FWUasv8JFHoR6VFcncCMBf1Wpvs3Wj5cWUGF0QuQNUryyJASNS30
         z09kPQLidStTthobiPWSadrJFfb578ZSFUWuyt1euY8Lb2790bWXVdtrP/Ai1Hcr6855
         42LA==
X-Gm-Message-State: AOAM533PD+S546D9oWhylrYxe0u+zBqhM4njR+JkIjFLfS6/rfvORJpU
        05mNLRGOeWndh5fy48c0WwMq4Q==
X-Google-Smtp-Source: ABdhPJyvbZmSwXCAkBT6VXeFS0m0xx7jYkh+Y72sntlPebrrA2MZNLeiZAHznGxx0KddljLghUMIMg==
X-Received: by 2002:a17:90b:e07:: with SMTP id ge7mr5367645pjb.204.1619677546961;
        Wed, 28 Apr 2021 23:25:46 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e1sm1446766pgl.25.2021.04.28.23.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 23:25:46 -0700 (PDT)
Date:   Wed, 28 Apr 2021 23:25:46 -0700 (PDT)
X-Google-Original-Date: Wed, 28 Apr 2021 23:25:44 PDT (-0700)
Subject:     Re: [PATCH] riscv: Fix 32b kernel build with CONFIG_DEBUG_VIRTUAL=y
In-Reply-To: <20210428100217.15964-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alex@ghiti.fr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-e465b5c3-6c0d-4192-adf7-b4e7f8a76a76@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 03:02:17 PDT (-0700), alex@ghiti.fr wrote:
> Declare kernel_virt_addr for 32b kernel since it is used in
> __phys_addr_symbol defined when CONFIG_DEBUG_VIRTUAL is set.
>
> Fixes: 2bfc6cd81bd17 ("riscv: Move kernel mapping outside of linear
> mapping")
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/include/asm/page.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index e280ba60cb34..6a7761c86ec2 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -106,9 +106,9 @@ extern unsigned long pfn_base;
>  #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
>  #endif /* CONFIG_MMU */
>
> -#ifdef CONFIG_64BIT
>  extern unsigned long kernel_virt_addr;
>
> +#ifdef CONFIG_64BIT
>  #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_pa_offset))
>  #ifdef CONFIG_XIP_KERNEL
>  #define kernel_mapping_pa_to_va(y)	({						\

Thanks, this is on for-next.
