Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A43045EFBE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353757AbhKZOUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 09:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377665AbhKZOSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:18:21 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702A0C061A28
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:30:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id c32so24393312lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62NaGXZNye+bcc6pSUDR9xhQdjuQpfBa9IJfATJov2w=;
        b=FGauSmJK9pSXkAuRZndXjue/La7270gVYI/JbuE30p6quJNAX2ITfoFGoYmfD+vDRU
         hLHfe4C0sUhEel02tblqpjWWgV2AexAkRDeoK4/dfirR1MBUVqs+K2PIqocn//oWkcI5
         hO2leBCa8PMeEEvVH8SVxqTq1QKF6E9Vi+S/eW/QFLut+3e59QkKiaJBT+JgQuFFfc2F
         9/ElRZVwsD7S61pvRSS5iFlfLasd9gooEfazSKZl4axhdiI79dH5CQ3km5Ktiy3qTd30
         NrZi6GSdxCGDIDS63ssaQSQASGeAA7gsEy7JE8Lt9hKNVM6DXSjl/FJ89jsYxMVrJ3d8
         Ay7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62NaGXZNye+bcc6pSUDR9xhQdjuQpfBa9IJfATJov2w=;
        b=ugjwPd2dP9v0mMOYwUyTmL7Rbjbvwk6uFGINfMfQdMTgy4+yV6E68ctwGA04ICfRej
         SpIGJKgEAdBCBBn5trS2ODdGoaF2paqbCUlQBPdiQyZMWHCBI2cdxlVstoUcJRcmX3BB
         FAiEG+C+iTLF5vnKfraV6CLsl+Q0ZcXiQlQGBmw1mtSVuXzYRmTD18+jfTi1Z9E+XGwo
         rB7Ydxr2UxFx52yGmMpg51jc6KxbGIs6Zgfo0BhtKk4Gam5MrYz8SzTgx3VGNBv9yr5Y
         jNoiwzq/ri+qHCBPgmjGvMlazlELYaJPIOGJ/IrPSOjhmurR3BfJ/zof3czh/2vEZheJ
         uSMw==
X-Gm-Message-State: AOAM530mq8jOogQBZ8yNh8g84+e1Mg6DqtL0kWjmzftps3Gr7JSNMUTd
        K1vpk/1KV4htBpLqj/k97RAbfQGiaW55sg==
X-Google-Smtp-Source: ABdhPJx+/bC09tHBA4qIQHPKQok//NIwCa54vbaeUguUqhbDTNVfdUZBgbGq87t5I4HwKkHnSvvu+g==
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr31342444lfv.481.1637933456796;
        Fri, 26 Nov 2021 05:30:56 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id c11sm505961lfj.34.2021.11.26.05.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 05:30:56 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.16-rc3
Date:   Fri, 26 Nov 2021 14:30:55 +0100
Message-Id: <20211126133055.27138-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.16-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16-rc1

for you to fetch changes up to 5f719948b5d43eb39356e94e8d0b462568915381:

  mmc: spi: Add device-tree SPI IDs (2021-11-23 12:32:28 +0100)

----------------------------------------------------------------
MMC host:
 - mmc_spi: Add SPI IDs to silence warning
 - sdhci: Fix ADMA for PAGE_SIZE >= 64KiB
 - sdhci-esdhc-imx: Disable broken CMDQ for imx8qm/imx8qxp/imx8mm

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Fix ADMA for PAGE_SIZE >= 64KiB

Jon Hunter (1):
      mmc: spi: Add device-tree SPI IDs

Tim Harvey (1):
      mmc: sdhci-esdhc-imx: disable CMDQ support

 drivers/mmc/host/mmc_spi.c         |  7 +++++++
 drivers/mmc/host/sdhci-esdhc-imx.c |  2 --
 drivers/mmc/host/sdhci.c           | 21 ++++++++++++++++++---
 drivers/mmc/host/sdhci.h           |  4 +++-
 4 files changed, 28 insertions(+), 6 deletions(-)
