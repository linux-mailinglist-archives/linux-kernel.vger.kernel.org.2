Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27679435DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhJUJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:32:27 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58652
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231473AbhJUJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:32:23 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 28C7C3F323
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634808607;
        bh=lGRdlVVI98glg7ntrSV8ab4TJAzQBo6Stek2XYxVhxg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ZeVHHmKzFibJjXnaZLacHiMZjeO8apRpTdSN3kggPrCjptVgchK++1WH7Ufn6aRaA
         y2RQHeVM8D21lpGim0FmGFcpJEP/uEfKU71msK85ROxoqheYV36kzS0CZZypN7xEWV
         FY2SUE953F4Iq+IxoxjmVFYSHZgzbQMh8Ttw9Rc2QHErHHFKZAKYzan8OZ0skXezpK
         d0vvQtMnam2W77kdFAZWbT/jFv4HsdCKZ9NfekJRRFXbsScLVnWvgv3eWKyzSN9N3i
         8wC6vX73rEBtDRmJo2CE+t+qceRg8ZVnThiGUsrbL26FtrPBQPlLXbjaxFObhk3auj
         UE+wW5Hhrn4xg==
Received: by mail-lf1-f69.google.com with SMTP id k18-20020a05651210d200b003fd86616d39so20649lfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lGRdlVVI98glg7ntrSV8ab4TJAzQBo6Stek2XYxVhxg=;
        b=xRPWLYT5is9KGScUDDbAOmjLYqN026qGiCDJb/3XMLEdUzuF+M9/twj6zMOONwKEA9
         9BV5LsAO3GwoxKbQVgyCBHRYL8EU6OXzssrckrRZdG1NwhG5DyeLCVwVgxQdj0rAnh7b
         ZtoV2kFXa8Oe15WAUIkAZFGg1aPh3oE/ycD13pIW8gd4s/njrRQmCJWYmf5+ShncLFcQ
         MGI0IsCw5kuBF+mizujTinytelrJqJ4ijP4Xm2qnvEJCtwX6LaNC4psFEGQft7fDtIxO
         OPbXkyMNcEaNzOvvnEuVt83QNNFks5oRZvEmC40MmtyQYeQuCeb8vtZBOMpDyhYDRF9E
         NSoQ==
X-Gm-Message-State: AOAM530uwOTPf3eWPVizEBf4BkO4kyTWsvCiDPWVnaK36HbOFAxgbdea
        Yu7oKZLDsmUCRd4ks3SVkxri1FnlLn56C98oi8IJAAY/SQRaIeU8J44pW7McpIU6nehtG4kcz25
        Wo+eJYRZAE3dmHiVZQ4f2J2LBhfDLvpP60l3ZHCP5JQ==
X-Received: by 2002:a05:6512:31b:: with SMTP id t27mr4548363lfp.688.1634808606112;
        Thu, 21 Oct 2021 02:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRCWa8XhZR6dH15N8eWqRYbXncemNhMtimPyQuIdMZaYT4R2Z807Gq6JVJCz623+OFDkhPEQ==
X-Received: by 2002:a05:6512:31b:: with SMTP id t27mr4548339lfp.688.1634808605920;
        Thu, 21 Oct 2021 02:30:05 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id c19sm489959ljj.130.2021.10.21.02.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 02:30:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v5.16, part 2
Date:   Thu, 21 Oct 2021 11:30:02 +0200
Message-Id: <20211021093002.118192-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Second pull request for memory controller drivers, mostly touching Tegra. On
top of previous tags/memory-controller-drv-5.16.

Best regards,
Krzysztof


The following changes since commit d611d7ea120bbef45e836565dfa2ddc85a168c16:

  Merge branch 'for-v5.16/renesas-rpc' into mem-ctrl-next (2021-10-10 19:45:00 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.16-2

for you to fetch changes up to 14b43c20c283de36131da0cb44f3170b9ffa7630:

  memory: tegra20-emc: Add runtime dependency on devfreq governor module (2021-10-21 11:18:08 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.16, part two

1. Convert LPDDR2 bindings to dtschema and extend them with new
   properties.
2. Tegra 20 EMC: support matching timings by LPDDR2 configuration from
   devicetree.

----------------------------------------------------------------
Dmitry Osipenko (9):
      dt-bindings: Relocate DDR bindings
      dt-bindings: memory: lpddr2: Convert to schema
      dt-bindings: memory: lpddr2: Add revision-id properties
      dt-bindings: memory: lpddr2: Document Elpida B8132B2PB-6D-F
      dt-bindings: Add vendor prefix for Elpida Memory
      dt-bindings: memory: tegra20: emc: Document new LPDDR2 sub-node
      memory: Add LPDDR2-info helpers
      memory: tegra20-emc: Support matching timings by LPDDR2 configuration
      memory: tegra20-emc: Add runtime dependency on devfreq governor module

 Documentation/devicetree/bindings/ddr/lpddr2.txt   | 102 ----------
 .../memory-controllers/ddr/jedec,lpddr2.yaml       | 223 +++++++++++++++++++++
 .../ddr/lpddr2-timings.txt                         |   0
 .../ddr/lpddr3-timings.txt                         |   0
 .../{ => memory-controllers}/ddr/lpddr3.txt        |   5 +-
 .../memory-controllers/nvidia,tegra20-emc.yaml     |  23 ++-
 .../memory-controllers/samsung,exynos5422-dmc.yaml |   3 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/memory/jedec_ddr.h                         |  47 +++++
 drivers/memory/jedec_ddr_data.c                    |  41 ++++
 drivers/memory/of_memory.c                         |  87 ++++++++
 drivers/memory/of_memory.h                         |   9 +
 drivers/memory/tegra/Kconfig                       |   1 +
 drivers/memory/tegra/tegra20-emc.c                 | 200 ++++++++++++++++--
 14 files changed, 622 insertions(+), 121 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ddr/lpddr2.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
 rename Documentation/devicetree/bindings/{ => memory-controllers}/ddr/lpddr2-timings.txt (100%)
 rename Documentation/devicetree/bindings/{ => memory-controllers}/ddr/lpddr3-timings.txt (100%)
 rename Documentation/devicetree/bindings/{ => memory-controllers}/ddr/lpddr3.txt (94%)
