Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6951230E347
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhBCTaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhBCTaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:30:07 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261DCC0613ED;
        Wed,  3 Feb 2021 11:29:26 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s3so1019588edi.7;
        Wed, 03 Feb 2021 11:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kganplicPJBtwsmEI4JfIkH23qpfQn4/Bhh9N1J6RWQ=;
        b=EqmWumb9cTIW9KJ2CVDuCnJaWM2zg+pHCTuTha9gAHKaBxe0BkB5pm5AJQBxOBwl1+
         zGTpq98Fd/5P/sAjjPnQKKZEm68D4d0ztJTITQfF6woINj/19E1T3RfePPdGCILg7jYs
         UncM5PNCRC9MpvI+Cz/2fi8kJV8zPaTTk42H1huobWoiM2/R/6ClQ9wDH8ucEtxt82bt
         ferhpwG66ZFHpv3gd30U/7M6Ol4ohTJlaaaMglTu2nNNq+6bVzZozzusQXcejz50feWg
         rHRMGQkZOYOtzklaQe+mj8wQcFs7lwrFWueXZwaezS8/aPm4oST9oSVt9gPisOO0mW1T
         Ielg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kganplicPJBtwsmEI4JfIkH23qpfQn4/Bhh9N1J6RWQ=;
        b=VFzHfgJNXl2XeIHQjUqGBzperHi/dyIaQEu4TxJymEPpM9K3LNsEJLwOO7LFhJeSKy
         L6QUa0aYqAgacUQGvn229TxWMgw/ZSDYVnaLPFxrWoZP6w1ZxuYWEOX10THUFfOPK8Pn
         eG4VRxnoDBA/ikYjYWdbHsZQlrDFOwfNLZMrHkeJNjqqlz9fbAed4/eK26v98rLLZhAE
         tP4gsbkKb5Aa9l1tVl+Qqnr4euLINjRZ6zckuzeZ/qz84Y9avoHMkpw8aCt4rTGhpOfI
         zmm6O/prbbTpYP4Fvvk2+IES82JNTKZFesTNIAupT4tsmb/3ka/AKRqSq4a8p/t+nSxx
         8d9Q==
X-Gm-Message-State: AOAM531aZD+PnNx1uvTWpzw3iqBbfCJWrTn+nmAVtt90EWsPDvCKAu5t
        yF5IslYXKmHKqPLzueuFLHU=
X-Google-Smtp-Source: ABdhPJx6nqFq5SK0benwWJ8qvmP4f/eNKzmsfV2KZjJ7c4flbUDcLi90U5agyYDzv1FmC08eaFqurA==
X-Received: by 2002:aa7:d6d4:: with SMTP id x20mr4838119edr.8.1612380564813;
        Wed, 03 Feb 2021 11:29:24 -0800 (PST)
Received: from [192.168.10.61] (74-13-107-185.static.kviknet.dk. [185.107.13.74])
        by smtp.gmail.com with ESMTPSA id f6sm1377348edk.13.2021.02.03.11.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 11:29:24 -0800 (PST)
Subject: Re: [PATCH mvebu v2 00/10] Armada 37xx: Fix cpufreq changing base CPU
 speed to 800 MHz from 1000 MHz
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?Q?G=c3=a9rald_Kerma?= <gerald@gk2.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>
References: <20210114124032.12765-1-pali@kernel.org>
From:   Anders Trier Olesen <anders.trier.olesen@gmail.com>
Message-ID: <cf766197-666f-3d7d-3b9e-ba512619004e@gmail.com>
Date:   Wed, 3 Feb 2021 20:29:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114124032.12765-1-pali@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek & Pali

