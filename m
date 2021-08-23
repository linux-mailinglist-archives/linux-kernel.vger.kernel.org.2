Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0973F4C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhHWOMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhHWOMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:12:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D205CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:12:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bt14so37379588ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQf0tXwdGDJ9ytbZatMzcHhknhsJ90N1NisHqNGGGOk=;
        b=jG8dBbc9aVT+q+Secokwq/et2WnxfcUfIwIAGzxxO03Oorl1BflqVdmpI5jhPh2wdz
         b+cxMtD1gEIG27Rci4CsrQs27fN9RRMtZHH2UOuLAuycI35vH1/n9RzHc4ae10GBFmEC
         KoVOVHosEGrRsT6ZEL/0jEUrsR5FCi0lRvugga+6OwEaC+sCNScA5R0mqDACuoyeCmVF
         AD9CePiuu0FPzePakassg2Xdc38Kj5tNz/H4AcPWWa/pgRDT0bvUBu1e7VIEv/Uj+4HH
         xOpYWlNNhbXFwJrYEiStnQfkasA5RBul36f/I5ESV95j+dquUmg18ufniRP80upaa9TN
         Tc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQf0tXwdGDJ9ytbZatMzcHhknhsJ90N1NisHqNGGGOk=;
        b=gru1JW0xA6gxVtLwhNAy0HFJODJBMHtxPXjJDZ9vH/oh3h1Wl2g5//YafuMMvbiHxL
         QjztEyEchfO7OkfdQ6o6SFqbz/p7MyZNoqNauB9U1qvcH111H/wA5CsxgyndyRCIdFgD
         fQdWPicJcsXsXt2BGVGbO6KGhfmX4tpyjCb4z4FjrHmeqimpoLTblzv5mPg534ot80TF
         LCP4iLtoZWiUsK5XT1OxzEc6Kz2H6PYgF/a2UT2FmL7ljs1h8iSs9C8mIRR4DD2M2/+r
         YC8On4UVjYgAvyOGraxpYNM9IYXheXs7EUospQHpkVipgwnskRN5jWL0vDsJPIxW9x4X
         7p6A==
X-Gm-Message-State: AOAM531INvfjZf+wSDZCcbD3MiIhGiP9NMIcittCi7XKsTn8BzPdymdy
        7jhMPsUPA98m2Hs+Ej208n8tmXn7IPM=
X-Google-Smtp-Source: ABdhPJygAyUKChQyBPQotOeMgOB0p7p6MqSUXCITAqUU25CrY60veUNgzg4WpdEactbSEAWGCZ4dKw==
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr36353720ejw.92.1629727929271;
        Mon, 23 Aug 2021 07:12:09 -0700 (PDT)
Received: from agape ([5.171.81.132])
        by smtp.gmail.com with ESMTPSA id g16sm7465876ejw.74.2021.08.23.07.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 07:12:09 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: rtl8723bs: fix code indent issues
Date:   Mon, 23 Aug 2021 16:12:00 +0200
Message-Id: <aa394052c8d81b4a00356adf5f98fc3c81f8b1d9.1629727333.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1629727333.git.fabioaiuto83@gmail.com>
References: <cover.1629727333.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post commit hook checkpatch issues:

ERROR: code indent should use tabs where possible
2463: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:388:
+        if (padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_$

ERROR: code indent should use tabs where possible
2464: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:389:
+                || padapter->securitypriv.dot11PrivacyAlgrthm
			== _TKIP_WTMIC_$

ERROR: code indent should use tabs where possible
2465: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:390:
+                || padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)$

ERROR: code indent should use tabs where possible
2466: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:391:
+                /* WPS open need to enable multicast */$

ERROR: code indent should use tabs where possible
2467: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:392:
+                /*  check_fwstate(&padapter->mlmepriv,
			WIFI_UNDER_WPS) == true) */$

ERROR: code indent should use tabs where possible
2468: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:393:
+                rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM,
					null_addr);$

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 790e3b2454e8..5067c2417351 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -385,12 +385,12 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 	}
 
 	/* TKIP and AES disallow multicast packets until installing group key */
-        if (padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_
-                || padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_WTMIC_
-                || padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
-                /* WPS open need to enable multicast */
-                /*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
-                rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
+	if (padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_
+		|| padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_WTMIC_
+		|| padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
+		/* WPS open need to enable multicast */
+		/*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
+		rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
 
 exit:
 
-- 
2.20.1

