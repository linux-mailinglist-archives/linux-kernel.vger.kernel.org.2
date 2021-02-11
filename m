Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098783184F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 06:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhBKFjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 00:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBKFjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:39:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0369CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:38:55 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d13so2774806plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DkXaHbb7vfykOZTzC+xBJRdgo6D6KFDFoMk3bIB0y48=;
        b=rIlTHtfRRMnexiBN16ky6IIM2MAx4co/9o7WPcw9X4ioxz5IsxhxNnBKhzI9A7ZwUF
         +RVX6MWWTJ08gfUfrbxnnCypUaHZ5GoSI7kMo4KNUQWd5X+ntOlO9qyTYI369aqCc8EJ
         pAlntRfuI39nXx1DCwSPUtW93PkuL6mMBx1WM6BX6/ACvsNSvMNN32ZJwatDMEo5TSKS
         Dspq9fObwxdqu9YE3lG+inENRPh8XwkA8J+mlLP23bAHrLWg4+RQRDnkbLnTFCOF6rSY
         6ZRwR41bYKSLAM1viUAef6rczrb2SZ4q0kcf/xiYdpQKOsMSOJUPrQvWqidOOrG6Ex8w
         wwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DkXaHbb7vfykOZTzC+xBJRdgo6D6KFDFoMk3bIB0y48=;
        b=UtpPmdMB7UzRL5dGwdun8ze1pRtR5zqvdH1Jw3Y6CpB5Q+upt43dumJSpLTzpZBIXq
         guKsG0C1noTMztqGoRZdpFVPdn+gRcFU9RA0C+kXxiroeVIz7FvKVjeVp+GCDWZ6qv/B
         RR45LPJDWL8+NVbDgeKgyWOqXkXEv1BmO+PYvaAcRH5xaAoo6VYIjvJBMeF8fcgQFB3X
         MSdA9RTorXeeWR4PX9qZDW7iQnFraM3K3bkfMNnFzz3Khp+lisoE+s3ybi37/gu8D5xE
         pl8ZChWCQXvaXcYuBCb61PQMOOMtbdnL28mkphYnv1uZh788zILdiTMcHLFeoDjURW0S
         h49A==
X-Gm-Message-State: AOAM530qh+WTaLqdIDYCr/hz7TBsGCTc8aaDuf5PoiApGVyPQi3HhlPo
        2O1DtPUmFwZlxO+WJT5GbiM=
X-Google-Smtp-Source: ABdhPJzKo6Ld8SfUdADvztVyYjrxWsk6xblowX30cNJR6Go7zw8d+MnCYFq9aNLcFj4MvL5Oe1SiuQ==
X-Received: by 2002:a17:902:7c0d:b029:e2:e9cd:6280 with SMTP id x13-20020a1709027c0db02900e2e9cd6280mr1043758pll.22.1613021934616;
        Wed, 10 Feb 2021 21:38:54 -0800 (PST)
Received: from localhost.localdomain ([103.200.106.135])
        by smtp.googlemail.com with ESMTPSA id v1sm4513641pfi.99.2021.02.10.21.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 21:38:54 -0800 (PST)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v4] staging: gdm724x: Fix DMA from stack
Date:   Thu, 11 Feb 2021 11:08:19 +0530
Message-Id: <20210211053819.34858-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stack allocated buffers cannot be used for DMA
on all architectures so allocate hci_packet buffer
using kmalloc.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
Changes in v4:
	- Use struct_size to allocate memory for hci_packet
	- Fix memory corruption

 drivers/staging/gdm724x/gdm_usb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
index dc4da66c3..54bdb64f5 100644
--- a/drivers/staging/gdm724x/gdm_usb.c
+++ b/drivers/staging/gdm724x/gdm_usb.c
@@ -56,20 +56,24 @@ static int gdm_usb_recv(void *priv_dev,

 static int request_mac_address(struct lte_udev *udev)
 {
-	u8 buf[16] = {0,};
-	struct hci_packet *hci = (struct hci_packet *)buf;
+	struct hci_packet *hci;
 	struct usb_device *usbdev = udev->usbdev;
 	int actual;
 	int ret = -1;

+	hci = kmalloc(struct_size(hci, data, 1), GFP_KERNEL);
+	if (!hci)
+		return -ENOMEM;
+
 	hci->cmd_evt = gdm_cpu_to_dev16(udev->gdm_ed, LTE_GET_INFORMATION);
 	hci->len = gdm_cpu_to_dev16(udev->gdm_ed, 1);
 	hci->data[0] = MAC_ADDRESS;

-	ret = usb_bulk_msg(usbdev, usb_sndbulkpipe(usbdev, 2), buf, 5,
+	ret = usb_bulk_msg(usbdev, usb_sndbulkpipe(usbdev, 2), hci, 5,
 			   &actual, 1000);

 	udev->request_mac_addr = 1;
+	kfree(hci);

 	return ret;
 }
--
2.30.1
