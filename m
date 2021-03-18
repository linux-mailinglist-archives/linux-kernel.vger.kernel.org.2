Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552413408E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhCRP1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhCRP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:27:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70860C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so3453481wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSkk9Yd2ayS87h/bRiWToyBS4V09sFZorEnhiQpsGRc=;
        b=Grk8droE1GZjSXxCNuGL6Xo+lCutqeR1djAql5Z7DtzoHIRq+/T/M7X4KIM/IUC6Hx
         GaZZoMe8f4BVavyBArjGy01FRAPoGqtQ5/fAeAxnB+ED1yPEu6D/12uqaMhWnYO11Ugt
         j6lYFEE9mNx8bU/SDF8vZQ4rfuM1unc4BWf9hGYjstTyFb9YFLkQyToQTmeGwi+U6roj
         DHbFg85RO8tQws4hkzPTk2doXg+PC4MnTR3e3JznhUWRFpH2Z4ZmkMXbP0zBYBkpNkDZ
         IZ5nGpm8Quomb7f1RSxkPE0bQm3Il7fOmwueSsL65gToqlDnd7b0owqGjS+6g78tGTbM
         bPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSkk9Yd2ayS87h/bRiWToyBS4V09sFZorEnhiQpsGRc=;
        b=cc+fzBTPA4ZTnWBOL9Sw4K3bEBPiNv7xJtQvczQjRUrQGKrZzJhZg9Uy+tREGhPWgg
         PWy6e3BQM2o666p3fWrr7psh2B/0kpd6Foiv+/3NNnzEobo7oMRMJEBqT2aJ5Y/pt8Hj
         g8xvGPGeV8COKuIx/hC2VefSFk9MySMs7gYw1YBG5Uo16NGz7UpU5QvVGAt6VNMXVNGb
         pHShh1ddZCjR7tk4LFu4qmGqkM9IxNO07aGN5qnQp+qYOHlYg8jQn/Ar7Uao2n8KaIhj
         wlJj8fUAT5QSNQqnsDurc8qNSYjJn5zORxD/rDnnzsOz5uJC/3WwQ8BpKt4t6ep4Blbs
         Xk1w==
X-Gm-Message-State: AOAM533KkoSsYLLNlcq/s3GkgZm1A8tHJxi9JHsmqeOYzGl1GnLHiGoj
        eL9hcKXifKY6a1qWmw5W784=
X-Google-Smtp-Source: ABdhPJz1Q820o1C9Pj4vK3uFfR0PIWMJMJ7oCtDWXXc8yaKCX2B+Wz576xCvzUnCHJVYT4hUPgUqww==
X-Received: by 2002:a7b:c214:: with SMTP id x20mr4216172wmi.186.1616081238268;
        Thu, 18 Mar 2021 08:27:18 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id c16sm4180431wrs.81.2021.03.18.08.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:27:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 14/15] staging: rtl8723bs: remove unnecessary logging in os_dep/os_intfs.c
Date:   Thu, 18 Mar 2021 16:26:09 +0100
Message-Id: <20210318152610.16758-15-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
977: FILE: drivers/staging/rtl8723bs/os_dep/os_intfs.c:977:
+	DBG_871X("===> %s.........\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1030: FILE: drivers/staging/rtl8723bs/os_dep/os_intfs.c:1030:
+	DBG_871X("====> %s...\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1127: FILE: drivers/staging/rtl8723bs/os_dep/os_intfs.c:1127:
+		DBG_871X("===> %s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1177: FILE: drivers/staging/rtl8723bs/os_dep/os_intfs.c:1177:
+		DBG_871X("<=== %s\n", __func__);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 3909f149de47..93d696d5cf19 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -974,9 +974,6 @@ static int  ips_netdrv_open(struct adapter *padapter)
 
 	padapter->net_closed = false;
 
-	DBG_871X("===> %s.........\n", __func__);
-
-
 	padapter->bDriverStopped = false;
 	padapter->bCardDisableWOHSM = false;
 	/* padapter->bup = true; */
@@ -1027,8 +1024,6 @@ void rtw_ips_pwr_down(struct adapter *padapter)
 
 void rtw_ips_dev_unload(struct adapter *padapter)
 {
-	DBG_871X("====> %s...\n", __func__);
-
 
 	if (!padapter->bSurpriseRemoved)
 		rtw_hal_deinit(padapter);
@@ -1124,7 +1119,6 @@ void rtw_dev_unload(struct adapter *padapter)
 	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("+%s\n", __func__));
 
 	if (padapter->bup) {
-		DBG_871X("===> %s\n", __func__);
 
 		padapter->bDriverStopped = true;
 		if (padapter->xmitpriv.ack_tx)
@@ -1174,7 +1168,6 @@ void rtw_dev_unload(struct adapter *padapter)
 
 		padapter->bup = false;
 
-		DBG_871X("<=== %s\n", __func__);
 	} else {
 		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("%s: bup ==false\n", __func__));
 		DBG_871X("%s: bup ==false\n", __func__);
-- 
2.20.1

