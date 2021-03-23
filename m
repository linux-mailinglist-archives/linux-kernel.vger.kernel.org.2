Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B7345EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhCWM7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbhCWM61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:58:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988A7C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u9so26928735ejj.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nme5ONpWtFP36oE58brk0se7hmjfl2KeXVc77HwtpBc=;
        b=BJVznlmWnFQoPqAdaF2BIiTsgoYEVQzFfl+cvSJ2+dPpPE6NH9IU3zIXTE9nCXWxsI
         xtiayIxOrdEbx3mUISvfEn+XOgiRETbmOi2fQpjz2vZrCHZu60DcA2rgoZMkpHlbm55e
         B9kx9bX4CvrIojbOETn7d6BwOL89ioM7fMKB5uINpV0tY1dN58k9NocyRiiUq/BaeuHB
         s+XkKnVoq7el9OqY+yfztGnTyjNkiwjt21etwMPOjd/KigUeV2xuWU/2unCbSiqBAhea
         k7VdDhXNsX3iXBLa7RCiFmpURrT9m39HaIrxasS6FzRRju+WP0pBO4nhdOXeJPbsAMRZ
         Y4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nme5ONpWtFP36oE58brk0se7hmjfl2KeXVc77HwtpBc=;
        b=bf1fiRkUsm8a4qDAWOYgE6T69bxUvo6YRYenUGHXHna7wlAmbABmNvqeqC/COma3Iv
         tpnJo7PlExb55y7vWRb9g+2zHMz7Yj4uGMIrzlBTvCf1cT4oZ9+/73CHOhirkQkjR47J
         GbsGACdE+7ExnE0SxZHchmy4205AZpryKsHFnxFPXUJ3rCddQc/rK8+dekvDEBfyz9fU
         7+NEjdOIU4b7YRXozgcH1kJWhaUuBd2V5OgCq4WDUjNtdCC3V2zAffgi20INgv8crM1z
         s9aNaLTkJL863Mwg97XQCdI9iqRczdSpQq076unEo7GUNDpA7HESCL/1C8bi62aMiAwt
         Sx8g==
X-Gm-Message-State: AOAM531iy4ZX/9UqeZKxfhZZoUxil+JSxybQNl4YCsfmfYJ0SqXOISrF
        P75HI+wJGD3KaMxFWOZjTe4=
X-Google-Smtp-Source: ABdhPJx2xa6D9VkLp9eb745fYzZCRpk/mVl/e4fEOi4s9cNCyyi/cCbiBRQK8uhCWIZgW68cMq49xQ==
X-Received: by 2002:a17:906:d790:: with SMTP id pj16mr4700201ejb.255.1616504305424;
        Tue, 23 Mar 2021 05:58:25 -0700 (PDT)
Received: from agape ([151.57.211.10])
        by smtp.gmail.com with ESMTPSA id 90sm13191751edf.31.2021.03.23.05.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:58:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 6/9] staging: rtl8723bs: move function prototypes out of os_dep/int_fs.c
Date:   Tue, 23 Mar 2021 13:56:33 +0100
Message-Id: <4604b856b9c20f1141e19894f46934cb860eebd4.1616503354.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616503354.git.fabioaiuto83@gmail.com>
References: <cover.1616503354.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issues:

WARNING: externs should be avoided in .c files
196: FILE: drivers/staging/rtl8723bs/os_dep/os_intfs.c:196:
+int _netdev_open(struct net_device *pnetdev);
--
WARNING: externs should be avoided in .c files
197: FILE: drivers/staging/rtl8723bs/os_dep/os_intfs.c:197:
+int netdev_open(struct net_device *pnetdev);

moved function prototype in include/osdep_intf.h
removed function prototype and made a static
removed unnecessary extern declaration in os_dep/ioctl_cfg80211.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/osdep_intf.h    | 2 ++
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 --
 drivers/staging/rtl8723bs/os_dep/os_intfs.c       | 4 +---
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_intf.h b/drivers/staging/rtl8723bs/include/osdep_intf.h
index 5ad85416c598..48c90f00cc2e 100644
--- a/drivers/staging/rtl8723bs/include/osdep_intf.h
+++ b/drivers/staging/rtl8723bs/include/osdep_intf.h
@@ -69,4 +69,6 @@ void rtw_ndev_destructor(struct net_device *ndev);
 int rtw_suspend_common(struct adapter *padapter);
 int rtw_resume_common(struct adapter *padapter);
 
+int netdev_open(struct net_device *pnetdev);
+
 #endif	/* _OSDEP_INTF_H_ */
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index a577ddcce8cd..03a784558d79 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1259,8 +1259,6 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 	return ret;
 }
 
-extern int netdev_open(struct net_device *pnetdev);
-
 static int cfg80211_rtw_change_iface(struct wiphy *wiphy,
 				     struct net_device *ndev,
 				     enum nl80211_iftype type,
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 9ae7d46fb501..c6c5cc0a9e08 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -193,8 +193,6 @@ MODULE_PARM_DESC(rtw_tx_pwr_lmt_enable, "0:Disable, 1:Enable, 2: Depend on efuse
 module_param(rtw_tx_pwr_by_rate, int, 0644);
 MODULE_PARM_DESC(rtw_tx_pwr_by_rate, "0:Disable, 1:Enable, 2: Depend on efuse");
 
-int _netdev_open(struct net_device *pnetdev);
-int netdev_open(struct net_device *pnetdev);
 static int netdev_close(struct net_device *pnetdev);
 
 static void loadparam(struct adapter *padapter, struct net_device *pnetdev)
@@ -875,7 +873,7 @@ int rtw_drv_register_netdev(struct adapter *if1)
 	return _rtw_drv_register_netdev(padapter, name);
 }
 
-int _netdev_open(struct net_device *pnetdev)
+static int _netdev_open(struct net_device *pnetdev)
 {
 	uint status;
 	struct adapter *padapter = rtw_netdev_priv(pnetdev);
-- 
2.20.1

