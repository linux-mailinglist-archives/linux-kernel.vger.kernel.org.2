Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0508403C88
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbhIHPb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhIHPb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:31:58 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B79C061575;
        Wed,  8 Sep 2021 08:30:50 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id p2so3592661oif.1;
        Wed, 08 Sep 2021 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S1I527MSfurdr1d2ztxDApsIAM7u0kpadwEyPZU2lRM=;
        b=DTInn5MCElDUDr75tHRRKQy1CbTrsMnaL3SZYIrevfNJZ4VKZWfRyQe567VEQidnqf
         dI4aBQvSNTwibrC4NyF0X2K7xKJNaQ/R8I7LlV/WAKI5B6juzy8+MhLk8IcBqIuPdZVV
         6wc0m7jWQ20qSZKxRdBikEDLw4cu1KHh/Kk+oss/d0yC5cmLRJyt38RrZrlbeEXwK6Ww
         GAo1wnxOgcUBtPX179ElFIXS4MU2XngiIETmrMVzzuIkS7ICwiEqKZflqcDNAWmD5Dh9
         tQnDD2IV/FtvWIS2OLto8rP2+4yIOW19ic5PNAERiwtikoPRrq/gueqRM4qERpubAHkM
         drxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=S1I527MSfurdr1d2ztxDApsIAM7u0kpadwEyPZU2lRM=;
        b=XoUHtmo2gacyIIIoMBtsMcJLu97MotXEZbhOUEdwrbIpt+e4BP39Tc/mSBaEHtHCPu
         LZHpbuJ21VNUfMdgmCh69U1R7yG3cnqdFn1KrPNzkxESFE5eavBiTMBZa7vJrgQKLxD/
         Lg98qL5Rw9o1dky8l1qtnn8Vf/HmQxLZfYog2xKrMhcnhvey3s3XJEPDIlL4ChY1rT/M
         jwDAdx3Ev7PW/X+uJ2bTB/YKsrgGTMSqerpng9UjOVgy7Og4Ofcgoyn14BprA5+PiJhg
         Cq01kaDeGYPt4rr0ZB06kUqUFj7OfPYfiYwzGiUdd7epWxiOtPaxkLtPBAhVL1Gz0XO1
         u6DQ==
X-Gm-Message-State: AOAM532TEY8F4bDwXaLYe+ElqzWcvX71Je/H+YcG8QqdEXbd9kMsWJQt
        wwP47WFu0MmE49jj53MEQlU=
X-Google-Smtp-Source: ABdhPJyipXJsjt2BhcEmx4BzU7EenAWT8g3uCxzkfYpI/c42Dauo1ByIXUy69d/eTjY90J80u000WA==
X-Received: by 2002:a05:6808:222a:: with SMTP id bd42mr2875847oib.87.1631115049364;
        Wed, 08 Sep 2021 08:30:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l13sm507884otp.29.2021.09.08.08.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:30:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH] parisc: Move pci_dev_is_behind_card_dino to where it is used
Date:   Wed,  8 Sep 2021 08:30:41 -0700
Message-Id: <20210908153041.643069-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parisc build test images fail to compile with the following error.

drivers/parisc/dino.c:160:12: error:
	'pci_dev_is_behind_card_dino' defined but not used

Move the function just ahead of its only caller to avoid the error.

Fixes: 5fa1659105fa ("parisc: Disable HP HSC-PCI Cards to prevent kernel crash")
Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/parisc/dino.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index 889d7ce282eb..952a92504df6 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -156,15 +156,6 @@ static inline struct dino_device *DINO_DEV(struct pci_hba_data *hba)
 	return container_of(hba, struct dino_device, hba);
 }
 
-/* Check if PCI device is behind a Card-mode Dino. */
-static int pci_dev_is_behind_card_dino(struct pci_dev *dev)
-{
-	struct dino_device *dino_dev;
-
-	dino_dev = DINO_DEV(parisc_walk_tree(dev->bus->bridge));
-	return is_card_dino(&dino_dev->hba.dev->id);
-}
-
 /*
  * Dino Configuration Space Accessor Functions
  */
@@ -447,6 +438,15 @@ static void quirk_cirrus_cardbus(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_6832, quirk_cirrus_cardbus );
 
 #ifdef CONFIG_TULIP
+/* Check if PCI device is behind a Card-mode Dino. */
+static int pci_dev_is_behind_card_dino(struct pci_dev *dev)
+{
+	struct dino_device *dino_dev;
+
+	dino_dev = DINO_DEV(parisc_walk_tree(dev->bus->bridge));
+	return is_card_dino(&dino_dev->hba.dev->id);
+}
+
 static void pci_fixup_tulip(struct pci_dev *dev)
 {
 	if (!pci_dev_is_behind_card_dino(dev))
-- 
2.33.0

