Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FBA3714F2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhECMDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233998AbhECMBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:01:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8520961278;
        Mon,  3 May 2021 12:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043259;
        bh=2XLnbKYGw70eB6socMJH1tAOUlUrIj0bitV95Pn6iR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsMgVTtq/kXQWLCAE7cbA4jcTnsCCf1B8/GPp7ewKWeqFQgT33ZFCJEFeAnW9jOab
         7vd4hccv+QaqDLvPoe0OQWx0Dp3+oKEy4x8/TWqgZRBL1LfetvLfz8blFyFcOH6fTE
         ULm8FLXfnQ/Qup3CcubsjEHfNjf4lze//SnjNYok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alaa Emad <alaaemadhossney.ae@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 61/69] media: gspca: mt9m111: Check write_bridge for timeout
Date:   Mon,  3 May 2021 13:57:28 +0200
Message-Id: <20210503115736.2104747-62-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alaa Emad <alaaemadhossney.ae@gmail.com>

If m5602_write_bridge times out, it will return a negative error value.
So properly check for this and handle the error correctly instead of
just ignoring it.

Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Alaa Emad <alaaemadhossney.ae@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/gspca/m5602/m5602_mt9m111.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/gspca/m5602/m5602_mt9m111.c b/drivers/media/usb/gspca/m5602/m5602_mt9m111.c
index 50481dc928d0..bf1af6ed9131 100644
--- a/drivers/media/usb/gspca/m5602/m5602_mt9m111.c
+++ b/drivers/media/usb/gspca/m5602/m5602_mt9m111.c
@@ -195,7 +195,7 @@ static const struct v4l2_ctrl_config mt9m111_greenbal_cfg = {
 int mt9m111_probe(struct sd *sd)
 {
 	u8 data[2] = {0x00, 0x00};
-	int i;
+	int i, err;
 	struct gspca_dev *gspca_dev = (struct gspca_dev *)sd;
 
 	if (force_sensor) {
@@ -213,15 +213,17 @@ int mt9m111_probe(struct sd *sd)
 	/* Do the preinit */
 	for (i = 0; i < ARRAY_SIZE(preinit_mt9m111); i++) {
 		if (preinit_mt9m111[i][0] == BRIDGE) {
-			m5602_write_bridge(sd,
-				preinit_mt9m111[i][1],
-				preinit_mt9m111[i][2]);
+			err = m5602_write_bridge(sd,
+					preinit_mt9m111[i][1],
+					preinit_mt9m111[i][2]);
 		} else {
 			data[0] = preinit_mt9m111[i][2];
 			data[1] = preinit_mt9m111[i][3];
-			m5602_write_sensor(sd,
-				preinit_mt9m111[i][1], data, 2);
+			err = m5602_write_sensor(sd,
+					preinit_mt9m111[i][1], data, 2);
 		}
+		if (err < 0)
+			return err;
 	}
 
 	if (m5602_read_sensor(sd, MT9M111_SC_CHIPVER, data, 2))
-- 
2.31.1

