Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9505316917
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhBJO0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhBJO0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:26:25 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93886C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 06:25:44 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z6so1378092pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 06:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8I480O/49ORaRi+QiD8YAganudXzh1u6v9aJFMTd2A=;
        b=bgoACTLsYcSXdtbBijoA/1R+6cPM5HJOZ8Yyuk/AfUNzddLT/TYI0kdOP/Gx22wVx/
         Q35AMhua5Rtxfw0aMVZ8OTSokS8svhyX1nVCM9SxVQ54oCMJ/MrKADpsbTAZ1G+ZHKaD
         c38ZvYGfbkMjdVavs98HgBZnp++3AInu6ICuiIB/HzDQAb2/WOkyXEgW5QogbnBDnh57
         Uq8HPDbHx+/BQEWD1RfTqvDe+LlloFNuL7V0+CTWFJfX3+oWCwc12D6Z7hHHSJDXNH7v
         Nj9GMNxs5kt6oT5lklWQO2OQz07GM3VpIYi4ZUtDseDkxodRY59seYX6AB3jo86AZJ4t
         0klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8I480O/49ORaRi+QiD8YAganudXzh1u6v9aJFMTd2A=;
        b=GvCuTbATEASfZC9MoHueUJIeCL2sULvMCVoq3AnqWEl2a1O8iin3zgARd7/odoa9EL
         8fzpxGgB5kBhfP5xYzxlK+WEvaS2yP4USYtO0gR4c1xpEx3jsaGx9hANpADNHmMHNdIS
         PteEaZHKTjvx6QkaG/2s7p09oOqywJ8crizFXTusKHPRMzUoi7X1J3AEQtDmiOM8mn5L
         ik4TBOGckO07jekW72RON9QHlEfFG0H3R3eZZiOgiQd8pn6AdyrjEfJyGO7BFBtCjU30
         mtRe1jFTba+ONvRYt4Tc4oLvSniaeqQ08/4w/erOtRevF/2hfVsujJeEbeRkkvUNypMF
         HHSQ==
X-Gm-Message-State: AOAM533+7bkuNOmZAB+UxFf5uP8elFfjUL+5bfeFkGIwB1JNcW+smcSh
        jJN2IxEGk30TaaPLJmucn5o=
X-Google-Smtp-Source: ABdhPJwNsxiX3m6b8wB4JOUQEeiU1TCrZ9qTvxdOAd7YXjO9GMBSXn+F/Syac/p+9o6PzBCZFglnKA==
X-Received: by 2002:a05:6a00:1707:b029:1cc:2d49:9f29 with SMTP id h7-20020a056a001707b02901cc2d499f29mr3328564pfc.8.1612967143985;
        Wed, 10 Feb 2021 06:25:43 -0800 (PST)
Received: from localhost.localdomain ([103.200.106.135])
        by smtp.googlemail.com with ESMTPSA id a30sm2565800pfh.66.2021.02.10.06.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 06:25:43 -0800 (PST)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v3] staging: gdm724x: Fix DMA from stack
Date:   Wed, 10 Feb 2021 19:55:12 +0530
Message-Id: <20210210142512.23152-1-ameynarkhede03@gmail.com>
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
Changes in v3:
	- Remove superfluous buf pointer
	- Reduce size of allocation of hci_packet to match number of
	bytes used for DMA

 drivers/staging/gdm724x/gdm_usb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
index dc4da66c3..80c58a3ef 100644
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

+	hci = kmalloc(5, GFP_KERNEL);
+	if (!hci)
+		return -ENOMEM;
+
 	hci->cmd_evt = gdm_cpu_to_dev16(udev->gdm_ed, LTE_GET_INFORMATION);
 	hci->len = gdm_cpu_to_dev16(udev->gdm_ed, 1);
 	hci->data[0] = MAC_ADDRESS;

-	ret = usb_bulk_msg(usbdev, usb_sndbulkpipe(usbdev, 2), buf, 5,
+	ret = usb_bulk_msg(usbdev, usb_sndbulkpipe(usbdev, 2), &hci, 5,
 			   &actual, 1000);

 	udev->request_mac_addr = 1;
+	kfree(hci);

 	return ret;
 }
--
2.30.1
