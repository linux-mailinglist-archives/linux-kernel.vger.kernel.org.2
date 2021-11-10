Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC92044C12B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhKJM0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhKJMZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:25:58 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D038C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:23:11 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id o4so2471358pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICjiJxg8C+g4r7bRxmTWtfH1V205tPAs91OzeGTMB0o=;
        b=oE7e/Ez8PuhpqUOmgY8y8n8H18d/9AOKOUA+lRKb4ECNHZoomxg+DmEt+K/QLYkefW
         oao3FjgPP2+jwvF5AvpgVyckBXTeWPGxEx6YZ/ZOtr1hRQZ9dVM3LK7O1hBTC1D1VZRi
         QCmZHjtU7+MRguqFxG+HPV4UMS3X1OatVS/ZJ571eUVP5TaJlkGWedIsZdJcwFIjwc9I
         JAuatwUpZfEkI5fO0y39i24SJgbS7gqFMKxEb+tN2R+D98ZP+dEU6fHOq4SsI6GcS+ek
         uDBf1+HVK9FW9l8gLzZ4y83rtshx7gE12a/WMcOhNUrKLiA6iYZVzO+Os8HVWWJLVvIk
         ANhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICjiJxg8C+g4r7bRxmTWtfH1V205tPAs91OzeGTMB0o=;
        b=y48LAu2z2C1WjFUBMdCqzofpy5n02alO2nN6gFGi+mCwjRehxkA43K8BYMBbtwcGnP
         axjlL7QNZPCIALFP0CumOScsrySa++nQGawF2svS0J5tnEmlsQSQOQ63BzmW/lqu35sH
         BbGKmxmQCc7k/2TJtingLajuEbK30c4+q0Kdadig/hHdZSijLM+AzqAoVnu00Bsqh5Cb
         3UDKbVISyYzYf1H+V2Du9Hgb2+52C8TjgejWXPwezJhzJ1/tMV54/mnOyTp2eiPJ2GvY
         I29aqU7+DZegjN1EQmWC1ncgIzLPWPQ7SyJItf7TPjkbRRSdOrVjrvSt/CjvQ568Q2UI
         bQqg==
X-Gm-Message-State: AOAM530PLlMAF4wNW8yHm67qBhT+9quXud81o8s7VoLArkMP3PyTFZH1
        tqLXQfE6PBFCWhbkG5LSiQ4=
X-Google-Smtp-Source: ABdhPJzWt7uGwKtCc3HoW9uZIS0hlPbteC2x/QfLAq4PWkqJYHwyIDi15xscrg/aA5e/2jox/GrRyA==
X-Received: by 2002:a05:6a00:2443:b0:44e:ec:f388 with SMTP id d3-20020a056a00244300b0044e00ecf388mr15870536pfj.7.1636546990802;
        Wed, 10 Nov 2021 04:23:10 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id fw21sm5432821pjb.25.2021.11.10.04.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 04:23:10 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] staging: r8188eu: remove unneeded variable
Date:   Wed, 10 Nov 2021 12:22:57 +0000
Message-Id: <20211110122257.151666-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck review:
./drivers/staging/r8188eu/os_dep/ioctl_linux.c: 1388: 10-13:
Unneeded variable  ret. Return 0

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 51f46696a593..8ee1d37110e1 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1385,7 +1385,7 @@ static int rtw_wx_get_essid(struct net_device *dev,
 			      struct iw_request_info *a,
 			      union iwreq_data *wrqu, char *extra)
 {
-	u32 len, ret = 0;
+	u32 len;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
@@ -1401,7 +1401,7 @@ static int rtw_wx_get_essid(struct net_device *dev,
 	wrqu->essid.length = len;
 	wrqu->essid.flags = 1;
 
-	return ret;
+	return 0;
 }
 
 static int rtw_wx_set_rate(struct net_device *dev,
-- 
2.25.1

