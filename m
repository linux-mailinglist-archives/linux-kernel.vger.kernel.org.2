Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A42456ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 13:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbhKSM3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 07:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbhKSM3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 07:29:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE22C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 04:26:44 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id l25so25558167eda.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 04:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38S9lb/xN7YIHKTpi8ddifaK2hGuRb5K16FaftQ2adY=;
        b=hpQprQQ+NXNkARP4s0bvv6VX5k09q3fNNG0DgtplcOSYyHhP80tD76rfROZCNv7x+V
         5SwES+5guz98hlK5VtiPv3rKlfGQM2gxp09p9DYkXO51vfgTjeqGOM2ZAC8+5LHAhjLh
         X814FSHLmzOHUlPRhWpuVEyNS+O3ozFFgY6OSvCVB0vCFxDFEx6c8hjATDG2ZcrRQPyx
         DWHoF4TX3Y+u8rnqNc3u2/cklTfIvktIsU/4bhlppx6959PkkS6Vf4Laa4HYzR4x89PN
         ORwTSKIQfQk5jdsR0X/Qc+xrUBw7HWe8VRrfqBfC7GlPDY7vmRGi/wReDvegC80+yo7i
         1H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38S9lb/xN7YIHKTpi8ddifaK2hGuRb5K16FaftQ2adY=;
        b=FwkIiA7fU+S/sbfZHVaPdKCgAlqstt4mXsf9CvC1uW60LwLOGN9yT0Fsyzj+UE5qFp
         IJy7xeTDXYP9miX9SPYs/YnQuvOf5jJ53+pxXNPytWnuQEx6EWENnic5vrjMgOAHkU0+
         lhbjPVYeZN/H2L9REFrs0y/c8G7iz88rFfluKF3uHRCn3L131DxNSIwZ8WRM7qT6ooOj
         o4CQOFD5bCbfbPR/F0SjbQGFFPCDpxGAubBD0shyqLOqIv67LWmhPi1PPAG4EpoLSHsN
         erbv7agSXNdCuenav7mA0/e0FF3ZDgC9+9LMhuesQpS2KPP/Xarx6mFvx144UjZJWdz4
         kLdw==
X-Gm-Message-State: AOAM5320/tS36i1d0QSMtYB0mpvNkbFeA24Zy2e8C8NdBt+HALl/6+Ix
        IvkwAsx4s+9jTJhzqz2FAm0=
X-Google-Smtp-Source: ABdhPJw+pLDazzlsZ1wuTvKbSJW8jfVF+KgeKthSXtBT02db2jM9yce2pKj4n4g5PYSc7PD3sPkTCg==
X-Received: by 2002:a17:907:868e:: with SMTP id qa14mr7500184ejc.564.1637324803274;
        Fri, 19 Nov 2021 04:26:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::79b5])
        by smtp.gmail.com with ESMTPSA id v10sm1374994edt.24.2021.11.19.04.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:26:42 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove rf_type from add_RATid()
Date:   Fri, 19 Nov 2021 13:26:34 +0100
Message-Id: <20211119122635.28435-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119122635.28435-1-straube.linux@gmail.com>
References: <20211119122635.28435-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rf_type is always RF_1T1R. Remove it from add_RATid() and remove
related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index c78feeb9c862..47bd84b67a08 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -318,7 +318,6 @@ void	expire_timeout_chk(struct adapter *padapter)
 void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 {
 	int i;
-	u8 rf_type;
 	u32 init_rate = 0;
 	unsigned char sta_band = 0, raid, shortGIrate = false;
 	unsigned char limit;
@@ -342,11 +341,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 	}
 	/* n mode ra_bitmap */
 	if (psta_ht->ht_option) {
-		GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-		if (rf_type == RF_2T2R)
-			limit = 16;/*  2R */
-		else
-			limit = 8;/*   1R */
+		limit = 8; /* 1R */
 
 		for (i = 0; i < limit; i++) {
 			if (psta_ht->ht_cap.mcs.rx_mask[i / 8] & BIT(i % 8))
-- 
2.33.1

