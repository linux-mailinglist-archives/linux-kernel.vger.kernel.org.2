Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDA43714CF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhECMBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233821AbhECMAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:00:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AE8861369;
        Mon,  3 May 2021 11:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043195;
        bh=dBWuzmYIceLuH1c76CsCnSLX34uWHpW9cjv0Hvb59lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2qSvSG2Zu2lPwAB9WRFRRyoZiX591/6kNuJCgVce/Yboy5TL/5N078z4wiwHQHDq
         ifvF+5bVgCdomhccj9yzOKQAEGoWUzQvhaVxm2efeLW0nv9LeHRtFMjudDwGEXhmrt
         6KAUif0NPldP948MpETGBcTw0yXUFSkrrjgh+huc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 06/69] Revert "media: usb: gspca: add a missed check for goto_low_power"
Date:   Mon,  3 May 2021 13:56:33 +0200
Message-Id: <20210503115736.2104747-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5b711870bec4dc9a6d705d41e127e73944fa3650.

Because of recent interactions with developers from @umn.edu, all
commits from them have been recently re-reviewed to ensure if they were
correct or not.

Upon review, this commit was found to do does nothing useful as a user
can do nothing with this information and if an error did happen, the
code would continue on as before.  Because of this, just revert it.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/gspca/cpia1.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
index a4f7431486f3..d93d384286c1 100644
--- a/drivers/media/usb/gspca/cpia1.c
+++ b/drivers/media/usb/gspca/cpia1.c
@@ -1424,7 +1424,6 @@ static int sd_config(struct gspca_dev *gspca_dev,
 {
 	struct sd *sd = (struct sd *) gspca_dev;
 	struct cam *cam;
-	int ret;
 
 	sd->mainsFreq = FREQ_DEF == V4L2_CID_POWER_LINE_FREQUENCY_60HZ;
 	reset_camera_params(gspca_dev);
@@ -1436,10 +1435,7 @@ static int sd_config(struct gspca_dev *gspca_dev,
 	cam->cam_mode = mode;
 	cam->nmodes = ARRAY_SIZE(mode);
 
-	ret = goto_low_power(gspca_dev);
-	if (ret)
-		gspca_err(gspca_dev, "Cannot go to low power mode: %d\n",
-			  ret);
+	goto_low_power(gspca_dev);
 	/* Check the firmware version. */
 	sd->params.version.firmwareVersion = 0;
 	get_version_information(gspca_dev);
-- 
2.31.1

