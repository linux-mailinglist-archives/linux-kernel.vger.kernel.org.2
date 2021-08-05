Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDB93E1CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbhHET1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhHET1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:27:13 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ED0C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:26:57 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id o17-20020a4a64110000b0290263e1ba7ff9so1615083ooc.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Glxub6hV3jqhhp28yTigWHrUbsNVWVHgWYvGXbOQq1c=;
        b=Lx1OOOqVuTpkHy0vBHzXaOabbHyoF/CuaHRZNuJkSfgnDy8Dn44IVBVsVEnZRFLSbP
         XJL13ySueGym4tP70+o/ccJ2K+H1gZglh7cZjKQIZc2YdFyenyCrW1tB+cMDs9g6F5vH
         3uA+f59eQc0LHJL9IixjAxUSiQo3CZ20z2GpdIfePPimU71XCBJd//SM5QLojG9r97q5
         lJqrsjXaZ9Ja92cvLQw5AK8+TsMmAf+cBW36ZyfEJP9d1oC6qoNDvjErgAZethbp/TVu
         BT5hoUFU8nLmOF2nxRrojM6MZ/WiQgaKPv+xGWPyS/+1CPKtKJueRnahrNOoH+pAnuqZ
         ub+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Glxub6hV3jqhhp28yTigWHrUbsNVWVHgWYvGXbOQq1c=;
        b=n7pwl+vj1B2jS2AG2vUeSPCiaD6CadVa/8xFspnQa1eD4dAUYjUjHkEtBWCBoV9uCZ
         LqW1xZpxu08lqpPzWe60lF/13hsfsNm62OIHUf+o6Cy2cDMocq5WUrYESYyVljLsRgaE
         UA8j0pQ2UdgJ9MarD+CXkTnlk11gJZNDkdQmkR9fJQJynfgy9ufGSsHfUMR89EKvYYNu
         eSG8DJSClqDOrdfrqV6lQ4YlOe+aqf/GJNSrs7WE1EFeNLeux04yFy6BbZJYLUdIHJVR
         GWXDk+i19cGfzPp5VcpVw6eZj5LB/q/6HWYO40QokOS2LvU4IXOlqO6WmMNNb+RmC7L6
         i0Mg==
X-Gm-Message-State: AOAM5332ArXck2si9ALNUEMbl4xh5yGjR2rp1NW4LiQen/LHvs+0TOLG
        /pZb1fNZrcgVldC12emZDzY=
X-Google-Smtp-Source: ABdhPJzSvdRF+3sQloTadq9Va7C7feKQ0VYo/CWzvp/DgteLSw0et32kEQxfOygNz8EkkLOAgqWePQ==
X-Received: by 2002:a05:6820:302:: with SMTP id l2mr4417171ooe.87.1628191617116;
        Thu, 05 Aug 2021 12:26:57 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com. [2603:8090:2005:39b3::1016])
        by smtp.gmail.com with ESMTPSA id n7sm1143479otf.45.2021.08.05.12.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 12:26:56 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/6] staging: r8188eu: Remove wrapper routine rtw_msleep_os()
Date:   Thu,  5 Aug 2021 14:26:40 -0500
Message-Id: <20210805192644.15978-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805192644.15978-1-Larry.Finger@lwfinger.net>
References: <20210805192644.15978-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The effect of this macro is to call msleep(). Remove the wrapper.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_cmd.c          |  4 ++--
 drivers/staging/r8188eu/core/rtw_mlme.c         |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c     | 16 ++++++++--------
 drivers/staging/r8188eu/core/rtw_mp.c           |  4 ++--
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c     |  6 +++---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c      |  4 ++--
 drivers/staging/r8188eu/core/rtw_xmit.c         |  4 ++--
 drivers/staging/r8188eu/hal/odm_interface.c     |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_mp.c       |  6 +++---
 drivers/staging/r8188eu/include/osdep_service.h |  1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 10 +++++-----
 drivers/staging/r8188eu/os_dep/osdep_service.c  |  5 -----
 12 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 720b534c29ad..3462543ae143 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -81,7 +81,7 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 
 	_cancel_workitem_sync(&pevtpriv->c2h_wk);
 	while (pevtpriv->c2h_wk_alive)
