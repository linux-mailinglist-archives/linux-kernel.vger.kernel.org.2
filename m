Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9891036A054
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbhDXJE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236521AbhDXJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C214C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l189-20020a1cbbc60000b0290140319ad207so5224wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91fZeTranZX1H5Z/+RUWnPue6CJoyhVbwkd9ov6Mo+w=;
        b=WjqZ+JXxwky7sNEd45JSuQPTOUkBZWVKSHBHWCu+FNIPfbJnu9kelvno/DmXTOJdxz
         1giyV3udda7TJIAt6yX39HudcZ1fGk2k1N/QjiuQ8/hZSLWqKOqJK0OZf2/KMIxhR6db
         VMovgEb3HprszHr2QIBUfqJm5Cmi3DQflaHi23T0DXt9Vg/L9VtBn8xOe/X8dkq4YYSQ
         nq37u9wTxgNdMz7bnV1MG0R19QWW2Kq3uosLgD/oXvAtyG5wyzId6m0G7PbkmfyNjzrw
         z/2tv1DBiqguJHUVMLNPgC3CG+ZcO4A/yn87U0L0YyCuiVeK4cLjo3YvRQwWtf3yF3Ph
         6K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91fZeTranZX1H5Z/+RUWnPue6CJoyhVbwkd9ov6Mo+w=;
        b=okNsmU5lTqMNaGfUuwmcBTjqi7tSumzdc2dGCZKAz7Mus71s/Kdup06fv5ax3HWJGE
         2y1J7ebBJCQoUZn8Efq8IsIsXwfSrOu4800xIOp4xz7XPCW/Ea9YY1xMOn+6oQHY4S33
         nPYcJ7sx4ZIPI4qSNPnyT5K9kzv4YANIkyMR30vFe/Xk+YQ4T6GfdLg9yvkQ5dwQiR19
         +VRIVCZlh1hMNh/DjG5rap2X3F/GNrdymjCE2KNlj/nerx2wNhip7RxvUaz2jlAiYzpx
         fT4NcELqfBprt6RJv4+JvOigJlIArTLSSM1mwCLKcl0d0OE8AdZXiiuTdjpAU/QKjVJg
         +G9w==
X-Gm-Message-State: AOAM5301E44giMGN4+9So4fwhgUn6mgWVlxwWHUzpolhwZKMWRZO+PPo
        DuLEWauGoT2Lgxddd14O8zmh/KOmafhjyg==
X-Google-Smtp-Source: ABdhPJwYZKgcXzNtwHX63bsJ6nlgTuNlHAoCqJkEDSWlNPwsfRJ6qRM3LB57/BCKJNl1gZ2shAsymg==
X-Received: by 2002:a1c:1cf:: with SMTP id 198mr6373505wmb.114.1619254988853;
        Sat, 24 Apr 2021 02:03:08 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id p13sm13578093wrt.0.2021.04.24.02.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:08 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/50] staging: rtl8723bs: move static array definition from header to .c file
Date:   Sat, 24 Apr 2021 11:02:03 +0200
Message-Id: <665c9d33a97954508ca9257850a5690afcf0a9a9.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move static array definition from header to .c file.
This prepare removal of a conditional compile block
_RTW_MLME_EXT_C_.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 30 +++++++++++++++++
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  | 32 -------------------
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 9031cf7657ae..1ff2b3a28bab 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5997,6 +5997,36 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 	return res;
 }
 
+static struct fwevent wlanevents[] = {
+	{0, rtw_dummy_event_callback},	/*0*/
+	{0, NULL},
+	{0, NULL},
+	{0, NULL},
+	{0, NULL},
+	{0, NULL},
+	{0, NULL},
+	{0, NULL},
+	{0, &rtw_survey_event_callback},		/*8*/
+	{sizeof(struct surveydone_event), &rtw_surveydone_event_callback},	/*9*/
+
+	{0, &rtw_joinbss_event_callback},		/*10*/
+	{sizeof(struct stassoc_event), &rtw_stassoc_event_callback},
+	{sizeof(struct stadel_event), &rtw_stadel_event_callback},
+	{0, &rtw_atimdone_event_callback},
+	{0, rtw_dummy_event_callback},
+	{0, NULL},	/*15*/
+	{0, NULL},
+	{0, NULL},
+	{0, NULL},
+	{0, rtw_fwdbg_event_callback},
+	{0, NULL},	 /*20*/
+	{0, NULL},
+	{0, NULL},
+	{0, &rtw_cpwm_event_callback},
+	{0, NULL},
+	{0, &rtw_wmm_event_callback},
+
+};
 
 u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 472818c5fd83..0248b91b4525 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -805,38 +805,6 @@ enum {
 
 #ifdef _RTW_MLME_EXT_C_
 
-static struct fwevent wlanevents[] =
-{
-	{0, rtw_dummy_event_callback},	/*0*/
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},
-	{0, &rtw_survey_event_callback},		/*8*/
-	{sizeof(struct surveydone_event), &rtw_surveydone_event_callback},	/*9*/
-
-	{0, &rtw_joinbss_event_callback},		/*10*/
-	{sizeof(struct stassoc_event), &rtw_stassoc_event_callback},
-	{sizeof(struct stadel_event), &rtw_stadel_event_callback},
-	{0, &rtw_atimdone_event_callback},
-	{0, rtw_dummy_event_callback},
-	{0, NULL},	/*15*/
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},
-	{0, rtw_fwdbg_event_callback},
-	{0, NULL},	 /*20*/
-	{0, NULL},
-	{0, NULL},
-	{0, &rtw_cpwm_event_callback},
-	{0, NULL},
-	{0, &rtw_wmm_event_callback},
-
-};
-
 #endif/* _RTL8192C_CMD_C_ */
 
 #endif
-- 
2.20.1

