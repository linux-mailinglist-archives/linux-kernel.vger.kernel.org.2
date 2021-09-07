Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F27D40292C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbhIGMtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:49:08 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:39879 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231600AbhIGMtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:49:07 -0400
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1631018878;
        bh=ATKYi2Vk5p0hBeuPNHEODB9n/mjvnxJq3rBPTJFZlp0=;
        h=From:To:Cc:Subject:Date:From;
        b=IooRD0Vl+15Z32+h4hNQYZl9xacLWEALyLzlP1IV3rSc3BA5DGwm9dyDsQP4+qvxv
         8CDNM4tcj5LCSs/cslgzcxtYRh2FCtt3yxUtUD4/rZNyJfHcjH2zrQyvB2lxxhyJjv
         N8AcFOtaiaHs3r8Rjm2wZIxWm2JCbFZXc3kiFgfo=
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] backlight: propagate errors from get_brightness()
Date:   Tue,  7 Sep 2021 14:47:51 +0200
Message-Id: <20210907124751.6404-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

backlight.h documents "struct backlight_ops->get_brightness()" to return
a negative errno on failure.
So far these errors have not been handled in the backlight core.
This leads to negative values being exposed through sysfs although only
positive values are documented to be reported.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

v1: https://lore.kernel.org/dri-devel/20210906215525.15418-1-linux@weissschuh.net/

v1 -> v2:
* use dev_err() instead of dev_warn() (Daniel Thompson)
* Finish logging format string with newline (Daniel Thompson)
* Log errno via dedicated error pointer format (Daniel Thompson)

 drivers/video/backlight/backlight.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 537fe1b376ad..4658cfb75aa2 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -292,10 +292,13 @@ static ssize_t actual_brightness_show(struct device *dev,
 	struct backlight_device *bd = to_backlight_device(dev);
 
 	mutex_lock(&bd->ops_lock);
-	if (bd->ops && bd->ops->get_brightness)
-		rc = sprintf(buf, "%d\n", bd->ops->get_brightness(bd));
-	else
+	if (bd->ops && bd->ops->get_brightness) {
+		rc = bd->ops->get_brightness(bd);
+		if (rc >= 0)
+			rc = sprintf(buf, "%d\n", rc);
+	} else {
 		rc = sprintf(buf, "%d\n", bd->props.brightness);
+	}
 	mutex_unlock(&bd->ops_lock);
 
 	return rc;
@@ -381,9 +384,18 @@ ATTRIBUTE_GROUPS(bl_device);
 void backlight_force_update(struct backlight_device *bd,
 			    enum backlight_update_reason reason)
 {
+	int brightness;
+
 	mutex_lock(&bd->ops_lock);
-	if (bd->ops && bd->ops->get_brightness)
-		bd->props.brightness = bd->ops->get_brightness(bd);
+	if (bd->ops && bd->ops->get_brightness) {
+		brightness = bd->ops->get_brightness(bd);
+		if (brightness >= 0)
+			bd->props.brightness = brightness;
+		else
+			dev_err(&bd->dev,
+				"Could not update brightness from device: %pe\n",
+				ERR_PTR(brightness));
+	}
 	mutex_unlock(&bd->ops_lock);
 	backlight_generate_event(bd, reason);
 }

base-commit: 79fad92f2e596f5a8dd085788a24f540263ef887
-- 
2.33.0

