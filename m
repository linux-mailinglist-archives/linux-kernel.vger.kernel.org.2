Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72890412F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhIUHgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhIUHgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:36:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B703C061757
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1891047pji.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TlJsAf1+7G/N1SBoPqWC+h5+yG2txJP5IpL+3P1rsSM=;
        b=D1DhBDIOmmSGRzi/t2NSRQrQ9QCfactfnRJ++l95GLll6PYCMp0D4YOLBHjRal0n4+
         +46tZ2t5hQNqP36wvns3NgeFhI2puILURcMpTXZdEF5PPt8DbSMt8StypRqc1U/aAW9L
         b7xRBMi/9B2GTGLOG5DhInruYwc06DELhaK5U0zscJQLrzL5VB1I3/UTCKMDLZT2R8qk
         FKDvz8WfCAUIlTBwE/99fIVYgVA6zz+2pPQCiOJv2o15bqOHRMfXFNsRIiR5CL9P1cmI
         9lpUr1sUmpz5yErC3wHIebGQmEUb5WeCR6p7LD5qkKa2UuaSIUJiaeNxe6EPFl7z+ztv
         g2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TlJsAf1+7G/N1SBoPqWC+h5+yG2txJP5IpL+3P1rsSM=;
        b=3V0hcm7JXW06ERXJb2BsMsJZOQaBzSLfYyLl9xD2ue6bMc+Jtn1CX//qIzx+06Lqlu
         qh+3dIjji+HZkeZzPBVFIu93QfXkURACjpECaDyxSmqFiroiPm4JS7z9gHrArr15EvWQ
         eCRDNTpmdWh/FafBllllZG2NM0WhW8VROWnGKFi2ottQu6ePsjsB239yiYaqy0U45Bzy
         LNt9vJ8sKTL92e/xWDeO5hATSOG/7fPy0GsbiiQLh09qZhuPgoJHONvL5xYwMc4EAZeK
         2QM8aNh+nrmTTvNkvlgxA4vUoiSH0n1i0imDcJPrw9LOPAi/w+1jmr1XjbsXWiMFKJF2
         HjyQ==
X-Gm-Message-State: AOAM530UD6KFInKrs0tKrjJR6dcrRDe+OACcXgwUeYn3SObsOTmd5JEy
        2wTiyw1cLajk6ynMRDVhBQ4=
X-Google-Smtp-Source: ABdhPJxd8sJdUI3XDgCAK4rHzqgqDTTcfn8LiXnqIzmuI1BhOPWGgBh780AzbJg2FgV10b1kRDbcvw==
X-Received: by 2002:a17:90a:f2cd:: with SMTP id gt13mr3696364pjb.153.1632209671814;
        Tue, 21 Sep 2021 00:34:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id x8sm16565957pfq.131.2021.09.21.00.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 00:34:31 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benjamin Philip <benjamin.philip495@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: rts5208: remove unnecessary parentheses in rtsx_chip.c
Date:   Tue, 21 Sep 2021 13:03:44 +0530
Message-Id: <4395499086a3188ea4c4d190460967990bd7a670.1632209460.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632209460.git.benjamin.philip495@gmail.com>
References: <cover.1632209460.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes unnecessary parentheses, that have been flagged
by checkpatch.pl in rtsx_chip.c
Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/rts5208/rtsx_chip.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_chip.c b/drivers/staging/rts5208/rtsx_chip.c
index ee9ddc4eb94d..6375032918d4 100644
--- a/drivers/staging/rts5208/rtsx_chip.c
+++ b/drivers/staging/rts5208/rtsx_chip.c
@@ -325,7 +325,7 @@ static int rtsx_enable_pcie_intr(struct rtsx_chip *chip)
 			return STATUS_FAIL;
 	}
 
-	if (chip->driver_first_load && (chip->ic_version < IC_VER_C))
+	if (chip->driver_first_load && chip->ic_version < IC_VER_C)
 		rtsx_calibration(chip);
 
 	return STATUS_SUCCESS;
@@ -496,7 +496,7 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 		chip->int_reg);
 	if (chip->int_reg & SD_EXIST) {
 #ifdef HW_AUTO_SWITCH_SD_BUS
-		if (CHECK_PID(chip, 0x5208) && (chip->ic_version < IC_VER_C))
+		if (CHECK_PID(chip, 0x5208) && chip->ic_version < IC_VER_C)
 			retval = rtsx_pre_handle_sdio_old(chip);
 		else
 			retval = rtsx_pre_handle_sdio_new(chip);
@@ -563,7 +563,7 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 			return retval;
 	}
 
-	if (CHECK_PID(chip, 0x5208) && (chip->ic_version >= IC_VER_D)) {
+	if (CHECK_PID(chip, 0x5208) && chip->ic_version >= IC_VER_D) {
 		retval = rtsx_write_register(chip, PETXCFG, 0x1C, 0x14);
 		if (retval)
 			return retval;
@@ -606,7 +606,7 @@ static inline int valid_sd_speed_prior(u32 sd_speed_prior)
 	for (i = 0; i < 4; i++) {
 		u8 tmp = (u8)(sd_speed_prior >> (i * 8));
 
-		if ((tmp < 0x01) || (tmp > 0x04)) {
+		if (tmp < 0x01 || tmp > 0x04) {
 			valid_para = false;
 			break;
 		}
@@ -808,10 +808,10 @@ int rtsx_init_chip(struct rtsx_chip *chip)
 	dev_dbg(rtsx_dev(chip), "sd_current_prior = 0x%08x\n",
 		chip->sd_current_prior);
 
-	if ((chip->sd_ddr_tx_phase > 31) || (chip->sd_ddr_tx_phase < 0))
+	if (chip->sd_ddr_tx_phase > 31 || chip->sd_ddr_tx_phase < 0)
 		chip->sd_ddr_tx_phase = 0;
 
-	if ((chip->mmc_ddr_tx_phase > 31) || (chip->mmc_ddr_tx_phase < 0))
+	if (chip->mmc_ddr_tx_phase > 31 || chip->mmc_ddr_tx_phase < 0)
 		chip->mmc_ddr_tx_phase = 0;
 
 	retval = rtsx_write_register(chip, FPDCTL, SSC_POWER_DOWN, 0);
@@ -1840,7 +1840,7 @@ int rtsx_pre_handle_interrupt(struct rtsx_chip *chip)
 	chip->int_reg = rtsx_readl(chip, RTSX_BIPR);
 
 	if (((chip->int_reg & int_enable) == 0) ||
-	    (chip->int_reg == 0xFFFFFFFF))
+	    chip->int_reg == 0xFFFFFFFF)
 		return STATUS_FAIL;
 
 	status = chip->int_reg &= (int_enable | 0x7FFFFF);
@@ -1939,7 +1939,7 @@ void rtsx_do_before_power_down(struct rtsx_chip *chip, int pm_stat)
 	}
 #endif
 
-	if (CHECK_PID(chip, 0x5208) && (chip->ic_version >= IC_VER_D)) {
+	if (CHECK_PID(chip, 0x5208) && chip->ic_version >= IC_VER_D) {
 		/* u_force_clkreq_0 */
 		rtsx_write_register(chip, PETXCFG, 0x08, 0x08);
 	}
-- 
2.31.1

