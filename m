Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF8402006
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbhIFS43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245071AbhIFSzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4229C0613D9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u19so10627121edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEzDdyzAFFu2bR5f0c3Tr73sdtBpa1SXUiajkJlqtqo=;
        b=GjF6j6jCtZTYM12tx7IF57xxlapmGqyoLvi+cZTb1VazJLy+dooW97sROFnDP3l7+/
         VqP58+KDD6jCA4qVrqyJk0Czupuwc4ubVWuf8IojYEfNTGZ4A6iij05gnlNscsQ3sS2J
         wnKvz/egYPjQPN1xB1OYIBUAzLxbzjB4bpnxHkjbvKDLFhYQeLqJugHHl5H/GwxsAnif
         G+46sZbE3RzRauABajkJlvHiPoMqx/GMw2kbpj527ZB7Y8JW0z+nehKHieHWRwR7JuMc
         fEFjvaEjibZL3bYLeU3sO+C3X8eGT7FzO5ipQIyp07HKh8mW/tjS1vlOPVjq+KAN2gb6
         eDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEzDdyzAFFu2bR5f0c3Tr73sdtBpa1SXUiajkJlqtqo=;
        b=JxzbSkNAB3kqonjq7lLfBjuiVr8rtq1Y0zleyW45qaIYhRULcz1HoFwt13KN6PFGug
         Tqc4gOvIpJkQ4XQ7bW2fyvon0EKOlsZv2gjDTpj9YV1NHW1wWvvm2r62HFI+Q3omFrgE
         mjEauc/N8ypVU7S5OUzCiR0XM/Tfu5wiRydk+yvBlkzIFxZK0I8wCeAg1dunfJBpQ30J
         Ve2IsvQ2knBvhV/z3Ms+tz4JbX4RUGvyvSzEDQq9aVln3vGzGMu1svzA0OI7ncX3g0zt
         mBGEOskyP7ImsxxvK5ll27AEk7ZnIuk39z6FTr6VJzX69JD6X5eakzh/fu2xzhSdlMBF
         b3JA==
X-Gm-Message-State: AOAM530c7Y6XpoOQfCGjI8j/WwhLyap2Ack7r4Gzv0sXFPuBoi1h4pBJ
        g8TJPbt0K64D++WcCaIW+e4=
X-Google-Smtp-Source: ABdhPJwBzkVwOfaKSVXdHJPNID87PTdG+y+2A6JOXZjP2AnxhQzZQpbcMXz2AX2O7To6i/bUm2k3IA==
X-Received: by 2002:a05:6402:2210:: with SMTP id cq16mr14621310edb.348.1630954462549;
        Mon, 06 Sep 2021 11:54:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:22 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 27/40] staging: r8188eu: remove empty comments
Date:   Mon,  6 Sep 2021 20:53:14 +0200
Message-Id: <20210906185327.10326-28-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty comments.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index bae9a32ec27e..9196a7925940 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -25,10 +25,9 @@ u8 fakeBTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 /*------------------------Define local variable------------------------------*/
 
-/*  */
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
-/*  */
+
 static bool Efuse_Read1ByteFromFakeContent(struct adapter *pAdapter,
 					   u16 Offset,
 					   u8 *Value)
@@ -364,14 +363,14 @@ u8 rtw_efuse_access(struct adapter *padapter, u8 write, u16 start_addr, u16 cnts
 
 	return res;
 }
-/*  */
+
 u16 efuse_GetMaxSize(struct adapter *padapter)
 {
 	u16 max_size;
 	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_size, false);
 	return max_size;
 }
-/*  */
+
 u8 efuse_GetCurrentSize(struct adapter *padapter, u16 *size)
 {
 	rtl8188e_EfusePowerSwitch(padapter, false, true);
@@ -380,7 +379,7 @@ u8 efuse_GetCurrentSize(struct adapter *padapter, u16 *size)
 
 	return _SUCCESS;
 }
-/*  */
+
 u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u16 mapLen = 0;
@@ -416,7 +415,7 @@ u8 rtw_BT_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 
 	return _SUCCESS;
 }
-/*  */
+
 u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u8 offset, word_en;
@@ -508,7 +507,6 @@ u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 	return ret;
 }
 
-/*  */
 u8 rtw_BT_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u8 offset, word_en;
-- 
2.33.0

