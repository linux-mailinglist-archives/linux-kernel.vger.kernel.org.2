Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCAA3B8B28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 02:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbhGAAYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 20:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbhGAAYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 20:24:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F426C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 17:22:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id a2so4388485pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 17:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aDnQQVopiKheNy1UmrcDKnk3g5arjbzcZ1y90JZZMEs=;
        b=M3wYEGtW3GTTHBiLO2Frsst4YQL4Cnl39+BXgG/RQwxVotP5Sa6p9h/ATQ2/JVZtlp
         CP3mu+tG5NrGUOI91b9fsO9nk+eXzOkzYWywp3TRvFLqtlfB5lzxdxYh7fGkAKSoOEM2
         CSMmS06vByZZiYM+bewyGDYmzsaOUfPpd2xmpju4H3+E4wI22B0SXPkaUUddMyIjHJ+o
         D5QUhNAPC+FTGZbqegNyctpPLY8yuKHRcRdeaByJkVb2jxikijyl6BujzqTQMaqbOxUu
         msWn589rNB72uXXM58oR3bSxMa/r/mxx8yVHRhma3JuJgAisLMrWPJxZ8P2wkgTNs2Zs
         gQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aDnQQVopiKheNy1UmrcDKnk3g5arjbzcZ1y90JZZMEs=;
        b=pQ51/ubHgBuK5YsuJ0Q2/E1/qDAoDNedHRrH6ao5cP9ou5XzgiLIqBY38O7DkDLNb6
         NtPjrPLqmRPyPNWbI8C1Yfv/AGE6NOFtpbhucM5Iaw7Z937IrVJaafJ8NkhFvm6xy1HZ
         +zCzksaRYKGZa2j6h8NaUeKKbnz8TqHb2W2oKqd7ZqB7WRXNC/7ryvzu8xYV6cSXFROi
         h0cIpvK9AeyBmRkCmOuVKTmB7lu64PWUQUo5BbL/r+C2qsNGf/TrMBocKJR55SK/oZ0W
         H99LmfaMUlIAR5w/ZPa2EXAGDmSU+GgHriGtjdPgMDK0xEuC3ODteuEyZI1oh/dqdUe6
         0bIA==
X-Gm-Message-State: AOAM531a4HbG3sgpfqf2m5yHfkmW9emRdnUYxp87Ewq3rEqFosqPnydb
        dObZEUmnYa9SsPBF1EowTOEkUw==
X-Google-Smtp-Source: ABdhPJw9dHks1Q2cYpLQ4+BAPxfbpT1UUQrH7in4l6B4aRPRkgWDW4GfL5ler7PScrKh481PnMGNDQ==
X-Received: by 2002:a62:e309:0:b029:310:dd66:a4ba with SMTP id g9-20020a62e3090000b0290310dd66a4bamr2138162pfh.13.1625098941778;
        Wed, 30 Jun 2021 17:22:21 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:8687:fcbc:6b3d:c844])
        by smtp.gmail.com with ESMTPSA id v6sm25117495pgk.33.2021.06.30.17.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 17:22:21 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [RFC PATH 0/2] gpio: starfive-jh7100: Add StarFive JH7100 GPIO bindings and driver
Date:   Wed, 30 Jun 2021 17:20:37 -0700
Message-Id: <20210701002037.912625-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings and driver for the GPIO controller in the
StarFive JH7100 SoC [1] used on the BeagleV Starlight JH7100 board [2].

The dts using "starfive,jh7100-gpio" is in StarFive's linux repo [3] and
is being cleaned up in preperation for submission.

[1] https://github.com/starfive-tech/beaglev_doc
[2] https://github.com/beagleboard/beaglev-starlight
[3] https://github.com/starfive-tech/linux/blob/beaglev/arch/riscv/boot/dts/starfive/jh7100.dtsi#L262

Drew Fustini (2):
  dt-bindings: gpio: add starfive,jh7100-gpio bindings
  gpio: starfive-jh7100: Add StarFive JH7100 GPIO driver

 .../bindings/gpio/starfive,jh7100-gpio.yaml   |  60 +++
 MAINTAINERS                                   |   8 +
 drivers/gpio/Kconfig                          |   8 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-starfive-jh7100.c           | 425 ++++++++++++++++++
 5 files changed, 502 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/starfive,jh7100-gpio.yaml
 create mode 100644 drivers/gpio/gpio-starfive-jh7100.c

-- 
2.27.0