-		rtw_msleep_os(10);
+		msleep(10);
 
 	while (!rtw_cbuf_empty(pevtpriv->c2h_queue)) {
 		void *c2h = rtw_cbuf_pop(pevtpriv->c2h_queue);
@@ -1820,7 +1820,7 @@ static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 		rtw_hal_get_hwreg(padapter, HW_VAR_CHK_HI_QUEUE_EMPTY, &val);
 
 		while (!val) {
-			rtw_msleep_os(100);
+			msleep(100);
 
 			cnt++;
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index e3d5a721d25c..d4b40c8664af 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1001,7 +1001,7 @@ void rtw_scan_abort(struct adapter *adapter)
 		if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 			break;
 		DBG_88E(FUNC_NDEV_FMT"fw_state=_FW_UNDER_SURVEY!\n", FUNC_NDEV_ARG(adapter->pnetdev));
-		rtw_msleep_os(20);
+		msleep(20);
 	}
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		if (!adapter->bDriverStopped && !adapter->bSurpriseRemoved)
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index fe24f72a3cf1..a9a4007ce063 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3776,7 +3776,7 @@ int issue_probereq_p2p_ex(struct adapter *adapter, u8 *da, int try_cnt, int wait
 			break;
 
 		if (i < try_cnt && wait_ms > 0 && ret == _FAIL)
-			rtw_msleep_os(wait_ms);
+			msleep(wait_ms);
 	} while ((i < try_cnt) && ((ret == _FAIL) || (wait_ms == 0)));
 
 	if (ret != _FAIL) {
@@ -4913,7 +4913,7 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 			break;
 
 		if (i < try_cnt && wait_ms > 0 && ret == _FAIL)
-			rtw_msleep_os(wait_ms);
+			msleep(wait_ms);
 
 	} while ((i < try_cnt) && ((ret == _FAIL) || (wait_ms == 0)));
 
@@ -5628,7 +5628,7 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 			break;
 
 		if (i < try_cnt && wait_ms > 0 && ret == _FAIL)
-			rtw_msleep_os(wait_ms);
+			msleep(wait_ms);
 	} while ((i < try_cnt) && ((ret == _FAIL) || (wait_ms == 0)));
 
 	if (ret != _FAIL) {
@@ -5751,7 +5751,7 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 			break;
 
 		if (i < try_cnt && wait_ms > 0 && ret == _FAIL)
-			rtw_msleep_os(wait_ms);
+			msleep(wait_ms);
 	} while ((i < try_cnt) && ((ret == _FAIL) || (wait_ms == 0)));
 
 	if (ret != _FAIL) {
@@ -5862,7 +5862,7 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 			break;
 
 		if (i < try_cnt && wait_ms > 0 && ret == _FAIL)
-			rtw_msleep_os(wait_ms);
+			msleep(wait_ms);
 	} while ((i < try_cnt) && ((ret == _FAIL) || (wait_ms == 0)));
 
 	if (ret != _FAIL) {
@@ -6350,7 +6350,7 @@ void site_survey(struct adapter *padapter)
 					if (pmlmeext->sitesurvey_res.ssid[i].SsidLength) {
 						/* todo: to issue two probe req??? */
 						issue_probereq(padapter, &(pmlmeext->sitesurvey_res.ssid[i]), NULL);
-						/* rtw_msleep_os(SURVEY_TO>>1); */
+						/* msleep(SURVEY_TO>>1); */
 						issue_probereq(padapter, &(pmlmeext->sitesurvey_res.ssid[i]), NULL);
 					}
 				}
@@ -6358,7 +6358,7 @@ void site_survey(struct adapter *padapter)
 				if (pmlmeext->sitesurvey_res.scan_mode == SCAN_ACTIVE) {
 					/* todo: to issue two probe req??? */
 					issue_probereq(padapter, NULL, NULL);
-					/* rtw_msleep_os(SURVEY_TO>>1); */
+					/* msleep(SURVEY_TO>>1); */
 					issue_probereq(padapter, NULL, NULL);
 				}
 			}
