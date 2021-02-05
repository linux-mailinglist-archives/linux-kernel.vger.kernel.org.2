Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB817310550
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhBEG7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 01:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhBEG7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 01:59:22 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B409C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 22:58:42 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id c132so3895447pga.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 22:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=45oiIlSnEIMV0OPXUhkf967gneJSNkEatrrE2Px5nkI=;
        b=JgcIxav6VgtWCRFlGZm4bOIGB88RSAZQXbeVY93XEPLLXk+XsRIQ6rDMelKbFe19+s
         ZQ6KrDNKHsOI1u7+ZiBFneZkUSJoTOpKN7zNN+036tz9SbjGzBpHqncMwhrMyi4fskOc
         cxZO7MFzxoyb/EEWWYLN0qTaiGM/bXEgHWHxnBrW0Tefr655qJRkjXlVPdUyTQMnj9kk
         xU3pp6P45GjocC1uD2Y1Cl7N+NmiDteiPQ3OwET2gT2WtR7Fhl+AhKo/Ems8/gJOYa9S
         zW0UGQO6YEUCVnF/aSuuKfTbirPnDi+SJ9hyBI9EeS8RhMeB15BrdsF6zFDhjwyuAIEG
         6dSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=45oiIlSnEIMV0OPXUhkf967gneJSNkEatrrE2Px5nkI=;
        b=fx0EjfTwobyGzJJa/BeQMu14q5Qb74i4+Agd6/lwgntO3H/OmvLomqwwWCiP8TNIPP
         wchmnf+OX61+WfiNdiq0sUZtiySKkMgDD6lUR/p46icxwe9R1m8cavIi/6Zb/uZVYaNh
         wFU8mG9+qPyCDMAEKKhxzVpGx7JLLSNZ43mT/8PGYvpUo950t8rZeQHPFes/fGO37AOp
         qftQ9JWFG3mLxkM4hUkzmnbNL87Ch1v4a1lu7wMK+D9ID5m+3cyVglic4yIvOvaXwdRe
         /ukNWrsnZ5UxaHi64kjV+tMMs8paTq0zAiTgIBNsEN0v2f0CBeGb9ip4JMZtHAnrsnO6
         6C0w==
X-Gm-Message-State: AOAM533mjWogbDd7bEv0cc28BUTJ9qffw17HTdjzo4TPdcQ7zjuxmQ+W
        SSoQvaCYII1rjLzu0+kgfYkp+pZc5g2BS3J7
X-Google-Smtp-Source: ABdhPJyMGXSHnCZ0Wvixs0wt52QtrkTyIBTMLxFz31XJIzGnJlN6MI4XnmPkS8ZwSTQopOGXEEC6Lg==
X-Received: by 2002:a63:4764:: with SMTP id w36mr2883164pgk.127.1612508321529;
        Thu, 04 Feb 2021 22:58:41 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t2sm9310675pga.45.2021.02.04.22.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 22:58:40 -0800 (PST)
Date:   Thu, 04 Feb 2021 22:58:40 -0800 (PST)
X-Google-Original-Date: Thu, 04 Feb 2021 22:58:36 PST (-0800)
Subject:     Re: [PATCH -next] RISCV: Add some depends for NUMA
In-Reply-To: <20210203142343.59781-1-wangkefeng.wang@huawei.com>
CC:     Atish Patra <Atish.Patra@wdc.com>, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-3a9465c0-42bb-42de-ad66-855dc2e3c56f@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Feb 2021 06:23:43 PST (-0800), wangkefeng.wang@huawei.com wrote:
> The numa feature is useless for riscv32 platform(MAXPHYSMEM_1GB if 32bit),

I'm not convinced of that.  There's no reason NUMA shouldn't work on 32-bit, it
doesn't depend on having a large amount of memory just having non-uniform
memory.  I could buy the argument that build a 32-bit NUMA system would be
wacky, but IIUC it works now and I don't see any reason to throw that away.

> and it should depends on SMP feature, this also fix the build error,

I can buy that CONFIG_NUMA doesn't really make sense without CONFIG_SMP, as
there's not a whole lot to do, but I also don't see any reason from disallowing
users from picking it.  arm64 allows !SMP && NUMA, and I don't see any reason
it wouldn't work just as well for us.

>   riscv64-buildroot-linux-gnu-ld: mm/page_alloc.o: in function `.L0 ':
>   page_alloc.c:(.text+0x4808): undefined reference to `node_reclaim_distance'

The only instance of node_reclaim_distance I see in mm/page_alloc.c is already
guarded with CONFIG_NUMA, but the definition of node_reclaim_distance isn't.
I'll send out some patches to add the guard which might make sorting this out
earlier, but I don't see it fixing any failures.

> Fixes: 4f0e8eef772e ("riscv: Add numa support for riscv64 platform")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 22fa17898d29..ac7f5801bd82 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -312,6 +312,8 @@ endchoice
>  # Common NUMA Features
>  config NUMA
>  	bool "NUMA Memory Allocation and Scheduler Support"
> +	depends on SMP
> +	depends on 64BIT
>  	select GENERIC_ARCH_NUMA
>  	select OF_NUMA
>  	select ARCH_SUPPORTS_NUMA_BALANCING
