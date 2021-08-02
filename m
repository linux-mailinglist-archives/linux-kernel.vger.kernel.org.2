Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DC13DE251
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 00:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhHBWOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 18:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhHBWOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:14:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B60DC06175F;
        Mon,  2 Aug 2021 15:14:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso422327wmq.3;
        Mon, 02 Aug 2021 15:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DehFgworsYY8Z4elnk8GHXrsWT2MFnGFLCsMTbpqwMY=;
        b=Cs9ZUq9iAzEM/26fGnMSLab0UWRgKRLovKtO5XkgucS2o8tFPcYBFJy6WIdrovg+D7
         owKfatd8z3HEVFuWfbYbcbWkBgndpI+ui2NomqrRLE8RzxVkVXnIVE0qi2vIuTxG9UKY
         pj+IbPl9Kryo+JOCuvZGEdZ7nn4m+p4DJCoYOHT2AnvEhc3onmG25/DZPGzTLgcbgf0a
         75twUEuJn0m/2+uKRvCApfTQ0UofN8aDuxX4Mv9w6Iv0e96VS4bkWNFTOPS8NqYJoAZJ
         U6kHQmXEDebCetZxyApBmXXvJD70wKoWvWgqjJpVijYSJCzbXT9vyoddasmr0A4MjTVB
         A+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DehFgworsYY8Z4elnk8GHXrsWT2MFnGFLCsMTbpqwMY=;
        b=KL4YF0+4/JBDxU9SjjdSgYXz8HLfrZC6k/MpsobC2WMevwFF8lppHGOTwhmkuubTwk
         ZzNUegtdC3x5TdIOdV/BItDc994ydcTfAWkTSyy1l50bJHauXdQ2yR0rnp05DGdYMQMD
         0yoUdKYC57Big4B1VxQX45yDmsSxu7Px1Z95FzydsbC08IpC0HWMQasIlWHiJTlGqTjv
         xNqNyF6zDEfVmGUxqCInZGP6R2WTEZ8FD+gFQ/aV4Iuq6M6G/dRT/iqOxHlUiuhKkO/N
         Kb2mDfp5gwQTAY9qCL/zvMFQ2d/XcGduJDDk2VLP8vOY7Nf/LUBegg+7ZxuXcJe8mYs3
         d7JQ==
X-Gm-Message-State: AOAM531aZM2JfniWM9e+NZtVS6Mv5F22Fj+WQlaGk9V9n+hrmTX5/Wlf
        ADRZ6MLptN6MeBmVGLzGf5OCmAoands=
X-Google-Smtp-Source: ABdhPJxdqbvX+Xt65IZsQvVoFBhPh/KuCcy5g9a07XxcqhHa5ZcbFB0aPAUoQ3a/zn8JrqPlKLPm3w==
X-Received: by 2002:a05:600c:2909:: with SMTP id i9mr1025024wmd.74.1627942472985;
        Mon, 02 Aug 2021 15:14:32 -0700 (PDT)
Received: from pc ([196.235.140.151])
        by smtp.gmail.com with ESMTPSA id t23sm600719wmi.32.2021.08.02.15.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:14:32 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:14:29 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: bluetooth: get lock before calling
 usb_[disable|enable]_autosuspend()
Message-ID: <20210802221429.GA1370657@pc>
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
 drivers/bluetooth/btusb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9855a2dd561..2ceb48164b6d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1939,8 +1939,11 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 
 			device_set_wakeup_capable(&data->udev->dev, false);
 			/* Re-enable autosuspend if this was requested */
-			if (enable_autosuspend)
+			if (enable_autosuspend) {
+				usb_lock_device(data->udev);
 				usb_enable_autosuspend(data->udev);
+				usb_unlock_device(data->udev);
+			}
 		}
 	}
 
-- 
2.25.1

