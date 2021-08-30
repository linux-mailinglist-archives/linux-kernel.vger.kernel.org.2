Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D1B3FB58A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbhH3MGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbhH3MFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:05:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5D8C0613D9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so9277057wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HirnwGNf7jyImc4ZKCsenDbRLWYzFjlPI/Sq6s9Xg8=;
        b=uzMCEtoEezXlvfIcoS/Z30RKzKk1Ue2suN/TxfDZwb0G//T88o+gkAgIpOHMXiMjcx
         RYL/Z5/RQBH4UO26Oiao+8MipEoMSp+zMgHe/8AjVZNumfY+FUhkR+1ie771Mm/wlhXy
         svOO1z90pXICCwVWdrStQsGuFeTG4+2QSuq7L+0S9eiZMfemf9n1KPlNTmPFP/iEosXG
         1xp/ujbUpUMJzAZ8a3zNUYmAtvXxu7qiP2VUC/4PItOUvcxXw6Klc/k2NvrDIWTcYxpS
         0d8JXZz4Na3+Y5vrLn2nSmTmeea4njqUPUgRkPmbUqKDt1ul/alUK1BOLYnUw4JEWD4p
         4lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HirnwGNf7jyImc4ZKCsenDbRLWYzFjlPI/Sq6s9Xg8=;
        b=JQr6UKSt5CHgDmcgY2/7xhCIjUOtD+FJ2CVxvhxmOE7F8B9e8+w77V8cOy2RhoP/uX
         qc+K1YkabfpMEg77tVEGSJBrs/x2QVmo+kPjnR/Fddst2X/sSbVMxWHuyz/FFdza82Zy
         pQhUs6owHArOFrg9wh/PLO/+vUqa6Wo+eZiBS9Xv1pAhjqUWGfUJa3rq1Af8pu/Bn9Zw
         8Fa2TuHPzhoFz1LxTG+v6ISbATzEMmxUc5ldAd3p4zxIl1so4wml6s7EIqfM/mWkMLZf
         OcEvR4Y/cuVaIT1qLnoE9XzhaKwnPsXCRAh9+MqfG/PVsZcYGqErdnPLOyz6vOE1asul
         Qqow==
X-Gm-Message-State: AOAM5322lzKXTipabmMo0IQePfF/9wWQPkDX+KUEo+qLp1zUAWdIxXsj
        gXGwkxMmwybNvkwpGDisM0A=
X-Google-Smtp-Source: ABdhPJxiHO229Pl+V8QCp4XfHbvkFo7i8EM28vmDLDdlDs1ZDDthnKbJSwPdygfGuWiM7srCQWXV4Q==
X-Received: by 2002:a7b:c94c:: with SMTP id i12mr9960953wml.111.1630325077420;
        Mon, 30 Aug 2021 05:04:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id f18sm13184195wmc.6.2021.08.30.05.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:04:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/8] staging: r8188eu: use is_*_ether_addr() in rtw_macaddr_cfg()
Date:   Mon, 30 Aug 2021 14:04:16 +0200
Message-Id: <20210830120420.5287-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830120420.5287-1-straube.linux@gmail.com>
References: <20210830120420.5287-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_broadcast_ether_addr() and is_zero_ether_addr() in
rtw_macaddr_cfg(). The buffer is properly aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 205798b76cf9..35a548e1c92e 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1032,10 +1032,7 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 		memcpy(mac, mac_addr, ETH_ALEN);
 	}
 
-	if (((mac[0] == 0xff) && (mac[1] == 0xff) && (mac[2] == 0xff) &&
-	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
-	    ((mac[0] == 0x0) && (mac[1] == 0x0) && (mac[2] == 0x0) &&
-	     (mac[3] == 0x0) && (mac[4] == 0x0) && (mac[5] == 0x0))) {
+	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
 		mac[0] = 0x00;
 		mac[1] = 0xe0;
 		mac[2] = 0x4c;
-- 
2.33.0

