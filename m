Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0D3DCDD8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 23:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhHAVEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 17:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhHAVEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 17:04:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F288C0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 14:04:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so9793804wmq.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVtsRpshvjxSGDOxwbBdf63+kQjdGeYHZIUcQhDzSgA=;
        b=gpHKST3HB4NXldnmI+x+hCvAheWaAriYHvkebnH3dX8JgXRrPg/MtYTpygrgzkXXGu
         LInhcpBVaETCHnlfe8TOLHUTIAC7MxftusCzmD5FdJL43vjNV6DwElw0IbIhraMzvdNu
         bz4efMHemNUJ2Foko4td5gn7kd/zlaExYDCCj3iJgfzIY17hwZnAwpvJMjiaXpb96D/T
         KXcAX8Kxp4x4ez3HXVX35e7Setrz4be433ePHFx+dmno5kiNcNJv7nQRdJV/ghwy1UYu
         7oaFtYuBACxyttWjJd5vxdFHoqSaFsUo9o/4b5AG5BjbS2c2K30Ka2VO2xdNE/l3qX+L
         O5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVtsRpshvjxSGDOxwbBdf63+kQjdGeYHZIUcQhDzSgA=;
        b=p6wbZr4vnkaRRa6GiOKrxzZrGwdJh3SFGWvZ4Dt6vWTXI4+H3qeXUVBZjemaECH+ue
         aft6GdqWj0ATsxuy96uxMaedvtESN7r8f1rkvBRaYduvjZcCQWimcYy29OxrgPWc6jw2
         koY/+LvjvSZbDf6K8DIzkacv6ZTODH/DDJPFr+fiw39eb358PLTfGOcPVsl7u3VBGhw9
         RsOMXJGAS1uhx74b1gBNGBJ2TxIG2F8AhLml5k8dyBlIEafPA/jfIHSrydJyZcX5fHDp
         5oT5hDgXP3KZzVAgd8pF6+PIjmFk8bS/QX/iWjqQkGGjc5ju1Ez+NmAUTMIHy3/cW+YR
         kkzg==
X-Gm-Message-State: AOAM5339rXe8j/X0mPtM6Tp8RrA16yzoi/BTCuguRXqpghas9ojooWYW
        KbheZfa1sCBaRRs1xznZFvI=
X-Google-Smtp-Source: ABdhPJx1x72/9jIFNpJ6nGCF16SW7cQOiJSnkpn2+SHHF3utY8SJScuFPcWI2tOa3kSoPA0pXVXOuw==
X-Received: by 2002:a1c:32c1:: with SMTP id y184mr13129109wmy.70.1627851873035;
        Sun, 01 Aug 2021 14:04:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id f15sm8629709wrp.12.2021.08.01.14.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 14:04:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove return from void functions
Date:   Sun,  1 Aug 2021 23:03:53 +0200
Message-Id: <20210801210354.25218-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove return from void functions to clear checkpatch warnings.

WARNING: void function return statements are not generally useful

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c      |  7 -----
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 30 --------------------
 drivers/staging/r8188eu/core/rtw_p2p.c       |  2 --
 drivers/staging/r8188eu/core/rtw_pwrctrl.c   |  1 -
 drivers/staging/r8188eu/core/rtw_security.c  |  2 --
 drivers/staging/r8188eu/core/rtw_wlan_util.c |  4 ---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c   |  1 -
 drivers/staging/r8188eu/hal/rtl8188e_dm.c    |  1 -
 drivers/staging/r8188eu/hal/rtl8188e_mp.c    |  2 --
 drivers/staging/r8188eu/os_dep/usb_intf.c    |  2 --
 10 files changed, 52 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index af4b7053686f..3ee83f2dc1c9 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -330,8 +330,6 @@ void rtw_generate_random_ibss(u8 *pibss)
 	pibss[3] = (u8)(curtime & 0xff);/* p[0]; */
 	pibss[4] = (u8)((curtime>>8) & 0xff);/* p[1]; */
 	pibss[5] = (u8)((curtime>>16) & 0xff);/* p[2]; */
