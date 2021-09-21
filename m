Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC713412F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhIUHgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhIUHgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:36:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83359C061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso1924574pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PtAd0e3vZMl6eRWI7UPA1FAn2TCGKPHdqyRd3Ljditw=;
        b=YYuWbNyqoSxxDgk78GHQrjVUSGNR4/nmk51FX30bhQMZZrzKsxNYdhlL+dl6dMikE0
         ebX5pTGKT8tPChHwxR99NfQifB/P8RIjRHOoSbladQqCs7VuPjSH+9rxQqmhZI8IKMce
         lAvAHzQNumUOJ1NnOm+3i2ISOv1nGS9wqSu+v4Iu2y7MzsrQJnHxSO1wmHBCDHhXcscM
         LFI9UleCKAdsmxqHPI0QhjepWRZfKewbUPBFNPmhkDDuey7670dy62M1zBKRDfS8flY+
         cNtM/26Kjjs2LWcUKx6PDFe6qlpNx5xyhcWG+hfSQInoo9GP8Iu+qy5BaRKovuGWC1Gb
         iV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PtAd0e3vZMl6eRWI7UPA1FAn2TCGKPHdqyRd3Ljditw=;
        b=Ne7+Rg5s1cI05beY9AuFUmjRJkyUrM7blET9r+0+fwoEnc0vV7UVtp8mP7dCMx2N2n
         7ByGw1uSxCpRQPYsDhYiyCv755fAS6ltrS/AaeuVNE6WeUrvKJoLuEG2tCAdlfOHbmS2
         Y3EZGDKeYXMLkkPMzqW6hhtPzBf3OxOKZOmanwkMtU7cbLPwa5bmueZFKo3HwdgcmJBu
         YKxDW3CWIh058U2Sy6aT03NMwvEAOHGTmhdCFqEPNsXyeeiJ6+khvRSFakJHn0Xk3ggj
         1i07wCt1xRwn7QHepeT/R79T+1/pUcPeQIsECq1IyDBl8zpoo2SyAIGXjbrjnEGzVxxR
         T7vg==
X-Gm-Message-State: AOAM533WXYO+gO/JtGIXVOWCgUwgChfGSy/DNPRzryI2jBA+hmsOKfum
        YqsPDN2hO6LIRwW9uP8265SnkfIP0lc=
X-Google-Smtp-Source: ABdhPJwCYC9G6HHni3G7cHh+t4CNLP+7usjJso14N18Y4kGYxLhh5xAJCRfg+sA9QgkyXpb+nfUs4g==
X-Received: by 2002:a17:90a:12:: with SMTP id 18mr3762713pja.104.1632209679111;
        Tue, 21 Sep 2021 00:34:39 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id x8sm16565957pfq.131.2021.09.21.00.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 00:34:38 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benjamin Philip <benjamin.philip495@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] staging: rts5208: remove unnecessary parentheses in xd.c
