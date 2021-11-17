Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3E1454900
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbhKQOm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbhKQOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:42:56 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF200C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:39:57 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id q14so2760699qtx.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7h7Lt/b8pjCkn+yNnqb7aBRnrGz1ydzrcNdi9m9JZ9M=;
        b=EUfs91+TNjJC5+7SR897mnLqjCs6X82LRkBRwPdjJHUY03ab8zGgpqAdHRDn+YIYBl
         nhqfuuKSj1qoa+iy1Caio/1CQJO1TtqeBtmfkEMigPR5QDm0UYw+lVzFX8EaRfBREqqM
         f67fW4tZ+ePmH/vevcpuGU1p94287ZT1RzjCmj+1K4+s1IiChEEwJaRLV8tZcFFJitEr
         2FbjEYfEKwy8N3Lw9fzWNaF4ka+4U3rZjrgsoNY4s8utdWkAWCDsNb9O1nBa3SdYFCfP
         Hf4BTNjgrT/kUZqX2QmqFkT3fwcgHVyc5o4RkMCEWXi3Y4+Ri9zxeMewgZPNPyZcpNcS
         9ICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7h7Lt/b8pjCkn+yNnqb7aBRnrGz1ydzrcNdi9m9JZ9M=;
        b=Xjlfl5m2NRrXLl6WZNVuKhf1e6wZpaGmgdF5Xi/fTZU7Be3SQNYy+DeX+1/EptuwxB
         GdSTgkP6z4DZ/MLWDHc3N6wbmtbaJNR3PW9Up82ZfkqaFlqd02nrV2U8bizKNjV144rv
         p66m1zToyynjMJj8CSvg3KuQf4LENsYMJPG302Q+D+a25INPVYc+gDC1qgdL3tCBI627
         ehK0dnX7/HQLRVU56ONmFmxGCtAm3pE7lVeEiUO++fxTWIB7kHdhLNUXNapStBvBLN4S
         g0X8Plfh7Bu5OjMvSVV90sFQvGtdBtrDqgYZfLSFrWpdPuWgr3kTu6U/1TTUeIkdh+wn
         Jwnw==
X-Gm-Message-State: AOAM532Zxk5/hXsTN5sRn3MxVzPsnQPmxRc8/giKXfGEQDWNipeEMFyp
        IcupCvod2/prmWeGPRon7aur4WWS/+p8fQ==
X-Google-Smtp-Source: ABdhPJyilmlMEPQ5hm2huOVKkoFwy4VZwD1b3VckdepObuDsNgY57prcjlveDpQzdcdS3Lk/IJETrQ==
X-Received: by 2002:ac8:5a0b:: with SMTP id n11mr17649089qta.372.1637159996913;
        Wed, 17 Nov 2021 06:39:56 -0800 (PST)
Received: from localhost.localdomain (pool-98-113-42-30.nycmny.fios.verizon.net. [98.113.42.30])
        by smtp.googlemail.com with ESMTPSA id c3sm10788698qkp.47.2021.11.17.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:39:56 -0800 (PST)
From:   Zameer Manji <zmanji@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Zameer Manji <zmanji@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove unused code in rtw_cmd.h
Date:   Wed, 17 Nov 2021 14:38:14 +0000
Message-Id: <20211117143831.1511437-1-zmanji@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unused code in rtw_cmd.h.

Signed-off-by: Zameer Manji <zmanji@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_cmd.h | 196 ----------------------
 1 file changed, 196 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 47c3c80cc24a..14e8a4c03449 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -8,13 +8,9 @@
 #include "rtw_rf.h"
 #include "rtw_led.h"
 
-#define C2H_MEM_SZ (16*1024)
-
 #include "osdep_service.h"
 #include "ieee80211.h" /*  <ieee80211/ieee80211.h> */
 
-#define FREE_CMDOBJ_SZ	128
-
 #define MAX_CMDSZ	1024
 #define MAX_RSPSZ	512
 #define MAX_EVTSZ	1024
@@ -425,37 +421,6 @@ struct	getphy_rsp {
 	u8	modem;
 };
 
-struct readBB_parm {
-	u8	offset;
-};
-struct readBB_rsp {
-	u8	value;
-};
-
-struct readTSSI_parm {
-	u8	offset;
-};
-struct readTSSI_rsp {
-	u8	value;
-};
-
-struct writeBB_parm {
-	u8	offset;
-	u8	value;
-};
-
-struct readRF_parm {
-	u8	offset;
-};
-struct readRF_rsp {
-	u32	value;
-};
-
-struct writeRF_parm {
-	u32	offset;
-	u32	value;
-};
-
 struct getrfintfs_parm {
 	u8	rfintfs;
 };
