Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7698E3EDA66
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhHPQAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbhHPQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69FDC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q6so12842212wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTop8HQmEzqB3xL9XUIKc3+nGBNTzbj4vdHct+bRfwU=;
        b=cccvNkhln0hCRD/xljX46L49zDYIhJM7S8ifqghmDYVamLkWW5Iq/NPxxbcRqsSRuD
         m4yih5DiEyBmpum+9AFnJKf3s5roEWRfIPlJa3379tnfb+O4XexT7J14cGJL3+VuKeu8
         U4F4cX7wC5cfoyiYqPPGcZSvXONoV4I3yodJBD+djM0VfTrSXe7FupD89HjSFL1BJ311
         ceuKDcC0tnSH/ugwKtkuoIkOOT5KDh6Ojn7bl4bKVLXg6eKchs/ODLzKJjbX/foaNwXb
         Hv34Rs4n67pGpIgPH18XOMqPqezphaWHllaeZ2B+nQFI7yuz6xzGVn6fZb2c0wab8bzp
         ygpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTop8HQmEzqB3xL9XUIKc3+nGBNTzbj4vdHct+bRfwU=;
        b=Gess4No9llEXfij948pJxjQ4OTObMvGoyHwyclC6Hnh2X4skBk+oFE+xGESaL0m2eh
         CImXZx3F6T+ryVEQileCaRX7PsarUu7V1BfNyHFzL94RIUt5Ap+CLsPElHNfa9EkeDHu
         WD8Uwv4GDZv4NsmujHt57EZF2WiEEd3pekcMZgWGLTYxjVDGDWO6gTwFa8HBR+DKRNG0
         H38RG7REp7eweQXKGrp+4IZdv/eUcwHhQ1lNC6ecVzx7kvkME7ASSzZFC58k1QGskfsC
         eVtkV+SeWGLdy4VwaWPbbnaXHApiANc23EE9W8TxBZuI65IVp8i/OE2DjqBfmO7F1MQW
         5F1A==
X-Gm-Message-State: AOAM531XNg8si0yn+5JjtQBJRoSt5Rhes+zJxpjAxLk6eAhLet4HGW2p
        E29hwzcNUro0xXLcb4vmGrc=
X-Google-Smtp-Source: ABdhPJycStlqdFu95X0kt8eO4NSpI7ALDTT44aRo6R0yRWO21f/b5w+KYFXo2spaUiOkD/iSyJAZMA==
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr19165623wrm.59.1629129576883;
        Mon, 16 Aug 2021 08:59:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 14/23] staging: r8188eu: clean up spacing style issues in core/rtw_p2p.c
Date:   Mon, 16 Aug 2021 17:58:09 +0200
Message-Id: <20210816155818.24005-15-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_p2p.c reported by checkpatch.

CHECK: spaces preferred around that ...
CHECK: No space is necessary after a cast
WARNING: space prohibited before semicolon
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c | 46 +++++++++++++-------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 1c2c6193b7af..e2b6cf2386e0 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -75,8 +75,8 @@ static u32 go_add_group_info_attr(struct wifidirect_info *pwdinfo, u8 *pbuf)
 			*pcur = psta->num_of_secdev_type;
 			pcur++;
 
-			memcpy(pcur, psta->secdev_types_list, psta->num_of_secdev_type*8);
-			pcur += psta->num_of_secdev_type*8;
+			memcpy(pcur, psta->secdev_types_list, psta->num_of_secdev_type * 8);
+			pcur += psta->num_of_secdev_type * 8;
 
 			if (psta->dev_name_len > 0) {
 				/* u16*)(pcur) = cpu_to_be16(WPS_ATTR_DEVICE_NAME); */
@@ -91,9 +91,9 @@ static u32 go_add_group_info_attr(struct wifidirect_info *pwdinfo, u8 *pbuf)
 				pcur += psta->dev_name_len;
 			}
 
-			tmplen = (u8)(pcur-pstart);
+			tmplen = (u8)(pcur - pstart);
 
-			*pstart = (tmplen-1);
+			*pstart = (tmplen - 1);
 
 			attr_len += tmplen;
 
@@ -419,10 +419,10 @@ u32 build_beacon_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pbuf)
 	/*	Be able to participate in additional P2P Groups and */
 	/*	support the P2P Invitation Procedure */
 	/*	Group Capability Bitmap, 1 byte */
