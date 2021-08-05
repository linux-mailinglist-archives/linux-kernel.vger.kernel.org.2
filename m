Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA07E3E1D93
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 22:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbhHEUvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 16:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhHEUvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 16:51:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630CC0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 13:51:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m19so4203216wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ST5aevt4uUTq4ziDf6ZuwvhFl9i7aM7uVjgXs4eXgg=;
        b=Xo5UI6m+/2hogSG9mdrobtRNcEXWKTGgVPiIuQh2Z7K34qPi8Abprax7i4v5PIhu7u
         Ddeu/GZrgV5naDARNx+qcDwTh5cRkR4pryeLVZz3dv6Ta/W2rJTjUMopmgveFWHcJ23L
         gCYDM7w2XPcvB85y3cSw6ghIfsdlynl9GzEEsekU6lrOkfrLW5+RU6H3/03uwuVqyjJP
         oPFBSowL+XxHu1D9PC1tOirKJnzw/iMlegJPrmfomyFmShKzAel8QWhQhaHy2o4oZNAR
         VXgiXRRVtxO2ffb6rXpw6SqcNSN5fonAAcAzcR1bw78Xq6k9UkMamPlj535PpFJ/yCew
         pQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ST5aevt4uUTq4ziDf6ZuwvhFl9i7aM7uVjgXs4eXgg=;
        b=fZlpnn/b81oKaz0HCc9HqNr/BSqzHsb9ibeQfv3q82x4Ut329KPmgASgnKkiowLWAp
         zt4MMWFBoKXMgqCDVdbwTp0abFVaGt0D+W3uFEh1ZVmCsdAwS9AYzxKy7qItXgQmyEnp
         9p4cD54cyv8dPSatwhTpsVcPnAcZKnHPtBWfpiT2RU42j0pPdbzgv2gBf4+Y1v6hjM7m
         X/z+loORP+uFBJaq/xvx7so9omC71Nx8QQ9j5PDPyMbdVueVyKVrly7P6sKB6f7iggVT
         jLHymA53vz/6tgvJm7dYiao7zWiFSx4EIxI9BLUeXDoF+MKdQb2AzuQ6c4o2mQ9Fal8r
         zoFQ==
X-Gm-Message-State: AOAM530ed0MEziV+Gxd6jnDTnyKoBa4JtGen66ahi+Qd42CSZelcRQvS
        Pc4iaqP3SIurXU5OLbv0OLxDWINwPzs=
X-Google-Smtp-Source: ABdhPJz+CtS5j5EoL1Tcfxm2j1Pk4PVpoZMQukde2CWhKOSEuqMYOcaNm0PXQnCDX9bzrtkN6XW+oQ==
X-Received: by 2002:a05:600c:4657:: with SMTP id n23mr40578wmo.46.1628196663677;
        Thu, 05 Aug 2021 13:51:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::996b])
        by smtp.gmail.com with ESMTPSA id h16sm7195347wre.52.2021.08.05.13.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 13:51:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: replace custom macros with is_broadcast_ether_addr
Date:   Thu,  5 Aug 2021 22:50:10 +0200
Message-Id: <20210805205010.31192-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace usage of custom macros with is_broadcast_ether_addr. All buffers
are properly aligned. Remove the now unsued macros MacAddr_isBcst and
IS_MAC_ADDRESS_BROADCAST.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 13 +++----------
 drivers/staging/r8188eu/core/rtw_recv.c      |  2 +-
 drivers/staging/r8188eu/include/wifi.h       |  7 -------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 3e2add5409cc..c354f720310c 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -13,13 +13,6 @@
 
 extern void indicate_wx_scan_complete_event(struct adapter *padapter);
 
-#define IS_MAC_ADDRESS_BROADCAST(addr) \
-(\
-	((addr[0] == 0xff) && (addr[1] == 0xff) && \
-		(addr[2] == 0xff) && (addr[3] == 0xff) && \
-		(addr[4] == 0xff) && (addr[5] == 0xff))  ? true : false \
-)
-
 u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
 {
 	u8	 i;
@@ -656,8 +649,8 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 		}
 
 		/*  check BSSID */
-		if (IS_MAC_ADDRESS_BROADCAST(key->BSSID) == true) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("MacAddr_isBcst(key->BSSID)\n"));
+		if (is_broadcast_ether_addr(key->BSSID)) {
+			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("is_broadcast_ether_addr(key->BSSID)\n"));
 			ret = false;
 			goto exit;
 		}
@@ -744,7 +737,7 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 				 padapter->securitypriv.dot118021XGrpPrivacy, key->KeyLength));
 		}
 
-		if ((check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE) == true) && (IS_MAC_ADDRESS_BROADCAST(key->BSSID) == false)) {
+		if (check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE) && !is_broadcast_ether_addr(key->BSSID)) {
 			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
 				 (" IBSS but BSSID is not Broadcast Address.\n"));
 			ret = _FAIL;
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index aef32f029537..afab951d87fd 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -694,7 +694,7 @@ static void count_rx_stats(struct adapter *padapter, struct recv_frame *prframe,
 
 	padapter->mlmepriv.LinkDetectInfo.NumRxOkInPeriod++;
 
-	if ((!MacAddr_isBcst(pattrib->dst)) && (!IS_MCAST(pattrib->dst)))
+	if (!is_broadcast_ether_addr(pattrib->dst) && !IS_MCAST(pattrib->dst))
 		padapter->mlmepriv.LinkDetectInfo.NumRxUnicastOkInPeriod++;
 
 	if (sta)
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 2c56d1d70d03..65fc677bf4eb 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -368,13 +368,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
 
-#define MacAddr_isBcst(addr) \
-	( \
-	((addr[0] == 0xff) && (addr[1] == 0xff) && \
-	(addr[2] == 0xff) && (addr[3] == 0xff) && \
-	(addr[4] == 0xff) && (addr[5] == 0xff))  ? true : false \
-)
-
 static inline int IS_MCAST(unsigned char *da)
 {
 	if ((*da) & 0x01)
-- 
2.32.0

