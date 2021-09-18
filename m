Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0344105D6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbhIRJ7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244870AbhIRJ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:59:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EC6C061764
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:58:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id a194-20020a1c98cb000000b0030b41ac389fso3774628wme.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7P045dEU7nb9Dn+sQy4wSUSI87UBpJSz893JclonIw=;
        b=bCKCXfmE6IM316LMsRbAD29MOdyh0Wy65zxUN9K3t2Vz5k2f8YPWyaDUub/YbxqNqj
         Rh34bDdK7uZxLtTyHghb0B4MLj8aQ5VaJ9UGjSymf9RBOezLdlY1jQFmG0hYaqRnAz9k
         ZsPbJBkcJBZGhEG1uB0ADqzBRVL0H9J9EYRKQn1jPvR/4m1huyIbH+/hsCparVI08fbs
         4jTtAgOb8mubOIWQ8fskmArwKqWYz7t36UD2S7Bo0MAayMwLg1QZisPeJVOdLbkuYaDD
         kvobkDUzbI1ZIUHrTA33NnjM7EyXDsWMVuUsP05c30QuSXX5RlnutZuMTIZeMxsFd0P1
         qURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7P045dEU7nb9Dn+sQy4wSUSI87UBpJSz893JclonIw=;
        b=URE/ofV3Z1omFuhA5DWeojgqrNrmSOkQ5CXlAJBnBE4S4RnPryQLqLeKREzQKoU9FS
         19DGoGF55El1BnkbOxCWBjNYqcQU/htKnCtENPljNXu41EGLuoV0GiU1hT1BcsaHzK/h
         DfUoGwN8prZidda1y4TUArbopg+X5fFFwK7Q6E5sHZa5xPAm3S5g9PXESdvzaSQS3pwF
         hIdw8v7s0r2e9o0kSqltLqTGLyB6GUg3YGJ+KGs8v2jfje/k60zCtn2T6e9ySrVpuoXI
         qKv7DoislMdioW8sK2+FdC6cYSNHDY9h3xF3y9Y7wBp7HGZB5gPpxkBm4bG31fKry2K6
         MMkA==
X-Gm-Message-State: AOAM532Cx6OJXemp3JebI4KOt0Uxc5UT7EQF3rhtVyfs6Xia5vVlSa4A
        ROo40PDcda4maxq5NlI1HX0=
X-Google-Smtp-Source: ABdhPJxthwx+gq1M4zpjGXsn0otM1mjjj2fIkb9Yle8g7PfzKpfH1WGoZl7xMxnO6Ix4swH7n9uXzA==
X-Received: by 2002:a05:600c:35c8:: with SMTP id r8mr2756694wmq.71.1631959081709;
        Sat, 18 Sep 2021 02:58:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id o26sm13013287wmc.17.2021.09.18.02.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:58:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/8] staging: r8188eu: remove rtl8188e_set_rssi_cmd()
Date:   Sat, 18 Sep 2021 11:57:26 +0200
Message-Id: <20210918095727.13591-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918095727.13591-1-straube.linux@gmail.com>
References: <20210918095727.13591-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtl8188e_set_rssi_cmd() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c     | 15 ---------------
 drivers/staging/r8188eu/include/rtl8188e_cmd.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 6cdc2e40aad4..6450c2c32f8a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -109,21 +109,6 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 	return ret;
 }
 
-u8 rtl8188e_set_rssi_cmd(struct adapter *adapt, u8 *param)
-{
-	u8 res = _SUCCESS;
-	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
-
-	if (haldata->fw_ractrl) {
-		;
-	} else {
-		DBG_88E("==>%s fw dont support RA\n", __func__);
-		res = _FAIL;
-	}
-
-	return res;
-}
-
 u8 rtl8188e_set_raid_cmd(struct adapter *adapt, u32 mask)
 {
 	u8 buf[3];
diff --git a/drivers/staging/r8188eu/include/rtl8188e_cmd.h b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
index 626df5f44fc5..01404b774ebd 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_cmd.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
@@ -91,7 +91,6 @@ struct P2P_PS_CTWPeriod_t {
 /*  host message to firmware cmd */
 void rtl8188e_set_FwPwrMode_cmd(struct adapter *padapter, u8 Mode);
 void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *padapter, u8 mstatus);
-u8 rtl8188e_set_rssi_cmd(struct adapter *padapter, u8 *param);
 u8 rtl8188e_set_raid_cmd(struct adapter *padapter, u32 mask);
 void rtl8188e_Add_RateATid(struct adapter *padapter, u32 bitmap, u8 arg,
 			   u8 rssi_level);
-- 
2.33.0

