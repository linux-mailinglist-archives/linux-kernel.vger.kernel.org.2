Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD11412F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhIUHgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhIUHgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:36:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j6so18682015pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vORvQzM1OzfPukaKkRydLG3ygbC1VXYYdqsAXpWPrgM=;
        b=knhwIXgOMcrLUXH8h8nVw6mv8w4AQzVAlPD0MYRvNeibADWBINhfOt7tEgI/0abgaD
         Snbq2iGZpHb+tJ58zT4IiCK+pw2m4hwLCzypaMCwSsz5gkQ6Mm92DhhvVwE4+DI+AwVc
         cxwOB6uMi/Qe8TeJUS6tVKy0InQNRabQobIsQqW38b7nGKvokhrclHEqsc9S/gup1nh0
         5JF3QX+1HXtGylzm3PN32XfTuYw94Y8z045ZVKYA6xNdvXrNnWyqN6BHgQakra0RPkEA
         zyfq0X8YjoC8XXX0oISBbe1fkZIt6hlaX/k/LCFu7fIgV1K5XfW55+NKz+x4n5iI3RdN
         HQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vORvQzM1OzfPukaKkRydLG3ygbC1VXYYdqsAXpWPrgM=;
        b=ouI8R9V9uCaIO9xrDI1BiFlNdlfpI3CL+9PoYuydSKs2/YJr5AHdStV5n5zRGZl2EK
         hbRn1dkdWffiOlXcMianUGCVSQcTGuQsy+HK2bHL69pU6/dHLa5wSgAkrbJ2WgGajEPm
         mNMgXvKjuOloWAuLBZ6Y6xW8gwM99jTD4WnZRVXuIyvIlRRVMo4caKChdnTPQYXZToRE
         mbu33UU9y5FXkqefm8pPLbEk4RkmasTiNNUbQFIgsN+GuRY/S0zSbz1yWSe/QMh9JLQj
         Q+OPzlDyvM2dBowqYLSesFmFjf3UuTqecS3BobG+3lJwZgutFgoIl1Q3wHrxziRybLFF
         6sgg==
X-Gm-Message-State: AOAM532CMWSJEECfsfHxbEhO/LOmZgPcdAFMp1Lw3RDL8pExYcHF5xrV
        RKNwFmBwfCxYzHVOPngCXrU=
X-Google-Smtp-Source: ABdhPJykD5AJnu+L8SyDwSxXQHB8SMk/2wEgEBUF5OI8a/efREto+RRWtKmup5i01dPjxF8vHXf74w==
X-Received: by 2002:a62:7fc2:0:b0:447:b510:6c22 with SMTP id a185-20020a627fc2000000b00447b5106c22mr9986220pfd.5.1632209676741;
        Tue, 21 Sep 2021 00:34:36 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id x8sm16565957pfq.131.2021.09.21.00.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 00:34:36 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benjamin Philip <benjamin.philip495@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: rts5208: remove unnecessary parentheses in sd.c
Date:   Tue, 21 Sep 2021 13:03:46 +0530
Message-Id: <b96aa1a0d9b306566a54d4b4643c06c520877042.1632209460.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632209460.git.benjamin.philip495@gmail.com>
References: <cover.1632209460.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes unnecessary parentheses, that have been flagged
by checkpatch.pl in sd.c

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/rts5208/sd.c | 66 ++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index 25c31496757e..71f04e317eff 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -218,9 +218,9 @@ static int sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx,
 		}
 	}
 
