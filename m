Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A43DE003
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhHBT1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhHBT1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:27:46 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B59C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 12:27:35 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id l12-20020a4a94cc0000b02902618ad2ea55so4662635ooi.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 12:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PEtNkG8rtc8rv6AzQvRGr9oASXuI9aEj66QUkSN+Z/A=;
        b=B3EEiNnhEvd9uTtO6gbS50HIGmMxNpqG9k7VfsUcDQ+z6kjxx3amdUfSdZRT+qEpmJ
         +fpshSmHuFC/vRdg1nd89m7sUTihdbEqiyCcCi/mmRCAsVddrIrAh1NmVhJc48fkHqJ/
         jiE2XAGP/CSLSrG01ymrKW1TLj8hb5H5Oyc1i9rSQEFT5A1XZyciyuu0FS3IHGoiDqTh
         UJTaW2WglYwokGYf8e5W2/PBy8O+avarNUjcBw50zvVd3/bi4qcZv/gdp7aIz40D9leq
         XZSsg6w1eDuZd4aALvEbahGLEUDz1+k7ZS+ahC0drKqoqxz8m/fQL/ZazCPYb88XVe8i
         VfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PEtNkG8rtc8rv6AzQvRGr9oASXuI9aEj66QUkSN+Z/A=;
        b=IyD3h/6zGVqF//QRtKVvsIq2ApWp1HtgQQTQoMF0FcQDFtX/e4r+BMdUPgQnbMI29X
         b6E8k0Lz9//XlJEioEQLYNZGlN+nb3SjI5kMY0W5I1ShSpZlQu6k/p/Nz3JGaOkh7JC+
         e9iz/Au8IYdM60LAG7c/l9o5Ab9kaUdxAm2OVSCG+Ttw3EWn7H82QeM5IbiVLj2rsPmg
         30UYRT0rxViGLBq0wY2ojiyXWM6tdxdHw9t70nwwNuRRcs3Rps6z40O6yV2S9ck0yrFH
         2oD6Z0AkO4kxGhi8WjRx1M1LwMuFSBPleqpuUPMOyMSR9Jb+FydIH5mdgTP4B0700yAg
         llRA==
X-Gm-Message-State: AOAM532KRaZiktZlUOO3PyUAZxOIbCUUsuftPKA0Gd4sA6i+pNR8SNbR
        RzKspPUHaSgZcQKzKetGJ9rdz7pdzaA=
X-Google-Smtp-Source: ABdhPJzmqnr0ZItZ4FhPQxCyvq1ak7eN7XxNx12rYiKyseh01eIEwkdlvtREDT+j0NYgy0zjG88Flw==
X-Received: by 2002:a4a:be1a:: with SMTP id l26mr12045301oop.27.1627932454672;
        Mon, 02 Aug 2021 12:27:34 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id i188sm1981035oih.7.2021.08.02.12.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 12:27:34 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 3/6] staging: r8188eu: Remove wrappers for atomic operations
Date:   Mon,  2 Aug 2021 14:27:18 -0500
Message-Id: <20210802192721.23110-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802192721.23110-1-Larry.Finger@lwfinger.net>
References: <20210802192721.23110-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These wrappers were useful when this driver had the hooks for Windows,
but are no longer needed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - no change
---
 drivers/staging/r8188eu/core/rtw_cmd.c        |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 14 +++---
 drivers/staging/r8188eu/include/drv_types.h   |  2 +-
 .../staging/r8188eu/include/osdep_service.h   | 14 ------
 drivers/staging/r8188eu/include/rtw_cmd.h     |  2 +-
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 +-
 drivers/staging/r8188eu/include/usb_ops.h     |  4 +-
 .../staging/r8188eu/os_dep/osdep_service.c    | 50 -------------------
 8 files changed, 13 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 55971c47c90a..35222a10b10c 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -64,7 +64,7 @@ int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
 	int res = _SUCCESS;
 
 	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
