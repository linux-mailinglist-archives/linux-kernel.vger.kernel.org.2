Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D023530A9EE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhBAOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhBAOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:36:03 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D291FC061786;
        Mon,  1 Feb 2021 06:35:22 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hs11so24719935ejc.1;
        Mon, 01 Feb 2021 06:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p0y1B4xpVR87SDn57GPRXm1SVNsp6DiLP4/759/Wuh8=;
        b=K+gFxd8za+oG8OKw/uRdYOGMCOw2HY9GwIFkNWZ7xcPkEIZRMtze+PEmUIzexvr+6m
         /lKxD9Mo8DvphlsBGkZfh0oGgg0Q5Cg/60ueM/shhQk4DYMhzwgxNvNFfUUlQReqjHf+
         2xja190TvVsxgSJzxjyHZ7t8/HKxr48ucWiTO0PZw77E/l8lbirulVTLItKVcDy9RrXW
         lf5MNpMo6cR04iBo+AlqwP14StlmS8dW3k5lMY1o+X8VC4TU86YZ2AZc1MwffEY9LsUQ
         30jCI9H4J9TsUBfpO1zZZLOIeitQ7xEvFEKDUKM+NjzBhqVYa1uqPgDlbTQKNq9ldYAS
         fLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p0y1B4xpVR87SDn57GPRXm1SVNsp6DiLP4/759/Wuh8=;
        b=KFDo76rwd13kQ8ZHnQ5SrppE445s1CU947hlWd7QBMmZ0T86s073+ewTpLYtQYCTTc
         lejJVd/QRpXQic4GXsSyaE6nchWJ8LnFFAvVwnlpWRvVLM4/QZWHKh0oAE49gELhztRm
         PvTI9B54zjBaczTpWaEikdQINdBuNEVJM270GzkCtGWfqazzA9UBmJ7AUS/JPRmfeED4
         rwK2YXXOuq3i+TQ358ptwiCPwVAfeNAYeLVpSgXp/xFNzJ99fp44Gv7aprLwPzJbJWll
         /fomcckvF3uHfDgqytl5AEpugTDH1Z9fITVfD7HUh9xsNw+rQnCpOAmCRhM++2MOienI
         JBmg==
X-Gm-Message-State: AOAM532D9VV678Xy59u6xPZr3ibr3W9HHFV1knjm/hSF+D0xB86aXhKc
        ZMIHBLL6f8bswsQfs7uap0YDuIJ0AJju4EHWXfc=
X-Google-Smtp-Source: ABdhPJz0GTo2K7lAckez4yf/9SVspRZvlzqmrFBGfIp8PVdkBK8K6gn43IXHJGLCsvCKCe6raQcylQ==
X-Received: by 2002:a17:906:2e85:: with SMTP id o5mr6995806eji.238.1612190121269;
        Mon, 01 Feb 2021 06:35:21 -0800 (PST)
Received: from [10.8.0.2] (terefe.re. [5.255.96.200])
        by smtp.gmail.com with ESMTPSA id du6sm6377449ejc.78.2021.02.01.06.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 06:35:20 -0800 (PST)
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?Q?G=c3=a9rald_Kerma?= <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
References: <20210114124032.12765-1-pali@kernel.org>
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
Message-ID: <0d5518be-9b22-a714-f5f0-72aadc2eebf5@gmail.com>
Date:   Mon, 1 Feb 2021 15:35:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210114124032.12765-1-pali@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 14.01.2021 o 13:40, Pali Rohár pisze:
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
>   arm64: dts: marvell: armada-37xx: add syscon compatible to NB clk node
>   cpufreq: armada-37xx: Fix setting TBG parent for load levels
>   clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM
>     clock
> 
> Pali Rohár (7):
>   cpufreq: armada-37xx: Fix the AVS value for loads L0 and L1
>   clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250 Mhz to
>     1 GHz
>   clk: mvebu: armada-37xx-periph: Fix workaround for switching from L1
>     to L0
>   cpufreq: armada-37xx: Fix driver cleanup when registration failed
>   cpufreq: armada-37xx: Fix determining base CPU frequency
>   cpufreq: armada-37xx: Remove cur_frequency variable
>   cpufreq: armada-37xx: Fix module unloading

Hi.
After running this series for three days, the system is stable and the 
issue with switching frequency doesn't seem to be there anymore. So:

Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>

Thanks.

> 
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi |   3 +-
>  drivers/clk/mvebu/armada-37xx-periph.c       |  83 ++++++++-------
>  drivers/cpufreq/armada-37xx-cpufreq.c        | 100 ++++++++++++++-----
>  3 files changed, 124 insertions(+), 62 deletions(-)
> 


-- 
TMN