@@ -523,167 +488,6 @@ struct drvextra_cmd_parm {
 	unsigned char *pbuf;
 };
 
-/*------------------- Below are used for RF/BB tunning ---------------------*/
-
-struct	setantenna_parm {
-	u8	tx_antset;
-	u8	rx_antset;
-	u8	tx_antenna;
-	u8	rx_antenna;
-};
-
-struct	enrateadaptive_parm {
-	u32	en;
-};
-
-struct settxagctbl_parm {
-	u32	txagc[MAX_RATES_LENGTH];
-};
-
-struct gettxagctbl_parm {
-	u32 rsvd;
-};
-struct gettxagctbl_rsp {
-	u32	txagc[MAX_RATES_LENGTH];
-};
-
-struct setagcctrl_parm {
-	u32	agcctrl;		/*  0: pure hw, 1: fw */
-};
-
-struct setssup_parm	{
-	u32	ss_ForceUp[MAX_RATES_LENGTH];
-};
-
-struct getssup_parm	{
-	u32 rsvd;
-};
-
-struct getssup_rsp	{
-	u8	ss_ForceUp[MAX_RATES_LENGTH];
-};
-
-struct setssdlevel_parm	{
-	u8	ss_DLevel[MAX_RATES_LENGTH];
-};
-
-struct getssdlevel_parm	{
-	u32 rsvd;
-};
-
-struct getssdlevel_rsp	{
-	u8	ss_DLevel[MAX_RATES_LENGTH];
-};
-
-struct setssulevel_parm	{
-	u8	ss_ULevel[MAX_RATES_LENGTH];
-};
-
-struct getssulevel_parm	{
-	u32 rsvd;
-};
-
-struct getssulevel_rsp	{
-	u8	ss_ULevel[MAX_RATES_LENGTH];
-};
-
-struct	setcountjudge_parm {
-	u8	count_judge[MAX_RATES_LENGTH];
-};
-
-struct	getcountjudge_parm {
-	u32 rsvd;
-};
-
-struct	getcountjudge_rsp {
-	u8	count_judge[MAX_RATES_LENGTH];
-};
-
-struct setratable_parm {
-	u8 ss_ForceUp[NumRates];
-	u8 ss_ULevel[NumRates];
-	u8 ss_DLevel[NumRates];
-	u8 count_judge[NumRates];
-};
-
-struct getratable_parm {
-                uint rsvd;
-};
-
-struct getratable_rsp {
-        u8 ss_ForceUp[NumRates];
-        u8 ss_ULevel[NumRates];
-        u8 ss_DLevel[NumRates];
-        u8 count_judge[NumRates];
-};
-
-/* to get TX,RX retry count */
-
-struct gettxretrycnt_parm {
-	unsigned int rsvd;
-};
-
-struct gettxretrycnt_rsp {
-	unsigned long tx_retrycnt;
-};
-
-struct getrxretrycnt_parm {
-	unsigned int rsvd;
-};
-
-struct getrxretrycnt_rsp {
-	unsigned long rx_retrycnt;
-};
-
-/* to get BCNOK,BCNERR count */
-struct getbcnokcnt_parm {
-	unsigned int rsvd;
-};
-
-struct getbcnokcnt_rsp {
-	unsigned long  bcnokcnt;
-};
-
-struct getbcnerrcnt_parm {
-	unsigned int rsvd;
-};
-
-struct getbcnerrcnt_rsp {
-	unsigned long bcnerrcnt;
-};
-
-/*  to get current TX power level */
-struct getcurtxpwrlevel_parm {
-	unsigned int rsvd;
-};
-struct getcurtxpwrlevel_rspi {
-	unsigned short tx_power;
-};
-
-struct setprobereqextraie_parm {
-	unsigned char e_id;
-	unsigned char ie_len;
-	unsigned char ie[0];
-};
-
-struct setassocreqextraie_parm {
-	unsigned char e_id;
-	unsigned char ie_len;
-	unsigned char ie[0];
-};
-
-struct setproberspextraie_parm {
-	unsigned char e_id;
-	unsigned char ie_len;
-	unsigned char ie[0];
-};
-
-struct setassocrspextraie_parm {
-	unsigned char e_id;
-	unsigned char ie_len;
-	unsigned char ie[0];
-};
-
 struct addBaReq_parm {
 	unsigned int tid;
 	u8	addr[ETH_ALEN];
-- 
2.25.1

