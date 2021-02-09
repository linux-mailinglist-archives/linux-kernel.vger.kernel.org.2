Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7709F315C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhBJBgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhBIWHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:07:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E891C08EB23
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 13:51:58 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u14so23899296wri.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 13:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7B1ZkR0uagcsDTEEwhmbCjTQMtDSTrQGmwoFrMWzdXI=;
        b=g6DK5UolerRqPFIlISdjbU5vDGFGrZhw0by0G3DLaUzcIXaF/lSGx0lEasmrE3ARu/
         sbzZ1iXwD2i2fn2wAlI+8V8Z+vyYEf2945XpqLtwL2ZCqRp8LpOhoOeAqbFXiV16ZA7m
         +Uk68yE5aJ39wK1Ttr0JH24W79ly+RW+4UvPkEuRq3BFLaAh7WKY3jKACBfiEDNZUUNg
         Unn7MfP/t7MZ2h0osBMRh1KmripbKY2Kl181mmWmwTt16/cHPhux+DvV3RQ/OZ3Dg9Un
         2lc/X6LxXJGbw38lFi64iR2mryI4BpF1g2kj9j5ZECK7RAUaQtmI0tT83vJqmIuvC7Yv
         +WBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7B1ZkR0uagcsDTEEwhmbCjTQMtDSTrQGmwoFrMWzdXI=;
        b=jrWDh6TKgQCkJuvHrqllRr3SqJPn4dm+Hwmk9kiKp5UaK22HsLIjcsFKRGad+U2Fka
         7Llg+TP1sT82xix5DjMaNdD8DVsoBKd8/09AJyPMgJAJiqfeUU2Z1SqCpcN7rEylYh3o
         rvBxCx/AtVY6s3sAwY/Z5c12C1C7z0wg3SiXVWYp/MmSz3b+oqsnm2qUAR/kYZ+tJGoj
         a7Z9gWKPY0SgpEjxy+If+7h7/9lXosfuaOSx1NUx51dUGf+p2RmxPKaBdVvbFDVAVYLa
         kxtCTZJK82hS630mQfd+BQIxPcAqXB89ybPaSdGNa7VJECr+KNoe3oY4Bg9dfzpwi4wb
         M1Bw==
X-Gm-Message-State: AOAM531gIDdOZht2tsXmuasdaoBn8zrBEL+6BoInkheC/rWx/cEnghXw
        P/0a/7o5izoi+pPZoZo9YXPnNA==
X-Google-Smtp-Source: ABdhPJycBNhbjzeRHvTSOFIYE340XSbFkuThJ5741p4eE/sCdx8bQv/sPD4G+07bf1z+mKCq/jnp8w==
X-Received: by 2002:adf:d20c:: with SMTP id j12mr122554wrh.407.1612907516605;
        Tue, 09 Feb 2021 13:51:56 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:4cbf:512d:a355:e705? ([2a01:e34:ed2f:f020:4cbf:512d:a355:e705])
        by smtp.googlemail.com with ESMTPSA id g16sm75153wmi.30.2021.02.09.13.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 13:51:55 -0800 (PST)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        j.neuschaefer@gmx.net
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v5.12
Message-ID: <3747fbde-134f-5e1d-47d5-8776c1a52aa1@linaro.org>
Date:   Tue, 9 Feb 2021 22:51:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

please consider pulling the following changes for v5.12.

Thanks

  -- Daniel


The following changes since commit e85c1d21b16b278f50d191155bc674633270e9c6:

  clocksource/drivers/timer-microchip-pit64b: Add clocksource
suspend/resume (2021-02-03 09:36:50 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
tags/timers-v5.12-rc1

for you to fetch changes up to e85c1d21b16b278f50d191155bc674633270e9c6:

  clocksource/drivers/timer-microchip-pit64b: Add clocksource
suspend/resume (2021-02-03 09:36:50 +0100)

----------------------------------------------------------------
- Drop dead code on efm32 (Uwe Kleine-König)

- Move pr_fmt() before the includes on davinci driver (Bartosz
  Golaszewski)

- Clarified timer interrupt must be specified on nuvoton DT bindings
  (Jonathan Neuschäfer)

- Remove tango, sirf, u300 and atlas timer drivers (Arnd Bergman)

- Add suspend/resume on pit64b (Claudiu Beznea)



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
