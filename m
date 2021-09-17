Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7974D40F5DA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242482AbhIQK0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:26:44 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55758
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240737AbhIQK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:26:43 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 97CFD3F324
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 10:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631874319;
        bh=2xQ1/AEURoJyQBP257GxvnHNKDEHX4wx3ObYTWar7oY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ACSWJA8nr4k+/12OR3MTUUcPWRf2TJnIXxIUjlXsNkJdSh5YQVOgsPG1kN62CvIEU
         4+gUEP8dJuXkVTfudJTVymItyJ92d65wpjJEsseUvD1rfPHybDFKr9DVVE9DXxGlMq
         Lk3SK5M9BlWap93d/Rzrca4q56zJGgr17O74L8yqmQZPQXBxbqI5Mo7K5pXQQCniph
         kjgQnhaFQQlxk+NvIfdfwt3R7+HVHMhdvNo3DRR5u0UC6gzuPFkx5dr6rPlsZxlHzP
         hcWUhnUmUkzTvWLhTFKF6bg9OFHgNpGrSxMlxmVLWtuY6dXQUsxhhwLYN9MpovzU4R
         73Ki2XdBpCmGg==
Received: by mail-wm1-f70.google.com with SMTP id j16-20020a1c2310000000b0030b3dce20e1so1320133wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 03:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xQ1/AEURoJyQBP257GxvnHNKDEHX4wx3ObYTWar7oY=;
        b=5U1skR+0lH1XojKagrLss8kWKR2FcaOKrs/0Ur9wp8qDBCO7r3Bnma8+UGLM+vzIwv
         gEfxTuzTSdzfMrztoS2YK4wgKXH8YxNNmc/OC5KUa/M6UHZQvZnPCNGhA+u98AWlexoZ
         X1RTniKaJZ8+4j6AMWg8hXjlhHWGfV8P+i8zzxb3Xol84Y2JlvZD6Tzax5+FtInkFFRK
         VyaQokH81nfu0GyWBT+HV08GJEKeesCBKLV/yO0eizHZ/+HSl/1iESBSKOhOt0KTUrvt
         wb0O4icQiU9AAHkGL5JDR2ukJ3fG2tGbaTYT1DD7VWksoSIgbG0NeVRTCIrsBstAd4eN
         axRg==
X-Gm-Message-State: AOAM5325ybo+Hhs95+nfoX1w6idA7/Rj3rKmwAMQYfhfv9l8nBn/WDDE
        zxIRlTZNowujiOynsP50jFA36pgmOovUa4UVMBgMmj0YngFrzuxJdoN/MR0sKT3+RhJjxZWsg/B
        had5FWisiBcCDzFHKY0Toa/3njd3q35lJiOFX+Kokxg==
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr9516520wme.71.1631874319221;
        Fri, 17 Sep 2021 03:25:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6BP6x1Dwi4163Sx4CfX5t+shARUqdLVM7Pj2bw2k5ASK7V0D5yK04rjbrHOAQzRUa1BAn0g==
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr9516509wme.71.1631874319074;
        Fri, 17 Sep 2021 03:25:19 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id h16sm6256944wre.52.2021.09.17.03.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 03:25:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] ahci: remove duplicated PCI device IDs
Date:   Fri, 17 Sep 2021 12:24:42 +0200
Message-Id: <20210917102442.24818-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel devices 0x2822, 0x2823, 0x2826 and 0x2827 are already on the list
as Lewisburg AHCI/RAID.  They use same configuration except 0x2822 which
has board_ahci_nosntf (for ICH8).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Not tested.
---
 drivers/ata/ahci.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 186cbf90c8ea..5f257064fcd8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -258,7 +258,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
 	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8 */
 	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
 	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
 	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
@@ -316,7 +315,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci }, /* PBG RAID */
 	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
-	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG RAID */
 	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_mobile }, /* Panther M AHCI */
@@ -358,8 +356,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg RAID */
-	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x43d4), board_ahci }, /* Rocket Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x43d5), board_ahci }, /* Rocket Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x43d6), board_ahci }, /* Rocket Lake PCH-H RAID */
@@ -395,9 +391,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_mobile }, /* Sunrise M RAID */
 	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Lewisburg AHCI*/
-	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg/Lewisburg AHCI*/
+	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
 	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa1d2), board_ahci }, /* Lewisburg RAID*/
-- 
2.30.2

