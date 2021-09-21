Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BA9412F90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhIUHgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhIUHgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:36:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FC8C061766
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:42 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g14so18716420pfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STxj2yyUqd5MfmrG+d4mKeV9MKV29F7Q4a7QuIwYtEk=;
        b=LlSZPouMNfyCFdybyb12Hu9leiSX+zn3bneWWSQE7NtBQ6onl8jFsrEKiI04f9eFUp
         lX5G1RqDFAM2z2J5Yjw1vfprpAdsaFz/yCKJ8YKy7eDnHoupeWjiYDzHlS+aIunMQO7C
         CUhcYfIhkXnHJKuJ1VW1uEDIqGKjLz1zFJ+IGVuevvZEqFaSpsiqjBIN+S0sU7RRImu3
         R4mXHuphE1q+7dBC/QbwMC72+9XsGxjh8jdimejFd/+UVI05SK/n1SU+qf212vVzapyN
         +fFTpeAKD+MebY+lD2b+N4Q/4K21WCm/SupcA7GsdZNg6F3kdgu+jYDuI05lW+CCS3HW
         YLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STxj2yyUqd5MfmrG+d4mKeV9MKV29F7Q4a7QuIwYtEk=;
        b=gi4gqH67lH5Z1AFMqFWX5xoiqOTGG/DCQKOze3zgIVuVmtrnhmva2sSmPGxKX3XHIS
         kRq1CN8tEAdRdA53T4AAPjpp3W9eL5znOOhOd0Txs3benV9x8PHzZmTj8NSJnx06G4gO
         DDPdbafp+JhJ199rwzQI20nAsjWrBneRe5ciJOl6pNQfMxnPN93UiFxR7OdGmdYQojXq
         2GColkDbTbhHfEGIPNq4vTZlGNPd+Xkh1bJD0xCpaivZoIL5Zb13UieBwckjEiivYXiD
         VmYg7W2KrDX/rzazDXs7NrQcWhduOq10bXSde+qXimi0sEdrFvvabMRs/CWeXFvIC7wn
         e1FA==
X-Gm-Message-State: AOAM531WhCgagKubyCyf2c9oMJd5htDMZPs3SpHiRWv2CjvyapqNcjyn
        l8d3ZpWsaCvorIejP58x4ec=
X-Google-Smtp-Source: ABdhPJzWOIyeIpN8W10gtM5ZrIDs/cHVR5T2J25QcFABERRXtxslhwE8sCxyGQtMYGOLiNH5ASabGQ==
X-Received: by 2002:a63:4344:: with SMTP id q65mr26923525pga.364.1632209681690;
        Tue, 21 Sep 2021 00:34:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id x8sm16565957pfq.131.2021.09.21.00.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 00:34:41 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benjamin Philip <benjamin.philip495@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] staging: rts5208: remove unnecessary parentheses in rtsx_scsi.c
Date:   Tue, 21 Sep 2021 13:03:48 +0530
Message-Id: <2d2e57eb448239d3b0105fcda2852137eaee4f5d.1632209460.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632209460.git.benjamin.philip495@gmail.com>
References: <cover.1632209460.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes unnecessary parentheses, that have been flagged
by checkpatch.pl in rtsx_scsi.c.

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/rts5208/rtsx_scsi.c | 106 ++++++++++++++--------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
index 11d9d9155eef..08bd768ad34d 100644
--- a/drivers/staging/rts5208/rtsx_scsi.c
+++ b/drivers/staging/rts5208/rtsx_scsi.c
@@ -500,12 +500,12 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		return TRANSPORT_ERROR;
 
 #ifdef SUPPORT_MAGIC_GATE
