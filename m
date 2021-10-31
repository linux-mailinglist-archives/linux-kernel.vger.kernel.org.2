Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAA6441006
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 19:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhJaSNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 14:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhJaSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 14:12:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FE4C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 11:10:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e65so15174640pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 11:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Yly+G2tQYc5jWH+dF3AkB+ki7+SZGT9TzfTXC0w8qwA=;
        b=ejXmkOq1FXvj2pqqc9Yjib4gl0az8LlfxSR82cemZEM+YuJAoW5qKXyNdMz6Iu7Z52
         MfNbXwpI+IK3Ayl7+Ajq7TaWnMeZdbHD/B1ye24gKeWChVdLK78i+56RbyuODiDUvmPJ
         QraEJkwfBN0+U9ZVldtcJNmhEpkycYHjl4uRLIr/zZdB09esuCPoR7Tg5/fr0DCZdK8D
         0GAUR+LTlaZrLckuxfeAf9YwhUBhsDBoFPWobvSyg3Ar4z1wyy+y9QVZto7jI28kFvM3
         t+mci3umufQcPIYx5psPScufPeszDRIjsjljui5FODZQIPU5TLxLIuTo4ylJ1gq2j4md
         cYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Yly+G2tQYc5jWH+dF3AkB+ki7+SZGT9TzfTXC0w8qwA=;
        b=pRdD+qXnWsbwV07xx5ibJ/9GIhxjSNtbfdBiHrsfctd2nTpakvpeNmzU3iHrlorHFx
         tnwZlMWodED1UCgyHhYNoBMeozGV31EJzih10NBgkDjyyV35aBKWYMe1ZukqXVAvjaDi
         pitUnMjy7InagucTdc8rUiyp0SNzJ3at0kLTvjaKWmP7Ep674lqybyVKB3jQPF/BPFAW
         eAP6aLY4ESHfieLCplVbpD+28Scu98xtp/LSyVZ3Fnq37emjbwjy7h6x2soJ8sy/caSh
         NZNFiUNkfA+YvtIjSpNmZfKostmCJq3LVs3k8lDiFCA3xLSNX0fbkXhaTc3uMW7KT+ne
         fXVg==
X-Gm-Message-State: AOAM533Rdt6fhBuRlmJgOB1MUWoOXOAHCX9lp0PoxaMEmMChdtmwEvMh
        cQGJye9435SCt9Cw6SY2Agg=
X-Google-Smtp-Source: ABdhPJwmJNiy7GWDga0g/NuzWU+G5Ss3MET5W4vRInso9d2T5pvOErULeGK3kbhmsAt9LwPZfuDYPQ==
X-Received: by 2002:a63:1d58:: with SMTP id d24mr18472516pgm.316.1635703826772;
        Sun, 31 Oct 2021 11:10:26 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.84.6])
        by smtp.gmail.com with ESMTPSA id t11sm10837514pgi.73.2021.10.31.11.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 11:10:26 -0700 (PDT)
Date:   Sun, 31 Oct 2021 23:40:18 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, saurav.girepunje@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: os_dep: remove the goto statement
Message-ID: <YX7cCtVss2RWOJ/a@Sauravs-MacBook-Air.local>
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
 drivers/staging/r8188eu/os_dep/os_intfs.c | 39 +++++++----------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 1418c9c4916c..4b409479108e 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -480,48 +480,34 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 {
 	u8	ret8 = _SUCCESS;

-	if ((rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (!rtw_init_cmd_priv(&padapter->cmdpriv))
+		return _FAIL;

 	padapter->cmdpriv.padapter = padapter;

-	if ((rtw_init_evt_priv(&padapter->evtpriv)) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
-
-	if (rtw_init_mlme_priv(padapter) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (!rtw_init_evt_priv(&padapter->evtpriv) || !rtw_init_mlme_priv(padapter))
+		return _FAIL;

 	rtw_init_wifidirect_timers(padapter);
 	init_wifidirect_info(padapter, P2P_ROLE_DISABLE);
 	reset_global_wifidirect_info(padapter);

-	if (init_mlme_ext_priv(padapter) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (!init_mlme_ext_priv(padapter))
+		return _FAIL;

-	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
+	if (!_rtw_init_xmit_priv(&padapter->xmitpriv, padapter)) {
 		DBG_88E("Can't _rtw_init_xmit_priv\n");
-		ret8 = _FAIL;
-		goto exit;
+		return _FAIL;
 	}

-	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL) {
+	if (!_rtw_init_recv_priv(&padapter->recvpriv, padapter)) {
 		DBG_88E("Can't _rtw_init_recv_priv\n");
-		ret8 = _FAIL;
-		goto exit;
+		return _FAIL;
 	}

-	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL) {
+	if (!_rtw_init_sta_priv(&padapter->stapriv)) {
 		DBG_88E("Can't _rtw_init_sta_priv\n");
-		ret8 = _FAIL;
-		goto exit;
+		return _FAIL;
 	}

 	padapter->stapriv.padapter = padapter;
@@ -539,7 +525,6 @@ u8 rtw_init_drv_sw(struct adapter *padapter)

 	spin_lock_init(&padapter->br_ext_lock);

-exit:
 	return ret8;
 }

--
2.33.0

