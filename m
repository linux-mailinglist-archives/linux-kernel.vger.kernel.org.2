Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9644E72A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhKLNV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhKLNV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:21:28 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAE5C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:18:38 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id m15so4104361pgu.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJJvgLkaj1ldPKqgEqYsJV1bKUGA/M9apuGLSVBki7o=;
        b=nThlzJQiU2cDw+giTSlT/gHFuBTPFIBTNttRtPpKK+ymN6AbOn8NfOcsQKpVaAwv4r
         RCMoTrVlDXVHSHEgW4xHXLJssjj0o5cswunHtVrDlk/PWSQvY79fYnYlkqhYQOFDX6g8
         wjpl1eBVwUpjZJXn36ueF9xt7aVBfKuNhwy19d+HpRlWAck9Abp2J6WuJ+qdQbnVGgq7
         i4JuuPxa5vbNVgZsod0gxUuxpa+BBaJN1cGUVkibC1eeMb08Hm/21LK1eA9NJZIFu5cJ
         dgMFbcv/fUYZ1xI3LpLGp7CChxy4pt+fE15wSqiQJfM3Mr+P3UIO4yUZg4mtxjmyVEql
         Xt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJJvgLkaj1ldPKqgEqYsJV1bKUGA/M9apuGLSVBki7o=;
        b=IjZ9WMUpp5LZZcODmVAswSStXhTnMhJpIMMnvo3zYJY3uZ+CwC7xQbGQkoLQAVKatm
         tlmlA+aRd3sJvu7sk9xiHU86vhlq44I2USf4KvDIJ8Cs8pI1eSOESkCIUCxRB571FXK6
         HSHxo0lMiD3kXjA1zhqszyxSfL6GIfUHKBHyWVjb9LUbzXT7PEYXt2nyUvsz7w2GU2QT
         5Y/RPTMJHc8jpH+7T2oZZQ1zOs0FYeaF6ht6hUQN8yG+56L5f9ifY/qKYivRPXEIbPuP
         3A2FtCn34dT2dnUo44Cu7gmKaMJQNmGEccrYvor5eI8J2Ae3ZOcxvV72ia6jzX0GVUJM
         tj+A==
X-Gm-Message-State: AOAM533zfG55ryDvoF5LnSxQ+0vTOOQTArrERCYu4XVR2JhIoYwwPpJz
        QT8I0r9IIiZYzsBWQzTyAlI=
X-Google-Smtp-Source: ABdhPJzjHBEzYfDkyhbnLuvks7Kb1S7Cqymv/Ya//rLQbl6y5ZfIne/bW6SHIhFuCrR6wzqO+3cv+w==
X-Received: by 2002:a05:6a00:a10:b0:412:448c:89c7 with SMTP id p16-20020a056a000a1000b00412448c89c7mr13568800pfh.83.1636723117570;
        Fri, 12 Nov 2021 05:18:37 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a13sm6983537pfv.99.2021.11.12.05.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 05:18:37 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     phil@philpotter.co.uk
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux@roeck-us.net, martin@kaiser.cx, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] staging: r8188eu: remove unneeded variable
Date:   Fri, 12 Nov 2021 13:18:30 +0000
Message-Id: <20211112131830.11418-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck review:
./drivers/staging/r8188eu/core/rtw_ap.c: 1094: 5-8: Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index c78feeb9c862..d103a92ee2f1 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -1091,7 +1091,6 @@ u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
 int rtw_sta_flush(struct adapter *padapter)
 {
 	struct list_head *phead, *plist;
-	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -1101,7 +1100,7 @@ int rtw_sta_flush(struct adapter *padapter)
 	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
 
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
-		return ret;
+		return 0;
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	phead = &pstapriv->asoc_list;
@@ -1124,7 +1123,7 @@ int rtw_sta_flush(struct adapter *padapter)
 
 	associated_clients_update(padapter, true);
 
-	return ret;
+	return 0;
 }
 
 /* called > TSR LEVEL for USB or SDIO Interface*/
-- 
2.25.1

