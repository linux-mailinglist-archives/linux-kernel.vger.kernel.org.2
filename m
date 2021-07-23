Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3107D3D3802
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhGWJFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhGWJF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:05:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C5CC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:45:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a20so2780680plm.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfGDF3uxVEu2CK16/T6WliIzRL7c2dB7pkWJyLpg0nw=;
        b=BYo5Bf7lGW+EKFn81RdiFPwr46xq3jY8JZ8beejibvqEBlFHayDdp55l5Zaa3PiSCy
         rseLyb/6g1GH/bj7g+Akk4QqHOb47PFQMRKtH7LB5v15nYO8cP7bWngHvCPriBJq6PdO
         dIwyrMsXS4QrEHcEpGyP01zA7CGiIdT7QUzIeAjWywoxycJNI9REexJx147i8w3H3ub8
         On7dprLZeVUkvOVo2pXD9tQ3kKvBagQRZW0bccqsj+ftIpyRLb6Ncs0bOdJpbzETG/yW
         FO1uf+r5fJpDKxplLYr2pJVkztvlsFS14jV1N8in4X0j00VnhP2E2Yy38qYz6WaJSjrf
         ikfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfGDF3uxVEu2CK16/T6WliIzRL7c2dB7pkWJyLpg0nw=;
        b=P0q/7nKE6sUy/h1XmjfDIvchegVvkj9c9WC8AgS83irb3gF5uoMY7NoEGbqCeUpSFN
         0t3z6Nw01/tNJ7vC4LRviekJ7dxcMAmmydeN9uWTsPH1GE7ak34tNowWJnDWdcof7oGi
         nNW8V/KhdTKpczmPyP76cs/BuQ/D/NwfE4P0eceiqBmwoRL1j1diSUzzl+wnxmkcVKdX
         NGDa0aJgwmu2pJdV0LTbv5Jpy/aqqkTHWCXb2tOoKq267st/ydfOJwT2glB3TEMo7BGD
         bY1h7c5mry/IffE/ZAuYJrI4WWVhtTIPlZ8bPy6PMT02+79jXUfRsTo37RAtbRjddyzK
         RExw==
X-Gm-Message-State: AOAM530ny4gT6JheuMlMtxyCwW5zu+iwAf+EJ/wDiMBxbCyyo8CvxYPr
        Ix3dWuqXpN6S+8pLbUAAWWo=
X-Google-Smtp-Source: ABdhPJwKB+9hf7uTGd/AXV++CixDQBYO/uEV3OiauvR67rJcKIGNogdhXncl+HYbDsCYlogJaxW0qg==
X-Received: by 2002:a65:6118:: with SMTP id z24mr4016232pgu.325.1627033558809;
        Fri, 23 Jul 2021 02:45:58 -0700 (PDT)
Received: from localhost.localdomain ([103.238.106.236])
        by smtp.gmail.com with ESMTPSA id r128sm5178461pfc.155.2021.07.23.02.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:45:57 -0700 (PDT)
From:   Jignesh Patel <jigs0101@gmail.com>
Cc:     jigs0101@gmail.com, Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Paul McQuade <paulmcquad@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: Line over 100 characters
Date:   Fri, 23 Jul 2021 15:15:16 +0530
Message-Id: <20210723094524.8811-1-jigs0101@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break lines into multiple lines to respect 100 character width limit.
Reported by checkpatch.pl

Signed-off-by: Jignesh Patel <jigs0101@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index b817aa8b9de4..a6e756720214 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -254,9 +254,12 @@ void expire_timeout_chk(struct adapter *padapter)
 			updated = ap_free_sta(padapter, psta, true,
 					      WLAN_REASON_DEAUTH_LEAVING);
 		} else {
-			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
+			/* TODO: Aging mechanism to digest frames in
+			 * sleep_q to avoid running out of xmitframe
+			 */
 			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
-			    padapter->xmitpriv.free_xmitframe_cnt < (NR_XMITFRAME / pstapriv->asoc_list_cnt / 2))
+			    padapter->xmitpriv.free_xmitframe_cnt <
+			    (NR_XMITFRAME / pstapriv->asoc_list_cnt / 2))
 				wakeup_sta_to_xmit(padapter, psta);
 		}
 	}
-- 
2.25.1

