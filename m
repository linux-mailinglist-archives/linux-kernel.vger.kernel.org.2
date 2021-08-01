Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE763DCD2E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhHATFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhHATFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:05:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F42C061796
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p5so18808532wro.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7mPn9VmlgPYEjGurxnLxgc5kUIFtinkuvrburr+EOd4=;
        b=IokLLMMp4WhF5JMi6OUpCysXjmoqVhsjaa91ybb2+v0OFeq0+S7ysH4RonKWv9GtBw
         MF57AFTKFIK+hjsYOHOEWu5EPZ6INghdVVFSM2CrnvIJOEXTD9TT35GMYb15/hzbk4sB
         JlDJNl1jmrdpVmYEe0TLkObITx851AhyYrI1tCH1hLpWUHYmwQvwR+/agmSWx3rNzU6H
         xkTg8ak8GR4zzcaNCcyOnRDOpoY+bp2P/cErYwjxyduIbAvqCWJAY8tpO5Sg+gv+djh4
         s4qJd3nMiHc9MG+1hidt7cmMlcrhz7FKJUaxIwEExZ6O1HaUCXHKMyZqFz/6f4ff5gyt
         qAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mPn9VmlgPYEjGurxnLxgc5kUIFtinkuvrburr+EOd4=;
        b=skRYkdQYxEnzAfO9KMHsN4FG13fZugizL8AA82sgRJ/PTttM7czQvQg8oiA8Bbprp3
         sbercGke60ASIRAPZjeKaSw3DVhNKqwbgBbUZtq1huXmxR/0OvHSUwa4OAe1HOADp9BZ
         hL3cui5IRlof5Ww4cKXvMPcO2upwf2/zcgGVdT0qFkfe9K2wb9X5VoTUFViU38wtzEwd
         es8cuFNihRX/JaMlzRlNRGaxADE21w3TAO2HiZfZgIXZrEQhUq8EPRjsLhSpL2cqfkDE
         rkd+HV7IBRI1MM49tvlbiNCFRKa2HvFxQuuYJhr0NeO11VXaowHcWgTFnTSwoZcs6JMd
         vn9A==
X-Gm-Message-State: AOAM532y9SbggY/TDP3WNzgHa6AUHl3ucAd0IyeQs/anhZt1ihpNzNF5
        XpjVaG0oG3gFSuoiZWEylyrU6g==
X-Google-Smtp-Source: ABdhPJyBdumDzWYju3+SN0EDgqoZwDON9NKUUes4b+K2QVT8/uiXT8m8XqJUXFrd873wTdgzp+Hwhg==
X-Received: by 2002:a05:6000:10d:: with SMTP id o13mr13833995wrx.88.1627844690544;
        Sun, 01 Aug 2021 12:04:50 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:50 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 14/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_mp_ioctl.c
Date:   Sun,  1 Aug 2021 20:04:36 +0100
Message-Id: <20210801190437.82017-15-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_mp_ioctl.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c | 176 +-------------------
 1 file changed, 8 insertions(+), 168 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index b6145c7b5893..f465acfa20b8 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -22,7 +22,6 @@ int rtl8188eu_oid_rt_wireless_mode_hdl(struct oid_par_priv *poid_par_priv)
 	} else if (poid_par_priv->type_of_oid == QUERY_OID) {
 		*(u8 *)poid_par_priv->information_buf = Adapter->registrypriv.wireless_mode;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
-		 RT_TRACE(_module_mp_, _drv_info_, ("-query Wireless Mode=%d\n", Adapter->registrypriv.wireless_mode));
 	} else {
 		status = NDIS_STATUS_NOT_ACCEPTED;
 	}
@@ -38,8 +37,6 @@ int rtl8188eu_oid_rt_pro_write_bb_reg_hdl(struct oid_par_priv *poid_par_priv)
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+rtl8188eu_oid_rt_pro_write_bb_reg_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -54,10 +51,6 @@ int rtl8188eu_oid_rt_pro_write_bb_reg_hdl(struct oid_par_priv *poid_par_priv)
 
 	value = pbbreg->value;
 
