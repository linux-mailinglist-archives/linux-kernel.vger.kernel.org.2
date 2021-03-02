Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E357F32A4BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446422AbhCBLMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 06:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838470AbhCBKy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:54:56 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA0CC061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:54:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b18so12868871wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WTqhktbSK+pb9FujmiEWqSsD3Ov6W1SagmahMe1crb4=;
        b=eekxItstzdek5bmY3Fy4eehDypAbrdub+lzL53FCHxqePg1RLZDjbEEHCxfe7H5MeL
         towuuIVEYAu76BFuny9l7i0558AzCjJQwktgvVC56VAIPG5pefsy7m+wYCgrwh0OwpNx
         tZb3O6EXXH7lqAbnkqYPREIe4oOmXsySzOSAbCE85QopRCcIKKht9ZcDJ0rpP7mYKEnK
         vviYTzhYaT90BQj+oIszMmWAJJrLlYs+e3CcNZ6yaJkA99jdrNtqgOWem7BKqI0WnguT
         SlYzp+ZW5ClaM4W0z+R77lXtqsS8NOCLuyQkkuFQ36eA8CGjqoL3YiRE2anwN2GEu1oP
         fZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WTqhktbSK+pb9FujmiEWqSsD3Ov6W1SagmahMe1crb4=;
        b=hqYRnBhpG6h2uPdt/eTyvzmSr13rp7bu5NMZBiogh+hbScxFZuNgI2gH8ALwcAh24+
         0x2WKEypL94nIUZKSTcSqlRDXuS9V2EYE0c2USngmT1sav2MVSFVCSy7G1bmyBlDcMtC
         GjzvQtOZD439u+bQH15izCU3vG0HOqRCutz+NjmLVDhV3z4QSWZKRWKuhoSQsrkT2LN7
         /ruW/vKaJ8qxPy+DnKVL74pEFcTe35W7vKQ+vNNy88ZMpJtymBN04Yi1rrX2N9MztxmE
         5uoucJKXy6wQfEZtWDiZ64ChfFiCkR8t6XxCm7BlHz/qyiseaGZnN+gIz/Jk2k+6ZaG4
         tnoQ==
X-Gm-Message-State: AOAM530fI5Aop3uFxFhaBMolRSNC3F+Nu0KlDBAz6oM0SoTGr3ih2ZAT
        kVipOKqVGrwMEBvTZu790o7OknPc9UTmtg==
X-Google-Smtp-Source: ABdhPJz2NeMkaA+BYqC42OXCin/GZFMyb6o91RKMQqOLxd9eWe0+cyjePPdLgXfy8TyNxcUMz/i6ZA==
X-Received: by 2002:a5d:4c81:: with SMTP id z1mr6493646wrs.85.1614682454582;
        Tue, 02 Mar 2021 02:54:14 -0800 (PST)
Received: from localhost.localdomain (67.red-83-54-30.dynamicip.rima-tde.net. [83.54.30.67])
        by smtp.gmail.com with ESMTPSA id v5sm2270407wmh.2.2021.03.02.02.54.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 02:54:14 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name
Subject: [PATCH] phy: ralink: phy-mt7621-pci: fix XTAL bitmask
Date:   Tue,  2 Mar 2021 11:54:12 +0100
Message-Id: <20210302105412.16221-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When this was rewriten to get mainlined and start to
use 'linux/bitfield.h' headers, XTAL_MASK was wrong.
It must mask three bits but only two were used. Hence
properly fix it to make things work.

Fixes: d87da32372a0 ("phy: ralink: Add PHY driver for MT7621 PCIe PHY")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/phy/ralink/phy-mt7621-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ralink/phy-mt7621-pci.c b/drivers/phy/ralink/phy-mt7621-pci.c
index 9a610b414b1f..84ee2b5c2228 100644
--- a/drivers/phy/ralink/phy-mt7621-pci.c
+++ b/drivers/phy/ralink/phy-mt7621-pci.c
@@ -62,7 +62,7 @@
 
 #define RG_PE1_FRC_MSTCKDIV			BIT(5)
 
-#define XTAL_MASK				GENMASK(7, 6)
+#define XTAL_MASK				GENMASK(8, 6)
 
 #define MAX_PHYS	2
 
-- 
2.25.1

