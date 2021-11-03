Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C84444EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhKCPvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhKCPv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:51:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F281DC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 08:48:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so1692471pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ead3RuHhckCl8EBMptNp8b8Ud4MyZajfflH02ACD9D4=;
        b=ROQd/5bUfimi8Aot2GdoDUDuuj/mtOzydB6RRRK1IkpZEu9AOK1A9yeex5CAMRlZ/A
         8ciq+FbzsGu7m2iPs/qy29rf+PvFXmRRzly4yXbVcp4RnXioCQ2zvwMLF7yJzSxdbVBb
         yUfhuZQmnhoa1meeQrpIK+MsuAILefO7Xjy0dkKeS79pMM2rSyEp/lmkmr90DIVyCvLS
         QzHdlt6UVhgAslH4g5Z2yal4sFi4gpS17x/zjzoLJsrv2uRjpEAqimNmBAJL4sRDZTsU
         cYPltAd6rETtJ4CJveVyiUd175v/QbtSgdkFX1yvoxzYfSG8LRj3hGMj7Ntx0cpVcZB2
         OeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ead3RuHhckCl8EBMptNp8b8Ud4MyZajfflH02ACD9D4=;
        b=uurUBmBDmmnuOy6P253fFJfpWAnMx2PJeklHZfbAzGZThoXacqExgnKgbl5OaH5spo
         NmI7RsaxIG6AA20EmgS5jJffPttw4ftbMiKBH4rSfsLPOk1l2kgd++JWwhScP+6e5Jw+
         NGOxJul339EExtm9xfiG5Ms1LH+nxrNP4GHvyNURIhesL+bx6WFHM4aXCGr1iQgpgVSa
         RLnYEIYeWTPwvcYpDSugqmPI1ECv1rTs/Gn1UcOL6ldD3o9wVM7RgyS+ZLwKRvaWa45R
         cikFPLTnc2jAFk4YmqZTa8lIrj4AnC06KU0q1lecn4GlFtIARz66EtcRL4saxtKGfh8Z
         selA==
X-Gm-Message-State: AOAM531cK8D5Hmk3bHSqPiSaPUjE4HEsHWJwAGbNspXyHwUR+jM2Tdsp
        YCtGNfQ4gWYK83Ygs4Owdh4=
X-Google-Smtp-Source: ABdhPJzQ5LnjtrL2CxxPTBAjDQznKcuPjQPjHfMRkxbqEOaZ/hm+Co2UT8alMF5lXcmWyPkkfKJiAw==
X-Received: by 2002:a17:903:2348:b0:141:d60b:ee90 with SMTP id c8-20020a170903234800b00141d60bee90mr23950290plh.15.1635954529339;
        Wed, 03 Nov 2021 08:48:49 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.85.116])
        by smtp.gmail.com with ESMTPSA id d19sm2220235pgk.81.2021.11.03.08.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 08:48:48 -0700 (PDT)
Date:   Wed, 3 Nov 2021 21:18:41 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, saurav.girepunje@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH v2] staging: r8188eu: os_dep: remove the goto statement
Message-ID: <YYKvWeyqd71pYSqM@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the goto statement from rtw_init_drv_sw(). In this function goto
can be replace by return statement. As on goto label exit, function
only return it is not performing any cleanup. Avoiding goto will
improve the function readability.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---

ChangelogV2:

	-On V1 combined the if condition check for functions as below

	 if (!rtw_init_evt_priv(&padapter->evtpriv) || !rtw_init_mlme_priv(padapter))
		return _FAIL;
	reverting these changes and keeping them as-is. It will make more clear on
	individual function call if something need to handle for error case.

ChangelogV1:

	-Remove the goto statement from rtw_init_drv_sw(). In this function goto
	 can be replace by return statement. As on goto label exit, function
	 only return it is not performing any cleanup. Avoiding goto will
	 improve the function readability.

 drivers/staging/r8188eu/os_dep/os_intfs.c | 34 ++++++++---------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 1418c9c4916c..ec96e837ab88 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -480,48 +480,37 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 {
 	u8	ret8 = _SUCCESS;

-	if ((rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if ((rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL)
+		return _FAIL;

 	padapter->cmdpriv.padapter = padapter;

-	if ((rtw_init_evt_priv(&padapter->evtpriv)) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if ((rtw_init_evt_priv(&padapter->evtpriv)) == _FAIL)
+		return _FAIL;

-	if (rtw_init_mlme_priv(padapter) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (rtw_init_mlme_priv(padapter) == _FAIL)
+		return _FAIL;

 	rtw_init_wifidirect_timers(padapter);
 	init_wifidirect_info(padapter, P2P_ROLE_DISABLE);
 	reset_global_wifidirect_info(padapter);

-	if (init_mlme_ext_priv(padapter) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (init_mlme_ext_priv(padapter) == _FAIL)
+		return _FAIL;

 	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
 		DBG_88E("Can't _rtw_init_xmit_priv\n");
-		ret8 = _FAIL;
-		goto exit;
+		return _FAIL;
 	}

 	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL) {
 		DBG_88E("Can't _rtw_init_recv_priv\n");
-		ret8 = _FAIL;
-		goto exit;
+		return _FAIL;
 	}

 	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL) {
 		DBG_88E("Can't _rtw_init_sta_priv\n");
-		ret8 = _FAIL;
-		goto exit;
+		return _FAIL;
 	}

 	padapter->stapriv.padapter = padapter;
@@ -539,7 +528,6 @@ u8 rtw_init_drv_sw(struct adapter *padapter)

 	spin_lock_init(&padapter->br_ext_lock);

-exit:
 	return ret8;
 }

--
2.33.0

