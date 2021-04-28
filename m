Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E317836DEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243379AbhD1R4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243370AbhD1R4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:56:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F87C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:55:29 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q2so12315816pfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=EOlR2LB50FEmXOIlb44UF+AW0LxIYM4DBDtW/EDmbM4=;
        b=UsmH3lJn+uVfWZiEIV0TIdAUxseTWvlwBFpLL2BwHQ1/GsavFQseePn0nZrQqS4277
         xyfqvnLp9srT9Vb5O+1a3ZNC415j4NZaqW63A7nNy+1E7nKqEUx0M+/4nyRd3nRE8N/T
         7hX0yRYnBIIudzCxaLsdyM7OAGSJvbkN8cbWUHrZ2HbXMkhxnxMkXiefJAupFRk1csy4
         rgmr25F07/ranBJOjSTqH0BcPTlpbZOJ4DbwWZeE5rr0o9r4jN6ttu7xOIRPEqZt4u9J
         YnrfnElG10KQibLawwRgHlT4Fu8izjuvEmIpmH5LtaTAaNssfbFeolYhEhhOnG99iVwE
         tr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EOlR2LB50FEmXOIlb44UF+AW0LxIYM4DBDtW/EDmbM4=;
        b=nEHyVOkRqC5T+cIe7L53lJ8zh1vOO3Hte4X6+EMXtk4wGWZv2AbBybfuaPXwvLzFth
         rT4jE94Q0vPNHlwYGuOAOC2ltSiOQpbi9ByzhJYqaofe0elJ7GR53v3XKzJGg5qGPyfS
         7n6Bby9aed9xv/KAILJsalFVMJCsRPBDEUhe9EV/2MsTfLp/nTPVDKXwiJV55A14mZbS
         LHZ3C62VcPWvKjIQ9bOcOBTpAFg/gndx0fjYDdK3qYmQXJQVXHHPBzhnsbyZi0CulJh6
         oyLmPoKC1OCYGXH1z5XVex790o6655j8PuHjbEfd0cH83yJ2NEDLquIxVsTQWRcUm8jU
         EULg==
X-Gm-Message-State: AOAM532evGwOVYEPvsUpWK6DC9KG2zJhC2gQLtjkq35q1B0vePKDvvBx
        U9f/Z3rve8ACKA2BX+6C1lY=
X-Google-Smtp-Source: ABdhPJwOTdy/HQ6OjYlOdx8j35mKQEpMtqo1lvVwZ/Hh6rXjztHurrAJfAG3Hrhl5Zpcceh3L2iuuQ==
X-Received: by 2002:a62:be16:0:b029:25a:e1b4:5deb with SMTP id l22-20020a62be160000b029025ae1b45debmr28574499pff.66.1619632529191;
        Wed, 28 Apr 2021 10:55:29 -0700 (PDT)
Received: from user ([2001:4490:4409:14a:3c1e:9a4c:c5d6:1dec])
        by smtp.gmail.com with ESMTPSA id gn24sm190185pjb.13.2021.04.28.10.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:55:28 -0700 (PDT)
Date:   Wed, 28 Apr 2021 23:25:20 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        fabioaiuto83@gmail.com, dan.carpenter@oracle.com,
        saurav.girepunje@gmail.com, john.oldman@polehill.co.uk,
        ross.schm.dev@gmail.com, insafonov@gmail.com,
        hello@bryanbrattlof.com, hdegoede@redhat.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: Change the return type
Message-ID: <20210428175520.GA8921@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ret variable in rtw_suspend_common() and change
the return type from int to void as rtw_suspend_common()
always return zero unconditionally.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/include/osdep_intf.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c    | 5 ++---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c   | 4 +++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_intf.h b/drivers/staging/rtl8723bs/include/osdep_intf.h
index 48c90f00cc2e..111e0179712a 100644
--- a/drivers/staging/rtl8723bs/include/osdep_intf.h
+++ b/drivers/staging/rtl8723bs/include/osdep_intf.h
@@ -66,7 +66,7 @@ void rtw_ips_pwr_down(struct adapter *padapter);
 int rtw_drv_register_netdev(struct adapter *padapter);
 void rtw_ndev_destructor(struct net_device *ndev);
 
-int rtw_suspend_common(struct adapter *padapter);
+void rtw_suspend_common(struct adapter *padapter);
 int rtw_resume_common(struct adapter *padapter);
 
 int netdev_open(struct net_device *pnetdev);
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 1f34cb2e367c..724909078d80 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1146,14 +1146,13 @@ static void rtw_suspend_normal(struct adapter *padapter)
 		padapter->intf_deinit(adapter_to_dvobj(padapter));
 }
 
-int rtw_suspend_common(struct adapter *padapter)
+void rtw_suspend_common(struct adapter *padapter)
 {
 	struct dvobj_priv *psdpriv = padapter->dvobj;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 	struct pwrctrl_priv *pwrpriv = dvobj_to_pwrctl(psdpriv);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	int ret = 0;
 	unsigned long start_time = jiffies;
 
 	DBG_871X_LEVEL(_drv_always_, " suspend start\n");
@@ -1196,7 +1195,7 @@ int rtw_suspend_common(struct adapter *padapter)
 
 exit:
 
-	return ret;
+	return;
 }
 
 static int rtw_resume_process_normal(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index a9a9631dd23c..84c16925c4f5 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -452,7 +452,9 @@ static int rtw_sdio_suspend(struct device *dev)
 		return 0;
 	}
 
-	return rtw_suspend_common(padapter);
+	rtw_suspend_common(padapter);
+
+	return 0;
 }
 
 static int rtw_resume_process(struct adapter *padapter)
-- 
2.25.1

