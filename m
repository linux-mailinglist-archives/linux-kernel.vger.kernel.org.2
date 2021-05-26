Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028D5391CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhEZQZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 12:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhEZQZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 12:25:27 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51512C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 09:23:53 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m124so1355798pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3gA9VrOSMoB8ARTOwNzx/FAC2RRzo+UnWgujJ7sE+Vg=;
        b=hw1o6LyKi/Tf03o7XXHTA0hWOc4hDYNPWAW/Qc9380ERy8w49LTljmKfxoB0gWHwzx
         PLa/V3YzSdTLK9MBsm5cNpaqGoraOfte5yuqBcO1qVewABciVG1V86NIsoyOg8d+HRNy
         /iAVcoyyjmEkcsYyYkIpXYiAmeLpWWvW7c1Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3gA9VrOSMoB8ARTOwNzx/FAC2RRzo+UnWgujJ7sE+Vg=;
        b=n+xGEnaM22FI3zHF6CjHkiTOAuvzbAEUkBDJ6jqLAk7EjkDbaCLszxRynBzGDYqSp/
         Hhxu8L+jQugvca/WMsV69e53OfCqIaaapp7BZABcQ5vbr5jvC35GBv6xm65iijCOJHFN
         JLuWL064joDQZ7ZE9Olu5ty9Ny2tPiMYyxLOuDNFlF/CxDwwLWzzeVzvZxuWHfZZ2in2
         7wikxrKiz/haCwHoZUlwGpSmC1SCnkqElCePvdM49uxIwSkCYyNRLcC3lsNNc4UjiZmz
         YA9rN7BLai0cRTMr01OWzp5kkCoWk5MmCbpyX6LVLcU7VNk9wYphsN4I8C/N7RpABJ/A
         f/7A==
X-Gm-Message-State: AOAM5310atEwVv9IAyia6IU33rD7AGNcNh21E9m5VQhPb//CTwqErqQ1
        Uhl9XrwCPRxVcgwfyzaSAcUV6g==
X-Google-Smtp-Source: ABdhPJzFZsOE0KGR4DZBTYb44yP9Xh1LSUaSN1gP1C1igJXhUr+iYyvOxYhrBdP+DIoKni43oJxwJw==
X-Received: by 2002:a63:185c:: with SMTP id 28mr25928416pgy.158.1622046232752;
        Wed, 26 May 2021 09:23:52 -0700 (PDT)
Received: from 8bbba9ba63a4 (110-175-118-133.tpgi.com.au. [110.175.118.133])
        by smtp.gmail.com with ESMTPSA id h6sm1046433pjs.15.2021.05.26.09.23.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 May 2021 09:23:52 -0700 (PDT)
Date:   Wed, 26 May 2021 16:23:46 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     broonie@kernel.org, ezequiel@collabora.com, chenjh@rock-chips.com,
        pgwipeout@gmail.com
Subject: [PATCH] regulator: fan53555: add back tcs4526
Message-ID: <20210526162342.GA20@8bbba9ba63a4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


For rk3399pro boards the tcs4526 regulator supports the vdd_gpu
regulator. The tcs4526 regulator has a chip id of <0>.
Add the compatibile tcs,tcs4526  

without this patch, the dmesg output is:
  fan53555-regulator 0-0010: Chip ID 0 not supported!
  fan53555-regulator 0-0010: Failed to setup device!
  fan53555-regulator: probe of 0-0010 failed with error -22
with this patch, the dmesg output is:
  vdd_gpu: supplied by vcc5v0_sys

The regulators are described as:
- Dedicated power management IC TCS4525
- Lithium battery protection chip TCS4526

This has been tested with a Radxa Rock Pi N10.

Fixes: f9028dcdf589 ("regulator: fan53555: only bind tcs4525 to correct chip id")
Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 drivers/regulator/fan53555.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 2695be617373..ddab9359ea20 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -90,6 +90,7 @@ enum {
 };
 
 enum {
+	TCS4525_CHIP_ID_00 = 0,
 	TCS4525_CHIP_ID_12 = 12,
 };
 
@@ -373,6 +374,7 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
 static int fan53526_voltages_setup_tcs(struct fan53555_device_info *di)
 {
 	switch (di->chip_id) {
+	case TCS4525_CHIP_ID_00:
 	case TCS4525_CHIP_ID_12:
 		di->slew_reg = TCS4525_TIME;
 		di->slew_mask = TCS_SLEW_MASK;
@@ -564,6 +566,9 @@ static const struct of_device_id __maybe_unused fan53555_dt_ids[] = {
 	}, {
 		.compatible = "tcs,tcs4525",
 		.data = (void *)FAN53526_VENDOR_TCS
+	}, {
+		.compatible = "tcs,tcs4526",
+		.data = (void *)FAN53526_VENDOR_TCS
 	},
 	{ }
 };
@@ -672,6 +677,9 @@ static const struct i2c_device_id fan53555_id[] = {
 	}, {
 		.name = "tcs4525",
 		.driver_data = FAN53526_VENDOR_TCS
+	}, {
+		.name = "tcs4526",
+		.driver_data = FAN53526_VENDOR_TCS
 	},
 	{ },
 };
-- 
2.29.2

