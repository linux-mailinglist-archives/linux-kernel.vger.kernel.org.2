Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6C343DA64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 06:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJ1EeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 00:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhJ1EeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 00:34:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92032C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 21:31:44 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso3708139pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 21:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YLVqItwDwS1zsr5x88IEWScrP6oWEhxTvH4fkBYiiHo=;
        b=qayOMmtY7e47aAYzDpc+3eSrBmTdoNa3sH4+nrM9F8Rd+AznQQ0/Mmeaunt4vENZcb
         Fz2dm268n2HEhB2AraFIfUlyUGmkD6SfgLx0T+MOUJSlzbcosbYRaQnDxWIDzvn64ZsE
         u7CuipJmi3R8V2AQYw3EA76Kn3+QHqfUE2C17084d+UzWtBFtqhpWHwgMChvQDhFR1n3
         Aa5ZkIkZhVAU6M/I6J0csg49avs8RspP3Yq42H3m3gHKrRS8rkNAHv+2PE10ab+AVYYw
         hvH3Rt0gQzjxKALFyuJV5hnWlT4B0MlCsyq9SRjSSMBuq9ON1hP6wUmCD48YyLeFK5hu
         D6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YLVqItwDwS1zsr5x88IEWScrP6oWEhxTvH4fkBYiiHo=;
        b=R+Rz25yRci+Ywc9QiBQh18IgVq+DebLxrNTdqqVNVd2X6rKpEDg5Kjh3tLv9e1Rrjy
         eAJaf3QsfpfhTQGBpJ5Z2AhPQjUYsYsWf4VR1YdUlzA5TkY6vaZ7XzXinnifwStIKJgh
         Ebor5cy1VL6UcS/nMDTjPqI6Afq50L2ReWaUDaJCVdWLoa8vC43UsLwkhMo7tBqOv2pV
         tC+B0O79rcfDSU4jut5ZuM17utJIAoVwbHWqFy0JAZNj1eXcfgoL8LeK5BV+wRPHaKDK
         sDCFSB2KjEeXYBBjmWAGUlLt+bAJFBnrvMN3P+XFY/y935v0xU9e6F0znsCe5sQ0defY
         XPsg==
X-Gm-Message-State: AOAM532Xcv7VqS4wUe0RVOGjWlfVOuzgGKuaCjq5drhZbATdfS8i31N6
        WBxHV9mlzMDj+6nh/O0eVeE=
X-Google-Smtp-Source: ABdhPJwrLY6F+T2x04+PqtbhhJ6qMJh+dPS9vxQjLiFJJ4TJDWgbfkHqpCZNTUVjLkYU2x80mx7QQw==
X-Received: by 2002:a17:902:7781:b0:13d:c9fe:6184 with SMTP id o1-20020a170902778100b0013dc9fe6184mr1591119pll.25.1635395504000;
        Wed, 27 Oct 2021 21:31:44 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.83.133])
        by smtp.gmail.com with ESMTPSA id d11sm1551128pfv.185.2021.10.27.21.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 21:31:43 -0700 (PDT)
Date:   Thu, 28 Oct 2021 10:01:33 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, alec@vc-celle.de,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8712: remove the condition with no effect
Message-ID: <YXonpdnCatbuOo8H@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the if condition check and else code section in
query_rx_phy_status(). As variable cck_highpwr is assign a value of '0'
after this assignment, if condition check !cck_highpwr is always
going to be true. So remove the if condition check as well as else
section which will be never true.

After removing the if condition there is no use of local variable
cck_highpwr. Remove the local variable cck_highpwr.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 75 +++++++++-----------------
 1 file changed, 26 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 0ffb30f1af7e..f04c454e16a6 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -708,7 +708,7 @@ static void query_rx_phy_status(struct _adapter *padapter,
 	s8 rx_pwr[4], rx_pwr_all;
 	u8 pwdb_all;
 	u32 rssi, total_rssi = 0;
-	u8 bcck_rate = 0, rf_rx_num = 0, cck_highpwr = 0;
+	u8 bcck_rate = 0, rf_rx_num = 0;
 	struct phy_cck_rx_status *pcck_buf;
 	u8 sq;

@@ -723,55 +723,32 @@ static void query_rx_phy_status(struct _adapter *padapter,
 		 * (2)PWDB, Average PWDB calculated by hardware
 		 * (for rate adaptive)
 		 */
-		if (!cck_highpwr) {
-			report = pcck_buf->cck_agc_rpt & 0xc0;
-			report >>= 6;
-			switch (report) {
-			/* Modify the RF RNA gain value to -40, -20,
-			 * -2, 14 by Jenyu's suggestion
-			 * Note: different RF with the different
-			 * RNA gain.
-			 */
-			case 0x3:
-				rx_pwr_all = -40 - (pcck_buf->cck_agc_rpt &
-					     0x3e);
-				break;
-			case 0x2:
-				rx_pwr_all = -20 - (pcck_buf->cck_agc_rpt &
-					     0x3e);
-				break;
-			case 0x1:
-				rx_pwr_all = -2 - (pcck_buf->cck_agc_rpt &
-					     0x3e);
-				break;
-			case 0x0:
-				rx_pwr_all = 14 - (pcck_buf->cck_agc_rpt &
-					     0x3e);
-				break;
-			}
-		} else {
-			report = ((u8)(le32_to_cpu(pphy_stat->phydw1) >> 8)) &
-				 0x60;
-			report >>= 5;
-			switch (report) {
-			case 0x3:
-				rx_pwr_all = -40 - ((pcck_buf->cck_agc_rpt &
-					     0x1f) << 1);
-				break;
-			case 0x2:
-				rx_pwr_all = -20 - ((pcck_buf->cck_agc_rpt &
-					     0x1f) << 1);
-				break;
-			case 0x1:
-				rx_pwr_all = -2 - ((pcck_buf->cck_agc_rpt &
-					     0x1f) << 1);
-				break;
-			case 0x0:
-				rx_pwr_all = 14 - ((pcck_buf->cck_agc_rpt &
-					     0x1f) << 1);
-				break;
-			}
+		report = pcck_buf->cck_agc_rpt & 0xc0;
+		report >>= 6;
+		switch (report) {
+		/* Modify the RF RNA gain value to -40, -20,
+		 * -2, 14 by Jenyu's suggestion
+		 * Note: different RF with the different
+		 * RNA gain.
+		 */
+		case 0x3:
+			rx_pwr_all = -40 - (pcck_buf->cck_agc_rpt &
+				     0x3e);
+			break;
+		case 0x2:
+			rx_pwr_all = -20 - (pcck_buf->cck_agc_rpt &
+				     0x3e);
+			break;
+		case 0x1:
+			rx_pwr_all = -2 - (pcck_buf->cck_agc_rpt &
+				     0x3e);
+			break;
+		case 0x0:
+			rx_pwr_all = 14 - (pcck_buf->cck_agc_rpt &
+				     0x3e);
+			break;
 		}
+
 		pwdb_all = query_rx_pwr_percentage(rx_pwr_all);
 		/* CCK gain is smaller than OFDM/MCS gain,*/
 		/* so we add gain diff by experiences, the val is 6 */
--
2.33.0

