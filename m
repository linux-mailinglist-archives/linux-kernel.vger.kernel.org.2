Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C63A41FF19
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 03:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhJCBei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 21:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhJCBeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 21:34:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860E6C0613EC;
        Sat,  2 Oct 2021 18:32:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s21so22516410wra.7;
        Sat, 02 Oct 2021 18:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KiymIwYE2EmUjFjTWRRk5oWuN9aBVXESXtXS4L2qhYU=;
        b=oCtajAQe7RUAUfRDJLUGSlZO1Xg4Ce1dThHMndcioqRHZsCk+JB/5YwWkmO8XgMXx3
         5NTDHaZTpGB6yc2aVSDU3HyavuAHOPudTis9UIMOfwM4IORYXRogqec2samItCxGQ8aG
         lhKHNOZeaYxPB7y3YAeBG8H2tRwOKMPJQoc9RERN91A4Nmgd9BrJdLt84cAUxsZHER6S
         f1T2d0H7qE7DSwgfHRIbvYrMPqLOn+W46935oyhBFTzSVwTQiBj1Jzl8197W8JT1BE6g
         EgyENwpUeVeicZxFdjMxEDOdMbceOvgDU+wocLnV4Q8khOtdFXyI8s/QRkTCeSssBqrD
         DPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KiymIwYE2EmUjFjTWRRk5oWuN9aBVXESXtXS4L2qhYU=;
        b=bZJOYFba4N1y75od7P3DBpfpgkv340yFRUtqA23hRyOuet8HIVN6pB6qJjh7lLBgBj
         Zumnf5TLqXn5OqhmH1zN7WVCWxe4u7KW0soqfQYWarnT3iqTQSaCn1V5Zb+8LBjvKSz2
         f1MpcXT4b8R/UouQ1NauBt/h89YODyUkGAcOT0lNv0nZ3qnkkPB6T/X1unYALU3yOaCY
         qLK6ff+5LOAZqadrp9JrDT99Okx32fw4OZSlnLVJG1a4yO/X6J/6Qb1YuUNWrUab/3k0
         Nnk01OvoyAxcfxow1JEj3rKXrzlBDudMZ1nMpkPma8mPa5PYhE8r/QH85wqnjkw8tb1i
         lA/Q==
X-Gm-Message-State: AOAM532Qfq79iFiTi5zb7/EUhynfe3+KkeNCId6/F5YrxHL9i7HSOvQe
        pTsM6K2eXQL/H3K9fnG66YU=
X-Google-Smtp-Source: ABdhPJz8QWrqyroYXoeL2HonN+zMQ7MEkHDgpKip8tz/f38QImTYb0WqyqU1KMJO9yq1MRtF5mMJ5w==
X-Received: by 2002:a5d:4810:: with SMTP id l16mr5872701wrq.3.1633224768099;
        Sat, 02 Oct 2021 18:32:48 -0700 (PDT)
Received: from localhost.localdomain (94-29-54-195.dynamic.spd-mgts.ru. [94.29.54.195])
        by smtp.gmail.com with ESMTPSA id 20sm12481926wme.46.2021.10.02.18.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 18:32:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 0/4] tegra20-emc: Identify memory chip by LPDDR configuration
Date:   Sun,  3 Oct 2021 04:32:31 +0300
Message-Id: <20211003013235.2357-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support memory chip identification by LPDDR2 configuration, which is
needed by ASUS Transformer TF101 tablet device that doesn't store RAMCODE
in Tegra's NVMEM.

Changelog:

v3: - Corrected sub-node name in tegra20-emc.yaml.

v2: - Added separate binding for standard LPDDR2 properties, like it
      was suggested by Krzysztof Kozlowski.

    - Switched Tegra binding to use new lpddr2-configuration sub-node
      that contains the standard properties.

    - Extended commit message of the "emc: Document new LPDDR2 sub-node"
      patch, telling how the properties are supposed to be used, which
      was requested by Krzysztof Kozlowski.

    - Added new common helpers for parsing LPDDR2 properties and made
      tegra20-emc driver to use these helpers.

Dmitry Osipenko (4):
  dt-bindings: memory: Add LPDDR2 binding
  dt-bindings: memory: tegra20: emc: Document new LPDDR2 sub-node
  memory: Add LPDDR2 configuration helpers
  memory: tegra20-emc: Support matching timings by LPDDR2 configuration

 .../memory-controllers/jedec,lpddr2.yaml      |  80 ++++++++
 .../nvidia,tegra20-emc.yaml                   |  17 +-
 drivers/memory/jedec_ddr.h                    |  21 ++
 drivers/memory/jedec_ddr_data.c               |  42 ++++
 drivers/memory/of_memory.c                    |  34 ++++
 drivers/memory/of_memory.h                    |   9 +
 drivers/memory/tegra/Kconfig                  |   1 +
 drivers/memory/tegra/tegra20-emc.c            | 191 ++++++++++++++++--
 include/dt-bindings/memory/lpddr2.h           |  25 +++
 9 files changed, 404 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/jedec,lpddr2.yaml
 create mode 100644 include/dt-bindings/memory/lpddr2.h

-- 
2.32.0

