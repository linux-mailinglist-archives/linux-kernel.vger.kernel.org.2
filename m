Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ED339CCFB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 06:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFFEir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 00:38:47 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:46715 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhFFEip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 00:38:45 -0400
Received: by mail-ej1-f48.google.com with SMTP id he7so1512479ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 21:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pH4GInW10Hp6KLNIVq0KGQtBtOWx4rjYfaOWwD1TPj8=;
        b=JAmH389YkyoK3omVOjdghXx2vEVJ5SB1b0N+laj5qfyMMoyT1ZJ0CbrBeU3M/Jsmqt
         Y3aHEzQ/7M9Dq7GZxiXpx9DEUxlWljK1W5XLBOQGw21yeVh+/+Ij91Hd9kYpWheq/3Sd
         2q7VzLpP1bPnaluClbNj1n/pLVjuTApLOkJ+1s3Z6Swjg8vZfUmGdiBN9jJOzb6B/1Sy
         SmgZImdGHdsgaWwyC21cmy7wOCso7F1456UDui83GgyBGh4w0liGpqHczag23NoOCOEp
         6jRjvkozeDx3DWdnwPEpRZ0iBx2oOf6vd3qC9Wh03Pe1yFYHa07npv0OoLv7ME34l87U
         iEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pH4GInW10Hp6KLNIVq0KGQtBtOWx4rjYfaOWwD1TPj8=;
        b=KU0+VJ5E3etcfuNir1L4Vu0BSFR0P6LZYqXLGftMQgekmhWAfdTB9pPK2ORGPvZFrQ
         qEXwmG5IEGfVuBfT0VD6H/HjGzLfXrDi6e5maBNq/1VV8X9qEO5Hf+J8KmvT6jLnQQxv
         LQyTUe44Szxn4rAtAAzlG7U5drUGghX4tp+gT7QBCcrTagrxWt9GV8tcgUbaNN4ItDz4
         O0BSSbc0UCHuc4rcAMkL9n7wQxX2pp3721YWcCEiBxV8RKyljWpeo81pQ3bdg0BERruG
         iiyzZe882iBhMAvqtIWDdXZryep4r99SOVkIs5b6QFp9XDY7FHD7JQuKty8fFvl0RLbe
         E9LA==
X-Gm-Message-State: AOAM530iL/3lnQhYMHnTWIm5Te99XhDc1axNNWLPQi4xYr6/pUKrJgtH
        hWSzNwoEuAMTm5tdKEayLPE=
X-Google-Smtp-Source: ABdhPJzjlT4dgF1ikXObsEfQy8kJolnGFce1z0v5cHwuJUWzEzvOyuflbmfpSXADmUYyO9lVWpxNHQ==
X-Received: by 2002:a17:906:6d45:: with SMTP id a5mr12199536ejt.399.1622954155836;
        Sat, 05 Jun 2021 21:35:55 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id y14sm4826420ejq.102.2021.06.05.21.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 21:35:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rtl8723bs: os_dep: Remove conditions with no effects
Date:   Sun,  6 Jun 2021 06:35:52 +0200
Message-Id: <20210606043552.31785-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed conditions with no effects. Detected by Coccinelle.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 213ec5b4ce98..2035573ee5a0 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1187,10 +1187,7 @@ void rtw_suspend_common(struct adapter *padapter)
 
 	rtw_ps_deny_cancel(padapter, PS_DENY_SUSPEND);
 
-	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
-		rtw_suspend_normal(padapter);
-	else
-		rtw_suspend_normal(padapter);
+	rtw_suspend_normal(padapter);
 
 	netdev_dbg(padapter->pnetdev, "rtw suspend success in %d ms\n",
 		   jiffies_to_msecs(jiffies - start_time));
@@ -1268,11 +1265,7 @@ int rtw_resume_common(struct adapter *padapter)
 
 	netdev_dbg(padapter->pnetdev, "resume start\n");
 
-	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
-		rtw_resume_process_normal(padapter);
-	} else {
-		rtw_resume_process_normal(padapter);
-	}
+	rtw_resume_process_normal(padapter);
 
 	hal_btcoex_SuspendNotify(padapter, 0);
 
-- 
2.31.1

