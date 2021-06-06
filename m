Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99D39CDEA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 09:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFFHpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 03:45:13 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:33645 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFHpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 03:45:10 -0400
Received: by mail-ej1-f42.google.com with SMTP id g20so21389769ejt.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEkqcK+ZsCfx0RKoS5sCh6znx6o98CrrxGkDXKRKUsg=;
        b=H8mSCiPt+rS5B5BvuBtl7dA6LWtO3csDe0YNYRKWYxTr0ervMpKkkZYsW4KCLFJ0/+
         1XQ+5LhuocKbptJrS1hhqm6GTr9vnZnjnedSRBNtg95k5qdlelAv5rAIEXHFgYsy0H11
         nbtO4DMfgQOMGSIKjwo4IF3UPY/VvVAPjrEK7WMnFK3C4aD1qhZkFKXDFUW+zD4BKhae
         320p4HTfVU8PN48ZmK4RcKp9Oa+c0M9Ch1VKI9/95VoQzs3mz1iRwOMJmGl8iIs66TrH
         F6S3NPo4JZu2HWPJc2dHOaSG+MRd5QepOwTW1HHpXccWJKVkdB2Qzic2jDZc7FIAt26W
         qAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEkqcK+ZsCfx0RKoS5sCh6znx6o98CrrxGkDXKRKUsg=;
        b=gUQbJDRVt1ua8pUmEWqP1HweP7+YKOcnSsiUmMQO1Mp+Iou9b3hB5K9e4avKKk1GjG
         cESDkMis4vZBi0l7owHO/5/k9HrwtJxOiyBTfnYSRzS4aVgIi4wG9WZzLasabT20aL3l
         vqnK+Xe9E7AAkANfW+QWNlp1Bmbtp55hW+03vQNY1B8SB1ivMwc/j/adljYnWIVOnqcD
         PUQRUEnXaTcSDOsgWs+qaans4eCW4AOXgDa8/5Nf+fWlCHfrbjJjr5QI5Gs7pXR+B3o1
         wiDfRh4AVBISMLREYlG9nQtvACDkVyAti3n6NCwXQS/Ai7JLx661lIKLT94jddTnUPaC
         Y8hg==
X-Gm-Message-State: AOAM530wn7bpNh8Ps2g4Vkw/YEKN7dVUfqgZfaa3Q/I6cW/qjlT8f3ft
        qTTdKLTJGoNbgZZ7RdJC2KQ=
X-Google-Smtp-Source: ABdhPJw40SprLvulNts0awtG+9BgtWsDCMxmdQDudQ7JpKGhHpkH7YKAyNGgeio/iUWcuwlR9jGqig==
X-Received: by 2002:a17:906:86d2:: with SMTP id j18mr12202709ejy.180.1622965340965;
        Sun, 06 Jun 2021 00:42:20 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id i15sm5108804ejk.30.2021.06.06.00.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 00:42:20 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: os_dep: Remove conditions with no effects
Date:   Sun,  6 Jun 2021 09:42:16 +0200
Message-Id: <20210606074216.26495-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed conditions with no effects. Detected by Coccinelle.
It seems that these conditions with no effects had been inadvertently
left while deleting code that had to be conditionally compiled by 
unused definition CONFIG_AP_WOWLAN (see commit dc365d2cc579).

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1 -> v2: Rewrote the changelog according to suggestion by 
Joe Perches <joe@perches.com>

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