-	capability = P2P_DEVCAP_INVITATION_PROC|P2P_DEVCAP_CLIENT_DISCOVERABILITY;
+	capability = P2P_DEVCAP_INVITATION_PROC | P2P_DEVCAP_CLIENT_DISCOVERABILITY;
 	capability |=  ((P2P_GRPCAP_GO | P2P_GRPCAP_INTRABSS) << 8);
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_PROVISIONING_ING))
-		capability |= (P2P_GRPCAP_GROUP_FORMATION<<8);
+		capability |= (P2P_GRPCAP_GROUP_FORMATION << 8);
 
 	le_tmp = cpu_to_le16(capability);
 	p2pielen += rtw_set_p2p_attr_content(&p2pie[p2pielen], P2P_ATTR_CAPABILITY, 2, (u8 *)&le_tmp);
@@ -790,7 +790,7 @@ u32 process_probe_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 	if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_DEVICE) || rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO)) {
 		p2pie = rtw_get_p2p_ie(pframe + WLAN_HDR_A3_LEN + _PROBEREQ_IE_OFFSET_, len - WLAN_HDR_A3_LEN - _PROBEREQ_IE_OFFSET_, NULL, &p2pielen);
 		if (p2pie) {
-			if (p && !memcmp((void *)(p+2), (void *)pwdinfo->p2p_wildcard_ssid, 7)) {
+			if (p && !memcmp((void *)(p + 2), (void *)pwdinfo->p2p_wildcard_ssid, 7)) {
 				/* todo: */
 				/* Check Requested Device Type attributes in WSC IE. */
 				/* Check Device ID attribute in P2P IE */
@@ -847,7 +847,7 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_CAPABILITY, (u8 *)&le_tmp, (uint *)&attr_contentlen)) {
 			DBG_88E("[%s] Got P2P Capability Attr!!\n", __func__);
 			cap_attr = le16_to_cpu(le_tmp);
-			psta->dev_cap = cap_attr&0xff;
+			psta->dev_cap = cap_attr & 0xff;
 		}
 
 		/* Check Extended Listen Timing ATTR */
@@ -886,28 +886,28 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 
 					psta->num_of_secdev_type = num_of_secdev_type;
 
-					len = (sizeof(psta->secdev_types_list) < (num_of_secdev_type*8)) ?
-					      (sizeof(psta->secdev_types_list)) : (num_of_secdev_type*8);
+					len = (sizeof(psta->secdev_types_list) < (num_of_secdev_type * 8)) ?
+					      (sizeof(psta->secdev_types_list)) : (num_of_secdev_type * 8);
 
 					memcpy(psta->secdev_types_list, pattr_content, len);
 
-					pattr_content += (num_of_secdev_type*8);
+					pattr_content += (num_of_secdev_type * 8);
 				}
 
 				psta->dev_name_len = 0;
 				if (WPS_ATTR_DEVICE_NAME == be16_to_cpu(*(__be16 *)pattr_content)) {
-					dev_name_len = be16_to_cpu(*(__be16 *)(pattr_content+2));
+					dev_name_len = be16_to_cpu(*(__be16 *)(pattr_content + 2));
 
 					psta->dev_name_len = (sizeof(psta->dev_name) < dev_name_len) ? sizeof(psta->dev_name) : dev_name_len;
 
-					memcpy(psta->dev_name, pattr_content+4, psta->dev_name_len);
+					memcpy(psta->dev_name, pattr_content + 4, psta->dev_name_len);
 				}
 				kfree(pbuf);
 			}
 		}
 
 		/* Get the next P2P IE */
-		p2p_ie = rtw_get_p2p_ie(p2p_ie+p2p_ielen, ies_len - (p2p_ie - ies + p2p_ielen), NULL, &p2p_ielen);
+		p2p_ie = rtw_get_p2p_ie(p2p_ie + p2p_ielen, ies_len - (p2p_ie - ies + p2p_ielen), NULL, &p2p_ielen);
 	}
 
 	return status_code;
