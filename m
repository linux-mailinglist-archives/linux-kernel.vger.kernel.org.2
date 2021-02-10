Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFDC316081
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhBJICo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhBJICk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:02:40 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9084AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:02:00 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l18so689211pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Slj9l/VQZUt/KaQ6/TUAGUUDhforIs71tVz3o7zQQ5E=;
        b=P7tpCvNf15gnEGdU+0sJnNw62dAnELLrG8NarD9qveiIiLvghu128VmnVXJsvGXiFF
         ZEsxaIe0bXmDlNuRwla+S1X2bwpBKyMfctARqcsrmsWxGBU5ZbsshMekFY8O3RAySSOF
         Ef2PsEtTB9+iDH9+YgS1JvwwxSTC7NnXHp1lcB9kGBsy2STP76WQlQoqi1ZM4MF7oCnC
         duzSYHqzdNQs373JGXPIxGH+csrOghj4UuoWPjthN/8gR6A76bykmHkdjvQyXVWc/Yjn
         ywffns2MEHVrFEs/DUbHeF6MWToqk3pqIraQf6OTtQVSn2W9f4HnapB8OJSHFaUm2ER1
         KdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Slj9l/VQZUt/KaQ6/TUAGUUDhforIs71tVz3o7zQQ5E=;
        b=Md2k4/wA4/Es5/l3YNPVQKoIUpx3RID/0NbADR9g2GSD/X1T5eErVnhnxYLxfuIVTZ
         B0VGOgRXnW4gxSk0UVhDFWUB/kUyXz0YDQcYaKBP1QBvrLzMaBgJ0YWAhZW2pvJBHt7Q
         9Q+872Peu21N1QMv/yCn2XSI5Ru9ZNk9By5YGzQ+E0YqKtoPEbasxWrCYFdJJbpZjM27
         gxK8rdXHT+7aDRCpI6WZG7ZiKLCfNfhIQq/xKQa1jXUOtOAUdZtZmbYIb8bdl5zRa1VA
         koAOgVsnjGygImMDi9SS77nZ/YIIDYciNbJTW0cUIvSTefqBkdyqa3fEl3xI4OVOQYhY
         WXWQ==
X-Gm-Message-State: AOAM530Ntcv2rrCPjjROMHt8zaROzVazhytCvMYa7+7zKNNBtiBX4qep
        1EGdLrRYQJpMd1HILplPc0M=
X-Google-Smtp-Source: ABdhPJx4q9nhVqe3Et6N+22cZ7MCAFU4h/lbXsa0lueUpcg3nUYaup7azYxrIeRCY5Yr+GKLuxCQ6g==
X-Received: by 2002:a17:902:e211:b029:e2:843c:426e with SMTP id u17-20020a170902e211b02900e2843c426emr1962098plb.16.1612944120197;
        Wed, 10 Feb 2021 00:02:00 -0800 (PST)
Received: from localhost.localdomain ([103.200.106.135])
        by smtp.googlemail.com with ESMTPSA id m5sm1287180pgj.11.2021.02.10.00.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:01:59 -0800 (PST)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v2] staging: gdm724x: Fix DMA from stack
Date:   Wed, 10 Feb 2021 13:31:34 +0530
Message-Id: <20210210080134.1978-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stack allocated buffers cannot be used for DMA
on all architectures so allocate hci_packet buffer
using kzalloc().

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
Changes in v2:
	- Fixed build warning
	- Fixed memory leak using kfree

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
