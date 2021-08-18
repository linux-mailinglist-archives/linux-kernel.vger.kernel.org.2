Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E573EFFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhHRI7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhHRI7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:59:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD751C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:59:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z20so3511884ejf.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yfblc24kClCAw2LhDZTuYVLpqQqgLMTKO9KyYtQMCqk=;
        b=tl5YNpBUp05iRCyrDdprab20ldnnyf/gDQwVIfAeCrMJdFXwgIUn/gquGtTZX33xe5
         qpVutf0208WhNrU8EDNaW52PRQhWqYkj7N/P2YB3CabfCzIrebxYBQM+p6LyqNLRc8UW
         NIqYYN+gmc+hx/wfgFP1E/X8x350aF3cQPM5vxCBeek4iJ8WlMsheUhbXRYfwt+cevZR
         lpxdx9YLqy9MFdmX2cxiY47nOMMF4VckvzDziDWzhlD7akVHCI1x8fOVTyshvaFlPisN
         xYNlImUM9NSDjbQoxWzhYix8zTsmLBPe+li4TlcSVybbunNhHf1De6s/lPBYxxXRLzDy
         gtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yfblc24kClCAw2LhDZTuYVLpqQqgLMTKO9KyYtQMCqk=;
        b=Cz4NY3MaH99ft6CyflbyhMeOED03KwN6AbSlgXvmoOHBIAsrIzrehXxsnvIbbw95GR
         zFaqa4j+Vc32TT/gO1jbEhWVjOqa4GKCzA7+Tke5QRKO4QuZ/Ay6b80meR88uKtVticp
         SBahFPuSFwxjQqSWjtSyekKtGLjhGTxrkooum5akwMkJohOtNhynZzEwzMbN9yPOrhhW
         U6Kw7UOx2EBzx7+2UzUiOJ0NXqDrJHM31cwaXFXuJdxisXo6ZT4cAQVxR17qfOyHhxVN
         uzWQUJfQl0sDge+xomDr/kitBzvbLO93fzRUWfpwsZw8pLjMWRGnXlqf4+IMEiMeutCM
         /xbg==
X-Gm-Message-State: AOAM533apzAkILAsu+Y2WaKAenYzq9u7VfemjYsj8BR6oza5XjusDrgq
        dIOhmCVt+a2BBo7fMngBXTE=
X-Google-Smtp-Source: ABdhPJz355jA6On5POrVcxTspKdz16ID6vjfl+FwoVzmHvbXr1U91j2FvNyOPZEfcmmEIGrPqRWlwQ==
X-Received: by 2002:a17:906:3aca:: with SMTP id z10mr8660105ejd.53.1629277148392;
        Wed, 18 Aug 2021 01:59:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id n16sm2248133edv.73.2021.08.18.01.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 01:59:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove null pointer checks before kfree
Date:   Wed, 18 Aug 2021 10:58:09 +0200
Message-Id: <20210818085809.31451-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree(NULL) is safe, so remove unnecessary null pointer checks before
calls to kfree. Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c  |  3 +--
 drivers/staging/r8188eu/core/rtw_cmd.c | 13 +++----------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 8ef0586b753f..1127e9a52458 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -1314,8 +1314,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 		pnetwork->IELength = wps_offset + (wps_ielen + 2) + remainder_ielen;
 	}
 
-	if (pbackup_remainder_ie)
-		kfree(pbackup_remainder_ie);
+	kfree(pbackup_remainder_ie);
 }
 
 static void update_bcn_p2p_ie(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index a68776f5e67b..955499eb608a 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -89,13 +89,9 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 
 void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
 {
-
 	if (pcmdpriv) {
-		if (pcmdpriv->cmd_allocated_buf)
-			kfree(pcmdpriv->cmd_allocated_buf);
-
-		if (pcmdpriv->rsp_allocated_buf)
-			kfree(pcmdpriv->rsp_allocated_buf);
+		kfree(pcmdpriv->cmd_allocated_buf);
+		kfree(pcmdpriv->rsp_allocated_buf);
 	}
 }
 
@@ -818,11 +814,8 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	psecnetwork = (struct wlan_bssid_ex *)&psecuritypriv->sec_bss;
 	if (!psecnetwork) {
-		if (pcmd)
-			kfree(pcmd);
-
+		kfree(pcmd);
 		res = _FAIL;
-
 		goto exit;
 	}
 
-- 
2.32.0

