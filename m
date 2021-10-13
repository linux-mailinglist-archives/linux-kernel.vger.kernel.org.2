Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926A642C642
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhJMQ0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:26:35 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35430
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229903AbhJMQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:26:31 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 63A123FFE7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634142262;
        bh=rIEj21HHKhJcsySyHApcwExmEsShxKv23rfMFAlFGSI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=V4rg/Cz/R+BoFKXe4B+BYQ0rHB/1jqbZ8RqoHNbCPlWmfuyllcIezoMCb0hltroJH
         gn2nn6w2JGMWRLUuNT+G2Ylw7zPf5ZWng82mNNq6V4dz0st0F0ItEGQL0PsVz+cbKe
         0iQ6HF9n6i2/4OR88H+w0qUnHwIQb0PGbRowcsXnNPXUZJ0jKOh99pckIxAlvTlg66
         UcT43/rBnhQvZNeNDlmRODXAnx1JnEL5HA8h6pJ1itPBMmyqazDBhrdCdEmOSnYRdB
         AvHF/d1qP7x/yP/Xl7ttfKNstkDq9Px3X7ajE0poDAR4De6x7T23BXW/DIPsbaDzhv
         60QJSsLEgEQzA==
Received: by mail-lf1-f71.google.com with SMTP id z29-20020a195e5d000000b003fd437f0e07so2341442lfi.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIEj21HHKhJcsySyHApcwExmEsShxKv23rfMFAlFGSI=;
        b=2hSORM4MHsS+wMVypAhjaDUBpjnDn4q7tmLHstL9ut5tNETlsfJVjmo+Uch+oJQf4E
         Vw4Y03BWdU9gRBavJ/a0wG0/l/niv4UWQVjAflC5DMVb7Ww3Fr5iNIby7A1ahTxnzsEn
         Wki1Z1RH1x9f71F8fTdLcHo7mZtxJCdXxIRY8dFfs8PfJYZ+ZTM2anaMA5mUYcm1Wr+v
         Fi+ZUHYBreqO0YMNQbWuVPhS53uopYiRstoPMq760cDQDm7BbPqZFXm/sDWboB1kgHeN
         A1o46tHnsWmpgr3JfkVguqfte1tVQteUcOFoEHi/pH29DsXke3C3t1RDZbl+thsh5tPy
         kADg==
X-Gm-Message-State: AOAM531gAm07J7xLoE8zP3bMokE6TbUduSsOUBC10zJFJtG9E4YnrbVK
        gu25ztSmYfR0KF5tq3sjd7TJV2H9wydgsnEOCbceT0wMcidVHFPKsDXBEXiUPxzlopExFOlRoB4
        bpNSFX4oo3gPId45STJz/XPNtW6gKTKQeHTqhd3D26Q==
X-Received: by 2002:a2e:9790:: with SMTP id y16mr323449lji.175.1634142261793;
        Wed, 13 Oct 2021 09:24:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoTIiea+8iBrlt5YSeJhanTDXQjxIM9l83Tywf3oR1RICkS2ZGaOCR5f49WvdAq4nAXfiLdA==
X-Received: by 2002:a2e:9790:: with SMTP id y16mr323422lji.175.1634142261620;
        Wed, 13 Oct 2021 09:24:21 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id r3sm1372281lfc.169.2021.10.13.09.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:24:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] ARM: dts: samsung: dts for v5.16
Date:   Wed, 13 Oct 2021 18:24:17 +0200
Message-Id: <20211013162418.43072-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.16

for you to fetch changes up to 7ec804d6025c952e3122ad7fe768178efca3300e:

  ARM: dts: exynos: use spaces instead of tabs around '=' (2021-09-30 13:45:55 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.16

Minor cleanups - from undocumented or unused properties, coding style.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      ARM: dts: exynos: drop undocumented samsung,sata-freq property in Exynos5250
      ARM: dts: exynos: remove unneeded DVS voltages from PMIC on Arndale
      ARM: dts: exynos: use spaces instead of tabs around '='

 arch/arm/boot/dts/exynos4210-origen.dts  | 24 ++++++++++++------------
 arch/arm/boot/dts/exynos4412-origen.dts  | 14 +++++++-------
 arch/arm/boot/dts/exynos5250-arndale.dts |  3 ---
 arch/arm/boot/dts/exynos5250.dtsi        |  1 -
 4 files changed, 19 insertions(+), 23 deletions(-)