-	if ((chip->mspro_formatter_enable) &&
+	if (chip->mspro_formatter_enable &&
 	    (chip->lun2card[lun] & MS_CARD))
 #else
 	if (chip->mspro_formatter_enable)
 #endif
-		if (!card || (card == MS_CARD))
+		if (!card || card == MS_CARD)
 			pro_formatter_flag = true;
 
 	if (pro_formatter_flag) {
@@ -754,7 +754,7 @@ static int mode_sense(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	data_size = 8;
 #ifdef SUPPORT_MAGIC_GATE
 	if ((chip->lun2card[lun] & MS_CARD)) {
-		if (!card || (card == MS_CARD)) {
+		if (!card || card == MS_CARD) {
 			data_size = 108;
 			if (chip->mspro_formatter_enable)
 				pro_formatter_flag = true;
@@ -775,11 +775,11 @@ static int mode_sense(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	page_code = srb->cmnd[2] & 0x3f;
 
-	if ((page_code == 0x3F) || (page_code == 0x1C) ||
-	    (page_code == 0x00) ||
-		(pro_formatter_flag && (page_code == 0x20))) {
+	if (page_code == 0x3F || page_code == 0x1C ||
+	    page_code == 0x00 ||
+		(pro_formatter_flag && page_code == 0x20)) {
 		if (srb->cmnd[0] == MODE_SENSE) {
-			if ((page_code == 0x3F) || (page_code == 0x20)) {
+			if (page_code == 0x3F || page_code == 0x20) {
 				ms_mode_sense(chip, srb->cmnd[0],
 					      lun, buf, data_size);
 			} else {
@@ -794,7 +794,7 @@ static int mode_sense(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				buf[3] = 0x00;
 			}
 		} else {
-			if ((page_code == 0x3F) || (page_code == 0x20)) {
+			if (page_code == 0x3F || page_code == 0x20) {
 				ms_mode_sense(chip, srb->cmnd[0],
 					      lun, buf, data_size);
 			} else {
@@ -879,7 +879,7 @@ static int read_write(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 #endif
 
-	if ((srb->cmnd[0] == READ_10) || (srb->cmnd[0] == WRITE_10)) {
+	if (srb->cmnd[0] == READ_10 || srb->cmnd[0] == WRITE_10) {
 		start_sec = ((u32)srb->cmnd[2] << 24) |
 			((u32)srb->cmnd[3] << 16) |
 			((u32)srb->cmnd[4] << 8) | ((u32)srb->cmnd[5]);
@@ -906,7 +906,7 @@ static int read_write(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	 * In this situation, start_sec + sec_cnt will overflow, so we
 	 * need to judge start_sec at first
 	 */
-	if ((start_sec > get_card_size(chip, lun)) ||
+	if (start_sec > get_card_size(chip, lun) ||
 	    ((start_sec + sec_cnt) > get_card_size(chip, lun))) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LBA_OVER_RANGE);
 		return TRANSPORT_FAILED;
@@ -993,9 +993,9 @@ static int read_format_capacity(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	buf[i++] = 0;
 
 	/* Capacity List Length */
-	if ((buf_len > 12) && chip->mspro_formatter_enable &&
+	if (buf_len > 12 && chip->mspro_formatter_enable &&
 	    (chip->lun2card[lun] & MS_CARD) &&
-	    (!card || (card == MS_CARD))) {
+	    (!card || card == MS_CARD)) {
 		buf[i++] = 0x10;
 		desc_cnt = 2;
 	} else {
@@ -1569,7 +1569,7 @@ static int get_dev_status(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 #ifdef SUPPORT_OCP
 	status[8] = 0;
 	if (CHECK_LUN_MODE(chip, SD_MS_2LUN) &&
-	    (chip->lun2card[lun] == MS_CARD)) {
+	    chip->lun2card[lun] == MS_CARD) {
 		oc_now_mask = MS_OC_NOW;
 		oc_ever_mask = MS_OC_EVER;
 	} else {
@@ -2544,7 +2544,7 @@ static int get_card_bus_width(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	card = get_lun_card(chip, lun);
-	if ((card == SD_CARD) || (card == MS_CARD)) {
+	if (card == SD_CARD || card == MS_CARD) {
 		bus_width = chip->card_bus_width[lun];
 	} else {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
@@ -2685,7 +2685,7 @@ void led_shine(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	unsigned int lun = SCSI_LUN(srb);
 	u16 sec_cnt;
 
-	if ((srb->cmnd[0] == READ_10) || (srb->cmnd[0] == WRITE_10)) {
+	if (srb->cmnd[0] == READ_10 || srb->cmnd[0] == WRITE_10) {
 		sec_cnt = ((u16)(srb->cmnd[7]) << 8) | srb->cmnd[8];
 	} else if ((srb->cmnd[0] == READ_6) || (srb->cmnd[0] == WRITE_6)) {
 		sec_cnt = srb->cmnd[4];
@@ -2716,9 +2716,9 @@ static int ms_format_cmnd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		return TRANSPORT_FAILED;
 	}
 
-	if ((srb->cmnd[3] != 0x4D) || (srb->cmnd[4] != 0x47) ||
-	    (srb->cmnd[5] != 0x66) || (srb->cmnd[6] != 0x6D) ||
-		(srb->cmnd[7] != 0x74)) {
+	if (srb->cmnd[3] != 0x4D || srb->cmnd[4] != 0x47 ||
+	    srb->cmnd[5] != 0x66 || srb->cmnd[6] != 0x6D ||
+		srb->cmnd[7] != 0x74) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
 		return TRANSPORT_FAILED;
 	}
@@ -2786,16 +2786,16 @@ static int get_ms_information(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		return TRANSPORT_FAILED;
 	}
 
-	if ((srb->cmnd[2] != 0xB0) || (srb->cmnd[4] != 0x4D) ||
-	    (srb->cmnd[5] != 0x53) || (srb->cmnd[6] != 0x49) ||
-	    (srb->cmnd[7] != 0x44)) {
+	if (srb->cmnd[2] != 0xB0 || srb->cmnd[4] != 0x4D ||
+	    srb->cmnd[5] != 0x53 || srb->cmnd[6] != 0x49 ||
+	    srb->cmnd[7] != 0x44) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
 		return TRANSPORT_FAILED;
 	}
 
 	dev_info_id = srb->cmnd[3];
-	if ((CHK_MSXC(ms_card) && (dev_info_id == 0x10)) ||
-	    (!CHK_MSXC(ms_card) && (dev_info_id == 0x13)) ||
+	if ((CHK_MSXC(ms_card) && dev_info_id == 0x10) ||
+	    (!CHK_MSXC(ms_card) && dev_info_id == 0x13) ||
 	    !CHK_MSPRO(ms_card)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
 		return TRANSPORT_FAILED;
@@ -2846,7 +2846,7 @@ static int get_ms_information(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	buf[i++] = data_len;		/* Data length LSB */
 	/* Valid Bit */
 	buf[i++] = 0x80;
-	if ((dev_info_id == 0x10) || (dev_info_id == 0x13)) {
+	if (dev_info_id == 0x10 || dev_info_id == 0x13) {
 		/* System Information */
 		memcpy(buf + i, ms_card->raw_sys_info, 96);
 	} else {
@@ -2978,8 +2978,8 @@ static int mg_report_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	switch (key_format) {
 	case KF_GET_LOC_EKB:
 		if ((scsi_bufflen(srb) == 0x41C) &&
-		    (srb->cmnd[8] == 0x04) &&
-		    (srb->cmnd[9] == 0x1C)) {
+		    srb->cmnd[8] == 0x04 &&
+		    srb->cmnd[9] == 0x1C) {
 			retval = mg_get_local_EKB(srb, chip);
 			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
@@ -2993,8 +2993,8 @@ static int mg_report_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	case KF_RSP_CHG:
 		if ((scsi_bufflen(srb) == 0x24) &&
-		    (srb->cmnd[8] == 0x00) &&
-		    (srb->cmnd[9] == 0x24)) {
+		    srb->cmnd[8] == 0x00 &&
+		    srb->cmnd[9] == 0x24) {
 			retval = mg_get_rsp_chg(srb, chip);
 			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
@@ -3009,12 +3009,12 @@ static int mg_report_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	case KF_GET_ICV:
 		ms_card->mg_entry_num = srb->cmnd[5];
 		if ((scsi_bufflen(srb) == 0x404) &&
-		    (srb->cmnd[8] == 0x04) &&
-		    (srb->cmnd[9] == 0x04) &&
-		    (srb->cmnd[2] == 0x00) &&
-		    (srb->cmnd[3] == 0x00) &&
-		    (srb->cmnd[4] == 0x00) &&
-		    (srb->cmnd[5] < 32)) {
+		    srb->cmnd[8] == 0x04 &&
+		    srb->cmnd[9] == 0x04 &&
+		    srb->cmnd[2] == 0x00 &&
+		    srb->cmnd[3] == 0x00 &&
+		    srb->cmnd[4] == 0x00 &&
+		    srb->cmnd[5] < 32) {
 			retval = mg_get_ICV(srb, chip);
 			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
@@ -3081,8 +3081,8 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	switch (key_format) {
 	case KF_SET_LEAF_ID:
 		if ((scsi_bufflen(srb) == 0x0C) &&
-		    (srb->cmnd[8] == 0x00) &&
-		    (srb->cmnd[9] == 0x0C)) {
+		    srb->cmnd[8] == 0x00 &&
+		    srb->cmnd[9] == 0x0C) {
 			retval = mg_set_leaf_id(srb, chip);
 			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
@@ -3096,8 +3096,8 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	case KF_CHG_HOST:
 		if ((scsi_bufflen(srb) == 0x0C) &&
-		    (srb->cmnd[8] == 0x00) &&
-		    (srb->cmnd[9] == 0x0C)) {
+		    srb->cmnd[8] == 0x00 &&
+		    srb->cmnd[9] == 0x0C) {
 			retval = mg_chg(srb, chip);
 			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
@@ -3111,8 +3111,8 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	case KF_RSP_HOST:
 		if ((scsi_bufflen(srb) == 0x0C) &&
-		    (srb->cmnd[8] == 0x00) &&
-		    (srb->cmnd[9] == 0x0C)) {
+		    srb->cmnd[8] == 0x00 &&
+		    srb->cmnd[9] == 0x0C) {
 			retval = mg_rsp(srb, chip);
 			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
@@ -3127,12 +3127,12 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	case KF_SET_ICV:
 		ms_card->mg_entry_num = srb->cmnd[5];
 		if ((scsi_bufflen(srb) == 0x404) &&
-		    (srb->cmnd[8] == 0x04) &&
-		    (srb->cmnd[9] == 0x04) &&
-		    (srb->cmnd[2] == 0x00) &&
-		    (srb->cmnd[3] == 0x00) &&
-		    (srb->cmnd[4] == 0x00) &&
-		    (srb->cmnd[5] < 32)) {
+		    srb->cmnd[8] == 0x04 &&
+		    srb->cmnd[9] == 0x04 &&
+		    srb->cmnd[2] == 0x00 &&
+		    srb->cmnd[3] == 0x00 &&
+		    srb->cmnd[4] == 0x00 &&
+		    srb->cmnd[5] < 32) {
 			retval = mg_set_ICV(srb, chip);
 			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
@@ -3168,10 +3168,10 @@ int rtsx_scsi_handler(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		/* Block all SCSI command except for
 		 * REQUEST_SENSE and rs_ppstatus
 		 */
-		if (!((srb->cmnd[0] == VENDOR_CMND) &&
-		      (srb->cmnd[1] == SCSI_APP_CMD) &&
-		      (srb->cmnd[2] == GET_DEV_STATUS)) &&
-		      (srb->cmnd[0] != REQUEST_SENSE)) {
+		if (!(srb->cmnd[0] == VENDOR_CMND &&
+		      srb->cmnd[1] == SCSI_APP_CMD &&
+		      srb->cmnd[2] == GET_DEV_STATUS) &&
+			srb->cmnd[0] != REQUEST_SENSE) {
 			/* Logical Unit Not Ready Format in Progress */
 			set_sense_data(chip, lun, CUR_ERR,
 				       0x02, 0, 0x04, 0x04, 0, 0);
@@ -3181,9 +3181,9 @@ int rtsx_scsi_handler(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 #endif
 
 	if ((get_lun_card(chip, lun) == MS_CARD) &&
-	    (ms_card->format_status == FORMAT_IN_PROGRESS)) {
-		if ((srb->cmnd[0] != REQUEST_SENSE) &&
-		    (srb->cmnd[0] != INQUIRY)) {
+	    ms_card->format_status == FORMAT_IN_PROGRESS) {
+		if (srb->cmnd[0] != REQUEST_SENSE &&
+		    srb->cmnd[0] != INQUIRY) {
 			/* Logical Unit Not Ready Format in Progress */
 			set_sense_data(chip, lun, CUR_ERR, 0x02, 0, 0x04, 0x04,
 				       0, (u16)(ms_card->progress));
-- 
2.31.1

