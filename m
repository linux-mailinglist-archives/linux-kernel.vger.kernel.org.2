Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64DD422346
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhJEK0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:26:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:45162 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhJEK0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:26:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="248963903"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="248963903"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 03:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="589306809"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2021 03:24:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E0FEE183; Tue,  5 Oct 2021 13:24:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v1 0/6] mmc: sdhci-pci: Add some CD GPIO related quirks
Date:   Tue,  5 Oct 2021 13:24:24 +0300
Message-Id: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that one of the supported platform magically worked with the
custom IRQ handler (any hints how?) while having two PCB designs with
an opposite CD sense level. Here is an attempt to fix it by quirking out
CD GPIO.

Patch 1 introduces two additional quirks (it's done this way due to
patch 3, see below). Patch 2 is an actual fix for the mentioned platform.
If backported need to be taken with patch 1 together. Patch 3 is (RFT)
clean up. The questionable part here is the locking scheme. Shouldn't
we do something similar in the generic IRQ handler of SDHCI? Or Broxton
case has something quite different in mind?

Patches 4-6 are dead-code removals. Patch 4 accompanying patch 2, patches
5-6 just similar to it, but (functionally) independent. Would like to hear
if it's okay to do.

Any comments, hints, advice are welcome!

Andy Shevchenko (6):
  mmc: sdhci: Introduce couple of quirks to ignore particular state of
    CD GPIO
  mmc: sdhci-pci: Read card detect from ACPI for Intel Merrifield
  mmc: sdhci: Replace bxt_get_cd() with
    SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_HIGH
  mmc: sdhci-pci: Remove dead code (struct sdhci_pci_data et al)
  mmc: sdhci-pci: Remove dead code (cd_gpio, cd_irq et al)
  mmc: sdhci-pci: Remove dead code (rst_n_gpio et al)

 drivers/mmc/host/Makefile          |   1 -
 drivers/mmc/host/sdhci-acpi.c      |  24 +----
 drivers/mmc/host/sdhci-pci-core.c  | 166 +++--------------------------
 drivers/mmc/host/sdhci-pci-data.c  |   6 --
 drivers/mmc/host/sdhci-pci.h       |   5 -
 drivers/mmc/host/sdhci.c           |  13 ++-
 drivers/mmc/host/sdhci.h           |   4 +
 include/linux/mmc/sdhci-pci-data.h |  18 ----
 8 files changed, 27 insertions(+), 210 deletions(-)
 delete mode 100644 drivers/mmc/host/sdhci-pci-data.c
 delete mode 100644 include/linux/mmc/sdhci-pci-data.h

-- 
2.33.0

