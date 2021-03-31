Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2588234FD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhCaJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhCaJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED32C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so29112172ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdGy+VaMo3QjX/AlR4vXWOzXKOhveyYfc+vTtnXrrws=;
        b=Wcjf239E6WQ48PFnYT3GculZwbRFJtMvSYb61z32Bwa9z6IvfA+1MyArBBnxLKJZgs
         xec+5apg66eZlBWw9sUDAiMcXp/4WQ7cukPGgxoiuSl5y+C+kcv+J0u+3iS4g+s7vkT2
         4EU2DXBgm/X0cv2FjI9ieJMqVxmXDpNDCZdsiPC7fqJ8/j/1VMob/V/wvubaaIiv6iP7
         QMDOBiIXRN/EkyQ9FM6ebpThlXQMKCY+0EI4lri+kBm0sp51PC7Txmn6KVHwgTFnKJ1f
         gEwTpYkbPilrNp/iKi2+Y2wPy1yBND6FjdUP3HeFVa+rjooShl+mgMHNa1se72Zslk7l
         y3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdGy+VaMo3QjX/AlR4vXWOzXKOhveyYfc+vTtnXrrws=;
        b=aV0u1DQ1IkHnHXJFVOC+jYa3RzY4QZ1MVNNyO5LCU/2BYpzyRzutsLi+2dGL02JLfa
         lMHQ3EliiZZiyQC7/WTMGrHXn4De5FS971P1GNOS6RoaoXJQoiIeH8o8SfcfZrj1TXX1
         Od9pCGkZaMSgEKrBWfreEgOoFR/eBsDKribosb8nAz1vmW0mr4u67ijTPzSAvEzYljb3
         5+nMfnfhP94SOgsrfNnxiu+LgcM4L/SOBGp4F/LFsr3lY/KKyi4TCHlaU6Hh8eneaG3c
         FsTwMFnLWQuaI403drl8J+w0kcr+cWM+FI72LmXE2K1ZnjTAZXxJuBq0zvJ9L6y56+zu
         c+Ow==
X-Gm-Message-State: AOAM531rxFdntnqIz4RGyDAFTOUNXwUTDLrEpa/gg3E83dH0oQi1Mp5q
        UuvaSQZ1EggggD4gRhEkCFo=
X-Google-Smtp-Source: ABdhPJy1dKPPloy9KVQ5p+V7VLkSv8n2/ZNNyFZTpqZK9DsUUt8TbhWOIpa1S4ozLzn8Ilm2+oNCMA==
X-Received: by 2002:a17:906:cb87:: with SMTP id mf7mr2497173ejb.81.1617183637055;
        Wed, 31 Mar 2021 02:40:37 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id a9sm1076401eds.33.2021.03.31.02.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:36 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 13/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in core/rtw_wlan_util.c
Date:   Wed, 31 Mar 2021 11:39:41 +0200
Message-Id: <cb26d4bd74d77dc4ed241c158a2e049517481d75.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 28 +++++++++----------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 760b0ea4e9bd..12566fbe1160 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1334,10 +1334,11 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	memcpy(bssid->Ssid.Ssid, (p + 2), ssid_len);
 	bssid->Ssid.SsidLength = ssid_len;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s bssid.Ssid.Ssid:%s bssid.Ssid.SsidLength:%d "
-				"cur_network->network.Ssid.Ssid:%s len:%d\n", __func__, bssid->Ssid.Ssid,
-				bssid->Ssid.SsidLength, cur_network->network.Ssid.Ssid,
-				cur_network->network.Ssid.SsidLength));
+	pr_info("%s %s bssid.Ssid.Ssid:%s bssid.Ssid.SsidLength:%d "
+		"cur_network->network.Ssid.Ssid:%s len:%d\n",
+		DRIVER_PREFIX, __func__, bssid->Ssid.Ssid,
+		bssid->Ssid.SsidLength, cur_network->network.Ssid.Ssid,
+		cur_network->network.Ssid.SsidLength);
 
 	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
 			bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
@@ -1355,9 +1356,8 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	else
 		bssid->Privacy = 0;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-			("%s(): cur_network->network.Privacy is %d, bssid.Privacy is %d\n",
-			 __func__, cur_network->network.Privacy, bssid->Privacy));
+	pr_info("%s %s(): cur_network->network.Privacy is %d, bssid.Privacy is %d\n",
+		DRIVER_PREFIX, __func__, cur_network->network.Privacy, bssid->Privacy);
 	if (cur_network->network.Privacy != bssid->Privacy) {
 		DBG_871X("%s(), privacy is not match\n", __func__);
 		goto _mismatch;
@@ -1383,24 +1383,22 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
 		if (pbuf && (wpa_ielen > 0)) {
 			if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-						("%s pnetwork->pairwise_cipher: %d, group_cipher is %d, is_8021x is %d\n", __func__,
-						 pairwise_cipher, group_cipher, is_8021x));
+				pr_info("%s %s pnetwork->pairwise_cipher: %d, group_cipher is %d, is_8021x is %d\n",
+					DRIVER_PREFIX, __func__, pairwise_cipher, group_cipher, is_8021x);
 			}
 		} else {
 			pbuf = rtw_get_wpa2_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
 
 			if (pbuf && (wpa_ielen > 0)) {
 				if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-							("%s pnetwork->pairwise_cipher: %d, pnetwork->group_cipher is %d, is_802x is %d\n",
-							 __func__, pairwise_cipher, group_cipher, is_8021x));
+					pr_info("%s %s pnetwork->pairwise_cipher: %d, pnetwork->group_cipher is %d, is_802x is %d\n",
+						DRIVER_PREFIX, __func__, pairwise_cipher, group_cipher, is_8021x);
 				}
 			}
 		}
 
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-				("%s cur_network->group_cipher is %d: %d\n", __func__, cur_network->BcnInfo.group_cipher, group_cipher));
+		pr_err("%s %s cur_network->group_cipher is %d: %d\n",
+		       DRIVER_PREFIX, __func__, cur_network->BcnInfo.group_cipher, group_cipher);
 		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
 			DBG_871X("%s pairwise_cipher(%x:%x) or group_cipher(%x:%x) is not match\n", __func__,
 					pairwise_cipher, cur_network->BcnInfo.pairwise_cipher,
-- 
2.20.1

