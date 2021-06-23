Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE793B2415
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFWXvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFWXva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:51:30 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BE9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:11 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g12so3525076qtb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i500zeynpOj9f3DeDL5kN9xvrj7e0uG6xsJdS1T9Uuk=;
        b=S4saWzjSSFr5O2/0eXJXG5sM89IjLY6X3vVjrAi4sihkjOEOnfTAuY4Ly/St3lRAgs
         NJMLJ3qRiPza0B7KY5dFAI9DoVngj8DegDFjhYtI/u+88+cOuuK8H2c5PpjBIsyPJ7tB
         Urln4G5NslePgIxKK5rmeT0qm2HGHu/ZykYfasfWOQ7BITfOOUd22LCpXqEWSBfBsW/x
         juWiCMUKyaJaEy/euQ09IqONPrTdDMYnkM7iXjjO27ScxjQZIEfTGN4XVRNMbq2tacqy
         JVFzS/lED2x7PsKRuL5HdNnbn6sSzlj3yTJxUAHswEetjClrB5EChfEfARiTVaaxmCJ5
         nsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i500zeynpOj9f3DeDL5kN9xvrj7e0uG6xsJdS1T9Uuk=;
        b=t0owUWqjrmaM5svXTHrJel3ktrE18MW2V0Wr6hzwwM2XPWv5q3oQJVeuLCbEaaUMT0
         0hWMrvV/ZrvuRs2TsJqb/VnOpFE8qYB3t4xgpHNSsILgK8BneYmuLjr/u5+Tk6C4jjc3
         NXuVSBg9IxmofqyEsi6FSP+AuJvGi2dIkYOXbJiMzAeZjH+/3ScMHQ+0QyfVzT/Pw9TI
         HsbPggHMHOGbhs5eW/OSiHzYnjE2vlxEALRZPfaaxY9oLTRfcakAtnCVfmac+d9nbr0h
         1A0ZFOkFNRpqBFm7UuTruq769yp2/VgKESECUfhdI9Z8LBUVYju4KwZrVqTOTF0R/wMQ
         4ipA==
X-Gm-Message-State: AOAM5334LqgZQVAPdmcdLRA8xhZAtNSgO7monrBvZT9PbbYxtUClGwiv
        JrtItS3ndzU6rFE/7oJBltsggg==
X-Google-Smtp-Source: ABdhPJxxFJuYWMg55b6m5Mo9jGyCmLOyqUAmKbvEpw3HpnJY0gaw5kIex4nUCgNEvubiobmdvHDzVg==
X-Received: by 2002:ac8:44cb:: with SMTP id b11mr2329838qto.170.1624492150853;
        Wed, 23 Jun 2021 16:49:10 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id w2sm992387qto.50.2021.06.23.16.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 16:49:10 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 3/9] staging: rtl8188eu: remove all DBG_88E_LEVEL calls from core/rtw_ioctl_set.c
Date:   Thu, 24 Jun 2021 00:48:56 +0100
Message-Id: <20210623234902.7411-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623234902.7411-1-phil@philpotter.co.uk>
References: <20210623234902.7411-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E_LEVEL calls from core/rtw_ioctl_set.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index c8b8346adbee..adf772e7bac0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -131,8 +131,6 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 	u32 cur_time = 0;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	DBG_88E_LEVEL(_drv_info_, "set bssid:%pM\n", bssid);
-
 	if ((bssid[0] == 0x00 && bssid[1] == 0x00 && bssid[2] == 0x00 &&
 	     bssid[3] == 0x00 && bssid[4] == 0x00 && bssid[5] == 0x00) ||
 	    (bssid[0] == 0xFF && bssid[1] == 0xFF && bssid[2] == 0xFF &&
@@ -214,9 +212,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_network *pnetwork = &pmlmepriv->cur_network;
 
-	DBG_88E_LEVEL(_drv_info_, "set ssid [%s] fw_state=0x%08x\n",
-		      ssid->ssid, get_fwstate(pmlmepriv));
-
 	if (!padapter->hw_init_completed) {
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
 			 ("set_ssid: hw_init_completed == false =>exit!!!\n"));
-- 
2.31.1

