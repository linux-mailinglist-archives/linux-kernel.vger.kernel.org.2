Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14173564A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhDGG6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:58:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59004 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345875AbhDGG6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:58:49 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lU299-0000eD-7a
        for linux-kernel@vger.kernel.org; Wed, 07 Apr 2021 06:58:39 +0000
Received: by mail-wr1-f69.google.com with SMTP id f3so11240092wrt.14
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 23:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zf/0xmgkd8JXssWxjuLFbhP71v2tVuYVuW0VdB/t3GU=;
        b=Q5wJ2gw0SvWVxSuo1oG3oioHH6JNbfPnhXyO/3Yb4MlScqsHd9DQ173veTqfa3sJmQ
         DFQ62kzfM8C71C/8p6c5YkRs1CN2pZrdx6C4cvv5OXjaF2upe0Okl0bsBedAzyX8ljtW
         7l6JgL53xrLoINfLyHbl2Zf7EYmqsob4ow2Fst5RmCUyOa03+rQMdw6MyTuRzUXDjFAd
         ZmR6pOujdAyvGrbg1cpo2qSfcAK3yuu/lPBUVbD/fBPTGA/xxb9TcTGX1BNf0WqheDXM
         2aL2s2iMOzZ1gcDW+T4npeoVVnkF4FgE5y+1MrgMwyWRSTseYOp5kya9+s1YTbVNcwm4
         E61g==
X-Gm-Message-State: AOAM532tyY4fmb+O5pwVsfPA5zZK7Vm4ydwqkO/RDlAjj8gl+APxDXsM
        rJz0CYBLfkFlarM8v4yMNCA2mOvDRTY7JwwSnTxNBNdMwveKUABLcWgaNAlj4SDUiwHfGoAgACH
        RooxPCyWxtAD4B8E+Nu/Af+HW2CPaMERVu5fkKqzsQQ==
X-Received: by 2002:adf:ee0f:: with SMTP id y15mr2377223wrn.43.1617778718585;
        Tue, 06 Apr 2021 23:58:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9IcdaSKcj+GrigVRg0Helk2YtTBPvlNhfhdALWQNwbMWOwjMQ3kKaSPfk/Wup3uyGbo1/Gg==
X-Received: by 2002:adf:ee0f:: with SMTP id y15mr2377204wrn.43.1617778718408;
        Tue, 06 Apr 2021 23:58:38 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id c16sm2410506wrx.46.2021.04.06.23.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:58:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/3] ARM: dts: samsung: Pull for v5.13
Date:   Wed,  7 Apr 2021 08:58:26 +0200
Message-Id: <20210407065828.7213-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.13

for you to fetch changes up to 7f4ebf3e4ce10a1ed8ff2aee5d75568dc3522b2f:

  ARM: dts: exynos: Add front camera support to I9100 (2021-03-28 20:10:09 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.13

1. Configure battery charger and front camera on GT-I9100 phone.
2. Fix in several boards the Maxim PMIC/MUIC/fuel gauge interrupt flags
   to match real type of interrupt coming from the device.
3. Correct DTS with dtschema.  This brings back the commit adding input
   clock to CMU in Exynos4412 Odroid which was reverted some time ago
   due to unsupported deferred probes (now supported and tested).

----------------------------------------------------------------
Krzysztof Kozlowski (13):
      ARM: dts: exynos: correct fuel gauge interrupt trigger level on GT-I9100
      ARM: dts: exynos: correct fuel gauge interrupt trigger level on P4 Note family
      ARM: dts: exynos: correct fuel gauge interrupt trigger level on Midas family
      ARM: dts: exynos: correct MUIC interrupt trigger level on Midas family
      ARM: dts: exynos: correct PMIC interrupt trigger level on Midas family
      ARM: dts: exynos: correct PMIC interrupt trigger level on Odroid X/U3 family
      ARM: dts: exynos: correct PMIC interrupt trigger level on P4 Note family
      ARM: dts: exynos: correct PMIC interrupt trigger level on SMDK5250
      ARM: dts: exynos: correct PMIC interrupt trigger level on Snow
      ARM: dts: s5pv210: correct fuel gauge interrupt trigger level on Fascinate family
      ARM: dts: exynos: add input clock to CMU in Exynos4412 Odroid
      ARM: dts: exynos: replace deprecated NTC/Murata compatibles
      ARM: dts: exynos: white-space cleanups

Timon Baetz (2):
      ARM: dts: exynos: add charger supply for I9100
      ARM: dts: exynos: Add front camera support to I9100

 arch/arm/boot/dts/exynos3250-monk.dts           |  4 +-
 arch/arm/boot/dts/exynos3250-rinato.dts         |  4 +-
 arch/arm/boot/dts/exynos4210-i9100.dts          | 56 ++++++++++++++++++++++++-
 arch/arm/boot/dts/exynos4412-midas.dtsi         |  6 +--
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  5 ++-
 arch/arm/boot/dts/exynos4412-odroidx.dts        |  3 +-
 arch/arm/boot/dts/exynos4412-p4note.dtsi        |  4 +-
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi   | 48 ++++++++++-----------
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |  2 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi   |  2 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi       | 28 ++++++-------
 arch/arm/boot/dts/s5pv210-fascinate4g.dts       |  2 +-
 12 files changed, 110 insertions(+), 54 deletions(-)
