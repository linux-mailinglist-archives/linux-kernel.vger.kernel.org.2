Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE11043AF66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhJZJtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:49:42 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40044
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233286AbhJZJtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:49:40 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 505283F17C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635241635;
        bh=cYZ6vLVJzKfmCMrRSQ5rwJQ1AQl6SdnwWfSPPnNLfrY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=BZPzJQOhHpo+7q+TZ5YaCoucAyZf1jNGNRF9AU+yUtHi4BhN+ZoD3106mXBjHjC2g
         VxukDRoEctiZeu29JQKInyhe0sOFoj8Vk80WMbi3YgWFo+Q14Zg/CzCskiwvpLBK4j
         JWzD48x/3Ik1i8ehKRxT7OSQAOIIov3lpyPMt6WSvQEQJcbyd4Rza3164jR80zpWOw
         tvQhl2fthOLhjhyfjYrSJzizr4I5+nMjOBxI//zv0f0Pai5sMAvQ+kgTjOmb8QrtHe
         iNYTXAwQsuRh5gU2iTtyLe4Y6yJwpzDPYYgBqe34fpBCJaS6kziWoxxCqrhQoBM2w1
         VAdcY8c78Zl3Q==
Received: by mail-lf1-f72.google.com with SMTP id i1-20020a056512340100b003fdd5b951e0so6025225lfr.22
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 02:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYZ6vLVJzKfmCMrRSQ5rwJQ1AQl6SdnwWfSPPnNLfrY=;
        b=UqlLa/UbT3oqvePMYMy0e+o8Hxv/UD6HYZ0d/AmB6fyMbeTHhwnVDKjzP6QxP4IRQQ
         2SitnhZSleQRnPVdUyjXX+hUUCSKX/APZ8A2Vqgp8895KzVy3ECSFxtjEREEuhIVYI6k
         CYH2koxme42ep36nm/JGXm2kPXTqDzWiyp5Bcp10C+W0B+y5x2XEn2QVYCniq/cW/MxX
         xMkx9FXGK+AfhBQQ5MX+q+kiv+3YdM6fE/xQv0MIaI31hV9IZb2ULZ9mHv7/Ybza/Zr2
         MTkTMylosMFZAw30MLDcx13DaMjwRiesRoqvR+Ei5Au3K6TF4+EvfQAqDNkNT8oPghZD
         jr8w==
X-Gm-Message-State: AOAM530AOO8SFRryNHI1/3yNXCSwaRbV0q6EvYMiQL4/rrt2kMafoRIs
        GxupumJdkOaSV0y2ESxsgmLhKQFqlQbd1GM46tpkRo4u3QfMQQT4A58Y72ESPu0zNVHr04rbiGh
        /dIVIBRqr785ZZeUw8ZM0Wp0LYGcjRQx53b9XLWEAuQ==
X-Received: by 2002:a05:6512:68b:: with SMTP id t11mr21162783lfe.586.1635241634811;
        Tue, 26 Oct 2021 02:47:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlQgrckrQHX3Yvswq5svDMfRPICsoGQMe4d5hGv/Expe3ttKtnyzJNWvaJkOw7N4Zei2O1cQ==
X-Received: by 2002:a05:6512:68b:: with SMTP id t11mr21162737lfe.586.1635241634261;
        Tue, 26 Oct 2021 02:47:14 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v17sm113794lfo.167.2021.10.26.02.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 02:47:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/4] soc: samsung: drivers for v5.16
Date:   Tue, 26 Oct 2021 11:47:06 +0200
Message-Id: <20211026094709.75692-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211026094709.75692-1-krzysztof.kozlowski@canonical.com>
References: <20211026094709.75692-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Set of changes mostly around Exynos ChipID driver. I hope it is not too late
for this. These were sitting in my tree for some time, so they got linux-next
coverage.

Best regards,
Krzysztof


The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-5.16

for you to fetch changes up to b417d1e88f32645ed62a00d43c347b4386a0a021:

  soc: samsung: exynos-chipid: add exynosautov9 SoC support (2021-10-26 09:16:53 +0200)

----------------------------------------------------------------
Samsung SoC drivers changes for v5.16

1. Convert Exynos ChipID and ASV driver to a module and make it a
   default, instead of selected. The driver is not essential, so it
   could be disabled, if needed.
2. Add support for Exynos850 and Exynos Auto v9 to Exynos ChipID and ASV
   driver.
3. Get rid of HAVE_S3C_RTC because it was adding just another layer
   instead of direct dependencies.
4. Minor cleanups.

----------------------------------------------------------------
Chanho Park (1):
      soc: samsung: exynos-chipid: add exynosautov9 SoC support

David Virag (1):
      soc: samsung: exynos-pmu: Fix compilation when nothing selects CONFIG_MFD_CORE

Krzysztof Kozlowski (4):
      soc: samsung: exynos-chipid: avoid soc_device_to_device()
      soc: samsung: exynos-chipid: convert to a module
      soc: samsung: exynos-chipid: do not enforce built-in
      soc: samsung: pm_domains: drop unused is_off field

Sam Protsenko (3):
      soc: samsung: exynos-chipid: Pass revision reg offsets
      dt-bindings: samsung: exynos-chipid: Document Exynos850 compatible
      soc: samsung: exynos-chipid: Add Exynos850 support

Will McVicker (2):
      arm64: exynos: don't have ARCH_EXYNOS select EXYNOS_CHIPID
      rtc: s3c: remove HAVE_S3C_RTC in favor of direct dependencies

 .../bindings/arm/samsung/exynos-chipid.yaml        |  5 +-
 arch/arm/Kconfig                                   |  1 -
 arch/arm/mach-exynos/Kconfig                       |  2 -
 arch/arm/mach-s5pv210/Kconfig                      |  1 -
 arch/arm64/Kconfig.platforms                       |  2 -
 drivers/rtc/Kconfig                                | 10 +--
 drivers/soc/samsung/Kconfig                        |  5 +-
 drivers/soc/samsung/Makefile                       |  3 +-
 drivers/soc/samsung/exynos-chipid.c                | 94 ++++++++++++++++++----
 drivers/soc/samsung/exynos5422-asv.c               |  1 +
 drivers/soc/samsung/pm_domains.c                   |  1 -
 include/linux/soc/samsung/exynos-chipid.h          |  6 +-
 12 files changed, 94 insertions(+), 37 deletions(-)
