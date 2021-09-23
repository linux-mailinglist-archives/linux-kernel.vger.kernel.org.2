Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464B04165BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbhIWTLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242780AbhIWTLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42940C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u18so20153918wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F3NtaaGbqjy151+4W3CxufbnYFaPjPMNMVa9qbgnmHU=;
        b=gIGP79jp1TGS5DZYgQz4Vl6ciOJJDjuax8TFeDtNSyyL7mhy4DusPLqSRvPKU2Ui0e
         dAKTuP1yHrMUekaneYmvNuE9GTpl/oKbzPTP0u6Epgun+/6jlI5cPL1sjUWrRQCqpKNu
         Usc9KhVYiFEMJ7uauDM9zDrF0FGhrOE/kydBmOhlFTtMQk6CNz5JOAWzqsPPKSUbX5OI
         mf16kS2Eb58e9YZYlSNpwoamKlJUT2604J9u18V8Z/m8AGL2HzP7iH6CYj09c7QrIggi
         ttBDVzuIOUjVh0qQHENE8ytz7ARer42iBX/nzy729JDRqAoCQiUmomHdiJbwEbXBCcHn
         u67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F3NtaaGbqjy151+4W3CxufbnYFaPjPMNMVa9qbgnmHU=;
        b=ndw7Dna/omOpqXGK3JxOxH/ZZsMq0XEplK/ZDDR0QpGQg/jozNFk5INuZrpTo8PhSc
         KtE/6Qhwm9lfp8zDj1NhdqLfnuPZHSYSUm/z3OXEstj7Z94FkhS0azsboYrPmkCsrNRI
         EhMpUZk70DG2KiQ/gqmfH+77n5ktas8tbbH9vyxzPg86OTEguV9p/muviZ2I9yNzYhqo
         vhjTu7pu+CetAjNWmRiSe+QNXHXye3SxFnHEgucfpot7e32tVWMZTYDWEd7ZiTbLqEk2
         l7hU4pX8BCIwNVO2Z/jbkkoIRE+8W42qzEN7F8iuFy0QRUQv5Ek//YdukgIG40MZC4Ug
         +sRQ==
X-Gm-Message-State: AOAM5328PEhBcQbEa56Bybxtlg8Qn3uqFypgp64XpbHfrIrfXvL4uv/F
        nO6Ufjh8O5gDu59vSAx8XKE=
X-Google-Smtp-Source: ABdhPJx2yzgrRUHS11NvHjZwfKEgD9iQ26k4QrlDvizYz//tS41HCv0di3BbcNEuuj9YyodY1ozYkg==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr17875612wmj.182.1632424179858;
        Thu, 23 Sep 2021 12:09:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:39 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 13/17] staging: r8188eu: remove rtw_setphy_cmd()
Date:   Thu, 23 Sep 2021 21:09:16 +0200
Message-Id: <20210923190920.3580-14-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_setphy_cmd() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 38 -----------------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  1 -
 2 files changed, 39 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ec21ac610bfe..9b36b23fecf7 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -475,44 +475,6 @@ u8 rtw_setdatarate_cmd(struct adapter *padapter, u8 *rateset)
 	return res;
 }
 
-/*
-unsigned char rtw_setphy_cmd(unsigned char  *adapter)
-
-1.  be called only after rtw_update_registrypriv_dev_network(~) or mp testing program
-2.  for AdHoc/Ap mode or mp mode?
-
-*/
-u8 rtw_setphy_cmd(struct adapter *padapter, u8 modem, u8 ch)
-{
-	struct cmd_obj *ph2c;
-	struct setphy_parm *psetphypara;
-	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-	u8	res = _SUCCESS;
-
-	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (!ph2c) {
-		res = _FAIL;
-		goto exit;
-		}
-	psetphypara = kzalloc(sizeof(struct setphy_parm), GFP_ATOMIC);
-
-	if (!psetphypara) {
-		kfree(ph2c);
-		res = _FAIL;
-		goto exit;
-	}
-
-	init_h2fwcmd_w_parm_no_rsp(ph2c, psetphypara, _SetPhy_CMD_);
-
-	psetphypara->modem = modem;
-	psetphypara->rfchannel = ch;
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
index f92dca3f1f89..2b5672ac9ad6 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -749,7 +749,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 		      int ssid_num, struct rtw_ieee80211_channel *ch,
 		      int ch_num);
 u8 rtw_createbss_cmd(struct adapter  *padapter);
-u8 rtw_setphy_cmd(struct adapter  *padapter, u8 modem, u8 ch);
 u8 rtw_setstakey_cmd(struct adapter *padapter, u8 *psta, u8 unicast_key);
 u8 rtw_clearstakey_cmd(struct adapter *padapter, u8 *psta, u8 entry, u8 enqueue);
 u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network* pnetwork);
-- 
2.33.0

