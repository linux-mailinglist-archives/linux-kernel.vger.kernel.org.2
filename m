Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5865541C526
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbhI2NE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:04:27 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48482
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344025AbhI2NE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:04:26 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9BBB63F4B9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 13:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632920564;
        bh=WQyoXTmGnA/i0/fq7CgN6IL65bEbPjXgHhQsmbo9nvw=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=f1jBEl6iMKQtk9NEr4L9HZpQyijNO2XRoEbF1cbkRYF9pCpic7FRfTWmQe5cVWTQ9
         iuI7IWEZfQi3h2Vp4ACYoYO+EuiF+6ma9TzBllyz6fkxEBvZeKbPxjobYoz0tF3sCn
         Kj8lNR5/qdblhPI4YUk3ncurDr8BfVDlmVhp8xJS8qCy1ktPy7WZUvM2uKfQzv15a6
         /3L3UF9Sp5yNRhXpCLjz1JbtQYMrHwwbCcihDnbeP00z9eQlHO7zDXaSTMwkpBvI98
         9Yan6cfxsVbL5xHu8T6bjP0lwjACncgpRump5HO0BqhFZOTEJm6nhmiI3GryrSz3ke
         qpp+9kpI7xC+Q==
Received: by mail-lf1-f70.google.com with SMTP id x4-20020a056512078400b003fc8e963f1dso2317512lfr.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 06:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WQyoXTmGnA/i0/fq7CgN6IL65bEbPjXgHhQsmbo9nvw=;
        b=DU7NzrithOLpJkJo+mTQcvOE0dyXQGhlT12faVl+8Cwq2mVFFsH248pdGPsW4vkNaN
         yovcnRQknm3rWS4DaHsGAkubAl6lH5zuJmgnXZQUiQSEBnMRO2u6bH1XpHbDsAdjRX/M
         1nMhcH4+xBEq2bW47earTwXqIub/McrnPZudUJSzi52eHOMYgn94RlFsIVGOEkZUWgm5
         1FWyMX9mPiAF23f7pTTFh4znXTqNB/iFK1E7ZOmjsOzXQgCHQXwdvDnmCDPoJQl/AjzF
         gqRMGJnk8Ok9gLYrEeLaWEp30E6S0GqsCIM2z7rWVYeu0FMP8x7iSQymj5YD5Aaolk+r
         QJLQ==
X-Gm-Message-State: AOAM5306YOOqNKUpgYWrObshsX23XRKtUiGw2PB7c1fVMCIaHK6B6QmB
        D1stZm+OavlhAIfKUgn61rNsEPWTV+kYkERjSKwHrJdEHpVe75FRgfXYF7EuQPjjHGBUqUNntj9
        iAvGizLu9OOB3tYUqlrb+2kJ02lVs0+fouPp7QWO4Jg==
X-Received: by 2002:ac2:5978:: with SMTP id h24mr11376830lfp.426.1632920562427;
        Wed, 29 Sep 2021 06:02:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0mrG6dmWb7waqTSD14bTgiM+wUm0WGoJ0bh+iZA1uG9aiIPJT8ie5QjhcT5bRPUqMJ0Rmww==
X-Received: by 2002:ac2:5978:: with SMTP id h24mr11376781lfp.426.1632920562152;
        Wed, 29 Sep 2021 06:02:42 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id q30sm158216lfb.108.2021.09.29.06.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 06:02:41 -0700 (PDT)
Subject: Re: [PATCH v2 00/12] arm64: Kconfig: Update ARCH_EXYNOS select
 configs
To:     Will McVicker <willmcvicker@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20210928235635.1348330-1-willmcvicker@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <7766faf8-2dd1-6525-3b9a-8ba790c29cff@canonical.com>
Date:   Wed, 29 Sep 2021 15:02:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928235635.1348330-1-willmcvicker@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2021 01:56, Will McVicker wrote:
> This is v2 of the series of patches that modularizes a number of core
> ARCH_EXYNOS drivers. Based off of the feedback from the v1 series, I have
> modularized all of the drivers that are removed from the ARCH_EXYNOS
> series of "select XXX". This includes setting the following configs as
> tristate:
> 
>  * COMMON_CLK_SAMSUNG
>  * EXYNOS_ARM64_COMMON_CLK
>  * PINCTRL_SAMSUNG
>  * PINCTRL_EXYNOS
>  * EXYNOS_PMU_ARM64
>  * EXYNOS_PM_DOMAINS
> 
> Additionally, it introduces the config EXYNOS_PMU_ARM64 and EXYNOS_PMU_ARM
> which was previously EXYNOS_PMU and EXYNOS_PMU_ARM_DRIVERS respectively.
> The reason for these new configs is because we are not able to easily
> modularize the ARMv7 PMU driver due to built-in arch dependencies on
> pmu_base_addr under arch/arm/mach-exynos/*. So the new configs split up
> the ARM and ARM64 portions into two separate configs.
> 
> Overall, these drivers didn't require much refactoring and converted to
> modules relatively easily. However, due to my lack of exynos hardware, I
> was not able to boot test these changes. I'm mostly concerned about the
> CLK_OF_DECLARE() changes having dependencies on early timers. So I'm
> requesting help for testing these changes on the respective hardware.
> 

These are all not tested at all? In such case, since these are not
trivial changes, please mark the series as RFT.

I will not be able to test these for some days, so it must wait.


Best regards,
Krzysztof
