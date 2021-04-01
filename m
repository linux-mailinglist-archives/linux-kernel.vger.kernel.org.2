Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B112B3511E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhDAJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhDAJVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A54C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h13so1154604eds.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Yp6HUDwotT4+ERSYJIqIGZC15Onkb0fH8+gTnR3dV0=;
        b=d+rSqmUpyv6CfbbFUNvDHzY9XBiU6QEALR7xDU/RovPnvBTrLmDy7xm6NnfZj+aX/t
         B7WYEgke270X7v7e7vhjKNPd0ZyDJifGNj0Y9fppJka2hZuntAQ70tkKW0HhMEmhjZgG
         AXX9cIndUAAEHKcyY0KqC8+cRcPv5IW6c2Qa8hz+74Cby+Eh+IF065StfDUaUAcYS5n5
         1fNfKPQbzQHa2Sgj8iTkIH5U09QHUMJBfDghBZW5yZIWgtU90BS1zhUtKrDi7naE6TL+
         jiwBovLhSCB1SplMDydFTsMyevJKQ9ptpCCepBAVcj44Dxim6NL7ktyrO1rwD0fD21lF
         Km5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Yp6HUDwotT4+ERSYJIqIGZC15Onkb0fH8+gTnR3dV0=;
        b=FjWepQjI/tr2LB4PmS9SicCuYxL3dWhAFyTLbHJLUNbFl72D8aAS+9mas+GyRpJSlC
         3DDSdLl05DwNAN2BAuHCWTpAnkxWcLdAlLjRZzxxrkPVmDgS2SSgmXQUH1YybyxQQDae
         0ETvJDC7Nebxi02pqTHIwRL6bh0v3yGhSE18kzDn1hI1noeY9AwKolM3q4TLXNP+rOQx
         Eof8irvH4ckvpalVxUXUjfPAUrbhXEt6ncuQcAWczDWtIpCfNRXumJoN+Am+gPBoAPpU
         F7d4uNBGRo6yCR8FmZ/Jung6irMxZPByKfxntCKALWmAjio0KX3nI9A1gJJrM3PKJoCA
         NCNw==
X-Gm-Message-State: AOAM531cb9m/DJ284avHQHOwpTwWoK3WQlgUIVee1qZK4g01ginWW+O8
        la/M2K6QzrYfjErrt2d6tuo=
X-Google-Smtp-Source: ABdhPJwSA5rPbsSC9d7zyklLmBBFZEh9k5U4eSHZKzmHmesuGEftJMk0GhNAqK/PH7uTA2d8ShY7yg==
X-Received: by 2002:aa7:de11:: with SMTP id h17mr8542803edv.83.1617268894588;
        Thu, 01 Apr 2021 02:21:34 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id m10sm2463641ejx.10.2021.04.01.02.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:34 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 07/49] staging: rtl8723bs: make one single if statement out of two nested ones
Date:   Thu,  1 Apr 2021 11:20:37 +0200
Message-Id: <144308b944b51799960704b95959e9ae7da0e9ae.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make one single if statement out of two nested ones

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 018553984dbf..dd0b69cb9a03 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -278,11 +278,8 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 		return;
 	}
 
-	if (padapter->bDriverStopped) {
-		if (pslv < PS_STATE_S2) {
-			return;
-		}
-	}
+	if (padapter->bDriverStopped && pslv < PS_STATE_S2)
+		return;
 
 	rpwm = pslv | pwrpriv->tog;
 	/*  only when from PS_STATE S0/S1 to S2 and higher needs ACK */
-- 
2.20.1

