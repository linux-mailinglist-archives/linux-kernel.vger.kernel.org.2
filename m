Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015CC4165AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242892AbhIWTLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbhIWTLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB00EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t8so20162448wrq.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyZGisBD3DW4oYzcr+S2RkmqV081EMO9g7OlIFtR4uE=;
        b=VyMGhuUmGkvIp72iMTLrAUaHspZP+lxyxSILXZ8cePLfbNfiEP13WVKZyFrb/VdcO3
         P9ijgvTTRqw4/UN8WmWL+ZaE/QDoKS34T3cIK3jKPyXbUk9Z7kya0BtwSm9x5plQBHGJ
         zr7hbtLsz9PvOjQ1wBQtIhVxCgBTadN4cwjC6eB3rKN5ai2AIdd8bkbMG6vFkXvrOr5P
         fqGjI7kwUi63/ELRvpg9Gd7orO+l1Tl/LZhcS+yk1yapyN0j9qEnQgp9QLkZahO81QJa
         1bsldJk2I1QHVVvW6iuNJ2fTck01BE/RfM1SzCk8ppYQ9saVu6M4+XULv0ZRRJr8brgP
         xAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyZGisBD3DW4oYzcr+S2RkmqV081EMO9g7OlIFtR4uE=;
        b=usaY5YvqkBH3MdcEop6gWeyj20BL82c2SdBArNrkv5k08nwKXuGeFXNK0GtePUCGtc
         rT/A8rqgUquhYm0d7YiGTS9kdUzSsHx/Rov9fMnOSUgh7CyRm/veeHV0pAUSE5b/eZgP
         8g+YYuernV/4g+CmZmMBnbJoXMCYCylYuGaIO+f4YrRKiQyK3qQQV2q6hEYxhY73sStw
         FVcYo2Tft1sreicu2Y7DBhlulnMNu95A8OcAYoLOhTsTBwoK6eGIPX4ZwnUe5k4BiyUB
         a8ms6NoEYOXcMApsC1A3No0a4nccRtTkkdyLT92U8ClxE0qQxB2tK6tlKGb6wuVIFmqk
         Xe3w==
X-Gm-Message-State: AOAM531VzR2b8hGMj4wtR/vVNf97xJOD+NrSXEwCxyMJN9I1x8v2duIJ
        SkdvxHxU4KwbQLafuAjVGzI=
X-Google-Smtp-Source: ABdhPJwndNK0biCeBUeSTQOoKjIYzudaaf08OXzEYBc/xmdDTM8CLBYO+KC06yRqAixbHkbC9xdtfw==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr6313029wme.76.1632424171160;
        Thu, 23 Sep 2021 12:09:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/17] staging: r8188eu: remove rtw_createbss_cmd_ex()
Date:   Thu, 23 Sep 2021 21:09:05 +0200
Message-Id: <20210923190920.3580-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_createbss_cmd_ex() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 26 -----------------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  2 --
 2 files changed, 28 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 4b149425cff7..972c47136b1c 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -717,32 +717,6 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 	return res;
 }
 
-u8 rtw_createbss_cmd_ex(struct adapter  *padapter, unsigned char *pbss, unsigned int sz)
-{
-	struct cmd_obj *pcmd;
-	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
-	u8	res = _SUCCESS;
-
-	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (!pcmd) {
-		res = _FAIL;
-		goto exit;
-	}
-
-	INIT_LIST_HEAD(&pcmd->list);
-	pcmd->cmdcode = GEN_CMD_CODE(_CreateBss);
-	pcmd->parmbuf = pbss;
-	pcmd->cmdsz =  sz;
-	pcmd->rsp = NULL;
-	pcmd->rspsz = 0;
-
-	res = rtw_enqueue_cmd(pcmdpriv, pcmd);
-
-exit:
-
-	return res;
-}
-
 u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 {
 	u8	res = _SUCCESS;
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 7923749ae7bd..ce47ad21c087 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -750,8 +750,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 		      int ssid_num, struct rtw_ieee80211_channel *ch,
 		      int ch_num);
 u8 rtw_createbss_cmd(struct adapter  *padapter);
-u8 rtw_createbss_cmd_ex(struct adapter  *padapter, unsigned char *pbss,
-			       unsigned int sz);
 u8 rtw_setphy_cmd(struct adapter  *padapter, u8 modem, u8 ch);
 u8 rtw_setstakey_cmd(struct adapter *padapter, u8 *psta, u8 unicast_key);
 u8 rtw_clearstakey_cmd(struct adapter *padapter, u8 *psta, u8 entry, u8 enqueue);
-- 
2.33.0

