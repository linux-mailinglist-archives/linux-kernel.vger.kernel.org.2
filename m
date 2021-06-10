Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF863A25A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFJHnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:43:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41131 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:43:00 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrFJG-0001Yc-Nh
        for linux-kernel@vger.kernel.org; Thu, 10 Jun 2021 07:41:02 +0000
Received: by mail-wm1-f72.google.com with SMTP id a25-20020a7bc1d90000b029019dd2ac7025so2732883wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e2+wIvEzXuddcIq0HptNZ4S2HwP4Xp1f1Y9ZwuawFc4=;
        b=Psj5vGH/LBhc3gbJliSBk9jurxVjHYzph7K05MjfVMW+zqAp3DigBr0+lbuKizO/8x
         xPMEymNqU8goyIa/0U4ApQqkBcYiP004+ND58hUcn3xHjKH+nS7iI2O3poU+yBUus5rm
         D/bwqiU5Z+j5C1zHOX19mDhwVRLfGXJjt6AYKobiiG5aSrccvIct5je9LiliNiVqAfTu
         +93usjXyGUZwTQfRrcKAj7qYUTHgr4+55qUDZm2Kw2i6bk7OcUy1kfi70ZuIqYaK3tYk
         IKRJGjkHm993sNVgMCiRRbYCsoMPD2ks9x5eUH2oVNnwUaeIo85Yj2a/eF4bADybTowA
         xJyg==
X-Gm-Message-State: AOAM5325PPgwzrlNa+ihRoBcNwEFcwosSx6u64mh/nlFGvZWjUUAI1SX
        Xf8+3RxrvteyKGz8IASJ/CmMIB8k8WhUQS7lbTOFdzeZzB/BVD4ACs/O7iQgnV2IKr59mNANR8J
        uLJEx3kUp+vcYcTfP+VML4zPY5I5CLDf/0apDHjZk9A==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr3761845wrv.80.1623310862384;
        Thu, 10 Jun 2021 00:41:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZwFM7Mtml6+tDBHWQSvn1Ol2Wwfw1kgdH8lO0D7YcHyNXXoa62MbbMN9e/Cmg+98Wt0tHsw==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr3761833wrv.80.1623310862249;
        Thu, 10 Jun 2021 00:41:02 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id k11sm8417229wmj.1.2021.06.10.00.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:41:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] ARM: dts: samsung: pull for v5.14
Date:   Thu, 10 Jun 2021 09:40:54 +0200
Message-Id: <20210610074055.12474-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Few DTS changes. I will have slightly later also pulls for ARM64 and defconfig.

Best regards,
Krzysztof


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.14

for you to fetch changes up to 135adbbee4c66f89b57519633cbf8c3c35b6c4da:

  ARM: dts: exynos: Disable unused camera input for I9100 (2021-05-31 17:53:00 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.14

1. Several cleanups and alignment with dtschema.  This includes removal
   of unused properties and fixing LED brightness property.
2. Enable PMIC RTC interrupt as a wakeup source (intended to wakeup for
   example from Suspend to RAM where the PMIC RTC's power is still
   supplied).
3. Disable unused/not implemented camera on GT-I9100.

----------------------------------------------------------------
Krzysztof Kozlowski (16):
      ARM: dts: exynos: align Broadcom WiFi with dtschema
      ARM: dts: exynos: replace legacy MMS114 touchscreen x/y properties in GT-N7100
      ARM: dts: exynos: fix PWM LED max brightness on Odroid XU/XU3
      ARM: dts: exynos: fix PWM LED max brightness on Odroid HC1
      ARM: dts: exynos: fix PWM LED max brightness on Odroid XU4
      ARM: dts: s5pv210: remove unused Atmel touchscreen properties in Goni
      ARM: dts: exynos: enable PMIC wakeup from suspend on Itop Core
      ARM: dts: exynos: enable PMIC wakeup from suspend on Origen4412
      ARM: dts: exynos: enable PMIC wakeup from suspend on Arndale
      ARM: dts: exynos: enable PMIC wakeup from suspend on Odroid XU
      ARM: dts: exynos: enable PMIC wakeup from suspend on Midas
      ARM: dts: exynos: enable PMIC wakeup from suspend on Odroid X/U3
      ARM: dts: exynos: enable PMIC wakeup from suspend on P4 Note
      ARM: dts: exynos: enable PMIC wakeup from suspend on Arndale Octa
      ARM: dts: exynos: enable PMIC wakeup from suspend on SMDK5420
      ARM: dts: exynos: enable PMIC wakeup from suspend on Odroid XU3/XU4 family

Timon Baetz (1):
      ARM: dts: exynos: Disable unused camera input for I9100

 arch/arm/boot/dts/exynos3250-rinato.dts         | 2 +-
 arch/arm/boot/dts/exynos4210-i9100.dts          | 8 +++++---
 arch/arm/boot/dts/exynos4210-trats.dts          | 2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 2 +-
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 1 +
 arch/arm/boot/dts/exynos4412-midas.dtsi         | 1 +
 arch/arm/boot/dts/exynos4412-n710x.dts          | 4 ++--
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
 arch/arm/boot/dts/exynos4412-origen.dts         | 1 +
 arch/arm/boot/dts/exynos4412-p4note.dtsi        | 1 +
 arch/arm/boot/dts/exynos5250-arndale.dts        | 1 +
 arch/arm/boot/dts/exynos5410-odroidxu.dts       | 1 +
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   | 1 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts       | 1 +
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi   | 1 +
 arch/arm/boot/dts/exynos5422-odroidhc1.dts      | 2 +-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts      | 2 +-
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi | 4 ++--
 arch/arm/boot/dts/s5pv210-goni.dts              | 9 ---------
 19 files changed, 24 insertions(+), 21 deletions(-)
