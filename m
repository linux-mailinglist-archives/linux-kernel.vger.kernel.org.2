Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33253E3651
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 18:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhHGQhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhHGQg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 12:36:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC4EC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 09:36:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z3so11471425plg.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=4ySF7t3f9IXZ9xCWYkjQadycnruU0kjHVud70QqSUeE=;
        b=02sy5q+gMNcB1jVOaqvUWMAySDDMU725SZ9iyRDOqgbRqzbAULDiNwyuRgNnh6R5UJ
         Na9nfm5QFDU8GS3x234s4z1+/KdtCQgkcaVWes+F3kVXw0moYOelkY2mJyxg6taIxx19
         AZOfhtim8SqpwH6PLmshrXaraHumMz6XDucxWJxg3MlbbGxFLcPkmjw0OvcTecWyQSRk
         D4GPOUB4adkzUHsqr41h7e4lEvwCXE2AEZ7X3Q7uqEVGr0MoK57KMZVntHISlk1rXCPe
         jx6KFOpvE/oG75RKrfX05/mJY4Vr76sqbBsiQ6CRcCp+SHw2LTxnqtNR7VeYXm3BWZre
         vCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=4ySF7t3f9IXZ9xCWYkjQadycnruU0kjHVud70QqSUeE=;
        b=hfioSWWu6biL0UL7ba6fhErc0WTMgOVMa7VQ/XjEMkaJZX0fvjV/xt72iu/g3YMse+
         svnNBISSSFnyEUShXBs8cDFcYxuGB9CxEpBcYlUbADKtJ/8TmR+K0ZqIO2L4orq/zVKg
         vibsq7XV1d/TFwkp2GXuBNsrNi7vFotKNeWifG4g7GqYhfOB74LTsoDJa3+JO2fTcdDF
         RaLVielUB7YVNMrErkS94FtrHuYe70R4cqJz8kfPf7A3zGj1e4hePdQ3tqpQHiJzX7Wa
         1YYVor4ihYRWBYpRa2f5StNVkUDFu8YjrEa3RL7106Pp4sqdIq9ufHE1IwIzvY0E5Thv
         qBjQ==
X-Gm-Message-State: AOAM531v/HvuAOrtz6hjkCmE/PqMX9hooU4/IDL3FXmUiHfDSRT6KQjb
        VPsfcPl6SB2mpwESrmFtZnTuaA==
X-Google-Smtp-Source: ABdhPJx1raKBqfmBr7+x9BmuR8aifXvMifS5f2Rv15DZIAwdpV5b8Kf3DA4pPAK5KJ5nMWIUlrwZWA==
X-Received: by 2002:a17:902:6904:b029:fb:42b6:e952 with SMTP id j4-20020a1709026904b02900fb42b6e952mr12653078plk.16.1628354201654;
        Sat, 07 Aug 2021 09:36:41 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x189sm16658823pfx.99.2021.08.07.09.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 09:36:41 -0700 (PDT)
Date:   Sat, 07 Aug 2021 09:36:41 -0700 (PDT)
X-Google-Original-Date: Fri, 06 Aug 2021 22:37:17 PDT (-0700)
Subject:     Re: [PATCH -fixes 3/3] riscv: Optimize kernel virtual address conversion macro
In-Reply-To: <20210721075937.696811-4-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-163d949e-5efc-46d4-a5b7-c90e4745a7a3@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 00:59:37 PDT (-0700), alex@ghiti.fr wrote:
> The current test in kernel_mapping_va_to_pa only applies when
> CONFIG_XIP_KERNEL is set, so use IS_ENABLED to optimize this macro at
> compile-time in standard kernels that do not require this test.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/include/asm/page.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index b0ca5058e7ae..10dc063868f6 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -123,7 +123,7 @@ extern phys_addr_t phys_ram_base;
>  #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - kernel_map.va_pa_offset)
>  #define kernel_mapping_va_to_pa(y) ({						\
>  	unsigned long _y = y;							\
> -	(_y < kernel_map.virt_addr + XIP_OFFSET) ?					\
> +	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ?	\
>  		((unsigned long)(_y) - kernel_map.va_kernel_xip_pa_offset) :		\
>  		((unsigned long)(_y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET);	\
>  	})

IIUC this isn't actually a fix?  The other two are, though, so 
they're on fixes.

Thanks!