-	RT_TRACE(_module_mp_, _drv_notice_,
-		 ("rtl8188eu_oid_rt_pro_write_bb_reg_hdl: offset=0x%03X value=0x%08X\n",
-		  offset, value));
-
 	_irqlevel_changed_(&oldirql, LOWER);
 	write_bbreg(Adapter, offset, 0xFFFFFFFF, value);
 	_irqlevel_changed_(&oldirql, RAISE);
@@ -73,8 +66,6 @@ int rtl8188eu_oid_rt_pro_read_bb_reg_hdl(struct oid_par_priv *poid_par_priv)
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+rtl8188eu_oid_rt_pro_read_bb_reg_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -94,10 +85,6 @@ int rtl8188eu_oid_rt_pro_read_bb_reg_hdl(struct oid_par_priv *poid_par_priv)
 	pbbreg->value = value;
 	*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 
-	RT_TRACE(_module_mp_, _drv_notice_,
-		 ("-rtl8188eu_oid_rt_pro_read_bb_reg_hdl: offset=0x%03X value:0x%08X\n",
-		  offset, value));
-
 	return status;
 }
 /*  */
@@ -110,8 +97,6 @@ int rtl8188eu_oid_rt_pro_write_rf_reg_hdl(struct oid_par_priv *poid_par_priv)
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+rtl8188eu_oid_rt_pro_write_rf_reg_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -131,10 +116,6 @@ int rtl8188eu_oid_rt_pro_write_rf_reg_hdl(struct oid_par_priv *poid_par_priv)
 	offset = (u8)pbbreg->offset;
 	value = pbbreg->value;
 
-	RT_TRACE(_module_mp_, _drv_notice_,
-		 ("rtl8188eu_oid_rt_pro_write_rf_reg_hdl: path=%d offset=0x%02X value=0x%05X\n",
-		  path, offset, value));
-
 	_irqlevel_changed_(&oldirql, LOWER);
 	write_rfreg(Adapter, path, offset, value);
 	_irqlevel_changed_(&oldirql, RAISE);
@@ -151,8 +132,6 @@ int rtl8188eu_oid_rt_pro_read_rf_reg_hdl(struct oid_par_priv *poid_par_priv)
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 	int status = NDIS_STATUS_SUCCESS;
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+rtl8188eu_oid_rt_pro_read_rf_reg_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -177,10 +156,6 @@ int rtl8188eu_oid_rt_pro_read_rf_reg_hdl(struct oid_par_priv *poid_par_priv)
 
 	*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 
-	RT_TRACE(_module_mp_, _drv_notice_,
-		 ("-rtl8188eu_oid_rt_pro_read_rf_reg_hdl: path=%d offset=0x%02X value=0x%05X\n",
-		  path, offset, value));
-
 	return status;
 }
 /*   rtl8188eu_oid_rtl_seg_81_87_00   section end**************** */
@@ -194,9 +169,6 @@ int rtl8188eu_oid_rt_pro_set_data_rate_hdl(struct oid_par_priv *poid_par_priv)
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_notice_,
-		 ("+rtl8188eu_oid_rt_pro_set_data_rate_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -204,8 +176,6 @@ int rtl8188eu_oid_rt_pro_set_data_rate_hdl(struct oid_par_priv *poid_par_priv)
 		return NDIS_STATUS_INVALID_LENGTH;
 
 	ratevalue = *((u32 *)poid_par_priv->information_buf);/* 4 */
-	RT_TRACE(_module_mp_, _drv_notice_,
-		 ("rtl8188eu_oid_rt_pro_set_data_rate_hdl: data rate idx=%d\n", ratevalue));
 	if (ratevalue >= MPT_RATE_LAST)
 		return NDIS_STATUS_INVALID_DATA;
 
@@ -224,8 +194,6 @@ int rtl8188eu_oid_rt_pro_start_test_hdl(struct oid_par_priv *poid_par_priv)
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+rtl8188eu_oid_rt_pro_start_test_hdl\n"));
-
 	if (Adapter->registrypriv.mp_mode == 0)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -247,8 +215,6 @@ int rtl8188eu_oid_rt_pro_start_test_hdl(struct oid_par_priv *poid_par_priv)
 exit:
 	_irqlevel_changed_(&oldirql, RAISE);
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("-rtl8188eu_oid_rt_pro_start_test_hdl: mp_mode=%d\n", Adapter->mppriv.mode));
-
 	return status;
 }
 /*  */
