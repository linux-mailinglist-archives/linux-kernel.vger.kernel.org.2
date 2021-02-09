Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAA7315995
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 23:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhBIWg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 17:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbhBITmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:42:24 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13E0C061A2A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:32:08 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 18so10398538pfz.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIh4OLXPZqyT593P1uGyKCdBeoEDHVFwCLVWLT+c4Mg=;
        b=Lt1uRsey0/tR64szLfqruKn04IQZuHfwckjuXpX/9mVwCAQULcPWOKRNfLKv/wNNCZ
         IzK2zPHOpi3J87qTeZS0Iet11OTonqXt8vBlEhO+DyA8O97wmur92vRLWaRKH8IhveM7
         g+KdLNtWU4eLWg78V3eoj8T30yPd8iAKmkVzQpdm0qpFVolIcI/bbTsLyzz1A4ZWUa2R
         Ka4bJGIKKn6UZFe8Gcj0x5FNCresZkSDxnttXZcOOlDDj0AwlKq38QJ1tOgsp+PevUNu
         KAiZhSXYDBTZF2wHN+G4wZRqYm+rnJztk3Ru28lzKf9IkjZ8JCJoKKUOYFsSw5uaoVPO
         RnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIh4OLXPZqyT593P1uGyKCdBeoEDHVFwCLVWLT+c4Mg=;
        b=CjydB/AyAXLH8X9goi24/pIHvBfhKDbK+t3hEO/mCgonX8lcBr/LQpm+XZYnM4VO0t
         vrNMMSE9FvEx14LPrSeWQTveXWYKocW8/Z5sDZg4PI736w1UMwVohEej5R1y/A77aF9K
         TvorUe0lqfkhBKU4JKsAjT/voExjvK89VMt10m9WCt8sRwsI11O6blizQ7F+vpA8Gq9m
         NP9bW0PNRcyveSnOgAs4bourLqwwX770XCu3UPK+yfRvQfok3ub7KJCLMebKmPrW9BFr
         JkUAbwOxaUPxe2OtQZ2OrV0HzaqUybkanVbsohSvemoucjqPHbEfLxRfmA39bf7xS/9y
         EXaw==
X-Gm-Message-State: AOAM531+41TtspBVpcFlynTpKChyAkfJrRkHSzplwOt1SVe6yriaeXHJ
        6oTFfiOrE3G7M2iQy+rvFsg=
X-Google-Smtp-Source: ABdhPJyTl78Zz2DcYCabZN13Y/BG0wPYREHUDsozd+maJ4kevTAOkkg3edzEq8Cvh7Nx+qY7w5+f7g==
X-Received: by 2002:a62:52d1:0:b029:1da:1371:20b8 with SMTP id g200-20020a6252d10000b02901da137120b8mr16948374pfb.73.1612899128436;
        Tue, 09 Feb 2021 11:32:08 -0800 (PST)
Received: from localhost.localdomain ([103.200.106.135])
        by smtp.googlemail.com with ESMTPSA id z16sm22936977pgj.51.2021.02.09.11.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:32:07 -0800 (PST)
From:   ameynarkhede03@gmail.com
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v2] staging: gdm724x: Fix DMA from stack
Date:   Wed, 10 Feb 2021 01:01:47 +0530
Message-Id: <20210209193147.558514-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amey Narkhede <ameynarkhede03@gmail.com>

Stack allocated buffers cannot be used for DMA
on all architectures so allocate hci_packet buffer
using kzalloc().

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/staging/gdm724x/gdm_usb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
index dc4da66c3..c4a9b90c5 100644
--- a/drivers/staging/gdm724x/gdm_usb.c
+++ b/drivers/staging/gdm724x/gdm_usb.c
@@ -56,11 +56,15 @@ static int gdm_usb_recv(void *priv_dev,

 static int request_mac_address(struct lte_udev *udev)
 {
-	u8 buf[16] = {0,};
-	struct hci_packet *hci = (struct hci_packet *)buf;
+	u8 *buf;
+	struct hci_packet *hci;
 	struct usb_device *usbdev = udev->usbdev;
 	int actual;
 	int ret = -1;
+	buf = kzalloc(16, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	hci = (struct hci_packet *)buf;

 	hci->cmd_evt = gdm_cpu_to_dev16(udev->gdm_ed, LTE_GET_INFORMATION);
 	hci->len = gdm_cpu_to_dev16(udev->gdm_ed, 1);
@@ -70,6 +74,7 @@ static int request_mac_address(struct lte_udev *udev)
 			   &actual, 1000);

 	udev->request_mac_addr = 1;
+	kfree(buf);

 	return ret;
 }
--
2.30.0
