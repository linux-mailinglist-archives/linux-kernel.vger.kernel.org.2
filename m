Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A936440F1F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 16:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhJaP1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 11:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhJaP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 11:27:10 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB7C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 08:24:39 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t7so14878722pgl.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=21pEljWHVkJKFCf2QnU/C0q5jsw1Tl8OTDRkLuhbugA=;
        b=pU0ZsPveSrl+pcbTIyJNbIHeSKtk214VUCSu1lEsHwfTBbMHrCPd3pSmjIEAJPUmEI
         I8F9DjkteHmk6M+KqJZP2zToRv7Rbh9RTlMoHl+sud/aVrP+QUHxTBtgRgwqcqVXKFJ6
         91cgBao1ZFYB/1Fd8IN+PYB5QRnuc5hMd+S6MhxkTLLyEpEte8xL/BBHiPtVBtw7pHhv
         FPpY67wO3kRvxfaZX7xQOH3tvmNrCEDX1LhQnaPOJod4hdrIgdI2wASg43C44/lZOtn7
         eEhyRvnWvAOvh1hIA+p1Y6CY6lPblIr5x/uXopqKTRibRi7gYJtvS30y8V6byZNMPreq
         em8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=21pEljWHVkJKFCf2QnU/C0q5jsw1Tl8OTDRkLuhbugA=;
        b=jXc12uOXguhY3JFLeLMPt8kB2SFDffEYbfJhKjFAswLrLRj05iWraPQC8REJ0lp+Hl
         vJY33oJJH3rwdCBkbNhA9ebqSwxddkAkQp5hKpFzX27S9KKa5Cuv4Wz/typcRiZoEbHI
         AcazVJud4U8dnrpvasf/0pXWeW5fWqC8igUKOs32gkyVscvLOOcZsVZIUgibCqA0xuHn
         1YNzlwSCIiaVmQZ8Nj4xdij4ivEnDvyqFnnnYTEEsaHSG8k3KCP0ZFV82S491DeMCRKA
         rbEYqheQdd9imC3LSgKrxeO6Nz/A4YhVXwyf6jJ87SM9r0zA25+H4HPAZboKs6tUrIjk
         pJvQ==
X-Gm-Message-State: AOAM530reBvAAmJDth8G0bGdCjkCQKKqXCVmRtFLV29AIAWVudYBFi9T
        4UtuE/CXgpBOfCpuhBjwgy4=
X-Google-Smtp-Source: ABdhPJy3SS3NjhCHPtulhPbXWITJ63JG2kp8jq2M2LW4ZCTLUbnPWbbCQY/vJuHucWJVtfH7NPqHqw==
X-Received: by 2002:a63:7c4f:: with SMTP id l15mr17775547pgn.19.1635693878488;
        Sun, 31 Oct 2021 08:24:38 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.84.6])
        by smtp.gmail.com with ESMTPSA id 11sm12334597pfl.41.2021.10.31.08.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 08:24:36 -0700 (PDT)
Date:   Sun, 31 Oct 2021 20:54:26 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, saurav.girepunje@gmail.com,
        alec@vc-celle.de, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH v2] staging: rtl8712: remove the condition with no effect
Message-ID: <YX61KpxdmCQtoFSX@Sauravs-MacBook-Air.local>
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

After removing the if condition, There is no use of local variable
cck_highpwr. Remove the local variable cck_highpwr. Merge the two lines
as length of lines together is coming within limit of 80 columns. As
per Linux kernel coding style.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---

Changelog V2:

	Merge the two lines as length of lines together is coming within
	limit of 80 columns. As per Linux kernel coding style.

Changelog V1:

	Remove the if condition check and else code section in
	query_rx_phy_status(). As variable cck_highpwr is assign a value of '0'
	after this assignment, if condition check !cck_highpwr is always
	going to be true. So remove the if condition check as well as else
	section which will be never true.

	After removing the if condition there is no use of local variable
	cck_highpwr. Remove the local variable cck_highpwr.

 drivers/staging/rtl8712/rtl8712_recv.c | 71 ++++++++------------------
 1 file changed, 22 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 0ffb30f1af7e..1c00905b4799 100644
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

@@ -723,55 +723,28 @@ static void query_rx_phy_status(struct _adapter *padapter,
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
+			rx_pwr_all = -40 - (pcck_buf->cck_agc_rpt & 0x3e);
+			break;
+		case 0x2:
+			rx_pwr_all = -20 - (pcck_buf->cck_agc_rpt & 0x3e);
+			break;
+		case 0x1:
+			rx_pwr_all = -2 - (pcck_buf->cck_agc_rpt & 0x3e);
+			break;
+		case 0x0:
+			rx_pwr_all = 14 - (pcck_buf->cck_agc_rpt & 0x3e);
+			break;
 		}
+
 		pwdb_all = query_rx_pwr_percentage(rx_pwr_all);
 		/* CCK gain is smaller than OFDM/MCS gain,*/
 		/* so we add gain diff by experiences, the val is 6 */
--
2.33.0

