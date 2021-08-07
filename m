Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E998E3E34A8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhHGKNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhHGKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:12:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CA9C06179F
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:12:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gs8so19613736ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfdfOq3fPaEyVy8vIu1pAlj6ZJZ6BE3vB+0GWCKQYmQ=;
        b=igev59uJB63Wi1lApSYaDZco2WfK1ozX62V5b+44oqizvJiJeyVeiW6cs3T3SrTlon
         qiwP/W9r5x+HOskNYWZajGcjnWhCGNs4ofOXY/P6Sv8pzk7CChmcHkfJWyvq4SYVcjKl
         BZDrHTkt+puXDdOfQlUf/Fsk6omVkmXMV7LtWPQAz0ZEFew8oF7bPT5i9Z0XImSbbuCu
         7xnPxBLfr2ojEsM5wuVy6CGVxsAffNZitvPHlSltZEfE0jr+csioInVF7lMJwuRpKvZa
         0zcrOfkdzxxNBB6CAhYbHfxM/+GEDGtDab+A8cFY5UhEo9Xh2hfZkvc1TG+9nZLbWx8t
         qPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfdfOq3fPaEyVy8vIu1pAlj6ZJZ6BE3vB+0GWCKQYmQ=;
        b=tuYUr1uyj3I4aLcf0ki28+fPYaoavqX6x3GHmSNgHXlmd2S5uFNKGiG1wxRRJwhs9P
         9IbgH3DdAvQds3VhrCRSOvARbPM/035ZS7jEBTqys+pGP1xBDnLXyAoWRu+MQrqJX/Wj
         y7QD+qpWAeYd8LE01MXgElKCi78WN7KMwy4zjHZQTeI3HTRy21CVd66YSN/Nt53Xir2d
         vRo2KLOGi5SUt8V+uGmh3FxeyCzfcZaDhC6KkgUpNg77lIOW8d8w4HWr7aGBj7zY4Xfl
         8yHUhJZ0389upDzKCDOQZLum8z+M9gMMNBLZDZT/5ChTrTI1pVMNyPUp6KojD6Gw2H0Y
         itEw==
X-Gm-Message-State: AOAM532ZOYEXieYja9lCSFhOdWdyS3sOapuMYWk1dBtsHLBvrwZ8Z+Er
        CrT5wwZRIHj6yJoPAyUl/X8=
X-Google-Smtp-Source: ABdhPJzVE6WyzOs58f0ARwM9XC81308q121AXou5M44FN9l3qXPj98ga+dl7l1CnHoRUBfLgb35v/A==
X-Received: by 2002:a17:906:4115:: with SMTP id j21mr13630961ejk.206.1628331133033;
        Sat, 07 Aug 2021 03:12:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::a83e])
        by smtp.gmail.com with ESMTPSA id u4sm3662514eje.81.2021.08.07.03.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:12:12 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/17] staging: r8188eu: clean up comparsions to true/false
Date:   Sat,  7 Aug 2021 12:11:10 +0200
Message-Id: <20210807101119.16085-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807101119.16085-1-straube.linux@gmail.com>
References: <20210807101119.16085-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some comparsions to true/false to clear chackpatch warnings.

WARNING: Unnecessary parentheses - maybe == should be = ?

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 4 ++--
 drivers/staging/r8188eu/core/rtw_mlme.c      | 2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 1a4227729e0d..41c14a4cff1f 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -166,7 +166,7 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 
 			rtw_free_assoc_resources(padapter, 1);
 
-			if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
+			if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
 				_clr_fwstate_(pmlmepriv, WIFI_ADHOC_MASTER_STATE);
 				set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
 			}
@@ -231,7 +231,7 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE)) {
 		if ((pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength) &&
 		    (!memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid, ssid->SsidLength))) {
-			if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)) {
+			if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 				if (!rtw_is_same_ibss(padapter, pnetwork)) {
 					/* if in WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE, create bss or rejoin again */
 					rtw_disassoc_cmd(padapter, 0, true);
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 4768d3ef350e..f28c30a6efb0 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -748,7 +748,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
 	if (pmlmepriv->to_join) {
-		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 0a755d7b8f19..018ee20553dd 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -740,7 +740,7 @@ s32 rtw_make_wlanhdr (struct adapter *padapter, u8 *hdr, struct pkt_attrib *patt
 	SetFrameSubType(fctrl, pattrib->subtype);
 
 	if (pattrib->subtype & WIFI_DATA_TYPE) {
-		if ((check_fwstate(pmlmepriv,  WIFI_STATION_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 			/* to_ds = 1, fr_ds = 0; */
 			/* Data transfer to AP */
 			SetToDs(fctrl);
-- 
2.32.0

