Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706D232CA79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 03:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhCDC13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 21:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhCDC1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 21:27:14 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9121C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 18:26:33 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so15236720plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 18:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=jg9i1mPUq1K1Wcc5GInzffq6do0Ck3ej7ZHTvXvymaQ=;
        b=iwyZr437AFeZuoHsMpAywvQ7EexOwWoAL9bPOiX8EFjQymmFy/flAiAB6qSlKVJBLT
         Vpf6odJvr44WSLiAKN2koccO4JbjOxJxByBLRtDFzQAUAaB/rJ/f/sGdi1tpGSzp+965
         kjDbiv4wz5B+v5TF1sn1U+CGegHxTrhTXdko1J19OnjwcUxK6Xj6RLfxfJq61pYV1JSa
         FaxS0vRfQpQ1JgtlOPCOuof5YuWDzBZd1YMZdr5yhFBaHZZ5Ei32FgT1Zg0/c9LCfUo7
         AgnxvRka0D6ll2q2P66NwcESGNBa4CHWDY4IlMXx2PopWK+bU5A5PTA4rVNxBaI1JwUN
         TNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=jg9i1mPUq1K1Wcc5GInzffq6do0Ck3ej7ZHTvXvymaQ=;
        b=NKtunUfKPIF0x9XP9K/WarXAeO6FVIpJMATcbR2rHsjeWb/8Tl5XezcQJcrlL2ttFI
         /NASgJ56U0HjTzmbullv3mSL5O9bXjl4rAIOwGUc5r3NreFDzOAvKR9Igkuevwh0L0An
         H1kIUB4aYWkbhOmIIYfv9XFLo3sGAjAN+E9DFmv8o3OwvICmFr/GFEaHV6io0iRgb4Xw
         TKgq+TMHlsM8kvkmAm5AgF6LvwfCcuWG8pw9a/SIlV+uN1sAqqXKu4HNsqMHA0F+hVX7
         STCOrQPRirNMD1XlQUJ3OH7FXNMrnk5Am8T9FOa82SBTLPdYykwkw/YbbC5QH8EzZzOA
         60DA==
X-Gm-Message-State: AOAM533kaacPd4vzaOAdhw30lQBLJFwYTVv9tlR0Xxbd15TIuMz/qJbt
        MGXXJvohuvM6C0ZVYhBDERddEQ==
X-Google-Smtp-Source: ABdhPJxwx9njZKYS6LhVNn0HXdr1kMTRLK9xUdhIxjnFvsH7nM6Grh2Lg7goB5XLHYbemCIyNs6ZNA==
X-Received: by 2002:a17:902:a714:b029:e3:1cd:a033 with SMTP id w20-20020a170902a714b02900e301cda033mr1819123plq.27.1614824793472;
        Wed, 03 Mar 2021 18:26:33 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 184sm27495857pfc.176.2021.03.03.18.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 18:26:32 -0800 (PST)
Date:   Wed, 03 Mar 2021 18:26:32 -0800 (PST)
X-Google-Original-Date: Wed, 03 Mar 2021 18:26:29 PST (-0800)
Subject:     Re: [PATCH] Documentation/admin-guide: kernel-parameters: correct the architectures for numa_balancing
In-Reply-To: <20210302084159.33688-1-song.bao.hua@hisilicon.com>
CC:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        song.bao.hua@hisilicon.com, mgorman@suse.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, paulmck@kernel.org, rdunlap@infradead.org,
        akpm@linux-foundation.org, tglx@linutronix.de,
        mchehab+huawei@kernel.org, viresh.kumar@linaro.org,
        mike.kravetz@oracle.com, peterz@infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     song.bao.hua@hisilicon.com
Message-ID: <mhng-a06d1543-65b7-49fa-87c7-f437ec1d85ea@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2021 00:41:59 PST (-0800), song.bao.hua@hisilicon.com wrote:
> X86 isn't the only architecture supporting NUMA_BALANCING. ARM64, PPC,
> S390 and RISCV also support it:
>
> arch$ git grep NUMA_BALANCING
> arm64/Kconfig:  select ARCH_SUPPORTS_NUMA_BALANCING
> arm64/configs/defconfig:CONFIG_NUMA_BALANCING=y
> arm64/include/asm/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
> powerpc/configs/powernv_defconfig:CONFIG_NUMA_BALANCING=y
> powerpc/configs/ppc64_defconfig:CONFIG_NUMA_BALANCING=y
> powerpc/configs/pseries_defconfig:CONFIG_NUMA_BALANCING=y
> powerpc/include/asm/book3s/64/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
> powerpc/include/asm/book3s/64/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
> powerpc/include/asm/book3s/64/pgtable.h:#endif /* CONFIG_NUMA_BALANCING */
> powerpc/include/asm/book3s/64/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
> powerpc/include/asm/book3s/64/pgtable.h:#endif /* CONFIG_NUMA_BALANCING */
> powerpc/include/asm/nohash/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
> powerpc/include/asm/nohash/pgtable.h:#endif /* CONFIG_NUMA_BALANCING */
> powerpc/platforms/Kconfig.cputype:      select ARCH_SUPPORTS_NUMA_BALANCING
> riscv/Kconfig:  select ARCH_SUPPORTS_NUMA_BALANCING
> riscv/include/asm/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
> s390/Kconfig:   select ARCH_SUPPORTS_NUMA_BALANCING
> s390/configs/debug_defconfig:CONFIG_NUMA_BALANCING=y
> s390/configs/defconfig:CONFIG_NUMA_BALANCING=y
> s390/include/asm/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
> x86/Kconfig:    select ARCH_SUPPORTS_NUMA_BALANCING     if X86_64
> x86/include/asm/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
> x86/include/asm/pgtable.h:#endif /* CONFIG_NUMA_BALANCING */
>
> On the other hand, setup_numabalancing() is implemented in mm/mempolicy.c
> which doesn't depend on architectures.
>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  Documentation/admin-guide/kernel-parameters.rst | 1 +
>  Documentation/admin-guide/kernel-parameters.txt | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> index 1132796a8d96..24302cad174a 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -140,6 +140,7 @@ parameter is applicable::
>  	PPT	Parallel port support is enabled.
>  	PS2	Appropriate PS/2 support is enabled.
>  	RAM	RAM disk support is enabled.
> +	RISCV	RISCV architecture is enabled.
>  	RDT	Intel Resource Director Technology.
>  	S390	S390 architecture is enabled.
>  	SCSI	Appropriate SCSI support is enabled.
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..371a02ae1e21 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3472,7 +3472,8 @@
>
>  	nr_uarts=	[SERIAL] maximum number of UARTs to be registered.
>
> -	numa_balancing=	[KNL,X86] Enable or disable automatic NUMA balancing.
> +	numa_balancing=	[KNL,ARM64,PPC,RISCV,S390,X86] Enable or disable automatic
> +			NUMA balancing.
>  			Allowed values are enable and disable
>
>  	numa_zonelist_order= [KNL, BOOT] Select zonelist order for NUMA.

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
