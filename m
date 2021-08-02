Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F9F3DE290
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 00:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhHBWhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 18:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhHBWhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:37:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECAEC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 15:37:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u15so11307388wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 15:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1NYy3xMVa4GkO751TKcuObegthDWDqsbdIWZPwNk3T8=;
        b=fp14hetuEWvtVi1U9vDQzbHmtEf4HT7iARzzKd1/K8u2r1+4ZD+niYk9EnL3TX4lxk
         6HgiNN9dHbkkvBUoHTLJLD/Oy8BgjvfroQqV1MT7Sf5AzGZoh39DN8oNJ/zS9WoiZtXb
         Qlwp5BIauGrnv3kqnbh5ew83aHsCuB+zzpui8mq7gFutfY+gdmSdaDt4lryru0J0exbP
         Tk3ek7Rw5CzyBmrvidyu1tiMMxPxQLZYI4lYG1mXNXJxhHqtWRF9vIuUmesRYOBPVNVQ
         1IpKk2dJ1vrdUVVCYGzccf97XFAyB/NRRRFZpdCur+oaLwBjgkjDFBfrWkyg9R1MxQ3f
         djGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1NYy3xMVa4GkO751TKcuObegthDWDqsbdIWZPwNk3T8=;
        b=Y3oet/rNaeIPX1ofIRrWMZBxDQhlaZrnBXnG3/0ByRebjlwRHq5yJTCCkD0ekMHpMj
         6Y32TwQS5eO5aHN4KHqPlK1o1lsfrORArGgrTZ//qjEJl2RacFI5pYQs7lQJx1bpOg7Y
         y912S9vCn0G5lIQvOvuqO9Mw9jLdMb7jRkNrrZzi4MR/CKlirFj7w9vsKIf5UXMrO2zk
         6vYzjySEE0cDDGE9zp3/MLFfod0G8UhVltixlIPWCdbiwa2FbbhawcrwXkvGJAXL9AlC
         r6HV4zjTUD+I+9omnczTAblwF6+3SWoCeR4ZxHhV44/qPxyRItOq4yoeDv0LITmS2gTc
         wSRw==
X-Gm-Message-State: AOAM530sbuLM3ruH96XvX/520ffP1Y8vZRQ4jMTx7sDLSzhvGZsK6lTi
        sqYpGDwwVXI7pyWe/cDXJEE=
X-Google-Smtp-Source: ABdhPJzjLHYzabtB+5RvH+66k6gq3MnEMipWqyqjNoMKDpOmRIxYpLN6sWM2hJdy1PO2epxec9N11A==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr1100122wma.94.1627943826859;
        Mon, 02 Aug 2021 15:37:06 -0700 (PDT)
Received: from pc ([196.235.140.151])
        by smtp.gmail.com with ESMTPSA id f15sm12061885wrp.12.2021.08.02.15.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:37:06 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:37:03 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gdm724x: get lock before calling
 usb_[disable|enable]_autosuspend()
Message-ID: <20210802223703.GA1425480@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the documentation of usb_[disable|enable]_autosuspend(), the
caller must hold udev's device lock.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/staging/gdm724x/gdm_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
index 54bdb64f52e8..31b3b3e563c8 100644
--- a/drivers/staging/gdm724x/gdm_usb.c
+++ b/drivers/staging/gdm724x/gdm_usb.c
@@ -846,7 +846,9 @@ static int gdm_usb_probe(struct usb_interface *intf,
 	udev->intf = intf;
 
 	intf->needs_remote_wakeup = 1;
+	usb_lock_device(usbdev);
 	usb_enable_autosuspend(usbdev);
+	usb_unlock_device(usbdev);
 	pm_runtime_set_autosuspend_delay(&usbdev->dev, AUTO_SUSPEND_TIMER);
 
 	/* List up hosts with big endians, otherwise,
-- 
2.25.1

