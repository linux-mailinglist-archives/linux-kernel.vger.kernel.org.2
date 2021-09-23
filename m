Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0730416387
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhIWQrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhIWQri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:47:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3DAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:46:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u18so19034391wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dCBklC89lfCAReaeNKsAh+FNbw7ueQvajKkQaVpDEDg=;
        b=X/CCeZOIgVfmMylIoYX4NLZvgGbUdlcG7ZjTshGNzT8xHmshH+Qh9ExAV/btGuNqNJ
         RuX1AxdPlWf44I+Cy2OFyfYkeapEdUqXfitKz3xDS5yRIRJwnJZRdHKGXI3WC7BI/eN7
         4lr1kE4fvQkm1t9fAU3blPD/rbsAiDM71GAJlecWJJZUYr5fJ7KAdgXlahnivIqFC3BO
         kO8yooioj8TKaYYiHtRt/k5kYYB1ZtIXjPru1T/PkrprQzEtWCnjOp6wLDgY+UhL/CGt
         KDSpj8pADxty48npmguoCwdbNMLKRCqAfcOxVNhM09Mtnz3blwuVBVLlBRtZvK+ZdHEH
         HsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dCBklC89lfCAReaeNKsAh+FNbw7ueQvajKkQaVpDEDg=;
        b=EnSNyv3EqQWJ33+ZZ4N5oqX4UQLzIHifSddE6R8oMtudCBD7U+SDsJG/XpHbG/Ue9G
         R4UgZGFA4o6CxeyG8e7KQ0xraI2fl7oCXoV+8SxSETjEcSuFPoHa8WxsJJiui6PZJxTY
         Qc9DBjsAJgOPgTwwOxLNDF+Bqyuhy4VuKBDjek5qgk1ViKDjXuDYFwuNqi/29l435/n+
         dmYXS9d8vtbUn8SfK1fPJUHIGKWrgX6UEOS3TEQGG7X2MpgWmQe4E1nezASlsJDP4ZIR
         G05Asf/Pxad0AJbz3Ce4wyGMN7P0il9D6XLkYgKC9ksjOXLazGt04/C87EaAaLdMKFSN
         wMng==
X-Gm-Message-State: AOAM531KjYtC5DGxrweswYEntYjTSN7TxzIWyzJm7nyHQy8PI3uiMjiC
        OCE+FSn/H8RS2PRz9VO4AD1G5QpO57cGoQ==
X-Google-Smtp-Source: ABdhPJxx6x7D9hkJl5by5naixukG7o+Xms+0PVu4lz2ehkvIBS2bMVxAps8+LefR/JJhjNSaUg2ohQ==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr6388857wrd.194.1632415565252;
        Thu, 23 Sep 2021 09:46:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id f1sm6086818wrc.66.2021.09.23.09.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 09:46:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove rtw_proc_{init,remove}_one()
Date:   Thu, 23 Sep 2021 18:45:56 +0200
Message-Id: <20210923164556.9492-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions rtw_proc_{init,remove}_one() are empty and can be
removed. There are non-empty versions of these functions covered by
#if 0. Remove this dead code as well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
Tested on x86_64 with Inter-Tech DMG-02.

 drivers/staging/r8188eu/include/osdep_intf.h  |   2 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 338 ------------------
 .../staging/r8188eu/os_dep/osdep_service.c    |   3 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   1 -
 4 files changed, 344 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
index da36770852f8..90b37655e9e0 100644
--- a/drivers/staging/r8188eu/include/osdep_intf.h
+++ b/drivers/staging/r8188eu/include/osdep_intf.h
@@ -51,8 +51,6 @@ void rtw_cancel_all_timer(struct adapter *padapter);
 int rtw_init_netdev_name(struct net_device *pnetdev, const char *ifname);
 struct net_device *rtw_init_netdev(struct adapter *padapter);
 u16 rtw_recv_select_queue(struct sk_buff *skb);
-void rtw_proc_init_one(struct net_device *dev);
-void rtw_proc_remove_one(struct net_device *dev);
 
 void rtw_ips_dev_unload(struct adapter *padapter);
 
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 23c087491255..f34998204e44 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -154,343 +154,6 @@ MODULE_PARM_DESC(rtw_notch_filter, "0:Disable, 1:Enable, 2:Enable only for P2P")
 module_param_named(debug, rtw_debug, int, 0444);
 MODULE_PARM_DESC(debug, "Set debug level (1-9) (default 1)");
 
