Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856D4315226
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhBIOzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhBIOzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:55:18 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51FAC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:54:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j11so9860608plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsFPmTIeHm7DtYVfmhESnu0dmNeWI5KMqfpQCLa5iyM=;
        b=c0UCx2hpMuMRuWZw0veFTmfeYTp9GcEPe41wCtVLRucXalJm2ayodh4x6gaRR/xJkm
         a3fq863JBv3+GLa1/utbL3s4/16clhaAxE+uHQTdDE6ie9pnasbiQfNXqM+m2tF1jL/a
         /EthGW58r+LVspVgjDAnjwfLVBjb97mEHiZOKZkUGxhucN5eTKUhIFMO+nbJ52/NG9vT
         9GvCX9BxkZy8xql8JAngqhJseaAbBodVm9CsME8aiUb2hlQApmldx/Z6bh2Cw5B08cmj
         RkFph55uISoFpfubzPWGsHsHF/8brFKX9qqqG7RDqcRNqNYQMHrVbzr4EjZCaHvw1f5p
         Ei7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsFPmTIeHm7DtYVfmhESnu0dmNeWI5KMqfpQCLa5iyM=;
        b=e0yGGOd+6CH+Uga8j5Vsta7Uvr/0EUaseXeo0JJgxKGtKmY0rZPxH/wRyqmoSGuEfG
         xX9+LS0H5Wxz7AzQx3eZ0vtaNDvoywMj+EfoiIX7igzqU0HOyxsQRr20Px+jWgQH3qvB
         SjU2h7OD9CSz5U/uLsS+mj67qi4/6xpznS5MFMgRhm49QWg2Y2R76rq6xHlylilhPQp7
         nISLWo0IPopaHzf9R2tqb92aRlcAJxRcsn5m7jPZ0LaKEbpy7G1msD7dVDetlwYa/ASe
         bcutjhB1aHeGA4QgU/ajnWsLNu/604fExcb/5oNc92EA962iIVkzQTSrnnN5wQ/57LCS
         l/7g==
X-Gm-Message-State: AOAM532wE8R81o2+e4DPzmPXEzo7iy/gC0RxMfluufhacbWWEMM+eRPB
        LQ3T16aabBiMmc6WgBkjNWU=
X-Google-Smtp-Source: ABdhPJxV86a/ldtHrtX1gHDG2mnkJoZqklMH4sbHBhbkJY7FNHpM9sW6HMLw9uUsOHofh5tY4/ZGNA==
X-Received: by 2002:a17:902:e812:b029:de:5af2:3d09 with SMTP id u18-20020a170902e812b02900de5af23d09mr21645098plg.33.1612882477400;
        Tue, 09 Feb 2021 06:54:37 -0800 (PST)
Received: from localhost.localdomain ([103.200.106.135])
        by smtp.googlemail.com with ESMTPSA id e23sm8878798pfd.145.2021.02.09.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:54:36 -0800 (PST)
From:   ameynarkhede03@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH] staging: gdm724x: Fix DMA from stack
Date:   Tue,  9 Feb 2021 20:24:15 +0530
Message-Id: <20210209145415.29609-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amey Narkhede <ameynarkhede03@gmail.com>

Stack allocated buffers cannot be used for DMA
on all architectures so allocate usbdev buffer
using kmalloc().

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/staging/gdm724x/gdm_usb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
index dc4da66c3..50dc463d4 100644
--- a/drivers/staging/gdm724x/gdm_usb.c
+++ b/drivers/staging/gdm724x/gdm_usb.c
@@ -56,7 +56,7 @@ static int gdm_usb_recv(void *priv_dev,

 static int request_mac_address(struct lte_udev *udev)
 {
-	u8 buf[16] = {0,};
+	u8 *buf;
 	struct hci_packet *hci = (struct hci_packet *)buf;
 	struct usb_device *usbdev = udev->usbdev;
 	int actual;
@@ -66,6 +66,10 @@ static int request_mac_address(struct lte_udev *udev)
 	hci->len = gdm_cpu_to_dev16(udev->gdm_ed, 1);
 	hci->data[0] = MAC_ADDRESS;

+	buf = kmalloc(16, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
 	ret = usb_bulk_msg(usbdev, usb_sndbulkpipe(usbdev, 2), buf, 5,
 			   &actual, 1000);

--
2.30.0
