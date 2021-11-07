Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CB444756D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhKGT76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:59:58 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:63421 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhKGT7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:59:55 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id joHtmnpvfIEdljoHtmSmvS; Sun, 07 Nov 2021 20:57:11 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 07 Nov 2021 20:57:11 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     eric.piel@tremplin-utc.net, hdegoede@redhat.com,
        markgross@kernel.org, dmitry.torokhov@gmail.com,
        giedriuswork@gmail.com, dvhart@linux.intel.com,
        akpm@linux-foundation.org, pavel@suse.cz
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] platform/x86: hp_accel: Fix an error handling path in 'lis3lv02d_probe()'
Date:   Sun,  7 Nov 2021 20:57:07 +0100
Message-Id: <5a4f218f8f16d2e3a7906b7ca3654ffa946895f8.1636314074.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'led_classdev_register()' fails, some additional resources should be
released.

Add the missing 'i8042_remove_filter()' and 'lis3lv02d_remove_fs()' calls
that are already in the remove function but are missing here.

Fixes: a4c724d0723b ("platform: hp_accel: add a i8042 filter to remove HPQ6000 data from kb bus stream")
Fixes: 9e0c79782143 ("lis3lv02d: merge with leds hp disk")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/platform/x86/hp_accel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
index b183967ecfb7..435a91fe2568 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -331,9 +331,11 @@ static int lis3lv02d_probe(struct platform_device *device)
 	INIT_WORK(&hpled_led.work, delayed_set_status_worker);
 	ret = led_classdev_register(NULL, &hpled_led.led_classdev);
 	if (ret) {
+		i8042_remove_filter(hp_accel_i8042_filter);
 		lis3lv02d_joystick_disable(&lis3_dev);
 		lis3lv02d_poweroff(&lis3_dev);
 		flush_work(&hpled_led.work);
+		lis3lv02d_remove_fs(&lis3_dev);
 		return ret;
 	}
 
-- 
2.30.2

