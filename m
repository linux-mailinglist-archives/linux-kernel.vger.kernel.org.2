Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA7835FA75
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352439AbhDNSMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbhDNSMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671F6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u21so32811132ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJrwn1454sssqHehz8g/nkG9vVvKy14dYg0aKBzWpPg=;
        b=YnV5IDqisjNL6H9MnxAEE5C3wbphbYe6gHtC+pVy6rBc9wiAhnAW6+b1O/ipTCGvIY
         OwBSooBFzYl7fJgNuxB+h2FEfPOfHgSk7uC7tivFL5myCxWhTfxa+KszD1lwp/yzu4/Z
         V3YZg7xf/MdpiD54/1ccNYLhAXfMALHn4ghT6wkNkvDSoD+tr0fi1Rv1l4/7T7ZcVVl6
         iuGzCKqvVIvKpTbL0wGlJytjqYvcS4Jxsm4LdJBmsBgUdubkwLyST5e6l5LXyg2i2b1p
         5xnwM6mewP3+PAM6Ckg5LnXLJmSjkhZwLaMQCGqGEFcrhMbRsLdoovqrGspzijGAOnGq
         Uwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJrwn1454sssqHehz8g/nkG9vVvKy14dYg0aKBzWpPg=;
        b=NeR83LgQ3+uPImm+7iTiKh7lmX/pHSPGaLnG3fv7baRK1JJVdiunubpX4NTp1R1rBp
         vqY9QuylIh4n7UXIDv87Od6WMBjS7MYPvQvxK/7BYVBzmiME5odLKewEfUq0e2xHk9Ya
         anRXY1pqg7aDSTTklQTH4/XIoJo/yDFLANDhEZVbeYuf13GvLAU57p+cVPOAZd2c0Q6J
         H664eIp0FByVuSbqgA+rFo52OKcmqD02UZW/eVxpa6dV5cjJYO7JCXHUwIjRPvm2HgnR
         6WwmyycTbOPWjEVwUpx4zrOAClTfqjuMNWmiWeTOdguDQdJVXIlq6Qo15gc7H9E21Abt
         hUnw==
X-Gm-Message-State: AOAM530OlTtNK99NdI6iKG4QHiqvKDogf9DWq68HvMPTvAeaRCT3nxNF
        nN+DU/J7MU+Or5Od3lFD51x0Tw==
X-Google-Smtp-Source: ABdhPJyPutMC/IaaSrE/QZC7LDkMe7cBi2sfQ+/PCon+KgRRJAEAwypOrvs1+U6Xj9GDb2Ctjui0tw==
X-Received: by 2002:a17:906:5fce:: with SMTP id k14mr151351ejv.9.1618423906174;
        Wed, 14 Apr 2021 11:11:46 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 11/57] staging: rtl8723bs: core: rtw_mlme_ext: Deal with a bunch of unused variables
Date:   Wed, 14 Apr 2021 19:10:43 +0100
Message-Id: <20210414181129.1628598-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some are used inside debug prints.  These get marked as __maybe_unused.

Others are used within #ifery.  These are defined inside the same #ifery.

Lastly, ones that are truly unused are removed entirely.

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c: In function ‘OnAssocReq’:
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1058:17: warning: variable ‘reassoc’ set but not used [-Wunused-but-set-variable]
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c: In function ‘OnAction_back’:
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1792:30: warning: variable ‘reason_code’ set but not used [-Wunused-but-set-variable]
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c: In function ‘_linked_info_dump’:
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:5393:21: warning: variable ‘psta’ set but not used [-Wunused-but-set-variable]
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c: In function ‘led_blink_hdl’:
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:6517:25: warning: variable ‘ledBlink_param’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ross Schmidt <ross.schm.dev@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index f19a15a3924b6..d1dbf234e9e02 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1019,7 +1019,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	u16 capab_info;
 	struct rtw_ieee802_11_elems elems;
 	struct sta_info *pstat;
-	unsigned char 	reassoc, *p, *pos, *wpa_ie;
+	unsigned char __maybe_unused reassoc, *p, *pos, *wpa_ie;
 	unsigned char WMM_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
 	int		i, ie_len, wpa_ie_len, left;
 	unsigned char 	supportRate[16];
@@ -1719,7 +1719,7 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 	struct recv_reorder_ctrl *preorder_ctrl;
 	unsigned char 	*frame_body;
 	unsigned char 	category, action;
-	unsigned short	tid, status, reason_code = 0;
+	unsigned short	tid, status, __maybe_unused reason_code = 0;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->u.hdr.rx_data;
@@ -5121,7 +5121,7 @@ void _linked_info_dump(struct adapter *padapter)
 		} else if ((pmlmeinfo->state&0x03) == _HW_STATE_AP_) {
 			struct list_head	*phead, *plist;
 
-			struct sta_info *psta = NULL;
+			struct sta_info __maybe_unused *psta = NULL;
 			struct sta_priv *pstapriv = &padapter->stapriv;
 
 			spin_lock_bh(&pstapriv->asoc_list_lock);
@@ -5980,7 +5980,8 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 
 u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
-	u8 evt_code, evt_seq;
+	u8 evt_seq;
+	u8 evt_code;
 	u16 evt_sz;
 	uint	*peventbuf;
 	void (*event_callback)(struct adapter *dev, u8 *pbuf);
@@ -6191,12 +6192,9 @@ u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
-	struct LedBlink_param *ledBlink_param;
-
 	if (!pbuf)
 		return H2C_PARAMETERS_ERROR;
 
-	ledBlink_param = (struct LedBlink_param *)pbuf;
 	return	H2C_SUCCESS;
 }
 
-- 
2.27.0