@@ -257,8 +223,6 @@ int rtl8188eu_oid_rt_pro_stop_test_hdl(struct oid_par_priv *poid_par_priv)
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+Set OID_RT_PRO_STOP_TEST\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -266,8 +230,6 @@ int rtl8188eu_oid_rt_pro_stop_test_hdl(struct oid_par_priv *poid_par_priv)
 	mp_stop_test(Adapter);
 	_irqlevel_changed_(&oldirql, RAISE);
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("-Set OID_RT_PRO_STOP_TEST\n"));
-
 	return status;
 }
 /*  */
@@ -277,8 +239,6 @@ int rtl8188eu_oid_rt_pro_set_channel_direct_call_hdl(struct oid_par_priv *poid_p
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+rtl8188eu_oid_rt_pro_set_channel_direct_call_hdl\n"));
-
 	if (poid_par_priv->information_buf_len != sizeof(u32))
 		return NDIS_STATUS_INVALID_LENGTH;
 
@@ -291,7 +251,6 @@ int rtl8188eu_oid_rt_pro_set_channel_direct_call_hdl(struct oid_par_priv *poid_p
 		return NDIS_STATUS_NOT_ACCEPTED;
 
 	Channel = *((u32 *)poid_par_priv->information_buf);
-	RT_TRACE(_module_mp_, _drv_notice_, ("rtl8188eu_oid_rt_pro_set_channel_direct_call_hdl: Channel=%d\n", Channel));
 	if (Channel > 14)
 		return NDIS_STATUS_NOT_ACCEPTED;
 	Adapter->mppriv.channel = Channel;
@@ -310,9 +269,6 @@ int rtl8188eu_oid_rt_set_bandwidth_hdl(struct oid_par_priv *poid_par_priv)
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *padapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_info_,
-		 ("+rtl8188eu_oid_rt_set_bandwidth_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -331,10 +287,6 @@ int rtl8188eu_oid_rt_set_bandwidth_hdl(struct oid_par_priv *poid_par_priv)
 	SetBandwidth(padapter);
 	_irqlevel_changed_(&oldirql, RAISE);
 
-	RT_TRACE(_module_mp_, _drv_notice_,
-		 ("-rtl8188eu_oid_rt_set_bandwidth_hdl: bandwidth=%d channel_offset=%d\n",
-		  bandwidth, channel_offset));
-
 	return status;
 }
 /*  */
@@ -344,8 +296,6 @@ int rtl8188eu_oid_rt_pro_set_antenna_bb_hdl(struct oid_par_priv *poid_par_priv)
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+rtl8188eu_oid_rt_pro_set_antenna_bb_hdl\n"));
-
 	if (poid_par_priv->information_buf_len != sizeof(u32))
 		return NDIS_STATUS_INVALID_LENGTH;
 
@@ -354,9 +304,6 @@ int rtl8188eu_oid_rt_pro_set_antenna_bb_hdl(struct oid_par_priv *poid_par_priv)
 
 		Adapter->mppriv.antenna_tx = (u16)((antenna & 0xFFFF0000) >> 16);
 		Adapter->mppriv.antenna_rx = (u16)(antenna & 0x0000FFFF);
-		RT_TRACE(_module_mp_, _drv_notice_,
-			 ("rtl8188eu_oid_rt_pro_set_antenna_bb_hdl: tx_ant=0x%04x rx_ant=0x%04x\n",
-			  Adapter->mppriv.antenna_tx, Adapter->mppriv.antenna_rx));
 
 		_irqlevel_changed_(&oldirql, LOWER);
 		SetAntenna(Adapter);
@@ -375,8 +322,6 @@ int rtl8188eu_oid_rt_pro_set_tx_power_control_hdl(struct oid_par_priv *poid_par_
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_info_, ("+rtl8188eu_oid_rt_pro_set_tx_power_control_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -389,10 +334,6 @@ int rtl8188eu_oid_rt_pro_set_tx_power_control_hdl(struct oid_par_priv *poid_par_
 
 	Adapter->mppriv.txpoweridx = (u8)tx_pwr_idx;
 
-	RT_TRACE(_module_mp_, _drv_notice_,
-		 ("rtl8188eu_oid_rt_pro_set_tx_power_control_hdl: idx=0x%2x\n",
-		  Adapter->mppriv.txpoweridx));
-
 	_irqlevel_changed_(&oldirql, LOWER);
 	SetTxPower(Adapter);
 	_irqlevel_changed_(&oldirql, RAISE);
@@ -432,11 +373,9 @@ int rtl8188eu_oid_rt_pro_query_rx_packet_received_hdl(struct oid_par_priv *poid_
 		status = NDIS_STATUS_NOT_ACCEPTED;
 		return status;
 	}
-	RT_TRACE(_module_mp_, _drv_alert_, ("===> rtl8188eu_oid_rt_pro_query_rx_packet_received_hdl.\n"));
 	if (poid_par_priv->information_buf_len == sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =  Adapter->mppriv.rx_pktcount;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
-		RT_TRACE(_module_mp_, _drv_alert_, ("recv_ok:%d\n", Adapter->mppriv.rx_pktcount));
 	} else {
 		status = NDIS_STATUS_INVALID_LENGTH;
 	}
@@ -453,11 +392,9 @@ int rtl8188eu_oid_rt_pro_query_rx_packet_crc32_error_hdl(struct oid_par_priv *po
 		status = NDIS_STATUS_NOT_ACCEPTED;
 		return status;
 	}
-	RT_TRACE(_module_mp_, _drv_alert_, ("===> rtl8188eu_oid_rt_pro_query_rx_packet_crc32_error_hdl.\n"));
 	if (poid_par_priv->information_buf_len == sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =  Adapter->mppriv.rx_crcerrpktcount;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
-		RT_TRACE(_module_mp_, _drv_alert_, ("recv_err:%d\n", Adapter->mppriv.rx_crcerrpktcount));
 	} else {
 		status = NDIS_STATUS_INVALID_LENGTH;
 	}
@@ -476,7 +413,6 @@ int rtl8188eu_oid_rt_pro_reset_tx_packet_sent_hdl(struct oid_par_priv *poid_par_
 		return status;
 	}
 
-	RT_TRACE(_module_mp_, _drv_alert_, ("===> rtl8188eu_oid_rt_pro_reset_tx_packet_sent_hdl.\n"));
 	Adapter->mppriv.tx_pktcount = 0;
 
 	return status;
@@ -524,8 +460,6 @@ int rtl8188eu_oid_rt_get_phy_rx_packet_received_hdl(struct oid_par_priv *poid_pa
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_info_, ("+rtl8188eu_oid_rt_get_phy_rx_packet_received_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -538,8 +472,6 @@ int rtl8188eu_oid_rt_get_phy_rx_packet_received_hdl(struct oid_par_priv *poid_pa
 
 	*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("-rtl8188eu_oid_rt_get_phy_rx_packet_received_hdl: recv_ok=%d\n", *(u32 *)poid_par_priv->information_buf));
-
 	return status;
 }
 /*  */
@@ -548,8 +480,6 @@ int rtl8188eu_oid_rt_get_phy_rx_packet_crc32_error_hdl(struct oid_par_priv *poid
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_info_, ("+rtl8188eu_oid_rt_get_phy_rx_packet_crc32_error_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -562,10 +492,6 @@ int rtl8188eu_oid_rt_get_phy_rx_packet_crc32_error_hdl(struct oid_par_priv *poid
 
 	*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 
-	RT_TRACE(_module_mp_, _drv_info_,
-		 ("-rtl8188eu_oid_rt_get_phy_rx_packet_crc32_error_hdl: recv_err =%d\n",
-		 *(u32 *)poid_par_priv->information_buf));
-
 	return status;
 }
 /*   rtl8188eu_oid_rtl_seg_81_80_20   section end **************** */
@@ -575,8 +501,6 @@ int rtl8188eu_oid_rt_pro_set_continuous_tx_hdl(struct oid_par_priv *poid_par_pri
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+rtl8188eu_oid_rt_pro_set_continuous_tx_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -606,8 +530,6 @@ int rtl8188eu_oid_rt_pro_set_single_carrier_tx_hdl(struct oid_par_priv *poid_par
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_alert_, ("+rtl8188eu_oid_rt_pro_set_single_carrier_tx_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -637,8 +559,6 @@ int rtl8188eu_oid_rt_pro_set_carrier_suppression_tx_hdl(struct oid_par_priv *poi
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+rtl8188eu_oid_rt_pro_set_carrier_suppression_tx_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -668,8 +588,6 @@ int rtl8188eu_oid_rt_pro_set_single_tone_tx_hdl(struct oid_par_priv *poid_par_pr
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_alert_, ("+rtl8188eu_oid_rt_pro_set_single_tone_tx_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -715,9 +633,6 @@ int rtl8188eu_oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_info_,
-		 ("+rtl8188eu_oid_rt_pro_read_register_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -742,9 +657,6 @@ int rtl8188eu_oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 		RegRWStruct->value = rtw_read32(Adapter, offset);
 		break;
 	}
-	RT_TRACE(_module_mp_, _drv_notice_,
-		 ("rtl8188eu_oid_rt_pro_read_register_hdl: offset:0x%04X value:0x%X\n",
-		  offset, RegRWStruct->value));
 
 	_irqlevel_changed_(&oldirql, RAISE);
 
@@ -760,9 +672,6 @@ int rtl8188eu_oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *padapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_info_,
-		 ("+rtl8188eu_oid_rt_pro_write_register_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -801,10 +710,6 @@ int rtl8188eu_oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
 
 	_irqlevel_changed_(&oldirql, RAISE);
 
-	RT_TRACE(_module_mp_, _drv_info_,
-		 ("-rtl8188eu_oid_rt_pro_write_register_hdl: offset=0x%08X width=%d value=0x%X\n",
-		  offset, width, value));
-
 	return status;
 }
 /*  */
@@ -876,8 +781,6 @@ int rtl8188eu_oid_rt_pro_set_data_rate_ex_hdl(struct oid_par_priv *poid_par_priv
 
 	int status = NDIS_STATUS_SUCCESS;
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+OID_RT_PRO_SET_DATA_RATE_EX\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -897,8 +800,6 @@ int rtl8188eu_oid_rt_get_thermal_meter_hdl(struct oid_par_priv *poid_par_priv)
 	u8 thermal = 0;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+rtl8188eu_oid_rt_get_thermal_meter_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -933,8 +834,6 @@ int rtl8188eu_oid_rt_pro_set_power_tracking_hdl(struct oid_par_priv *poid_par_pr
 		u8 enable;
 
 		enable = *(u8 *)poid_par_priv->information_buf;
-		RT_TRACE(_module_mp_, _drv_notice_,
-			 ("+rtl8188eu_oid_rt_pro_set_power_tracking_hdl: enable =%d\n", enable));
 
 		SetPowerTracking(Adapter, enable);
 	} else {
@@ -1015,24 +914,16 @@ int rtl8188eu_oid_rt_pro_read_efuse_hdl(struct oid_par_priv *poid_par_priv)
 	cnts = pefuse->cnts;
 	data = pefuse->data;
 
-	RT_TRACE(_module_mp_, _drv_notice_,
-		 ("+rtl8188eu_oid_rt_pro_read_efuse_hd: buf_len=%d addr=%d cnts=%d\n",
-		  poid_par_priv->information_buf_len, addr, cnts));
-
 	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 
-	if ((addr + cnts) > max_available_size) {
-		RT_TRACE(_module_mp_, _drv_err_, ("!rtl8188eu_oid_rt_pro_read_efuse_hdl: parameter error!\n"));
+	if ((addr + cnts) > max_available_size)
 		return NDIS_STATUS_NOT_ACCEPTED;
-	}
 
 	_irqlevel_changed_(&oldirql, LOWER);
-	if (rtw_efuse_access(Adapter, false, addr, cnts, data) == _FAIL) {
-		RT_TRACE(_module_mp_, _drv_err_, ("!rtl8188eu_oid_rt_pro_read_efuse_hdl: rtw_efuse_access FAIL!\n"));
+	if (rtw_efuse_access(Adapter, false, addr, cnts, data) == _FAIL)
 		status = NDIS_STATUS_FAILURE;
-	} else {
+	else
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
-	}
 	_irqlevel_changed_(&oldirql, RAISE);
 
 	return status;
@@ -1054,16 +945,10 @@ int rtl8188eu_oid_rt_pro_write_efuse_hdl(struct oid_par_priv *poid_par_priv)
 	cnts = pefuse->cnts;
 	data = pefuse->data;
 
-	RT_TRACE(_module_mp_, _drv_notice_,
-		 ("+rtl8188eu_oid_rt_pro_write_efuse_hdl: buf_len=%d addr=0x%04x cnts=%d\n",
-		  poid_par_priv->information_buf_len, addr, cnts));
-
 	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 
-	if ((addr + cnts) > max_available_size) {
-		RT_TRACE(_module_mp_, _drv_err_, ("!rtl8188eu_oid_rt_pro_write_efuse_hdl: parameter error"));
+	if ((addr + cnts) > max_available_size)
 		return NDIS_STATUS_NOT_ACCEPTED;
-	}
 
 	_irqlevel_changed_(&oldirql, LOWER);
 	if (rtw_efuse_access(Adapter, true, addr, cnts, data) == _FAIL)
@@ -1089,10 +974,6 @@ int rtl8188eu_oid_rt_pro_rw_efuse_pgpkt_hdl(struct oid_par_priv *poid_par_priv)
 	_irqlevel_changed_(&oldirql, LOWER);
 
 	if (poid_par_priv->type_of_oid == QUERY_OID) {
-		RT_TRACE(_module_mp_, _drv_notice_,
-			 ("rtl8188eu_oid_rt_pro_rw_efuse_pgpkt_hdl: Read offset=0x%x\n",\
-			 ppgpkt->offset));
-
 		Efuse_PowerSwitch(Adapter, false, true);
 		if (Efuse_PgPacketRead(Adapter, ppgpkt->offset, ppgpkt->data, false) == true)
 			*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
@@ -1100,10 +981,6 @@ int rtl8188eu_oid_rt_pro_rw_efuse_pgpkt_hdl(struct oid_par_priv *poid_par_priv)
 			status = NDIS_STATUS_FAILURE;
 		Efuse_PowerSwitch(Adapter, false, false);
 	} else {
-		RT_TRACE(_module_mp_, _drv_notice_,
-			 ("rtl8188eu_oid_rt_pro_rw_efuse_pgpkt_hdl: Write offset=0x%x word_en=0x%x\n",\
-			 ppgpkt->offset, ppgpkt->word_en));
-
 		Efuse_PowerSwitch(Adapter, true, true);
 		if (Efuse_PgPacketWrite(Adapter, ppgpkt->offset, ppgpkt->word_en, ppgpkt->data, false) == true)
 			*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
@@ -1114,9 +991,6 @@ int rtl8188eu_oid_rt_pro_rw_efuse_pgpkt_hdl(struct oid_par_priv *poid_par_priv)
 
 	_irqlevel_changed_(&oldirql, RAISE);
 
-	RT_TRACE(_module_mp_, _drv_info_,
-		 ("-rtl8188eu_oid_rt_pro_rw_efuse_pgpkt_hdl: status=0x%08X\n", status));
-
 	return status;
 }
 /*  */
@@ -1160,10 +1034,6 @@ int rtl8188eu_oid_rt_get_efuse_max_size_hdl(struct oid_par_priv *poid_par_priv)
 	*(u32 *)poid_par_priv->information_buf = efuse_GetMaxSize(Adapter);
 	*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 
-	RT_TRACE(_module_mp_, _drv_info_,
-		 ("-rtl8188eu_oid_rt_get_efuse_max_size_hdl: size=%d status=0x%08X\n",
-		  *(int *)poid_par_priv->information_buf, status));
-
 	return status;
 }
 /*  */
@@ -1171,15 +1041,11 @@ int rtl8188eu_oid_rt_pro_efuse_hdl(struct oid_par_priv *poid_par_priv)
 {
 	int status;
 
-	RT_TRACE(_module_mp_, _drv_info_, ("+rtl8188eu_oid_rt_pro_efuse_hdl\n"));
-
 	if (poid_par_priv->type_of_oid == QUERY_OID)
 		status = rtl8188eu_oid_rt_pro_read_efuse_hdl(poid_par_priv);
 	else
 		status = rtl8188eu_oid_rt_pro_write_efuse_hdl(poid_par_priv);
 
-	RT_TRACE(_module_mp_, _drv_info_, ("-rtl8188eu_oid_rt_pro_efuse_hdl: status=0x%08X\n", status));
-
 	return status;
 }
 /*  */
@@ -1190,8 +1056,6 @@ int rtl8188eu_oid_rt_pro_efuse_map_hdl(struct oid_par_priv *poid_par_priv)
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 	u16	maplen = 0;
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+rtl8188eu_oid_rt_pro_efuse_map_hdl\n"));
-
 	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&maplen, false);
 
 	*poid_par_priv->bytes_rw = 0;
@@ -1204,35 +1068,20 @@ int rtl8188eu_oid_rt_pro_efuse_map_hdl(struct oid_par_priv *poid_par_priv)
 	_irqlevel_changed_(&oldirql, LOWER);
 
 	if (poid_par_priv->type_of_oid == QUERY_OID) {
-		RT_TRACE(_module_mp_, _drv_info_,
-			 ("rtl8188eu_oid_rt_pro_efuse_map_hdl: READ\n"));
-
-		if (rtw_efuse_map_read(Adapter, 0, maplen, data) == _SUCCESS) {
+		if (rtw_efuse_map_read(Adapter, 0, maplen, data) == _SUCCESS)
 			*poid_par_priv->bytes_rw = maplen;
-		} else {
-			RT_TRACE(_module_mp_, _drv_err_,
-				 ("rtl8188eu_oid_rt_pro_efuse_map_hdl: READ fail\n"));
+		else
 			status = NDIS_STATUS_FAILURE;
-		}
 	} else {
 		/*  SET_OID */
-		RT_TRACE(_module_mp_, _drv_info_,
-			 ("rtl8188eu_oid_rt_pro_efuse_map_hdl: WRITE\n"));
-
-		if (rtw_efuse_map_write(Adapter, 0, maplen, data) == _SUCCESS) {
+		if (rtw_efuse_map_write(Adapter, 0, maplen, data) == _SUCCESS)
 			*poid_par_priv->bytes_rw = maplen;
-		} else {
-			RT_TRACE(_module_mp_, _drv_err_,
-				 ("rtl8188eu_oid_rt_pro_efuse_map_hdl: WRITE fail\n"));
+		else
 			status = NDIS_STATUS_FAILURE;
-		}
 	}
 
 	_irqlevel_changed_(&oldirql, RAISE);
 
-	RT_TRACE(_module_mp_, _drv_info_,
-		 ("-rtl8188eu_oid_rt_pro_efuse_map_hdl: status=0x%08X\n", status));
-
 	return status;
 }
 
@@ -1247,8 +1096,6 @@ int rtl8188eu_oid_rt_set_rx_packet_type_hdl(struct oid_par_priv *poid_par_priv)
 	u8		rx_pkt_type;
 	int status = NDIS_STATUS_SUCCESS;
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+rtl8188eu_oid_rt_set_rx_packet_type_hdl\n"));
-
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
 
@@ -1257,8 +1104,6 @@ int rtl8188eu_oid_rt_set_rx_packet_type_hdl(struct oid_par_priv *poid_par_priv)
 
 	rx_pkt_type = *((u8 *)poid_par_priv->information_buf);/* 4 */
 
-	RT_TRACE(_module_mp_, _drv_info_, ("rx_pkt_type: %x\n", rx_pkt_type));
-
 	return status;
 }
 
@@ -1279,8 +1124,6 @@ int rtl8188eu_mp_ioctl_xmit_packet_hdl(struct oid_par_priv *poid_par_priv)
 	struct mp_priv *pmp_priv;
 	struct pkt_attrib *pattrib;
 
-	RT_TRACE(_module_mp_, _drv_notice_, ("+%s\n", __func__));
-
 	pparm = (struct mp_xmit_parm *)poid_par_priv->information_buf;
 	padapter = (struct adapter *)poid_par_priv->adapter_context;
 	pmp_priv = &padapter->mppriv;
@@ -1317,9 +1160,6 @@ int rtl8188eu_oid_rt_set_power_down_hdl(struct oid_par_priv *poid_par_priv)
 		return status;
 	}
 
-	RT_TRACE(_module_mp_, _drv_info_,
-		 ("\n ===> Setrtl8188eu_oid_rt_set_power_down_hdl.\n"));
-
 	_irqlevel_changed_(&oldirql, LOWER);
 
 	/* CALL  the power_down function */
-- 
2.31.1

