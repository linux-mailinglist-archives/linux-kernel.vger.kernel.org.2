Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5DB395A97
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 14:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhEaMdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhEaMdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:33:00 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9025EC061763
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:31:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t3so13273448edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aKbt/25Lpr+qYLajJWVfyCTo+4CRErqlZFkE0uYt2vs=;
        b=W37ulNIOItQXCidIGXdbU3wrpoV1xoJfJMx/IzU6SUrICrKtkjj/5lbckpJgbBl+v0
         YNAoZ5zlOiJSpxiaDL5BQQn6oNxa19uqC2JaZUpVWTyp31WAWE5qXbk/8+GTY4HO1Z6h
         BD468mfNCDN2mDOWRhhHOFg4PSmtqSGh84y3f4hKCzi3zOOtF1ARwr7qC0dTDEhxpgUO
         TSsw2f1CMINyoB3IGaljO/kmcVvkkYoaOf+tZgELN+IIuOiaWul4EFjqxTSrhC40T4Os
         30RqXfmXpvAqyrkjOwUfcm5byTrnVbrkEu1rNwOnbyTH14aOWRVo7ZrLNPsXZQ7/zrMp
         mI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aKbt/25Lpr+qYLajJWVfyCTo+4CRErqlZFkE0uYt2vs=;
        b=IqCrp0k6F5EKr/IRRL9os8TFzu8JKDYtJ3m12zCfIcTnDn1YurNa9Nx3I6+mgpctdV
         Gf32I2cqe5cSnbl0haL/mwsX36mKYMkUffz/ZnzoxMIzLV75J6ot1hlbTzxxYwfu1dEv
         4sHdLKu09LBwtoixpOBFd60fhTeYrVfqK64b8ZB5gZCFN6LTupuxqsZXG1ceFSTfe/c9
         m2XMruNXj5S8ywBDsHF/bpEvT1bA5bCxTG/HVEnvoj31jSjDkBTgoEQPV3Uvux9kOivC
         mfVh9xe9Zo6eiu1PSz1XAD1L0sMQL2Mz25qRCRbtMXEvHfT7IlyyY7GP57fiTxcXTT4P
         Q7Wg==
X-Gm-Message-State: AOAM530yxvlZz0wuNO5Lc2EJOo4UfcuaQMcoeBrXOS1IISeIP7T9J8Pu
        ztiYu9z6B1fRZ1LYJxqAGnpEeQ==
X-Google-Smtp-Source: ABdhPJw3apIrasvW7VHL6gyFcLUmXzlBPwG/C8F5gqcd/uz77RvwTgPhhDbf6cF/kiAyjcVaZFqY0g==
X-Received: by 2002:aa7:d7cf:: with SMTP id e15mr15643125eds.114.1622464277227;
        Mon, 31 May 2021 05:31:17 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::45a? ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id fe20sm5526644ejc.108.2021.05.31.05.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 05:31:16 -0700 (PDT)
Subject: Re: [PATCH v2 21/33] locking/atomic: microblaze: move to ARCH_ATOMIC
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        will@kernel.org, boqun.feng@gmail.com, peterz@infradead.org
Cc:     aou@eecs.berkeley.edu, arnd@arndb.de, bcain@codeaurora.org,
        benh@kernel.crashing.org, chris@zankel.net, dalias@libc.org,
        davem@davemloft.net, deanbo422@gmail.com, deller@gmx.de,
        geert@linux-m68k.org, gerg@linux-m68k.org, green.hu@gmail.com,
        guoren@kernel.org, ink@jurassic.park.msu.ru,
        James.Bottomley@HansenPartnership.com, jcmvbkbc@gmail.com,
        jonas@southpole.se, ley.foon.tan@intel.com, linux@armlinux.org.uk,
        mattst88@gmail.com, mpe@ellerman.id.au, nickhu@andestech.com,
        palmerdabbelt@google.com, paulus@samba.org,
        paul.walmsley@sifive.com, rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@synopsys.com, ysato@users.sourceforge.jp
References: <20210525140232.53872-1-mark.rutland@arm.com>
 <20210525140232.53872-22-mark.rutland@arm.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <8ba825a4-5213-b355-ba3a-ef9e67e1ce78@monstr.eu>
Date:   Mon, 31 May 2021 14:31:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525140232.53872-22-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/21 4:02 PM, Mark Rutland wrote:
> We'd like all architectures to convert to ARCH_ATOMIC, as once all
> architectures are converted it will be possible to make significant
> cleanups to the atomics headers, and this will make it much easier to
> generically enable atomic functionality (e.g. debug logic in the
> instrumented wrappers).
> 
> As a step towards that, this patch migrates microblaze to ARCH_ATOMIC,
> using the asm-generic implementations.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/microblaze/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 0660f47012bc..5a52922dc225 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -2,6 +2,7 @@
>  config MICROBLAZE
>  	def_bool y
>  	select ARCH_32BIT_OFF_T
> +	select ARCH_ATOMIC
>  	select ARCH_NO_SWAP
>  	select ARCH_HAS_DMA_PREP_COHERENT
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