-
-	return;
 }
 
 u8 *rtw_get_capability_from_ie(u8 *ie)
@@ -702,10 +700,7 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 /* TODO: Perry: For Power Management */
 void rtw_atimdone_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
-
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("receive atimdone_evet\n"));
-
-	return;
 }
 
 void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
@@ -752,8 +747,6 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 exit:
 
 	spin_unlock_bh(&pmlmepriv->lock);
-
-	return;
 }
 
 void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 00650888a2e3..62c77800bfd1 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -2149,8 +2149,6 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	dump_mgntframe(padapter, pmgntframe);
-
-	return;
 }
 
 static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame_body, uint len, u8 result)
@@ -2514,7 +2512,6 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	dump_mgntframe(padapter, pmgntframe);
-	return;
 }
 
 static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
@@ -2677,7 +2674,6 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, p2pielen, (unsigned char *)p2pie, &pattrib->pktlen);
 	pattrib->last_txcmdsz = pattrib->pktlen;
 	dump_mgntframe(padapter, pmgntframe);
-	return;
 }
 
 void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
@@ -2925,8 +2921,6 @@ void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	dump_mgntframe(padapter, pmgntframe);
-
-	return;
 }
 
 void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialogToken, u8 status_code)
@@ -3117,8 +3111,6 @@ void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialo
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	dump_mgntframe(padapter, pmgntframe);
-
-	return;
 }
 
 void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidlen, u8 *pdev_raddr)
@@ -3214,8 +3206,6 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidle
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	dump_mgntframe(padapter, pmgntframe);
-
-	return;
 }
 
 static u8 is_matched_in_profilelist(u8 *peermacaddr, struct profile_info *profileinfo)
@@ -3480,8 +3470,6 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	dump_mgntframe(padapter, pmgntframe);
-
-	return;
 }
 
 static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
@@ -4813,8 +4801,6 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	dump_mgntframe(padapter, pmgntframe);
-
-	return;
 }
 
 static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *pssid, u8 *da, int wait_ack)
@@ -5084,8 +5070,6 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	rtw_wep_encrypt(padapter, (u8 *)pmgntframe);
 	DBG_88E("%s\n", __func__);
 	dump_mgntframe(padapter, pmgntframe);
-
-	return;
 }
 
 void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_info *pstat, int pkt_type)
@@ -5556,8 +5540,6 @@ void issue_assocreq(struct adapter *padapter)
 		pmlmepriv->assoc_req = NULL;
 		pmlmepriv->assoc_req_len = 0;
 	}
-
-	return;
 }
 
 /* when wait_ack is ture, this function shoule be called at process context */
@@ -6473,7 +6455,6 @@ void site_survey(struct adapter *padapter)
 			issue_action_BSSCoexistPacket(padapter);
 		}
 	}
-	return;
 }
 
 /* collect bss info from Beacon and Probe request/response frames. */
@@ -7028,8 +7009,6 @@ void report_survey_event(struct adapter *padapter, struct recv_frame *precv_fram
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 
 	pmlmeext->sitesurvey_res.bss_cnt++;
-
-	return;
 }
 
 void report_surveydone_event(struct adapter *padapter)
@@ -7073,8 +7052,6 @@ void report_surveydone_event(struct adapter *padapter)
 	DBG_88E("survey done event(%x)\n", psurveydone_evt->bss_cnt);
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
-
-	return;
 }
 
 void report_join_res(struct adapter *padapter, int res)
@@ -7123,8 +7100,6 @@ void report_join_res(struct adapter *padapter, int res)
 	rtw_joinbss_event_prehandle(padapter, (u8 *)&pjoinbss_evt->network);
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
-
-	return;
 }
 
 void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsigned short reason)
@@ -7179,8 +7154,6 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	DBG_88E("report_del_sta_event: delete STA, mac_id =%d\n", mac_id);
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
-
-	return;
 }
 
 void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int cam_idx)