-	if ((rsp_type == SD_RSP_TYPE_R1) || (rsp_type == SD_RSP_TYPE_R1b)) {
-		if ((cmd_idx != SEND_RELATIVE_ADDR) &&
-		    (cmd_idx != SEND_IF_COND)) {
+	if (rsp_type == SD_RSP_TYPE_R1 || rsp_type == SD_RSP_TYPE_R1b) {
+		if (cmd_idx != SEND_RELATIVE_ADDR &&
+		    cmd_idx != SEND_IF_COND) {
 			if (cmd_idx != STOP_TRANSMISSION) {
 				if (ptr[1] & 0x80)
 					return STATUS_FAIL;
@@ -462,7 +462,7 @@ static int sd_check_csd(struct rtsx_chip *chip, char check_wp)
 	if (CHK_MMC_SECTOR_MODE(sd_card)) {
 		sd_card->capacity = 0;
 	} else {
-		if ((!CHK_SD_HCXC(sd_card)) || (csd_ver == 0)) {
+		if ((!CHK_SD_HCXC(sd_card)) || csd_ver == 0) {
 			u8 blk_size, c_size_mult;
 			u16 c_size;
 
@@ -1077,7 +1077,7 @@ static int sd_query_switch_result(struct rtsx_chip *chip, u8 func_group,
 	}
 
 	/* Check 'Busy Status' */
-	if ((buf[DATA_STRUCTURE_VER_OFFSET] == 0x01) &&
+	if (buf[DATA_STRUCTURE_VER_OFFSET] == 0x01 &&
 	    ((buf[check_busy_offset] & switch_busy) == switch_busy)) {
 		return STATUS_FAIL;
 	}
@@ -1148,7 +1148,7 @@ static int sd_check_switch_mode(struct rtsx_chip *chip, u8 mode, u8 func_group,
 
 		dev_dbg(rtsx_dev(chip), "Maximum current consumption: %dmA\n",
 			cc);
-		if ((cc == 0) || (cc > 800))
+		if (cc == 0 || cc > 800)
 			return STATUS_FAIL;
 
 		retval = sd_query_switch_result(chip, func_group,
@@ -1156,7 +1156,7 @@ static int sd_check_switch_mode(struct rtsx_chip *chip, u8 mode, u8 func_group,
 		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
 
-		if ((cc > 400) || (func_to_switch > CURRENT_LIMIT_400)) {
+		if (cc > 400 || func_to_switch > CURRENT_LIMIT_400) {
 			retval = rtsx_write_register(chip, OCPPARA2,
 						     SD_OCP_THD_MASK,
 						     chip->sd_800mA_ocp_thd);
@@ -1292,7 +1292,7 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 
 #ifdef SUPPORT_SD_LOCK
 	if ((sd_card->sd_lock_status & SD_SDR_RST) &&
-	    (func_to_switch == DDR50_SUPPORT) &&
+	    func_to_switch == DDR50_SUPPORT &&
 	    (sd_card->func_group1_mask & SDR50_SUPPORT_MASK)) {
 		func_to_switch = SDR50_SUPPORT;
 		dev_dbg(rtsx_dev(chip), "Using SDR50 instead of DDR50 for SD Lock\n");
@@ -1664,8 +1664,8 @@ static u8 sd_search_final_phase(struct rtsx_chip *chip, u32 phase_map,
 		path[idx].mid = path[idx].start + path[idx].len / 2;
 	}
 
-	if ((path[0].start == 0) &&
-	    (path[cont_path_cnt - 1].end == MAX_PHASE)) {
+	if (path[0].start == 0 &&
+	    path[cont_path_cnt - 1].end == MAX_PHASE) {
 		path[0].start = path[cont_path_cnt - 1].start - MAX_PHASE - 1;
 		path[0].len += path[cont_path_cnt - 1].len;
 		path[0].mid = path[0].start + path[0].len / 2;
@@ -1811,7 +1811,7 @@ static int sd_ddr_pre_tuning_tx(struct rtsx_chip *chip)
 		retval = sd_send_cmd_get_rsp(chip, SEND_STATUS,
 					     sd_card->sd_addr, SD_RSP_TYPE_R1,
 					     NULL, 0);
-		if ((retval == STATUS_SUCCESS) ||
+		if (retval == STATUS_SUCCESS ||
 		    !sd_check_err_code(chip, SD_RSP_TIMEOUT))
 			phase_map |= 1 << i;
 	}
@@ -2269,7 +2269,7 @@ static int sd_check_wp_state(struct rtsx_chip *chip)
 
 	sd_card_type = ((u16)buf[2] << 8) | buf[3];
 	dev_dbg(rtsx_dev(chip), "sd_card_type = 0x%04x\n", sd_card_type);
-	if ((sd_card_type == 0x0001) || (sd_card_type == 0x0002)) {
+	if (sd_card_type == 0x0001 || sd_card_type == 0x0002) {
 		/* ROM card or OTP */
 		chip->card_wp |= SD_CARD;
 	}
@@ -2361,7 +2361,7 @@ static int reset_sd(struct rtsx_chip *chip)
 	retval = sd_send_cmd_get_rsp(chip, SEND_IF_COND, 0x000001AA,
 				     SD_RSP_TYPE_R7, rsp, 5);
 	if (retval == STATUS_SUCCESS) {
-		if ((rsp[4] == 0xAA) && ((rsp[3] & 0x0f) == 0x01)) {
+		if (rsp[4] == 0xAA && ((rsp[3] & 0x0f) == 0x01)) {
 			hi_cap_flow = true;
 			voltage = SUPPORT_VOLTAGE | 0x40000000;
 		}
@@ -2713,7 +2713,7 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 	if (width == MMC_8BIT_BUS) {
 		dev_dbg(rtsx_dev(chip), "BUSTEST_R [8bits]: 0x%02x 0x%02x\n",
 			ptr[0], ptr[1]);
-		if ((ptr[0] == 0xAA) && (ptr[1] == 0x55)) {
+		if (ptr[0] == 0xAA && ptr[1] == 0x55) {
 			u8 rsp[5];
 			u32 arg;
 
@@ -2724,7 +2724,7 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 
 			retval = sd_send_cmd_get_rsp(chip, SWITCH, arg,
 						     SD_RSP_TYPE_R1b, rsp, 5);
-			if ((retval == STATUS_SUCCESS) &&
+			if (retval == STATUS_SUCCESS &&
 			    !(rsp[4] & MMC_SWITCH_ERR))
 				return SWITCH_SUCCESS;
 		}
@@ -2741,7 +2741,7 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 
 			retval = sd_send_cmd_get_rsp(chip, SWITCH, arg,
 						     SD_RSP_TYPE_R1b, rsp, 5);
-			if ((retval == STATUS_SUCCESS) &&
+			if (retval == STATUS_SUCCESS &&
 			    !(rsp[4] & MMC_SWITCH_ERR))
 				return SWITCH_SUCCESS;
 		}
@@ -2830,7 +2830,7 @@ static int mmc_switch_timing_bus(struct rtsx_chip *chip, bool switch_ddr)
 
 		retval = sd_send_cmd_get_rsp(chip, SWITCH, 0x03B90100,
 					     SD_RSP_TYPE_R1b, rsp, 5);
-		if ((retval != STATUS_SUCCESS) || (rsp[4] & MMC_SWITCH_ERR))
+		if (retval != STATUS_SUCCESS || (rsp[4] & MMC_SWITCH_ERR))
 			CLR_MMC_HS(sd_card);
 	}
 
@@ -2989,7 +2989,7 @@ static int reset_mmc(struct rtsx_chip *chip)
 			}
 		}
 
-		if (CHK_MMC_SECTOR_MODE(sd_card) && (sd_card->capacity == 0))
+		if (CHK_MMC_SECTOR_MODE(sd_card) && sd_card->capacity == 0)
 			return STATUS_FAIL;
 
 		if (switch_ddr && CHK_MMC_DDR52(sd_card)) {
@@ -3333,11 +3333,11 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 	}
 
 	if (sd_card->seq_mode &&
-	    ((sd_card->pre_dir != srb->sc_data_direction) ||
+	    (sd_card->pre_dir != srb->sc_data_direction ||
 	    ((sd_card->pre_sec_addr + sd_card->pre_sec_cnt) !=
 	    start_sector))) {
-		if ((sd_card->pre_sec_cnt < 0x80) &&
-		    (sd_card->pre_dir == DMA_FROM_DEVICE) &&
+		if (sd_card->pre_sec_cnt < 0x80 &&
+		    sd_card->pre_dir == DMA_FROM_DEVICE &&
 		    !CHK_SD30_SPEED(sd_card) &&
 		    !CHK_SD_HS(sd_card) &&
 		    !CHK_MMC_HS(sd_card)) {
@@ -3361,7 +3361,7 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 			goto RW_FAIL;
 		}
 
-		if ((sd_card->pre_sec_cnt < 0x80) &&
+		if (sd_card->pre_sec_cnt < 0x80 &&
 		    !CHK_SD30_SPEED(sd_card) &&
 		    !CHK_SD_HS(sd_card) &&
 		    !CHK_MMC_HS(sd_card)) {
@@ -3666,9 +3666,9 @@ int ext_sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx, u32 arg,
 		}
 	}
 
-	if ((cmd_idx == SELECT_CARD) || (cmd_idx == APP_CMD) ||
-	    (cmd_idx == SEND_STATUS) || (cmd_idx == STOP_TRANSMISSION)) {
-		if ((cmd_idx != STOP_TRANSMISSION) && !special_check) {
+	if (cmd_idx == SELECT_CARD || cmd_idx == APP_CMD ||
+	    cmd_idx == SEND_STATUS || cmd_idx == STOP_TRANSMISSION) {
+		if (cmd_idx != STOP_TRANSMISSION && !special_check) {
 			if (ptr[1] & 0x80)
 				return STATUS_FAIL;
 		}
@@ -3772,10 +3772,10 @@ int sd_pass_thru_mode(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		return TRANSPORT_FAILED;
 	}
 
-	if ((srb->cmnd[2] != 0x53) || (srb->cmnd[3] != 0x44) ||
-	    (srb->cmnd[4] != 0x20) || (srb->cmnd[5] != 0x43) ||
-	    (srb->cmnd[6] != 0x61) || (srb->cmnd[7] != 0x72) ||
-	    (srb->cmnd[8] != 0x64)) {
+	if (srb->cmnd[2] != 0x53 || srb->cmnd[3] != 0x44 ||
+	    srb->cmnd[4] != 0x20 || srb->cmnd[5] != 0x43 ||
+	    srb->cmnd[6] != 0x61 || srb->cmnd[7] != 0x72 ||
+	    srb->cmnd[8] != 0x64) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
 		return TRANSPORT_FAILED;
 	}
@@ -4596,10 +4596,10 @@ int sd_hw_rst(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		return TRANSPORT_FAILED;
 	}
 
-	if ((srb->cmnd[2] != 0x53) || (srb->cmnd[3] != 0x44) ||
-	    (srb->cmnd[4] != 0x20) || (srb->cmnd[5] != 0x43) ||
-	    (srb->cmnd[6] != 0x61) || (srb->cmnd[7] != 0x72) ||
-	    (srb->cmnd[8] != 0x64)) {
+	if (srb->cmnd[2] != 0x53 || srb->cmnd[3] != 0x44 ||
+	    srb->cmnd[4] != 0x20 || srb->cmnd[5] != 0x43 ||
+	    srb->cmnd[6] != 0x61 || srb->cmnd[7] != 0x72 ||
+	    srb->cmnd[8] != 0x64) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
 		return TRANSPORT_FAILED;
 	}
-- 
2.31.1

