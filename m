Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46443FAA70
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhH2J0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbhH2J0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:26:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0BFC061756
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:25:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r7so788689edd.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8cOJwuF63B3kAPlXYd6oasS8yb7CPWzUAASpmG5Xb8=;
        b=gVCHHH9NHciA1B34T3gAuRPrjTuX53cpRqJEQgM9Gq4LNYSxOwO3j/T9ho1b0YDBgv
         +0dAkztcE4mzaQ7RL3R3+B1L8gCjNsx/C6pb23oETbXXCOpPoS1RziijwIrKUKvmg/Ln
         yKS+7/eGdq0AN6ulT8KIOFWiKIQiKNARa+QY+QEcRbpLdZ8kFE3A19jO2QgtjfHmAWfR
         zcURkAU7yfJmylqmvxk1WiScTlIBf5QTJ6g4zeZw5MEP0yhG+HeJtXmWWjrzxrWu/40T
         qJpDMzp+olz3hntqiWFpMOHY9uwVXzoCohCXwmdhfdGv3RyQH0GKUHdS4tJhbmXM/7il
         JVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8cOJwuF63B3kAPlXYd6oasS8yb7CPWzUAASpmG5Xb8=;
        b=oR1byRmUW60t49Tr7PQPoK3vpXm4E8wltJrZWtGETVHXtSI6vOiZSQ0NjbqdytWcxw
         J5zCDk0zBmh27XYUr0DOzE0dZ/eA/cuMvoq2nP2Z7HsfhHa+Edw57RtYe6ZmBL3e7y52
         CiwS8p/YFf57MYME/gLVLdEk2jdJB7usdL2ftPM8AdYcjfeRBYn06S2G4l/jHUgIGbCo
         dFOaiX+Tc3Rzqh/ehQKpj/0JPLjlO5+5w0nQ/hh9EfunHTA8GwW5nI1lj2JpijsjK3tK
         kl+ppowzsmR1b57HsqbaLYqVGUmw+YNvQKza9rgrxdUesWXIiKIb/e8TvA8UfEhnibQH
         jmgg==
X-Gm-Message-State: AOAM532vjnDgBnjR4k+4Ibc/jJj5WeaHdTYODeWQ/GDsKnWktLKZpIIV
        ywtiswIvdWSIIPxVP+QD6U4=
X-Google-Smtp-Source: ABdhPJxmrLnlHUJtXbMWShP+34rlN/WFLyCROTsnVKZ/ornQblLCWR2/QTS4xi+YKkbUHQSNfPDZvQ==
X-Received: by 2002:aa7:c60e:: with SMTP id h14mr8450755edq.43.1630229125231;
        Sun, 29 Aug 2021 02:25:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id d23sm5814414edt.39.2021.08.29.02.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:25:24 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: r8188eu: remove CAM_empty_entry()
Date:   Sun, 29 Aug 2021 11:25:00 +0200
Message-Id: <20210829092502.3658-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829092502.3658-1-straube.linux@gmail.com>
References: <20210829092502.3658-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function CAM_empty_entry() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c   | 5 -----
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index bc10a08d01e6..ddc84f6b74e2 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -427,11 +427,6 @@ unsigned int decide_wait_for_beacon_timeout(unsigned int bcn_interval)
 		return bcn_interval << 2;
 }
 
-void CAM_empty_entry(struct adapter *Adapter, u8 ucIndex)
-{
-	rtw_hal_set_hwreg(Adapter, HW_VAR_CAM_EMPTY_ENTRY, (u8 *)(&ucIndex));
-}
-
 void invalidate_cam_all(struct adapter *padapter)
 {
 	rtw_hal_set_hwreg(padapter, HW_VAR_CAM_INVALID_ALL, NULL);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index c6b17da73c5f..01f770d02e5f 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -462,7 +462,6 @@ void write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key);
 void clear_cam_entry(struct adapter *padapter, u8 entry);
 
 void invalidate_cam_all(struct adapter *padapter);
-void CAM_empty_entry(struct adapter * Adapter, u8 ucIndex);
 
 int allocate_fw_sta_entry(struct adapter *padapter);
 void flush_all_cam_entry(struct adapter *padapter);
-- 
2.32.0