@@ -7225,8 +7198,6 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	DBG_88E("report_add_sta_event: add STA\n");
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
-
-	return;
 }
 
 /****************************************************************************
@@ -7667,7 +7638,6 @@ void link_timer_hdl(struct adapter *padapter)
 		issue_assocreq(padapter);
 		set_link_timer(pmlmeext, REASSOC_TO);
 	}
-	return;
 }
 
 void addba_timer_hdl(struct sta_info *psta)
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index ce30161535c1..c19360ea09a4 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -312,8 +312,6 @@ static void issue_p2p_provision_resp(struct wifidirect_info *pwdinfo, u8 *raddr,
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	dump_mgntframe(padapter, pmgntframe);
-
-	return;
 }
 
 static void issue_p2p_presence_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 status, u8 dialogToken)
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index d67eeb045002..80268a7d4388 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -189,7 +189,6 @@ void rtw_ps_processor(struct adapter *padapter)
 exit:
 	rtw_set_pwr_state_check_timer(&padapter->pwrctrlpriv);
 	pwrpriv->ps_processing = false;
-	return;
 }
 
 static void pwr_state_check_handler(struct timer_list *t)
diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 66c730a5d754..df8107a0f5f2 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -180,8 +180,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 				 &crc, &payload[length-4]));
 		}
 	}
-
-	return;
 }
 
 /* 3		===== TKIP related ===== */
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index db133ffad8f9..4bc42f18d6cc 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -648,8 +648,6 @@ void WMMOnAssocRsp(struct adapter *padapter)
 		pxmitpriv->wmm_para_seq[i] = inx[i];
 		DBG_88E("wmm_para_seq(%d): %d\n", i, pxmitpriv->wmm_para_seq[i]);
 	}
-
-	return;
 }
 
 static void bwmode_update_check(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
@@ -777,7 +775,6 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 		else
 			pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= MCS_rate_2R[i];
 	}
-	return;
 }
 
 void HT_info_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
@@ -798,7 +795,6 @@ void HT_info_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 
 	pmlmeinfo->HT_info_enable = 1;
 	memcpy(&(pmlmeinfo->HT_info), pIE->data, pIE->Length);
-	return;
 }
 
 void HTOnAssocRsp(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 62219a908097..03fe29e16f1d 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -345,5 +345,4 @@ bool ODM_DynamicPrimaryCCA_DupRTS(struct odm_dm_struct *dm_odm)
 
 void odm_DynamicPrimaryCCA(struct odm_dm_struct *dm_odm)
 {
-	return;
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 0e264c39d636..b5f42127a751 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -182,7 +182,6 @@ void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
 skip_dm:
 	/*  Check GPIO to determine current RF on/off and Pbc status. */
 	/*  Check Hardware Radio ON/OFF or not */
-	return;
 }
 
 void rtl8188e_init_dm_priv(struct adapter *Adapter)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index 510906cc6007..a7893aa469ac 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -67,8 +67,6 @@ void Hal_mpt_SwitchRfSetting(struct adapter *pAdapter)
 		pmp->MptCtx.backup0x52_RF_B = (u8)PHY_QueryRFReg(pAdapter, RF_PATH_B, RF_0x52, 0x000F0);
 		PHY_SetRFReg(pAdapter, RF_PATH_A, RF_0x52, 0x000F0, 0xD);
 		PHY_SetRFReg(pAdapter, RF_PATH_B, RF_0x52, 0x000F0, 0xD);
-
-	return;
 }
 /*---------------------------hal\rtl8192c\MPT_Phy.c---------------------------*/
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index bc7f4bd7ce0b..ffa2f150f937 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -808,8 +808,6 @@ static void rtw_dev_remove(struct usb_interface *pusb_intf)
 
 	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-dev_remove()\n"));
 	DBG_88E("-r871xu_dev_remove, done\n");
-
-	return;
 }
 
 static int __init rtw_drv_entry(void)
-- 
2.32.0