Date:   Tue, 21 Sep 2021 13:03:47 +0530
Message-Id: <22907b882bac30e8062b0b044bcf61253768e930.1632209460.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632209460.git.benjamin.philip495@gmail.com>
References: <cover.1632209460.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes unnecessary parentheses, that have been flagged
by checkpatch.pl in xd.c

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/rts5208/xd.c | 48 ++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index a305e15dfb9c..42cab93982c0 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -177,7 +177,7 @@ static int xd_read_data_from_ppb(struct rtsx_chip *chip, int offset,
 {
 	int retval, i;
 
-	if (!buf || (buf_len < 0))
+	if (!buf || buf_len < 0)
 		return STATUS_FAIL;
 
 	rtsx_init_cmd(chip);
@@ -203,7 +203,7 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 	int retval;
 	u8 reg;
 
-	if (!buf || (buf_len < 10))
+	if (!buf || buf_len < 10)
 		return STATUS_FAIL;
 
 	rtsx_init_cmd(chip);
@@ -713,7 +713,7 @@ static int reset_xd(struct rtsx_chip *chip)
 		}
 
 		/* Check CIS data */
-		if ((redunt[BLOCK_STATUS] == XD_GBLK) &&
+		if (redunt[BLOCK_STATUS] == XD_GBLK &&
 		    (redunt[PARITY] & XD_BA1_ALL0)) {
 			u8 buf[10];
 
@@ -723,12 +723,12 @@ static int reset_xd(struct rtsx_chip *chip)
 			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
 
-			if ((buf[0] == 0x01) && (buf[1] == 0x03) &&
-			    (buf[2] == 0xD9) &&
-			    (buf[3] == 0x01) && (buf[4] == 0xFF) &&
-			    (buf[5] == 0x18) && (buf[6] == 0x02) &&
-			    (buf[7] == 0xDF) && (buf[8] == 0x01) &&
-			    (buf[9] == 0x20)) {
+			if (buf[0] == 0x01 && buf[1] == 0x03 &&
+			    buf[2] == 0xD9 &&
+			    buf[3] == 0x01 && buf[4] == 0xFF &&
+			    buf[5] == 0x18 && buf[6] == 0x02 &&
+			    buf[7] == 0xDF && buf[8] == 0x01 &&
+			    buf[9] == 0x20) {
 				xd_card->cis_block = (u16)i;
 			}
 		}
@@ -847,8 +847,8 @@ static void xd_set_unused_block(struct rtsx_chip *chip, u32 phy_blk)
 			return;
 	}
 
-	if ((zone->set_index >= XD_FREE_TABLE_CNT) ||
-	    (zone->set_index < 0)) {
+	if (zone->set_index >= XD_FREE_TABLE_CNT ||
+	    zone->set_index < 0) {
 		free_zone(zone);
 		dev_dbg(rtsx_dev(chip), "Set unused block fail, invalid set_index\n");
 		return;
@@ -876,13 +876,13 @@ static u32 xd_get_unused_block(struct rtsx_chip *chip, int zone_no)
 	}
 	zone = &xd_card->zone[zone_no];
 
-	if ((zone->unused_blk_cnt == 0) ||
-	    (zone->set_index == zone->get_index)) {
+	if (zone->unused_blk_cnt == 0 ||
+	    zone->set_index == zone->get_index) {
 		free_zone(zone);
 		dev_dbg(rtsx_dev(chip), "Get unused block fail, no unused block available\n");
 		return BLK_NOT_FOUND;
 	}
-	if ((zone->get_index >= XD_FREE_TABLE_CNT) || (zone->get_index < 0)) {
+	if (zone->get_index >= XD_FREE_TABLE_CNT || zone->get_index < 0) {
 		free_zone(zone);
 		dev_dbg(rtsx_dev(chip), "Get unused block fail, invalid get_index\n");
 		return BLK_NOT_FOUND;
@@ -1109,7 +1109,7 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 	if (start_page > end_page)
 		return STATUS_FAIL;
 
-	if ((old_blk == BLK_NOT_FOUND) || (new_blk == BLK_NOT_FOUND))
+	if (old_blk == BLK_NOT_FOUND || new_blk == BLK_NOT_FOUND)
 		return STATUS_FAIL;
 
 	old_page = (old_blk << xd_card->block_shift) + start_page;
@@ -1375,16 +1375,16 @@ static int xd_build_l2p_tbl(struct rtsx_chip *chip, int zone_no)
 		}
 
 		cur_fst_page_logoff = xd_load_log_block_addr(redunt);
-		if ((cur_fst_page_logoff == 0xFFFF) ||
-		    (cur_fst_page_logoff > max_logoff)) {
+		if (cur_fst_page_logoff == 0xFFFF ||
+		    cur_fst_page_logoff > max_logoff) {
 			retval = xd_erase_block(chip, i);
 			if (retval == STATUS_SUCCESS)
 				xd_set_unused_block(chip, i);
 			continue;
 		}
 
-		if ((zone_no == 0) && (cur_fst_page_logoff == 0) &&
-		    (redunt[PAGE_STATUS] != XD_GPG))
+		if (zone_no == 0 && cur_fst_page_logoff == 0 &&
+		    redunt[PAGE_STATUS] != XD_GPG)
 			XD_SET_MBR_FAIL(xd_card);
 
 		if (zone->l2p_table[cur_fst_page_logoff] == 0xFFFF) {
@@ -1874,8 +1874,8 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 	if (srb->sc_data_direction == DMA_TO_DEVICE) {
 #ifdef XD_DELAY_WRITE
 		if (delay_write->delay_write_flag &&
-		    (delay_write->logblock == log_blk) &&
-		    (start_page > delay_write->pageoff)) {
+		    delay_write->logblock == log_blk &&
+		    start_page > delay_write->pageoff) {
 			delay_write->delay_write_flag = 0;
 			if (delay_write->old_phyblock != BLK_NOT_FOUND) {
 				retval = xd_copy_page(chip,
@@ -1907,8 +1907,8 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 #endif
 			old_blk = xd_get_l2p_tbl(chip, zone_no, log_off);
 			new_blk  = xd_get_unused_block(chip, zone_no);
-			if ((old_blk == BLK_NOT_FOUND) ||
-			    (new_blk == BLK_NOT_FOUND)) {
+			if (old_blk == BLK_NOT_FOUND ||
+			    new_blk == BLK_NOT_FOUND) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
 				return STATUS_FAIL;
@@ -2034,7 +2034,7 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 		start_page = 0;
 	}
 
-	if ((srb->sc_data_direction == DMA_TO_DEVICE) &&
+	if (srb->sc_data_direction == DMA_TO_DEVICE &&
 	    (end_page != (xd_card->page_off + 1))) {
 #ifdef XD_DELAY_WRITE
 		delay_write->delay_write_flag = 1;
-- 
2.31.1

