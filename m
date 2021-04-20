Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B25365E14
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhDTRCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:02:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50059 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhDTRCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:02:05 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtkg-0004Rs-TZ
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 17:01:31 +0000
Received: by mail-ej1-f72.google.com with SMTP id r14-20020a1709062cceb0290373a80b4002so5026042ejr.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHsQSEUOmORiTB8Zkf0mC2OREpdRoRDZ4OLN4iMgWKc=;
        b=qdAm2nnEALvYzGR8YgKUxmNu91yKGsdGUVcEVIaEz1Gq60lxtse876Quz3uuamAtUI
         at3MSeDiOoQHi9mtQRGxVxwmTCCHxC3cGOBvZTvbXpyptDwC690UvU2DkFLKs2Pg32QG
         b+q52x7XdzBbt9gwlev9uaDJz8bvG2N8Pvu5Cp+A+KXMdwGqIlKcvxC9TtnHzAqRM7Vo
         Vra2y4023B7GQ2tdRIE/kBhRiXA7fy4HV7DAg41IN9gzbFndYY/lU+ruqc1lRLEEtrrO
         oJcER4SB/1idX7tmEwcP6rcfkl9GikDHZvToNaKon7jnPPmymqiKqOHQsQdE/VAGfWoD
         mW6A==
X-Gm-Message-State: AOAM530VPpP+ycUfoDaLVFqIQRYGtu6q0/x/RjtLIZECnT4cbisSpCYU
        CzMSHVX8ijiDFPpi1pGkL2c+WclCCO33RxJMNJgisH5AsV/oRI2QHBabWnempMJFr1SsPe8NWbE
        VU+H1hfcIRBUR8IHZrd3bN4ExP8EuqbXztNTGHmrpLw==
X-Received: by 2002:a17:906:b353:: with SMTP id cd19mr28801326ejb.253.1618938090418;
        Tue, 20 Apr 2021 10:01:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWCjFUTB+i+AWDnumgO9r4qpi2r6FWXN4Xy3B0T5zjsqdLAfvrora74Xl3gg1bViJWFcX6bQ==
X-Received: by 2002:a17:906:b353:: with SMTP id cd19mr28801300ejb.253.1618938090234;
        Tue, 20 Apr 2021 10:01:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id x7sm16334441eds.67.2021.04.20.10.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 10:01:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 0/9] mfd/rtc/regulator: Drop board file support for Samsung PMIC
Date:   Tue, 20 Apr 2021 19:01:09 +0200
Message-Id: <20210420170118.12788-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Samsung PMIC drivers since long time are used only on devicetree
platforms (Samsung Exynos) and there are no users with board files.

Drop the support for board files entirely and depend on OF for matching.

This makes the code smaller and simpler.

Dependencies
============
The MFD pieces are rebased on my previous sec-core dirver changes:
mfd: sec: Simplify getting of_device_id match data
https://lore.kernel.org/linux-samsung-soc/20210420113929.278082-1-krzysztof.kozlowski@canonical.com/T/#t

Applying - can be independent
=============================
The last RTC and regulator patches can be picked up independently via
regulator and rtc trees.  There are no board files currently, so the
code in these drivers is basically dead code and feature-bisection is
preserved.

Best regards,
Krzysztof


Krzysztof Kozlowski (9):
  mfd: sec: Drop support for board files and require devicetree
  mfd: sec: Remove unused cfg_pmic_irq in platform data
  mfd: sec: Remove unused device_type in platform data
  mfd: sec: Remove unused irq_base in platform data
  mfd: sec: Enable wakeup from suspend via devicetree property
  mfd: sec: Remove unused platform data members
  rtc: s5m: Remove reference to parent's device pdata
  regulator: s2mpa01: Drop initialization via platform data
  regulator: s2mps11: Drop initialization via platform data

 drivers/mfd/Kconfig              |  1 +
 drivers/mfd/sec-core.c           | 64 +++++---------------------------
 drivers/mfd/sec-irq.c            |  4 +-
 drivers/regulator/s2mpa01.c      |  4 --
 drivers/regulator/s2mps11.c      | 22 +----------
 drivers/rtc/rtc-s5m.c            |  6 ---
 include/linux/mfd/samsung/core.h | 33 ----------------
 7 files changed, 14 insertions(+), 120 deletions(-)

-- 
2.25.1

