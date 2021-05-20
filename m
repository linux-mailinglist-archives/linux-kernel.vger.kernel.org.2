Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089C138B55D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhETRnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbhETRnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:43:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0039AC061574;
        Thu, 20 May 2021 10:42:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s4so7967430plg.12;
        Thu, 20 May 2021 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8zCNoX6FBhDb9BPO2SfpaVqoJwSrdnELOz9ad+w2Hs=;
        b=F0K9pE5jJqO8El0iUu+UuqqOSEvHIusZlmi4TvCeT5ioYpbo+fW6HuQSOdpjSu1dkj
         /mraHU6rfUA/G0r5M4Nx3xYmyX3L8wT5eDyCzITAaWbl4rX1oxVL6hm4JpX8X3yCsKIO
         nKwSXwhgAuV05IWPfCdnxP3OFntqGlDonkDbbpIYN8iEctU2no2tvck5FEkCBShflI5+
         f62hC85CBNY86C77r/F5nLdJu3K3Dr5x7pqni285Y2ERJaw6yplmN6rgzhXp85Tqweb+
         wyvK9WZRZ7EvhSLK82KM9rQwCDrpAmobJ11QhYsDihxbT6+qkn/59lKijwgCAwF8Dwry
         xAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8zCNoX6FBhDb9BPO2SfpaVqoJwSrdnELOz9ad+w2Hs=;
        b=r9mGrHSEpQYcU3q/gHvdH6HZcNx6hPX1MHVPMoOX7dmtTJgtTmJoEU33d0h9imPcSb
         xbCd/Z45yamFdUpNg6s4Y+q8jHCZ3De2G1Vx8TNZUTXxS81ZRNTqzbZ9A9TfZaEklAOS
         s5Hri43ax2LZ+LKBdFZYdBvuIb00tSshJMm2+FtLpm6V/93X+NANJXIx7+Y6R81lBBUC
         21LD9gL3dNPdfdXKng5NSZz8/HdOzZEVIkpEyEmgfLKgAp2dolLM27nd70D8Btb/nf38
         Ukh4lmNd5Rk+ptQTkxgxao7wKSrZe9MbdXOq1Q/2LXOJTYik5tO+cfNliaSxwjxHJw0z
         fCIw==
X-Gm-Message-State: AOAM530ALvwTZUPT2lJ/eXXkROVT9VxHv06OZJTBqs8jh2KcxMCISub+
        T0FElby1+WR/QGwpJnQDQ7qSZ3tf6ORWzQ==
X-Google-Smtp-Source: ABdhPJwj0dMmG40f8FtDMB8YzT+MDULCxn3q34+OFOndOfilj6OxZRRkgKKg22tGrzN5VR4RI99OuQ==
X-Received: by 2002:a17:90a:e2c5:: with SMTP id fr5mr6066622pjb.150.1621532545967;
        Thu, 20 May 2021 10:42:25 -0700 (PDT)
Received: from tardis.. ([2601:645:8203:5ef0:aaa1:59ff:fe3e:c140])
        by smtp.googlemail.com with ESMTPSA id u24sm2671644pga.78.2021.05.20.10.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 10:42:25 -0700 (PDT)
From:   David Bartley <andareed@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-x86_64@vger.kernel.org, David Bartley <andareed@gmail.com>
Subject: [PATCH] x86/amd_nb: add AMD family 19h model 50h PCI ids
Date:   Thu, 20 May 2021 10:41:30 -0700
Message-Id: <20210520174130.94954-1-andareed@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required to support Zen3 APUs in k10temp.

Signed-off-by: David Bartley <andareed@gmail.com>
---
 arch/x86/kernel/amd_nb.c | 3 +++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 09083094eb57..23dda362dc0f 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -25,6 +25,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
+#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
 
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
@@ -57,6 +58,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{}
 };
 
@@ -72,6 +74,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4c3fa5293d76..5356ccf1c275 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -555,6 +555,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
+#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.30.2

