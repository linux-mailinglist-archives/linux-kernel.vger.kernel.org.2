Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA2410AF0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbhISJos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 05:44:48 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36562
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237716AbhISJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 05:44:47 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AAD324018F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 09:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632044600;
        bh=uaNs/xYVK85AxU1iGJvmG2bpbl9HxTnxXvUi2iolq6o=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=LDUfJFGExkVPACZTgAMKEKV+PSuYmFg1D3saFjGMNX1ia0IncFljFJQTVRuwmRRdb
         7k20aI81DWYcfZ15vASItwoZpJ9zKSb6piF6zrOikhU9VfT3iSw/GcIWGPNn1MrKN2
         I54JQF6OGpAmcziTUR6E3Z2Fe4hxcm0b4Q5dqiaQaQE+d8iTqRrv9cOdDv7V+Ocsiz
         /MlIBWKSd5p6YHscKE0378UH94UsD22ZyuXPtkD6aq81hkFyoR5wThq/QTwc41ytLj
         dXW9wJBmSJgoMFqjj95WFzCMde4pDlvyA2WUvp8NuwcfHbtk4RDHQeuu74zgw84jZh
         GS2A4tSm4bthg==
Received: by mail-ed1-f72.google.com with SMTP id r23-20020a50d697000000b003d824845066so4683849edi.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 02:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaNs/xYVK85AxU1iGJvmG2bpbl9HxTnxXvUi2iolq6o=;
        b=izz19v61BkJjT3TkfckdsNOh2hTzdLtKnkYGY62LItZVNNvQzdrGhCZuuSfyh+K6ic
         EN6vfKOvAMWDFv07INLH0lW2AGJ2PyWVtHhd1Yxc7qgaLW5KON+QM+BxxlTq5ym5Gzvn
         XOhD9/El1eqJIteo5ZQNeCeH6Y6kyA6cCpRc+bF8TzxtMq/0aKqa6YX/6mdMOdItjACP
         RBbUCPGSBpq8foJZNu0t7Qbw9SMTR9N3+AyRrF8SkOi8dnzrquryZNLA92zcEkUfnoys
         B0VKmmRceWABg7HWQ3rbYHWcNxK+QWZKfgdLzGM+ITeey8TzEnI3ke66MZCEgJu3dk5M
         SXFg==
X-Gm-Message-State: AOAM5334sTMmFleXPk1w92ldZFTCpFoEPMo+QeRRYd0YbmBzxWLA9C1g
        ieD8jY0JKjAbMsGE9hiHPmwWCAO0v4MLOJxjr4kdgK7R4BQjZf2Zc3AZwXK5HIdGThoDSsLFHph
        i/KNTqpsBJjn6JV1RI7sOiSJXdaKBZNs78iYZvD95zQ==
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr22609924ejc.504.1632044600026;
        Sun, 19 Sep 2021 02:43:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGT4606JPYMwEU1a10XdgBbQ/KWQjrmYj4MW/2J+egl2qD355Htf5c2+iR0SHaiwij1MfkZA==
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr22609908ejc.504.1632044599845;
        Sun, 19 Sep 2021 02:43:19 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id c21sm4637015ejz.69.2021.09.19.02.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 02:43:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandra Yates <alexandra.yates@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2] ahci: remove duplicated PCI device IDs
Date:   Sun, 19 Sep 2021 11:43:13 +0200
Message-Id: <20210919094313.52666-1-krzysztof.kozlowski@canonical.com>
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

Changes since v1:
1. Use still board_ahci_nosntf for 0x2822.
---
 drivers/ata/ahci.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 186cbf90c8ea..63198ad95ed9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -258,7 +258,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
 	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
 	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
 	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
@@ -316,7 +316,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci }, /* PBG RAID */
 	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
-	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG RAID */
+	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_mobile }, /* Panther M AHCI */
@@ -358,8 +358,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg RAID */
-	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg RAID */
+	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg/Lewisburg AHCI*/
+	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x43d4), board_ahci }, /* Rocket Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x43d5), board_ahci }, /* Rocket Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x43d6), board_ahci }, /* Rocket Lake PCH-H RAID */
@@ -394,10 +394,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_mobile }, /* Sunrise M RAID */
 	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Lewisburg AHCI*/
-	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
 	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa1d2), board_ahci }, /* Lewisburg RAID*/
-- 
2.30.2