@@ -8255,7 +8255,7 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 			return H2C_SUCCESS;
 
 		if ((pstapriv->tim_bitmap&BIT(0)) && (psta_bmc->sleepq_len > 0)) {
-			rtw_msleep_os(10);/*  10ms, ATIM(HIQ) Windows */
+			msleep(10);/*  10ms, ATIM(HIQ) Windows */
 			spin_lock_bh(&psta_bmc->sleep_q.lock);
 
 			xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 9ff0a19cc680..76db563d3969 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -591,7 +591,7 @@ static int mp_xmit_packet_thread(void *context)
 			    padapter->bDriverStopped) {
 				goto exit;
 			} else {
-				rtw_msleep_os(1);
+				msleep(1);
 				continue;
 			}
 		}
@@ -895,7 +895,7 @@ u32 mp_query_psd(struct adapter *pAdapter, u8 *data)
 		i++;
 	}
 
-	rtw_msleep_os(100);
+	msleep(100);
 	return strlen(data)+1;
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index f465acfa20b8..8fcc74598e5f 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -513,7 +513,7 @@ int rtl8188eu_oid_rt_pro_set_continuous_tx_hdl(struct oid_par_priv *poid_par_pri
 		if (pmp_priv->tx.stop == 0) {
 			pmp_priv->tx.stop = 1;
 			DBG_88E("%s: pkt tx is running...\n", __func__);
-			rtw_msleep_os(5);
+			msleep(5);
 		}
 		pmp_priv->tx.stop = 0;
 		pmp_priv->tx.count = 1;
@@ -542,7 +542,7 @@ int rtl8188eu_oid_rt_pro_set_single_carrier_tx_hdl(struct oid_par_priv *poid_par
 		if (pmp_priv->tx.stop == 0) {
 			pmp_priv->tx.stop = 1;
 			DBG_88E("%s: pkt tx is running...\n", __func__);
-			rtw_msleep_os(5);
+			msleep(5);
 		}
 		pmp_priv->tx.stop = 0;
 		pmp_priv->tx.count = 1;
@@ -571,7 +571,7 @@ int rtl8188eu_oid_rt_pro_set_carrier_suppression_tx_hdl(struct oid_par_priv *poi
 		if (pmp_priv->tx.stop == 0) {
 			pmp_priv->tx.stop = 1;
 			DBG_88E("%s: pkt tx is running...\n", __func__);
-			rtw_msleep_os(5);
+			msleep(5);
 		}
 		pmp_priv->tx.stop = 0;
 		pmp_priv->tx.count = 1;
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 2c029f85d63d..710bc02180c1 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -507,7 +507,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 	if (pwrpriv->ps_processing) {
 		DBG_88E("%s wait ps_processing...\n", __func__);
 		while (pwrpriv->ps_processing && rtw_get_passing_time_ms(start) <= 3000)
-			rtw_msleep_os(10);
+			msleep(10);
 		if (pwrpriv->ps_processing)
 			DBG_88E("%s wait ps_processing timeout\n", __func__);
 		else
@@ -519,7 +519,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		while (pwrpriv->bInSuspend &&
 		       (rtw_get_passing_time_ms(start) <= 3000 ||
 		       (rtw_get_passing_time_ms(start) <= 500)))
-				rtw_msleep_os(10);
+				msleep(10);
 		if (pwrpriv->bInSuspend)
 			DBG_88E("%s wait bInSuspend timeout\n", __func__);
 		else
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index edd5746be556..036f1f9a5d0f 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -134,7 +134,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		/* Tx buf allocation may fail sometimes, so sleep and retry. */
 		res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
 		if (res == _FAIL) {
-			rtw_msleep_os(10);
+			msleep(10);
 			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
 			if (res == _FAIL) {
 				goto exit;
@@ -652,7 +652,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 				rtw_secmicsetkey(&micdata, psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021XGrpKeyid].skey);
 			} else {
 				if (!memcmp(&stainfo->dot11tkiptxmickey.skey[0], null_key, 16)) {
-					/* rtw_msleep_os(10); */
+					/* msleep(10); */
 					return _FAIL;
 				}
 				/* start to calculate the mic code */
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 38f6ae410e53..d39556d4a347 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -147,7 +147,7 @@ void ODM_delay_us(u32 us)
 
 void ODM_sleep_ms(u32 ms)
 {
-	rtw_msleep_os(ms);
+	msleep(ms);
 }
 
 void ODM_sleep_us(u32 us)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index 3defe1a6904d..cc24684945ef 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -541,7 +541,7 @@ u8 Hal_ReadRFThermalMeter(struct adapter *pAdapter)
 void Hal_GetThermalMeter(struct adapter *pAdapter, u8 *value)
 {
 	Hal_TriggerRFThermalMeter(pAdapter);
-	rtw_msleep_os(1000);
+	msleep(1000);
 	*value = Hal_ReadRFThermalMeter(pAdapter);
 }
 
@@ -571,7 +571,7 @@ void Hal_SetSingleCarrierTx(struct adapter *pAdapter, u8 bStart)
 		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bDisable);
 		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bDisable);
 		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
-		rtw_msleep_os(10);
+		msleep(10);
 
 		/* BB Reset */
 		write_bbreg(pAdapter, rPMAC_Reset, bBBResetB, 0x0);
@@ -773,7 +773,7 @@ void Hal_SetOFDMContinuousTx(struct adapter *pAdapter, u8 bStart)
 		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bDisable);
 		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
 		/* Delay 10 ms */
-		rtw_msleep_os(10);
+		msleep(10);
 		/* BB Reset */
 		write_bbreg(pAdapter, rPMAC_Reset, bBBResetB, 0x0);
 		write_bbreg(pAdapter, rPMAC_Reset, bBBResetB, 0x1);
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 87315d1a5c72..5b83f2efd94c 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -232,7 +232,6 @@ s32  rtw_get_time_interval_ms(u32 start, u32 end);
 
 void rtw_sleep_schedulable(int ms);
 
-void rtw_msleep_os(int ms);
 void rtw_usleep_os(int us);
 
 u32  rtw_atoi(u8 *s);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 11301e0f287a..34dce01e469c 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1431,7 +1431,7 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	wait_status = _FW_UNDER_SURVEY | _FW_UNDER_LINKING;
 
 	while (check_fwstate(pmlmepriv, wait_status)) {
-		rtw_msleep_os(30);
+		msleep(30);
 		cnt++;
 		if (cnt > wait_for_surveydone)
 			break;
@@ -2566,7 +2566,7 @@ static int rtw_get_ap_info(struct net_device *dev,
 	}
 
 	while ((check_fwstate(pmlmepriv, (_FW_UNDER_SURVEY|_FW_UNDER_LINKING)))) {
-		rtw_msleep_os(30);
+		msleep(30);
 		cnt++;
 		if (cnt > 100)
 			break;
@@ -6957,7 +6957,7 @@ static int rtw_mp_ctx(struct net_device *dev,
 		struct mp_priv *pmp_priv = &padapter->mppriv;
 		if (pmp_priv->tx.stop == 0) {
 			pmp_priv->tx.stop = 1;
-			rtw_msleep_os(5);
+			msleep(5);
 		}
 		pmp_priv->tx.stop = 0;
 		pmp_priv->tx.count = 1;
@@ -7172,7 +7172,7 @@ static int rtw_mp_reset_stats(struct net_device *dev,
 
 	/* reset phy counter */
 	write_bbreg(padapter, 0xf14, BIT16, 0x1);
-	rtw_msleep_os(10);
+	msleep(10);
 	write_bbreg(padapter, 0xf14, BIT16, 0x0);
 
 	return 0;
@@ -7449,7 +7449,7 @@ static int rtw_mp_get(struct net_device *dev,
 		break;
 	}
 
-	rtw_msleep_os(10); /* delay 5ms for sending pkt before exit adb shell operation */
+	msleep(10); /* delay 5ms for sending pkt before exit adb shell operation */
 	return 0;
 }
 
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index e0eddf44b5c7..a29d10f281e9 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -133,11 +133,6 @@ void rtw_sleep_schedulable(int ms)
 		return;
 }
 
-void rtw_msleep_os(int ms)
-{
-	msleep((unsigned int)ms);
-}
-
 void rtw_usleep_os(int us)
 {
 	if (1 < (us/1000))
-- 
2.32.0

