Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A7333146
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhCIVu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhCIVuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:50:19 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D87C06174A;
        Tue,  9 Mar 2021 13:50:18 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id e17so3412071oow.4;
        Tue, 09 Mar 2021 13:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jkffniONoMC7mrwuhJlVEEW2S94cUNkXOU/qWJndqpE=;
        b=LUKRICsBmSP732ti8u2MmZY+7xpJM3UXAm6/Gbs0d189YG/t03m/4BRmBhYOAFXQYI
         9wMZ3fW4nWVsBj2QMYtIrq+SqghVo4hpEdZykvrohNF/3oDX+nsjZjKqwoLIh/KFIFCB
         66LHUqUuuChYXWJ5ceytLWMgMAxlTkOOUyVcdORX9abuvhPvrI9YbcwueBi1DzPjyQPQ
         KbJu/P7JO38CPCwK5JRqGOg7uzTROnyZ1ySOIrjbZJjzObSnRga5MOMmRvzyfJ9E9btI
         WzqhP4VBWxzcXvG2LLQQEm/TT1twmw5uZR7Zn7TLXYRENO5wj+os1lw2oGfSWqC446S1
         iLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jkffniONoMC7mrwuhJlVEEW2S94cUNkXOU/qWJndqpE=;
        b=HpROStq+j7XoE/KFtHqDS3TlapLTm9KKXVJIoUdHvwY3vua3Mmd3O65TgDo2xdnCVC
         cF0KMXHj2vDSekqiakQ98bIlL17YudeVY5ajIDCxkgHOZuJg3qTC0eZLR+ISckRiCidR
         6QtD4+0cmULlhRRteqQFAJqHU9vPZ/xkWv6+CZt3d9lo5VY/CAq55BnroxL/Lpw3MWtR
         coQ8SRzP43nIqD2vkvugEbJXLOKttm53+Ivyy+qGMrqPlGPTVU7sqzC6ivOIuPkAmCN/
         pqwuvvElsiSsk/QqOeMntHCuCPdWbUO5J0tUwNfqHhcw5THSIyPDIcWM2n1nM1sI2UT3
         il8g==
X-Gm-Message-State: AOAM532crL8NnAtuzZdLo8uZl1RtyYJreVski6L1albOwnimk66so/Vh
        ej3C2MFdjHzDjmyyY/hKDR8iXQwYZBcQ3A==
X-Google-Smtp-Source: ABdhPJzASJcp1j0AdrSTwZMco/0vwMftXQ42TqNlgg420+HW0d3kOw1qud87t2xgixtpPKprG6Yn/w==
X-Received: by 2002:a05:6820:451:: with SMTP id p17mr2696148oou.93.1615326618286;
        Tue, 09 Mar 2021 13:50:18 -0800 (PST)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id s193sm71560oih.52.2021.03.09.13.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 13:50:17 -0800 (PST)
Subject: Re: [PATCH v2 00/14] Introduce STM32MP1 RCC in secured mode
To:     gabriel.fernandez@foss.st.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>, marex@denx.de,
        Marek Vasut <marex@denx.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <2e04f814-b694-119d-fe8a-13e6df129536@gmail.com>
Date:   Tue, 9 Mar 2021 15:50:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 3:01 AM, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> Platform STM32MP1 can be used in configuration where some clocks and
> IP resets can relate as secure resources.
> These resources are moved from a RCC clock/reset handle to a SCMI
> clock/reset_domain handle.
> 
> The RCC clock driver is now dependent of the SCMI driver, then we have
> to manage now the probe defering.
> 
> v1 -> v2:
>    - fix yamllint warnings.

Hi Gabriel,

I don't have much clout with the maintainers, but I have to NAK this 
series after finding major breakage.

The problem with series is that it breaks pretty much every board it 
touches. I have a DK2 here that I'm using for development, which no 
longer boots with this series applied.

The crux of the matter is that this series assumes all boards will boot 
with an FSBL that implements a very specific SCMI clock tree. This is 
major ABI breakage for anyone not using TF-A as the first stage 
bootloader. Anyone using u-boot SPL is screwed.

This series imposes a SOC-wide change via the dtsi files. So even boards 
that you don't intend to convert to SCMI will get broken this way. 
Adding a -no-scmi file that isn't used anywhere doesn't help things.

Here's what I suggest:

Generate new dtb files for those boards that you want to convert. So you 
would get:
   - stm32mp157c-dk2.dtb # Good old hardware clocks
   - stm32mp157c-dk2-secure-rcc.dtb # Clocks accessible by scmi.

A lot of users use a larger build system where they extract the relevant 
files. With the scheme I'm proposing you don't break their builds, and 
you allow SCMI users to have upstream support.

This means that you'll have to rethink the DTS and DTSI changes to 
accomodate both use cases.

Thanks,
Alex




> 
> Gabriel Fernandez (14):
>    clk: stm32mp1: merge 'clk-hsi-div' and 'ck_hsi' into one clock
>    clk: stm32mp1: merge 'ck_hse_rtc' and 'ck_rtc' into one clock
>    clk: stm32mp1: remove intermediate pll clocks
>    clk: stm32mp1: convert to module driver
>    clk: stm32mp1: move RCC reset controller into RCC clock driver
>    reset: stm32mp1: remove stm32mp1 reset
>    dt-bindings: clock: add IDs for SCMI clocks on stm32mp15
>    dt-bindings: reset: add IDs for SCMI reset domains on stm32mp15
>    dt-bindings: reset: add MCU HOLD BOOT ID for SCMI reset domains on
>      stm32mp15
>    clk: stm32mp1: new compatible for secure RCC support
>    ARM: dts: stm32: define SCMI resources on stm32mp15
>    ARM: dts: stm32: move clocks/resets to SCMI resources for stm32mp15
>    dt-bindings: clock: stm32mp1 new compatible for secure rcc
>    ARM: dts: stm32: introduce basic boot include on stm32mp15x board
> 
>   .../bindings/clock/st,stm32mp1-rcc.yaml       |   6 +-
>   arch/arm/boot/dts/stm32mp15-no-scmi.dtsi      | 158 ++++++
>   arch/arm/boot/dts/stm32mp151.dtsi             | 127 +++--
>   arch/arm/boot/dts/stm32mp153.dtsi             |   4 +-
>   arch/arm/boot/dts/stm32mp157.dtsi             |   2 +-
>   arch/arm/boot/dts/stm32mp15xc.dtsi            |   4 +-
>   drivers/clk/Kconfig                           |  10 +
>   drivers/clk/clk-stm32mp1.c                    | 495 +++++++++++++++---
>   drivers/reset/Kconfig                         |   6 -
>   drivers/reset/Makefile                        |   1 -
>   drivers/reset/reset-stm32mp1.c                | 115 ----
>   include/dt-bindings/clock/stm32mp1-clks.h     |  27 +
>   include/dt-bindings/reset/stm32mp1-resets.h   |  15 +
>   13 files changed, 704 insertions(+), 266 deletions(-)
>   create mode 100644 arch/arm/boot/dts/stm32mp15-no-scmi.dtsi
>   delete mode 100644 drivers/reset/reset-stm32mp1.c
> 