@@ -936,7 +936,7 @@ u32 process_p2p_devdisc_req(struct wifidirect_info *pwdinfo, u8 *pframe, uint le
 
 		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GROUP_ID, groupid, &attr_contentlen)) {
 			if (!memcmp(pwdinfo->device_addr, groupid, ETH_ALEN) &&
-			    !memcmp(pwdinfo->p2p_group_ssid, groupid+ETH_ALEN, pwdinfo->p2p_group_ssid_len)) {
+			    !memcmp(pwdinfo->p2p_group_ssid, groupid + ETH_ALEN, pwdinfo->p2p_group_ssid_len)) {
 				attr_contentlen = 0;
 				if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_DEVICE_ID, dev_addr, &attr_contentlen)) {
 					struct list_head *phead, *plist;
@@ -951,7 +951,7 @@ u32 process_p2p_devdisc_req(struct wifidirect_info *pwdinfo, u8 *pframe, uint le
 
 						plist = plist->next;
 
-						if (psta->is_p2p_device && (psta->dev_cap&P2P_DEVCAP_CLIENT_DISCOVERABILITY) &&
+						if (psta->is_p2p_device && (psta->dev_cap & P2P_DEVCAP_CLIENT_DISCOVERABILITY) &&
 						    !memcmp(psta->dev_addr, dev_addr, ETH_ALEN)) {
 							/* issue GO Discoverability Request */
 							issue_group_disc_req(pwdinfo, psta->hwaddr);
@@ -1038,7 +1038,7 @@ static u8 rtw_p2p_get_peer_ch_list(struct wifidirect_info *pwdinfo, u8 *ch_conte
 			peer_ch_list[j] = *(ch_content + 1 + i);
 		ch_content += (temp + 1);
 		ch_cnt -= (temp + 1);
-		ch_no += temp ;
+		ch_no += temp;
 	}
 
 	return ch_no;
@@ -1198,7 +1198,7 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 		}
 
 		/* Get the next P2P IE */
-		p2p_ie = rtw_get_p2p_ie(p2p_ie+p2p_ielen, ies_len - (p2p_ie - ies + p2p_ielen), NULL, &p2p_ielen);
+		p2p_ie = rtw_get_p2p_ie(p2p_ie + p2p_ielen, ies_len - (p2p_ie - ies + p2p_ielen), NULL, &p2p_ielen);
 	}
 	return result;
 }
@@ -1360,7 +1360,7 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 			}
 
 			/* Get the next P2P IE */
-			p2p_ie = rtw_get_p2p_ie(p2p_ie+p2p_ielen, ies_len - (p2p_ie - ies + p2p_ielen), NULL, &p2p_ielen);
+			p2p_ie = rtw_get_p2p_ie(p2p_ie + p2p_ielen, ies_len - (p2p_ie - ies + p2p_ielen), NULL, &p2p_ielen);
 		}
 	}
 	return result;
@@ -1431,7 +1431,7 @@ u8 process_p2p_group_negotation_confirm(struct wifidirect_info *pwdinfo, u8 *pfr
 		}
 
 		/* Get the next P2P IE */
-		p2p_ie = rtw_get_p2p_ie(p2p_ie+p2p_ielen, ies_len - (p2p_ie - ies + p2p_ielen), NULL, &p2p_ielen);
+		p2p_ie = rtw_get_p2p_ie(p2p_ie + p2p_ielen, ies_len - (p2p_ie - ies + p2p_ielen), NULL, &p2p_ielen);
 	}
 	return result;
 }
@@ -1623,7 +1623,7 @@ void process_p2p_ps_ie(struct adapter *padapter, u8 *IEs, u32 IELength)
 		}
 
 		/* Get the next P2P IE */
-		p2p_ie = rtw_get_p2p_ie(p2p_ie+p2p_ielen, ies_len - (p2p_ie - ies + p2p_ielen), NULL, &p2p_ielen);
+		p2p_ie = rtw_get_p2p_ie(p2p_ie + p2p_ielen, ies_len - (p2p_ie - ies + p2p_ielen), NULL, &p2p_ielen);
 	}
 
 	if (find_p2p) {
@@ -1740,7 +1740,7 @@ static void reset_ch_sitesurvey_timer_process(struct timer_list *t)
 	pwdinfo->rx_invitereq_info.scan_op_ch_only = 0;
 }
 
-static void reset_ch_sitesurvey_timer_process2 (struct timer_list *t)
+static void reset_ch_sitesurvey_timer_process2(struct timer_list *t)
 {
 	struct adapter *adapter = from_timer(adapter, t, pwrctrlpriv.pwr_state_check_timer);
 	struct	wifidirect_info		*pwdinfo = &adapter->wdinfo;
@@ -1902,7 +1902,7 @@ void init_wifidirect_info(struct adapter *padapter, enum P2P_ROLE role)
 
 	rtw_p2p_findphase_ex_set(pwdinfo, P2P_FINDPHASE_EX_NONE);
 
-	pwdinfo->listen_dwell = (u8) ((jiffies % 3) + 1);
+	pwdinfo->listen_dwell = (u8)((jiffies % 3) + 1);
 
 	memset(&pwdinfo->tx_prov_disc_info, 0x00, sizeof(struct tx_provdisc_req_info));
 	pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_NONE;
-- 
2.32.0

