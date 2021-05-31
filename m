Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30E7395A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 14:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhEaM0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhEaM0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:26:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C258C061763
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:25:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h24so12489083ejy.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FW9/91oXBy6Mao6g/WQyoqZ2VlX3RS8bSdK17yEcolU=;
        b=zeFMi410XXFAIk92KbRPsYvamk9jNcjSYzFyz8hyv0j66nyXqVGZ4aXT/Arsdk+n6b
         p+XBFg5deVkez/9/judkzj3agLMeWTzkV6E16U2qRIiwSAb5Qz55SwyoJ/duSxaPbJgL
         PAg6n4Bp9XFLgye5mUrLlElxVEVgDYhwqbrhTL8a55aS24pNLB81o4THCiSjgaEu3wZq
         /PDzRXmk95xZNY3BzOjI1fWPV6LhHoK0jwPSK//an3mA7QJK3RX3iVThcWyn42kRmnoV
         wcnYPsgQ8EmJIJHQaoCqAOoByUOvyldnoc76L4FNZ7VwBC0iF+Wu5ti9fDYIkB0Te8ON
         Cb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FW9/91oXBy6Mao6g/WQyoqZ2VlX3RS8bSdK17yEcolU=;
        b=DktXLXsMQQsKvaH0/YOKRbiGwfTgVLZ1CDESuwcGP/r/o7rt4CxMkUVkvkJAqD0dfe
         7vQ9zV/zeE5m4TKklncJQa4uypIFgMJuW7X3Y7ZFscTlcbLGX/wXAjPQnVcuGoYS5s8q
         X7/D7THALwiXB8kgRBBDlqAOuaARdDlhigYvagpFyIfP4IKnMjc9grGjWfS2V3/TPsFE
         VAj/yabm34rDg/AFk8jI55/oBpj1PX+2bjUtbQukaJs6CAk9ubUAUO5Ofv0xkZX5htUN
         0lr2r52CR69lNkHCk0rQ2noaI6xcF9zOLHz8H9EsZ2c72q7yEwBtKau12G/9Vn9ODo6O
         Cm/A==
X-Gm-Message-State: AOAM533iYhLeyXg8pYgivci5EdEBX4o/q17RW4uXv/IKnd4klvbTrAtD
        tB9djRTYLr4tKs/TuLcBpYPY3Q==
X-Google-Smtp-Source: ABdhPJyDYlmkSLP3gas8rRrq3uvFjJoPBY9aCf31K4xNc/54kq9YOxBqvPi2P0P04x4KlgfPdlQgsg==
X-Received: by 2002:a17:906:5d0c:: with SMTP id g12mr22408401ejt.447.1622463899056;
        Mon, 31 May 2021 05:24:59 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::45a? ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id b22sm1235904eds.71.2021.05.31.05.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 05:24:58 -0700 (PDT)
Subject: Re: [PATCH V2 2/2] microblaze: Cleanup unused functions
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
References: <1622350408-44875-1-git-send-email-guoren@kernel.org>
 <1622350408-44875-3-git-send-email-guoren@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <73bf48c1-6692-795c-ba16-b7baeb11d3b9@monstr.eu>
Date:   Mon, 31 May 2021 14:24:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622350408-44875-3-git-send-email-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/21 6:53 AM, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> These functions haven't been used, so just remove them. The patch
> just uses grep to verify.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/include/asm/page.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
> index bf681f2..ce55097 100644
> --- a/arch/microblaze/include/asm/page.h
> +++ b/arch/microblaze/include/asm/page.h
> @@ -35,9 +35,6 @@
>  
>  #define ARCH_SLAB_MINALIGN	L1_CACHE_BYTES
>  
> -#define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
> -#define PAGE_DOWN(addr)	((addr)&(~((PAGE_SIZE)-1)))
> -
>  /*
>   * PAGE_OFFSET -- the first address of the first page of memory. With MMU
>   * it is set to the kernel start address (aligned on a page boundary).
> 

Ah ok. you have sent v2. Will take this version instead of previous one.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

