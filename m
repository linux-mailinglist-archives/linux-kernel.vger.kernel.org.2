Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51074369559
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbhDWPA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbhDWO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C4C061346
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so39664025wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91fZeTranZX1H5Z/+RUWnPue6CJoyhVbwkd9ov6Mo+w=;
        b=C1QiuZJpNteY9tZZCizOWRpMwd80IY+0+Z6NNmx097Rbuyevz/HsVPYomD0nj1yGGV
         xRUM7KwMwk8DXll5y/IkQMrEu2cWhw9R7KyD2SbvOcK6IbCJt8I5D0Xr+OOCGtHALH/f
         /wJgs1FYvyIzO8DG7lelpdsAfL+aGjpyXqtlsxQMuynLzda1K2KU+0Lmwy1M5USbYb32
         qTMS5hfhOJKerkQJVxi5Q08zRxjrNxSpVyWXX9ddagMwOVnBxFSEZ4AGABUFwkKDCRhi
         2IGWptmluPp/5veZzU3k3rXfxCOISGA0MdWzI301XGPxUzd/DOJ9X7qx2Sx29UXEhycA
         D0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91fZeTranZX1H5Z/+RUWnPue6CJoyhVbwkd9ov6Mo+w=;
        b=qk7ZJ9u4sbzoB1hluuVTBjdP6Q4+2crXllPxZL9OhCLaiRERo9FCMsYNvC0Pjl+PNg
         fhrYjtJB+BGJYFL9ujUdjNJp2OGW2gOAs109mkQURwt14y5G2cLYGtfnQeCCmj5Mypig
         F7v0TH+F9Of7ObHrilseJm6zakVw+Jx9IKZfMxnA4LgTekE2uBYiGmEd38pIVFox6Ki1
         uXaCs6b5lfADUM910uvlzC3tZWgbgiz4JNPaUvKOWwbQ/02fuD2qezk/cMiPSJbR+Rmp
         kDjqeqCpKT/3+oHmHNo3+tH3sCinD1+9XQsWtEl1/I4JfKgFuMQy5AyEscf7kxD8RZLa
         wGtw==
X-Gm-Message-State: AOAM533/KjlqeEcWOnhBg6Xtjf+WW71SoRerK2MXeMGdIFwt85/PaBEB
        gpmdBpYUShl91YsygSGIHX/PVZhxxQE=
X-Google-Smtp-Source: ABdhPJycyL434Rk6JWRy0HuzuT841TQGtYHfJq9NmUm+NdUTP6qYhYzLOhOZnjH4y4ni0+FIeiYxOQ==
X-Received: by 2002:a5d:4bc9:: with SMTP id l9mr5475396wrt.242.1619189953033;
        Fri, 23 Apr 2021 07:59:13 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id z14sm11147916wrt.54.2021.04.23.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 19/49] staging: rtl8723bs: move static array definition from header to .c file
Date:   Fri, 23 Apr 2021 16:58:10 +0200
Message-Id: <497353741dc5b9045d62218fed39f51c25859f45.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
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