-/* dummy routines */
-void rtw_proc_remove_one(struct net_device *dev)
-{
-}
-
-void rtw_proc_init_one(struct net_device *dev)
-{
-}
-
-#if 0	/* TODO: Convert these to /sys */
-void rtw_proc_init_one(struct net_device *dev)
-{
-	struct proc_dir_entry *dir_dev = NULL;
-	struct proc_dir_entry *entry = NULL;
-	struct adapter	*padapter = rtw_netdev_priv(dev);
-	u8 rf_type;
-
-	if (!rtw_proc) {
-		memcpy(rtw_proc_name, DRV_NAME, sizeof(DRV_NAME));
-
-		rtw_proc = create_proc_entry(rtw_proc_name, S_IFDIR, init_net.proc_net);
-		if (!rtw_proc) {
-			DBG_88E(KERN_ERR "Unable to create rtw_proc directory\n");
-			return;
-		}
-
-		entry = create_proc_read_entry("ver_info", S_IFREG | S_IRUGO, rtw_proc, proc_get_drv_version, dev);
-		if (!entry) {
-			pr_info("Unable to create_proc_read_entry!\n");
-			return;
-		}
-	}
-
-	if (!padapter->dir_dev) {
-		padapter->dir_dev = create_proc_entry(dev->name,
-					  S_IFDIR | S_IRUGO | S_IXUGO,
-					  rtw_proc);
-		dir_dev = padapter->dir_dev;
-		if (!dir_dev) {
-			if (rtw_proc_cnt == 0) {
-				if (rtw_proc) {
-					remove_proc_entry(rtw_proc_name, init_net.proc_net);
-					rtw_proc = NULL;
-				}
-			}
-
-			pr_info("Unable to create dir_dev directory\n");
-			return;
-		}
-	} else {
-		return;
-	}
-
-	rtw_proc_cnt++;
-
-	entry = create_proc_read_entry("write_reg", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_write_reg, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-	entry->write_proc = proc_set_write_reg;
-
-	entry = create_proc_read_entry("read_reg", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_read_reg, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-	entry->write_proc = proc_set_read_reg;
-
-	entry = create_proc_read_entry("fwstate", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_fwstate, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("sec_info", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_sec_info, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("mlmext_state", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_mlmext_state, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("qos_option", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_qos_option, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("ht_option", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_ht_option, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("rf_info", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_rf_info, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("ap_info", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_ap_info, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("adapter_state", S_IFREG | S_IRUGO,
-				   dir_dev, proc_getstruct adapter_state, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("trx_info", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_trx_info, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("mac_reg_dump1", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_mac_reg_dump1, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("mac_reg_dump2", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_mac_reg_dump2, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("mac_reg_dump3", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_mac_reg_dump3, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("bb_reg_dump1", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_bb_reg_dump1, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("bb_reg_dump2", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_bb_reg_dump2, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("bb_reg_dump3", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_bb_reg_dump3, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("rf_reg_dump1", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_rf_reg_dump1, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("rf_reg_dump2", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_rf_reg_dump2, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-	if ((RF_1T2R == rf_type) || (RF_1T1R == rf_type)) {
-		entry = create_proc_read_entry("rf_reg_dump3", S_IFREG | S_IRUGO,
-					   dir_dev, proc_get_rf_reg_dump3, dev);
-		if (!entry) {
-			pr_info("Unable to create_proc_read_entry!\n");
-			return;
-		}
-
-		entry = create_proc_read_entry("rf_reg_dump4", S_IFREG | S_IRUGO,
-					   dir_dev, proc_get_rf_reg_dump4, dev);
-		if (!entry) {
-			pr_info("Unable to create_proc_read_entry!\n");
-			return;
-		}
-	}
-
-	entry = create_proc_read_entry("all_sta_info", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_all_sta_info, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("best_channel", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_best_channel, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-
-	entry = create_proc_read_entry("rx_signal", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_rx_signal, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-	entry->write_proc = proc_set_rx_signal;
-	entry = create_proc_read_entry("ht_enable", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_ht_enable, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-	entry->write_proc = proc_set_ht_enable;
-
-	entry = create_proc_read_entry("cbw40_enable", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_cbw40_enable, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-	entry->write_proc = proc_set_cbw40_enable;
-
-	entry = create_proc_read_entry("ampdu_enable", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_ampdu_enable, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-	entry->write_proc = proc_set_ampdu_enable;
-
-	entry = create_proc_read_entry("rx_stbc", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_rx_stbc, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-	entry->write_proc = proc_set_rx_stbc;
-
-	entry = create_proc_read_entry("path_rssi", S_IFREG | S_IRUGO,
-					dir_dev, proc_get_two_path_rssi, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-	entry = create_proc_read_entry("rssi_disp", S_IFREG | S_IRUGO,
-				   dir_dev, proc_get_rssi_disp, dev);
-	if (!entry) {
-		pr_info("Unable to create_proc_read_entry!\n");
-		return;
-	}
-	entry->write_proc = proc_set_rssi_disp;
-}
-
-void rtw_proc_remove_one(struct net_device *dev)
-{
-	struct proc_dir_entry *dir_dev = NULL;
-	struct adapter	*padapter = rtw_netdev_priv(dev);
-	u8 rf_type;
-
-	dir_dev = padapter->dir_dev;
-	padapter->dir_dev = NULL;
-
-	if (dir_dev) {
-		remove_proc_entry("write_reg", dir_dev);
-		remove_proc_entry("read_reg", dir_dev);
-		remove_proc_entry("fwstate", dir_dev);
-		remove_proc_entry("sec_info", dir_dev);
-		remove_proc_entry("mlmext_state", dir_dev);
-		remove_proc_entry("qos_option", dir_dev);
-		remove_proc_entry("ht_option", dir_dev);
-		remove_proc_entry("rf_info", dir_dev);
-		remove_proc_entry("ap_info", dir_dev);
-		remove_proc_entry("adapter_state", dir_dev);
-		remove_proc_entry("trx_info", dir_dev);
-		remove_proc_entry("mac_reg_dump1", dir_dev);
-		remove_proc_entry("mac_reg_dump2", dir_dev);
-		remove_proc_entry("mac_reg_dump3", dir_dev);
-		remove_proc_entry("bb_reg_dump1", dir_dev);
-		remove_proc_entry("bb_reg_dump2", dir_dev);
-		remove_proc_entry("bb_reg_dump3", dir_dev);
-		remove_proc_entry("rf_reg_dump1", dir_dev);
-		remove_proc_entry("rf_reg_dump2", dir_dev);
-		rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-		if ((RF_1T2R == rf_type) || (RF_1T1R == rf_type)) {
-			remove_proc_entry("rf_reg_dump3", dir_dev);
-			remove_proc_entry("rf_reg_dump4", dir_dev);
-		}
-		remove_proc_entry("all_sta_info", dir_dev);
-
-		remove_proc_entry("best_channel", dir_dev);
-		remove_proc_entry("rx_signal", dir_dev);
-		remove_proc_entry("cbw40_enable", dir_dev);
-		remove_proc_entry("ht_enable", dir_dev);
-		remove_proc_entry("ampdu_enable", dir_dev);
-		remove_proc_entry("rx_stbc", dir_dev);
-		remove_proc_entry("path_rssi", dir_dev);
-		remove_proc_entry("rssi_disp", dir_dev);
-		remove_proc_entry(dev->name, rtw_proc);
-		dir_dev = NULL;
-	} else {
-		return;
-	}
-	rtw_proc_cnt--;
-
-	if (rtw_proc_cnt == 0) {
-		if (rtw_proc) {
-			remove_proc_entry("ver_info", rtw_proc);
-
-			remove_proc_entry(rtw_proc_name, init_net.proc_net);
-			rtw_proc = NULL;
-		}
-	}
-}
-#endif
-
 static uint loadparam(struct adapter *padapter,  struct  net_device *pnetdev)
 {
 	struct registry_priv  *registry_par = &padapter->registrypriv;
@@ -1002,7 +665,6 @@ int _netdev_open(struct net_device *pnetdev)
 		}
 		if (padapter->intf_start)
 			padapter->intf_start(padapter);
-		rtw_proc_init_one(pnetdev);
 
 		rtw_led_control(padapter, LED_CTL_NO_LINK);
 
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index bee6d42b8738..7db2542bc627 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -180,8 +180,6 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
 	else
 		unregister_netdevice(cur_pnetdev);
 
-	rtw_proc_remove_one(cur_pnetdev);
-
 	rereg_priv->old_pnetdev = cur_pnetdev;
 
 	pnetdev = rtw_init_netdev(padapter);
@@ -203,7 +201,6 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
 	if (ret != 0)
 		goto error;
 
-	rtw_proc_init_one(pnetdev);
 	return 0;
 error:
 	return -1;
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 11a584cbe9d8..db312a674c9a 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -529,7 +529,6 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
 		if (pnetdev) {
 			/* will call netdev_close() */
 			unregister_netdev(pnetdev);
-			rtw_proc_remove_one(pnetdev);
 		}
 	}
 	rtw_cancel_all_timer(if1);
-- 
2.33.0