-	ATOMIC_SET(&pevtpriv->event_seq, 0);
+	atomic_set(&pevtpriv->event_seq, 0);
 	pevtpriv->evt_done_cnt = 0;
 
 	_init_workitem(&pevtpriv->c2h_wk, c2h_wk_callback, NULL);
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index bce2f31e0ac1..a9a8ca157a7d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -204,7 +204,7 @@ static void init_mlme_ext_priv_value(struct adapter *padapter)
 		_12M_RATE_, _24M_RATE_, 0xff,
 	};
 
-	ATOMIC_SET(&pmlmeext->event_seq, 0);
+	atomic_set(&pmlmeext->event_seq, 0);
 	pmlmeext->mgnt_seq = 0;/* reset to zero when disconnect at client mode */
 
 	pmlmeext->cur_channel = padapter->registrypriv.channel;
@@ -7008,7 +7008,7 @@ void report_survey_event(struct adapter *padapter, struct recv_frame *precv_fram
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct survey_event);
 	pc2h_evt_hdr->ID = GEN_EVT_CODE(_Survey);
-	pc2h_evt_hdr->seq = ATOMIC_INC_RETURN(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
 
 	psurvey_evt = (struct survey_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 
@@ -7060,7 +7060,7 @@ void report_surveydone_event(struct adapter *padapter)
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct surveydone_event);
 	pc2h_evt_hdr->ID = GEN_EVT_CODE(_SurveyDone);
-	pc2h_evt_hdr->seq = ATOMIC_INC_RETURN(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
 
 	psurveydone_evt = (struct surveydone_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	psurveydone_evt->bss_cnt = pmlmeext->sitesurvey_res.bss_cnt;
@@ -7106,7 +7106,7 @@ void report_join_res(struct adapter *padapter, int res)
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct joinbss_event);
 	pc2h_evt_hdr->ID = GEN_EVT_CODE(_JoinBss);
-	pc2h_evt_hdr->seq = ATOMIC_INC_RETURN(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
 
 	pjoinbss_evt = (struct joinbss_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	memcpy((unsigned char *)(&(pjoinbss_evt->network.network)), &(pmlmeinfo->network), sizeof(struct wlan_bssid_ex));
@@ -7157,7 +7157,7 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct stadel_event);
 	pc2h_evt_hdr->ID = GEN_EVT_CODE(_DelSTA);
-	pc2h_evt_hdr->seq = ATOMIC_INC_RETURN(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
 
 	pdel_sta_evt = (struct stadel_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	memcpy((unsigned char *)(&(pdel_sta_evt->macaddr)), MacAddr, ETH_ALEN);
@@ -7211,7 +7211,7 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct stassoc_event);
 	pc2h_evt_hdr->ID = GEN_EVT_CODE(_AddSTA);
-	pc2h_evt_hdr->seq = ATOMIC_INC_RETURN(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
 
 	padd_sta_evt = (struct stassoc_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	memcpy((unsigned char *)(&(padd_sta_evt->macaddr)), MacAddr, ETH_ALEN);
@@ -8244,7 +8244,7 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 		goto _abort_event_;
 	}
 
-	ATOMIC_INC(&pevt_priv->event_seq);
+	atomic_inc(&pevt_priv->event_seq);
 
 	peventbuf += 2;
 
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 8cefb5c288f3..04f4224c11de 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -178,7 +178,7 @@ struct dvobj_priv {
 	struct usb_interface *pusbintf;
 	struct usb_device *pusbdev;
 
-	ATOMIC_T continual_urb_error;
+	atomic_t continual_urb_error;
 	u8 signal_strength;
 };
 
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 446f43ac08d3..c70bbca29ccb 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -327,20 +327,6 @@ void rtw_suspend_lock_uninit(void);
 void rtw_lock_suspend(void);
 void rtw_unlock_suspend(void);
 
-/* Atomic integer operations */
-#define ATOMIC_T atomic_t
-
-void ATOMIC_SET(ATOMIC_T *v, int i);
-int ATOMIC_READ(ATOMIC_T *v);
-void ATOMIC_ADD(ATOMIC_T *v, int i);
-void ATOMIC_SUB(ATOMIC_T *v, int i);
-void ATOMIC_INC(ATOMIC_T *v);
-void ATOMIC_DEC(ATOMIC_T *v);
-int ATOMIC_ADD_RETURN(ATOMIC_T *v, int i);
-int ATOMIC_SUB_RETURN(ATOMIC_T *v, int i);
-int ATOMIC_INC_RETURN(ATOMIC_T *v);
-int ATOMIC_DEC_RETURN(ATOMIC_T *v);
-
 struct rtw_netdev_priv_indicator {
 	void *priv;
 	u32 sizeof_priv;
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 0f64b72bb5de..c14d9052b997 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -53,7 +53,7 @@ struct	evt_priv {
 	bool c2h_wk_alive;
 	struct rtw_cbuf *c2h_queue;
 	#define C2H_QUEUE_MAX_LEN 10
-	ATOMIC_T event_seq;
+	atomic_t event_seq;
 	u8	*evt_buf;	/* shall be non-paged, and 4 bytes aligned */
 	u8	*evt_allocated_buf;
 	u32	evt_done_cnt;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index b9c76f04445c..88d4ec073723 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -382,7 +382,7 @@ struct p2p_oper_class_map {
 struct mlme_ext_priv {
 	struct adapter	*padapter;
 	u8	mlmeext_init;
-	ATOMIC_T	event_seq;
+	atomic_t event_seq;
 	u16	mgnt_seq;
 
 	unsigned char	cur_channel;
diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index 273bc2705558..5d290199e37c 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -38,7 +38,7 @@ static inline int rtw_inc_and_chk_continual_urb_error(struct dvobj_priv *dvobj)
 {
 	int ret = false;
 	int value;
-	value = ATOMIC_INC_RETURN(&dvobj->continual_urb_error);
+	value = atomic_inc_return(&dvobj->continual_urb_error);
 	if (value > MAX_CONTINUAL_URB_ERR) {
 		DBG_88E("[dvobj:%p][ERROR] continual_urb_error:%d > %d\n",
 			dvobj, value, MAX_CONTINUAL_URB_ERR);
@@ -52,7 +52,7 @@ static inline int rtw_inc_and_chk_continual_urb_error(struct dvobj_priv *dvobj)
 */
 static inline void rtw_reset_continual_urb_error(struct dvobj_priv *dvobj)
 {
-	ATOMIC_SET(&dvobj->continual_urb_error, 0);
+	atomic_set(&dvobj->continual_urb_error, 0);
 }
 
 #define USB_HIGH_SPEED_BULK_SIZE	512
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index ec877615bdf7..f44b7dea95ed 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -183,56 +183,6 @@ inline void rtw_unlock_suspend(void)
 {
 }
 
-inline void ATOMIC_SET(ATOMIC_T *v, int i)
-{
-	atomic_set(v, i);
-}
-
-inline int ATOMIC_READ(ATOMIC_T *v)
-{
-	return atomic_read(v);
-}
-
-inline void ATOMIC_ADD(ATOMIC_T *v, int i)
-{
-	atomic_add(i, v);
-}
-
-inline void ATOMIC_SUB(ATOMIC_T *v, int i)
-{
-	atomic_sub(i, v);
-}
-
-inline void ATOMIC_INC(ATOMIC_T *v)
-{
-	atomic_inc(v);
-}
-
-inline void ATOMIC_DEC(ATOMIC_T *v)
-{
-	atomic_dec(v);
-}
-
-inline int ATOMIC_ADD_RETURN(ATOMIC_T *v, int i)
-{
-	return atomic_add_return(i, v);
-}
-
-inline int ATOMIC_SUB_RETURN(ATOMIC_T *v, int i)
-{
-	return atomic_sub_return(i, v);
-}
-
-inline int ATOMIC_INC_RETURN(ATOMIC_T *v)
-{
-	return atomic_inc_return(v);
-}
-
-inline int ATOMIC_DEC_RETURN(ATOMIC_T *v)
-{
-	return atomic_dec_return(v);
-}
-
 static const struct device_type wlan_type = {
 	.name = "wlan",
 };
-- 
2.32.0

