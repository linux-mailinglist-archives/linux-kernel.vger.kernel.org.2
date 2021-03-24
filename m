Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33AE34850C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbhCXXHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbhCXXG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:06:59 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1366C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:06:58 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id v26so15754iox.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4nsP5iuSvLRUSUoVyhkKNOJvSrZQbNgl007uSGB9Jk=;
        b=Nm1q6owNG5rx+/fwQyP3HWBenPMSaXplLjhEAlA3MxdK0J/q3Q5IKEUOeu9EbPftDx
         qwADRNgOrFS/7Jey+oH6I2UMDtxfytpDtXH/RepLF78ZfL378dyChrXQpViPlstLQFve
         ukdj4wEbMxN9my+RyGreh1NL6r2cuymInq9kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4nsP5iuSvLRUSUoVyhkKNOJvSrZQbNgl007uSGB9Jk=;
        b=eWYl6B9CQ7ZwzK/5oRrOLXU0bB7mrrLurTYnB/ng11PirBE8mSEI/KU7yyZ/r4RJnp
         eKZ+dDQi4V9TFMw0089FEu5PjZj1d5K3fnJWVZ5hQuT3vErYXyfPx5Ng60LW1ku2qCl8
         HfZOMhp3GAeyIZ2OVVkaVJJW1bsg1cKd7UeVR6ZupgaRIga0HcYvs3I55IbI6jOrnlSY
         fRuzOZOhPURHHQPz3N792LjPbgF0ZMiQMGrixyukkN8owWMJjDjCNPtA8In8tAOIk2p7
         LBqWAU7WuoM5d4lhATf+YrmD2eQcGxPEGuQ+24HDc49RtH19x6ckMDX96KiKvtDoX9IT
         0Mug==
X-Gm-Message-State: AOAM5303RKTGlt/Gt0P7hvSsJEzUUjG68L0+KcCf/BzlShwe1oAYrAZn
        z1WGtbNSoOLFa32J0ybFWleVAw==
X-Google-Smtp-Source: ABdhPJyS+92HCc3ZBxTa2EOIEXTFs5p8NK2Hu4c2/ZOCCFrNy5I2JuIXSsPRUWGuP6UZtTqU2ZvIQg==
X-Received: by 2002:a6b:650f:: with SMTP id z15mr4183159iob.128.1616627218256;
        Wed, 24 Mar 2021 16:06:58 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t8sm1638249ioc.12.2021.03.24.16.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:06:57 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+3dea30b047f41084de66@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: [PATCH] usbip: vhci_hcd fix shift out-of-bounds in vhci_hub_control()
Date:   Wed, 24 Mar 2021 17:06:54 -0600
Message-Id: <20210324230654.34798-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix shift out-of-bounds in vhci_hub_control() SetPortFeature handling.

UBSAN: shift-out-of-bounds in drivers/usb/usbip/vhci_hcd.c:605:42
shift exponent 768 is too large for 32-bit type 'int'

Reported-by: syzbot+3dea30b047f41084de66@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/usb/usbip/vhci_hcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 3209b5ddd30c..a20a8380ca0c 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -594,6 +594,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				pr_err("invalid port number %d\n", wIndex);
 				goto error;
 			}
+			if (wValue >= 32)
+				goto error;
 			if (hcd->speed == HCD_USB3) {
 				if ((vhci_hcd->port_status[rhport] &
 				     USB_SS_PORT_STAT_POWER) != 0) {
-- 
2.27.0

