Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D684A3DB5AA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbhG3JKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbhG3JKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:10:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6826C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:10:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qk33so15513269ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmSFntXo42F64KXJ5DYrzhICbIK4OEVcdEWb/uS+d1I=;
        b=sImjCvaVAqeQqkjOk0qRpgJ3XGblIkc2rrDmcnpXIY4UUeDmU1OBjj5oSqg1HW7ms0
         pYzaPsKdrkEdoMEr5jvo95pLaXsaJI1gJCyB9kIFrJMeMgARERC8V1yBfRe7TapZlxkp
         KCC05oPtC7/tmG8E9NmOvH5doGRRPKXvtrEPl/r21WQZozPjPS3eGmZz2+ySUfl291rb
         96acB2QBuUhRf1wSHFkWxBnk4t1tlMqavrH8rpTAPwhEXwraEjU74udbld/wkUe2EpVP
         6siMpljg41YHo8GEFNocAjLold7lLorcNBzBg8YGA00IAte8/5byNdeGUEjwylEG4Rho
         QKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmSFntXo42F64KXJ5DYrzhICbIK4OEVcdEWb/uS+d1I=;
        b=aPq39IETAv+zBOz3ZALBR2MdUsmZHz8Jrh95RhoNqPUCg4BYVPI529ZOZb7wDFMQDN
         61V0yGE5kFj7LB3SQ9+7inPto8HxvZXkMbMUKssa/b1clU0+8tEG63kYkVbKdshHCKdt
         tDkE09wKQQH46yYH8LZsU8cUAhBjY6ZZgFfx896hloU9uVV5eXbTgosPSUd2xF6ZJa52
         7ajlxxoG5iElegighkmcJiVj07bQdMni5fuFJ3Wuzm6vX4RlrEYOwYeuaFT6d/wCvLsf
         ieqCfFyHmbyeG4gLZYd7OcyfGumupZdEf0pAEFJlE2menwQKOaWnoPAtLz8vfvIq8mXZ
         cMnA==
X-Gm-Message-State: AOAM533thIS2kono6OMf9bHbeHHO46wP7fnBPitFiwo+BAKXhMbj5tPA
        vo9X4c7IaLwsBBRmr5SvgYU=
X-Google-Smtp-Source: ABdhPJy2+6evQAzc0EY/tQascXTV7xNSwY7FR6AWKrG8xXCOx+vqVjR36CWdGzTPaVRGFRTsF98inA==
X-Received: by 2002:a17:906:af02:: with SMTP id lx2mr1564041ejb.133.1627636234126;
        Fri, 30 Jul 2021 02:10:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id da23sm417665edb.34.2021.07.30.02.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:10:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: rename odm_EVMdbToPercentage()
Date:   Fri, 30 Jul 2021 11:09:46 +0200
Message-Id: <20210730090948.32759-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename odm_EVMdbToPercentage() to avoid camel case.
odm_EVMdbToPercentage() -> odm_evm_db_to_percentage()

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 4c9317833fbc..6afe3f9bc47c 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -77,7 +77,7 @@ static u8 odm_SQ_process_patch_RT_CID_819x_Lenovo(struct odm_dm_struct *dm_odm,
 	return 0;
 }
 
-static u8 odm_EVMdbToPercentage(s8 Value)
+static u8 odm_evm_db_to_percentage(s8 Value)
 {
 	/*  -33dB~0dB to 0%~99% */
 	s8 ret_val;
@@ -338,7 +338,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 				/*  Do not use shift operation like "rx_evmX >>= 1" because the compilor of free build environment */
 				/*  fill most significant bit to "zero" when doing shifting operation which may change a negative */
 				/*  value to positive one, then the dbm value (which is supposed to be negative)  is not correct anymore. */
-				EVM = odm_EVMdbToPercentage((pPhyStaRpt->stream_rxevm[i]));	/* dbm */
+				EVM = odm_evm_db_to_percentage((pPhyStaRpt->stream_rxevm[i]));	/* dbm */
 
 				if (pPktinfo->bPacketMatchBSSID) {
 					if (i == RF_PATH_A) /*  Fill value in RFD, Get the first spatial stream only */
-- 
2.32.0

