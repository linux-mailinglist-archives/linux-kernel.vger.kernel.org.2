Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8F33F58F8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhHXH2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbhHXH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:28:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB4C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:27:17 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c12so35957722ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssEJXS5mWPr1Oq2NWHBdclycHEgmiyzEVQ1hB54zJfc=;
        b=EZotiKOWqWceedGd639AfckDcj6us2YrlvptzWSYTRVyNjx2FLWtghZEqPtkup8CHG
         qbzqkFclisobdc8gdgYl1Bn9Oh7j5aNtMSd4uU0+uzNyV1GI+NEgy5BFnJhueonyVnZH
         ctDyoIqBNewyxGT0QZgOfbbOaFIZ1vEmA2hRBgGkJoCeqU4OBDDHx6xyVqgVVjobGmuB
         H+PcspQcvnnt4gWPufvrq+bEAAmpziQznmSR6fZOVnk4NBP4RYZGWk/fukQTCrxpZ9sj
         mXRcj9HC8TRzaS2BGv87MsBd5kGFzSOqQz8Y9T3gd/8S3xecSzlZgJ0R4V0h8/GYZcwl
         c7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssEJXS5mWPr1Oq2NWHBdclycHEgmiyzEVQ1hB54zJfc=;
        b=OsGFJOfZOcJnES1S1zBMQZ0+RMiJNgv8xoZ8fWqxIqO9FLDHJKtAOD1MWjM663LveD
         bhVd3PjPAb8TFGkRcoltA8JviUALyc3h7nrVQpAsbDDCSN1wVau9aC6QzLtDMsRghJFp
         E1BqGf356lmMj86CpqnSro58L6qlwogsJnV1Cl+6/0o73f65uefL4zuijuXu/uraJWUy
         aTnhsHyo9+SEILJxwdAIxg80icEmCeXVVKv1TncBIBEtKSQRInpOj8qLttsVZX/KzGV3
         bWcC9U82RRbnuP4KK0V95IvO7j2qnLZjwOCBncLuv3Ri4Wfj+7F03HkNjahbl4+QcWvr
         Q5LQ==
X-Gm-Message-State: AOAM530OnsbcrXrhrWM7sHpo1zQmVfoFUcBElrah+KdSYiOPh8BRbSWZ
        e72eoEbuxcC5SE4YqSTFCxl9f8zM5vuMjQ==
X-Google-Smtp-Source: ABdhPJzf+d3tbE/rt7WNuEWsP2ouaGmBIcwvSl103N0kEFhagfqLaPhigwFZxnAAwOgY873gbtmEOg==
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr30188401ljm.95.1629790035529;
        Tue, 24 Aug 2021 00:27:15 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id l8sm331302lfh.157.2021.08.24.00.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:27:15 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 1/6] staging: r8188eu: remove {read,write}_macreg
Date:   Tue, 24 Aug 2021 10:27:13 +0300
Message-Id: <d591e29d77da73790c71f7a8e508a8b16fd48f65.1629789580.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629789580.git.paskripkin@gmail.com>
References: <cover.1629789580.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 2 functions are unused, so they can be simply removed

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mp.c    | 39 ------------------------
 drivers/staging/r8188eu/include/rtw_mp.h |  2 --
 2 files changed, 41 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 93bb683b628f..0a0a24fd37b0 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -7,45 +7,6 @@
 #include "../include/odm_precomp.h"
 #include "../include/rtl8188e_hal.h"
 
-u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz)
-{
-	u32 val = 0;
-
-	switch (sz) {
-	case 1:
-		val = rtw_read8(padapter, addr);
-		break;
-	case 2:
-		val = rtw_read16(padapter, addr);
-		break;
-	case 4:
-		val = rtw_read32(padapter, addr);
-		break;
-	default:
-		val = 0xffffffff;
-		break;
-	}
-
-	return val;
-}
-
-void write_macreg(struct adapter *padapter, u32 addr, u32 val, u32 sz)
-{
-	switch (sz) {
-	case 1:
-		rtw_write8(padapter, addr, (u8)val);
-		break;
-	case 2:
-		rtw_write16(padapter, addr, (u16)val);
-		break;
-	case 4:
-		rtw_write32(padapter, addr, val);
-		break;
-	default:
-		break;
-	}
-}
-
 u32 read_bbreg(struct adapter *padapter, u32 addr, u32 bitmask)
 {
 	return rtw_hal_read_bbreg(padapter, addr, bitmask);
diff --git a/drivers/staging/r8188eu/include/rtw_mp.h b/drivers/staging/r8188eu/include/rtw_mp.h
index b64b16554343..3a259d991348 100644
--- a/drivers/staging/r8188eu/include/rtw_mp.h
+++ b/drivers/staging/r8188eu/include/rtw_mp.h
@@ -410,8 +410,6 @@ void mp_stop_test(struct adapter *padapter);
 u32 _read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask);
 void _write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask, u32 val);
 
-u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz);
-void write_macreg(struct adapter *padapter, u32 addr, u32 val, u32 sz);
 u32 read_bbreg(struct adapter *padapter, u32 addr, u32 bitmask);
 void write_bbreg(struct adapter *padapter, u32 addr, u32 bitmask, u32 val);
 u32 read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr);
-- 
2.32.0