On 1/14/21 1:40 PM, Pali Rohár wrote:
> Hello!
> 
> The armada-37xx-cpufreq driver changes base CPU speed from 1000 MHz to
> 800 MHz on EspressoBIN and Turris MOX. The commit message in patch 2/10
> explains why and how can this be discovered.
> 
> That patch 2/10 led us to discover another bug, in the SOC itself,
> that causes the CPU to behave weirdly when frequency changes to 1 GHz.
> A similar erratum is documented by Marvell but only for systems where
> base frequency is 1.2 GHz.
> 
> We've discovered that to make cpufreq scaling stable on Armada 3720
> systems with base frequency 1 GHz, we also have to set voltage levels
> for L0 and L1 loads to at least 1108 mV. We were led to this by patch we
> found in Marvell kernel fork. Fix is in the patch 4/10.
> 
> https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/dc33b62c90696afb6adc7dbcc4ebbd48bedec269
> 
> During fixing this voltage issue for 1 GHz we discovered another bug in
> armada-37xx-cpufreq driver that causes CPU instability. Erratum for VDD
> stabilization was improperly implemented, details are in patch 6/10.
> 
> This patch series is also available in my git tree in branch a3720-cpufreq-issues:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=a3720-cpufreq-issues
> 
> We have tested this patch series on Espressobin v5 and Turris MOX
> boards. If you have other Armada 3720 boards (Espressobin v5/v7, uDPU,
> Devel Board, ...) then it will be nice to do an additional tests and
> check if instability issues are finally fixed.
> 
> There is a discussion on armbian forum that Espressobin v7 is unstable
> when running at 1 GHz and in this thread was also mentioned above
> voltage patch from Marvell kernel fork:
> 
> https://forum.armbian.com/topic/10429-how-to-make-espressobin-v7-stable/
> 
> Marek & Pali
> 
> 
> Marek Behún (3):
>    arm64: dts: marvell: armada-37xx: add syscon compatible to NB clk node
>    cpufreq: armada-37xx: Fix setting TBG parent for load levels
>    clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM
>      clock
> 
> Pali Rohár (7):
>    cpufreq: armada-37xx: Fix the AVS value for loads L0 and L1
>    clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250 Mhz to
>      1 GHz
>    clk: mvebu: armada-37xx-periph: Fix workaround for switching from L1
>      to L0
>    cpufreq: armada-37xx: Fix driver cleanup when registration failed
>    cpufreq: armada-37xx: Fix determining base CPU frequency
>    cpufreq: armada-37xx: Remove cur_frequency variable
>    cpufreq: armada-37xx: Fix module unloading
> 
>   arch/arm64/boot/dts/marvell/armada-37xx.dtsi |   3 +-
>   drivers/clk/mvebu/armada-37xx-periph.c       |  83 ++++++++-------
>   drivers/cpufreq/armada-37xx-cpufreq.c        | 100 ++++++++++++++-----
>   3 files changed, 124 insertions(+), 62 deletions(-)
> 

Thank you for looking at this problem!

I have tested your a3720-cpufreq-issues branch on my Espressobin v7 (1GB 
variant) with the ondemand governor. No issues so far.

root@espressobin:~# uname -a
Linux espressobin 5.11.0-rc1+ #1 SMP PREEMPT Sun Jan 31 23:35:17 CET
2021 aarch64 aarch64 aarch64 GNU/Linux
root@espressobin:~# cpufreq-info
cpufrequtils 008: cpufreq-info (C) Dominik Brodowski 2004-2009
Report errors and bugs to cpufreq@vger.kernel.org, please.
analyzing CPU 0:
    driver: cpufreq-dt
    CPUs which run at the same hardware frequency: 0 1
    CPUs which need to have their frequency coordinated by software: 0 1
    maximum transition latency: 0.97 ms.
    hardware limits: 200 MHz - 1000 MHz
    available frequency steps: 200 MHz, 250 MHz, 500 MHz, 1000 MHz
    available cpufreq governors: conservative, ondemand, userspace,
powersave, performance, schedutil
    current policy: frequency should be within 200 MHz and 1000 MHz.
                    The governor "ondemand" may decide which speed to use
                    within this range.
    current CPU frequency is 1000 MHz (asserted by call to hardware).
    cpufreq stats: 200 MHz:34.71%, 250 MHz:13.20%, 500 MHz:6.26%, 1000
MHz:45.83%  (2015)
analyzing CPU 1:
    driver: cpufreq-dt
    CPUs which run at the same hardware frequency: 0 1
    CPUs which need to have their frequency coordinated by software: 0 1
    maximum transition latency: 0.97 ms.
    hardware limits: 200 MHz - 1000 MHz
    available frequency steps: 200 MHz, 250 MHz, 500 MHz, 1000 MHz
    available cpufreq governors: conservative, ondemand, userspace,
powersave, performance, schedutil
    current policy: frequency should be within 200 MHz and 1000 MHz.
                    The governor "ondemand" may decide which speed to use
                    within this range.
    current CPU frequency is 500 MHz (asserted by call to hardware).
    cpufreq stats: 200 MHz:34.71%, 250 MHz:13.20%, 500 MHz:6.26%, 1000
MHz:45.83%  (2015)

root@espressobin:~# 7za b

7-Zip (a) [64] 16.02 : Copyright (c) 1999-2016 Igor Pavlov : 2016-05-21
p7zip Version 16.02 (locale=en_US.UTF-8,Utf16=on,HugeFiles=on,64 bits,2
CPUs LE)

LE
CPU Freq:   974   997   993   996   997   997   996   997

RAM size:     983 MB,  # CPU hardware threads:   2
RAM usage:    441 MB,  # Benchmark threads:      2

                         Compressing  |                  Decompressing
Dict     Speed Usage    R/U Rating  |      Speed Usage    R/U Rating
           KiB/s     %   MIPS   MIPS  |      KiB/s     %   MIPS   MIPS

22:        879   153    560    856  |      21904   199    941   1870
23:        871   154    576    888  |      21518   199    938   1863
24:        863   154    603    928  |      21147   199    935   1857
25:        857   154    634    979  |      20885   199    934   1859
----------------------------------  | ------------------------------
Avr:             154    593    913  |              199    937   1862
Tot:             176    765   1387


Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>

Thanks,
Anders Trier Olesen
