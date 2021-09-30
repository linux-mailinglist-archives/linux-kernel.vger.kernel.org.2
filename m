Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDDF41D9E4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350895AbhI3MgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350458AbhI3MgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:36:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA3AC06176F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:34:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x20so9779868wrg.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HRgJEndOuR4ynn0OPA7sKb8RToaEd1xX8/0RUVPc1gs=;
        b=PRGDsSbneH4StUFwwnRbLwzVrVS8dXAQMsfx9rpM11hullUX4XhH0L8xtDo2A/JSkh
         vfBLbBJodUO8FPeQngR5h+hr4KzarQc3FnV7xoLaGEAqs4Mq3Nxqk8Tka17mIGHBR8Od
         esOL2mV/wXFcVwgwNwRbo3Q3ZQnzpznbdz36TaU/MQyMq8aXDMshuKrRT/qvB5Sm90Uq
         GVOsPer9/U8+t0an4EcH7UcvvfTO0BqQiwyNuympdIbRjiTOy6VmqkBA9QuR13uL6a8c
         3cEBsixjLbEzKXW6P/6E1GmBNN1bveSx8Y12kRb7bitYdhJf98gFz7TxmEcyjy9XVeIp
         srug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HRgJEndOuR4ynn0OPA7sKb8RToaEd1xX8/0RUVPc1gs=;
        b=v9ougz9fNvgPxiAfMXPeq1Z3/LYt1YkiNMAyCT9ga2ITS9gqLLGSom19wBmO+aqg+6
         YQerV/M82fqDkCMT91Tql4joYcqo7IyYTy+pZF4PuKUxofGcUjcaNzi634acZy1b/O8V
         RC97rjFyCN/xABCeV/lPv5PoO0fnfZ0UJn7lMfYC+5eQ8WdN+e/a6qt0T5d2FJVRWDuu
         AVFxWsfHewYRHJGdnfFyizfyMHFG1tD+LQWs6j0ZJtfgN58hWc+YRfnBMx0K+/O+XWB5
         kNjIj23m0mKz03BlRLarTx4h3u8JrOvmK8zYxCW36gwvXBukI8noLC5P7NawFhzJ1f+h
         K+AQ==
X-Gm-Message-State: AOAM53323I99SMSNc43xv3LCSNK86fsyLLLi/ntm1Di/JdJuXK1srkzS
        yxAJfUGKDq++LHZbTS6F/DyqLQ==
X-Google-Smtp-Source: ABdhPJzruR/5Ef2zjhhdSPBNA0SVjA7uVPC3/lwtP8K1MW5Z2+vlJQr3w2Z7LogtLW9jhnrPbK8iNw==
X-Received: by 2002:a5d:66d0:: with SMTP id k16mr5973546wrw.98.1633005275981;
        Thu, 30 Sep 2021 05:34:35 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id u5sm3175142wrg.57.2021.09.30.05.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 05:34:35 -0700 (PDT)
Date:   Thu, 30 Sep 2021 13:34:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Will McVicker <willmcvicker@google.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Saravana Kannan <saravanak@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-rtc@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 00/12] arm64: Kconfig: Update ARCH_EXYNOS select
 configs
Message-ID: <YVWu2RoSqEzcG79I@google.com>
References: <20210928235635.1348330-1-willmcvicker@google.com>
 <7766faf8-2dd1-6525-3b9a-8ba790c29cff@canonical.com>
 <CABYd82YodFDwBxexCv+0hpYrdYEX1Z1CvnRkmnBPkEJNJ4bssQ@mail.gmail.com>
 <c65bf0db-6fd1-eb05-f407-37c41f9125f4@canonical.com>
 <CAK8P3a0zezKvexqvL29Oc44uQq-8QG7LwZy31VYJuYAYbh-Utw@mail.gmail.com>
 <YVWDsFE7qyH6AwxR@google.com>
 <8928290c-73d9-0843-25ed-2a4817ad32f7@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8928290c-73d9-0843-25ed-2a4817ad32f7@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021, Krzysztof Kozlowski wrote:
> >   It sounds like a lack of testing is your main concern.
> > 
> >   How can I help here?  What H/W do I need to be able to fully test this?
> 
> The changes here need to be tested on affected platforms (ARMv7 and
> ARMv8), when built as a modules on some types of regular distros (e.g.
> Arch, Ubuntu). From each of such boot I would be happy to see number of
> new dmesg warnings/errors plus number of probe deferrals.
> 
> Since the drivers could be switched to modules (and some distros might
> do it), they might be hit by surprise regressions in boot performance
> due to probe deferrals. This should be also checked on these platforms.
> Geert pointed out before that clocks in many cases are not optional -
> driver needs them and will wait defer.
> 
> Assuming of course that boot succeeds. Minor differences in boot speed
> should not be a problem, I think, because distro anyway chosen
> all-module approach so it accepts the penalty.

Do you have any suggestions in terms of devboards?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
