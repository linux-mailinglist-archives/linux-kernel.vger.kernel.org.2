Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B404344BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhCVQlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231989AbhCVQlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:41:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3D6461983;
        Mon, 22 Mar 2021 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616431299;
        bh=wTCQr9EWReJqtv/s8uqRSPBYWLbukkFUAZ7BJJhYHhI=;
        h=From:To:Cc:Subject:Date:From;
        b=FPrmYxwLnsZstci9axXyytZZzCy9y3Cevl1KqesKwOuenXzXvlVzxhadzwKXI54mr
         aSjFBZSVdDt22a6tXaI7+rJMgbES/VMyJGT6D0V0jpWtdKNJjJBI7i+FF1Cxm2JvSz
         Df/icB4sJaXsfPKndnUEX+SJzndY/e/Moin0GZrEgqjqDA1WPy4+f/S3jS/eSYmgQR
         cX1/5h5kq98Nru1lJO0vBoWrejwnli8I7gsqb9nlCSypsvDhhCyy5J4kLgSCWnWpTO
         6APc7UdRuJKkdl0BJr4RE5gCy+vyln4Nw7PNsov+iQZrMrG1+gfPGHmvVsIRo0WQH4
         09iB9yXFo/YoA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Richard Purdie <rpurdie@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: journada720: fix Wmisleading-indentation warning
Date:   Mon, 22 Mar 2021 17:41:28 +0100
Message-Id: <20210322164134.827091-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With gcc-11, we get a warning about code that looks correct
but badly indented:

drivers/video/backlight/jornada720_bl.c: In function ‘jornada_bl_update_status’:
drivers/video/backlight/jornada720_bl.c:66:11: error: this ‘else’ clause does not guard... [-Werror=misleading-indentation]
   66 |         } else  /* turn on backlight */
      |           ^~~~

Change the formatting according to our normal conventions.

Fixes: 13a7b5dc0d17 ("backlight: Adds HP Jornada 700 series backlight driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/backlight/jornada720_bl.c | 44 ++++++++++++-------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/video/backlight/jornada720_bl.c b/drivers/video/backlight/jornada720_bl.c
index 996f7ba3b373..066d0dc98f60 100644
--- a/drivers/video/backlight/jornada720_bl.c
+++ b/drivers/video/backlight/jornada720_bl.c
@@ -66,30 +66,30 @@ static int jornada_bl_update_status(struct backlight_device *bd)
 	} else  /* turn on backlight */
 		PPSR |= PPC_LDD1;
 
-		/* send command to our mcu */
-		if (jornada_ssp_byte(SETBRIGHTNESS) != TXDUMMY) {
-			dev_info(&bd->dev, "failed to set brightness\n");
-			ret = -ETIMEDOUT;
-			goto out;
-		}
+	/* send command to our mcu */
+	if (jornada_ssp_byte(SETBRIGHTNESS) != TXDUMMY) {
+		dev_info(&bd->dev, "failed to set brightness\n");
+		ret = -ETIMEDOUT;
+		goto out;
+	}
 
-		/*
-		 * at this point we expect that the mcu has accepted
-		 * our command and is waiting for our new value
-		 * please note that maximum brightness is 255,
-		 * but due to physical layout it is equal to 0, so we simply
-		 * invert the value (MAX VALUE - NEW VALUE).
-		 */
-		if (jornada_ssp_byte(BL_MAX_BRIGHT - bd->props.brightness)
-			!= TXDUMMY) {
-			dev_err(&bd->dev, "set brightness failed\n");
-			ret = -ETIMEDOUT;
-		}
+	/*
+	 * at this point we expect that the mcu has accepted
+	 * our command and is waiting for our new value
+	 * please note that maximum brightness is 255,
+	 * but due to physical layout it is equal to 0, so we simply
+	 * invert the value (MAX VALUE - NEW VALUE).
+	 */
+	if (jornada_ssp_byte(BL_MAX_BRIGHT - bd->props.brightness)
+		!= TXDUMMY) {
+		dev_err(&bd->dev, "set brightness failed\n");
+		ret = -ETIMEDOUT;
+	}
 
-		/*
-		 * If infact we get an TXDUMMY as output we are happy and dont
-		 * make any further comments about it
-		 */
+	/*
+	 * If infact we get an TXDUMMY as output we are happy and dont
+	 * make any further comments about it
+	 */
 out:
 	jornada_ssp_end();
 
-- 
2.29.2

