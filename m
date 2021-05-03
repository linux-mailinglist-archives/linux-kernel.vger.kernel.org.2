Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61423714F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhECMC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233948AbhECMBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:01:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 247286127A;
        Mon,  3 May 2021 12:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043256;
        bh=Ie00amOOJeEDuOtAfjGCSTkQd5eoze8rDc72pB37rb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tivas+zk23sqcDXX9aUnQjW5tsbzabCeJV27+JPUuUeWIs+06i/Uws1/ULuwTeI6A
         CwEulo4D5C57n7c7ZJdmX59WEJb0QsGmqBboA+lIzwV3BX4/LpxyJeMF8sqVWWAIMI
         /TotReA0DTotewqzNx7CB7tSI7wBKGWUz3najDF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 60/69] Revert "media: gspca: mt9m111: Check write_bridge for timeout"
Date:   Mon,  3 May 2021 13:57:27 +0200
Message-Id: <20210503115736.2104747-61-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 656025850074f5c1ba2e05be37bda57ba2b8d491.

Because of recent interactions with developers from @umn.edu, all
commits from them have been recently re-reviewed to ensure if they were
correct or not.

Upon review, this commit was found to be incorrect for the reasons
below, so it must be reverted.  It will be fixed up "correctly" in a
later kernel change.

Different error values should never be "OR" together and expect anything
sane to come out of the result.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/gspca/m5602/m5602_mt9m111.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/gspca/m5602/m5602_mt9m111.c b/drivers/media/usb/gspca/m5602/m5602_mt9m111.c
index bfa3b381d8a2..50481dc928d0 100644
--- a/drivers/media/usb/gspca/m5602/m5602_mt9m111.c
+++ b/drivers/media/usb/gspca/m5602/m5602_mt9m111.c
@@ -195,7 +195,7 @@ static const struct v4l2_ctrl_config mt9m111_greenbal_cfg = {
 int mt9m111_probe(struct sd *sd)
 {
 	u8 data[2] = {0x00, 0x00};
-	int i, rc = 0;
+	int i;
 	struct gspca_dev *gspca_dev = (struct gspca_dev *)sd;
 
 	if (force_sensor) {
@@ -213,18 +213,16 @@ int mt9m111_probe(struct sd *sd)
 	/* Do the preinit */
 	for (i = 0; i < ARRAY_SIZE(preinit_mt9m111); i++) {
 		if (preinit_mt9m111[i][0] == BRIDGE) {
-			rc |= m5602_write_bridge(sd,
+			m5602_write_bridge(sd,
 				preinit_mt9m111[i][1],
 				preinit_mt9m111[i][2]);
 		} else {
 			data[0] = preinit_mt9m111[i][2];
 			data[1] = preinit_mt9m111[i][3];
-			rc |= m5602_write_sensor(sd,
+			m5602_write_sensor(sd,
 				preinit_mt9m111[i][1], data, 2);
 		}
 	}
-	if (rc < 0)
-		return rc;
 
 	if (m5602_read_sensor(sd, MT9M111_SC_CHIPVER, data, 2))
 		return -ENODEV;
-- 
2.31.1

