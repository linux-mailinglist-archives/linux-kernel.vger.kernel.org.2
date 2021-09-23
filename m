Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8FD4165B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbhIWTLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242954AbhIWTLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6475BC0613D8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u18so20153791wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtzqTSVRFlo/ZvmYdz5vMEFpgxiPpsEV+IcKD/HUlvc=;
        b=how4mWxYK+jyqMAHOHqbWQgUmSKF/dgBrAYZqSUk+O4lMGF+UyvWXdBVVDQ0n/ELGv
         TFQmnI4SpGBTUFqCS4qPyheXJfN2K2sam5oANOdsBrZFifm8nzbA/Hav/GQCTKWq1VmI
         +xQYJRJsxa2SMWhcraapP8985NiHA+rwxLLk0rnxTgQwIl4Pm/biXbuV58UDioVCFWWE
         ud6LasSh0KrsEq4KNozUBbOFz8p9YFSis8DUJlYn9hqBC7sjl0j8jFrfpCY/T6LZO5fC
         7qXG1V41mv0hb94I8Dl3lOTmOukTmRYJdhZ9uCj2PBMTtwEoN8q2sPVbOMBYPIhY18Ex
         DpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtzqTSVRFlo/ZvmYdz5vMEFpgxiPpsEV+IcKD/HUlvc=;
        b=1Hg+MmeYYyML3vzpJe49Z7AKzULOYN79MceUVIFPzX7hm6r+Vzms5Q4F37Uy/Sfs7W
         5BHv/RUNnm5tZ72fukT9BpSVXAq5hhBATnYyKflOZyXCyXMMZ928tXBDjYR91e5hyrcc
         0qcWhJBX18Zh6qgkmRHAD2wnM1/nbW3x9ShXPMjqyHOoYeuqiRn4RtJJo3jC2yfseItr
         4iSAAOduzvH8ea3bUQ2ZXj6HHoKsP8GWChjiNAwAmMv1nZFr7t/qTNPWaG1fI73MeFgJ
         p0Q+cfu59uZF0c6PgfqTa2GULSxfMloELHf2Do/nVKhL148f6074WnNONHXfXtDTp+QF
         4KXw==
X-Gm-Message-State: AOAM533ro+mkkjani8AMNHMom9sG08YpaGxfZV3pLE6SJUd4Yds1iL32
        BN2aLsf8SKLzm6JKPlt2Dbs=
X-Google-Smtp-Source: ABdhPJx9WygWFfr3y8J6KxUGDjPkg74dbJESEC0vWH4FN3+qcpAtHJiBbfs8gzYmxrwZ+aMek9fLHw==
X-Received: by 2002:a05:600c:3548:: with SMTP id i8mr6254033wmq.106.1632424179030;
        Thu, 23 Sep 2021 12:09:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/17] staging: r8188eu: remove rtw_setbbreg_cmd()
Date:   Thu, 23 Sep 2021 21:09:15 +0200
Message-Id: <20210923190920.3580-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_setbbreg_cmd() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 31 -----------------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  1 -
 2 files changed, 32 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 01e3fcaada3e..ec21ac610bfe 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -513,37 +513,6 @@ u8 rtw_setphy_cmd(struct adapter *padapter, u8 modem, u8 ch)
 	return res;
 }
 
-u8 rtw_setbbreg_cmd(struct adapter *padapter, u8 offset, u8 val)
-{
-	struct cmd_obj *ph2c;
-	struct writeBB_parm *pwritebbparm;
-	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-	u8	res = _SUCCESS;
-
-	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (!ph2c) {
-		res = _FAIL;
-		goto exit;
-		}
-	pwritebbparm = kzalloc(sizeof(struct writeBB_parm), GFP_ATOMIC);
-
-	if (!pwritebbparm) {
-		kfree(ph2c);
-		res = _FAIL;
-		goto exit;
-	}
-
-	init_h2fwcmd_w_parm_no_rsp(ph2c, pwritebbparm, GEN_CMD_CODE(_SetBBReg));
-
-	pwritebbparm->offset = offset;
-	pwritebbparm->value = val;
-
-	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
-exit:
-
-	return res;
-}
-
 u8 rtw_setrfreg_cmd(struct adapter  *padapter, u8 offset, u32 val)
 {
 	struct cmd_obj *ph2c;
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index bb6163941742..f92dca3f1f89 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -756,7 +756,6 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network* pnetwork);
 u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueue);
 u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infra networktype);
 u8 rtw_setdatarate_cmd(struct adapter  *padapter, u8 *rateset);
-u8 rtw_setbbreg_cmd(struct adapter * padapter, u8 offset, u8 val);
 u8 rtw_setrfreg_cmd(struct adapter * padapter, u8 offset, u32 val);
 u8 rtw_setrfintfs_cmd(struct adapter  *padapter, u8 mode);
 u8 rtw_setrttbl_cmd(struct adapter  *padapter, struct setratable_parm *prate_table);
-- 
2.33.0

