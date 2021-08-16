Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28C3EDA5D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhHPQAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhHPP77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:59:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4C7C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z9so24273732wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sYq+g207LjJtSbvJASB4VmxsuSwSS6X25wNvk6tbDlM=;
        b=jSl4CiufFJg5iRUUbmX7TQgJsill7iIBRGYpylTbBDEs0eerD98OoSKlGVHvbb57ay
         h3pKYIwcHdUL36hSV4ZpMV1PfoLYqLUmw8lri9DLI3cLUQPgr/o/MltSjHy4+EGlr4KV
         tsjBf5CIgfWaJKTugsgZ1JxGrCE6GrPG76dpuRtElj5/+87eF7EmZImo/JcV0fylbLJz
         VUrA67+kJNbb8FWNH6VzVrsMHEQwFD3gfeQfdyagOAlRtcGGtQbypTJfMZQrQ0F27Cmf
         fyDVaksclt+37PRU99vqkhy9qZKWZPla8h23DPN0HHnikSgnBrQlw3CRzemobxJY1lbY
         F9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sYq+g207LjJtSbvJASB4VmxsuSwSS6X25wNvk6tbDlM=;
        b=OHy4kQaydWSYGa9Cc7esyjcQPrIDrBHw9RK0vMIkX6FRJpv51dWQT/HMIK3h7Gy5HV
         JRVOz+WLGCRgNUjoFDWK3IzaV6+x84gE+RoCwcto/MH2r8534JJ1xBpSf1w9c2rU2XL7
         kCvs6HDXWBNwgYQHu2vUXWRzCKxxCef3QfQuD5gy2kHXXL+6RJeh5XFOQE0nEisiECwU
         1b8DL1g03GZUEfOrqZ0RASVz32KSGlqrkk2qTcRbeMV9XHbdajyzjwdP+Kfp8pEi0vf4
         JWdUxxN4PYYyZBL7g4uHn+jQieTLIhX7DOj1/u1U1WAnOhDsbEygDBwbfVajkGTNcss7
         /ELA==
X-Gm-Message-State: AOAM533bWOmwZgGE+IDFNXbuWujdP2wVAbUOKR5YtB5mNGvfhYEAaUTE
        fL3SxZOserS/a2QgNYi2/6I=
X-Google-Smtp-Source: ABdhPJzaV8hofW+oGJqBBIxGsT9DjZbWrn7KjBCkazqKGPZLEZbExmfoP9bDUTYGM3DVWKQNzG7YwQ==
X-Received: by 2002:a05:6000:14f:: with SMTP id r15mr11255392wrx.18.1629129566390;
        Mon, 16 Aug 2021 08:59:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/23] staging: r8188eu: clean up spacing style issues in core/rtw_ieee80211.c
Date:   Mon, 16 Aug 2021 17:58:01 +0200
Message-Id: <20210816155818.24005-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_ieee80211.c reported by
checkpatch.

CHECK: spaces preferred around that ...
CHECK: No space is necessary after a cast
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 124 +++++++++----------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 0c7231cefdda..add97664510c 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -140,7 +140,7 @@ u8 *rtw_set_ie
 	return pbuf + len + 2;
 }
 
-inline u8 *rtw_set_ie_ch_switch (u8 *buf, u32 *buf_len, u8 ch_switch_mode,
+inline u8 *rtw_set_ie_ch_switch(u8 *buf, u32 *buf_len, u8 ch_switch_mode,
 	u8 new_ch, u8 ch_switch_cnt)
 {
 	u8 ie_data[3];
@@ -187,8 +187,8 @@ inline u8 *rtw_set_ie_mesh_ch_switch_parm(u8 *buf, u32 *buf_len, u8 ttl,
 
 	ie_data[0] = ttl;
 	ie_data[1] = flags;
-	*(u16 *)(ie_data+2) = cpu_to_le16(reason);
-	*(u16 *)(ie_data+4) = cpu_to_le16(precedence);
+	*(u16 *)(ie_data + 2) = cpu_to_le16(reason);
+	*(u16 *)(ie_data + 4) = cpu_to_le16(precedence);
 
 	return rtw_set_ie(buf, 0x118,  6, ie_data, buf_len);
 }
@@ -251,18 +251,18 @@ u8 *rtw_get_ie_ex(u8 *in_ie, uint in_len, u8 eid, u8 *oui, u8 oui_len, u8 *ie, u
 	cnt = 0;
 
 	while (cnt < in_len) {
-		if (eid == in_ie[cnt] && (!oui || !memcmp(&in_ie[cnt+2], oui, oui_len))) {
+		if (eid == in_ie[cnt] && (!oui || !memcmp(&in_ie[cnt + 2], oui, oui_len))) {
 			target_ie = &in_ie[cnt];
 
 			if (ie)
-				memcpy(ie, &in_ie[cnt], in_ie[cnt+1]+2);
+				memcpy(ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 
 			if (ielen)
-				*ielen = in_ie[cnt+1]+2;
+				*ielen = in_ie[cnt + 1] + 2;
 
 			break;
 		} else {
-			cnt += in_ie[cnt+1]+2; /* goto next */
+			cnt += in_ie[cnt + 1] + 2; /* goto next */
 		}
 	}
 	return target_ie;
@@ -427,7 +427,7 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
 
 		if (pbuf) {
 			/* check if oui matches... */
-			if (memcmp((pbuf + 2), wpa_oui_type, sizeof (wpa_oui_type)))
+			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type)))
 				goto check_next_ie;
 
 			/* check version... */
@@ -503,8 +503,8 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		return _FAIL;
 	}
 
-	if ((*wpa_ie != _WPA_IE_ID_) || (*(wpa_ie+1) != (u8)(wpa_ie_len - 2)) ||
-	    (memcmp(wpa_ie+2, RTW_WPA_OUI_TYPE, WPA_SELECTOR_LEN)))
+	if ((*wpa_ie != _WPA_IE_ID_) || (*(wpa_ie + 1) != (u8)(wpa_ie_len - 2)) ||
+	    (memcmp(wpa_ie + 2, RTW_WPA_OUI_TYPE, WPA_SELECTOR_LEN)))
 		return _FAIL;
 
 	pos = wpa_ie;
@@ -563,7 +563,7 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		return _FAIL;
 	}
 
-	if ((*rsn_ie != _WPA2_IE_ID_) || (*(rsn_ie+1) != (u8)(rsn_ie_len - 2)))
+	if ((*rsn_ie != _WPA2_IE_ID_) || (*(rsn_ie + 1) != (u8)(rsn_ie_len - 2)))
 		return _FAIL;
 
 	pos = rsn_ie;
@@ -624,21 +624,21 @@ int rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie,
 	while (cnt < in_len) {
 		authmode = in_ie[cnt];
 
-		if ((authmode == _WPA_IE_ID_) && (!memcmp(&in_ie[cnt+2], &wpa_oui[0], 4))) {
+		if ((authmode == _WPA_IE_ID_) && (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
 				if (wpa_ie)
-					memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt+1]+2);
+					memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 
-				*wpa_len = in_ie[cnt+1]+2;
-				cnt += in_ie[cnt+1]+2;  /* get next */
+				*wpa_len = in_ie[cnt + 1] + 2;
+				cnt += in_ie[cnt + 1] + 2;  /* get next */
 		} else {
 			if (authmode == _WPA2_IE_ID_) {
 				if (rsn_ie)
-					memcpy(rsn_ie, &in_ie[cnt], in_ie[cnt+1]+2);
+					memcpy(rsn_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 
-				*rsn_len = in_ie[cnt+1]+2;
-				cnt += in_ie[cnt+1]+2;  /* get next */
+				*rsn_len = in_ie[cnt + 1] + 2;
+				cnt += in_ie[cnt + 1] + 2;  /* get next */
 			} else {
-				cnt += in_ie[cnt+1]+2;   /* get next */
+				cnt += in_ie[cnt + 1] + 2;   /* get next */
 			}
 		}
 	}
@@ -657,7 +657,7 @@ u8 rtw_is_wps_ie(u8 *ie_ptr, uint *wps_ielen)
 	eid = ie_ptr[0];
 
 	if ((eid == _WPA_IE_ID_) && (!memcmp(&ie_ptr[2], wps_oui, 4))) {
-		*wps_ielen = ie_ptr[1]+2;
+		*wps_ielen = ie_ptr[1] + 2;
 		match = true;
 	}
 	return match;
@@ -689,20 +689,20 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 	while (cnt < in_len) {
 		eid = in_ie[cnt];
 
-		if ((eid == _WPA_IE_ID_) && (!memcmp(&in_ie[cnt+2], wps_oui, 4))) {
+		if ((eid == _WPA_IE_ID_) && (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
 			wpsie_ptr = &in_ie[cnt];
 
 			if (wps_ie)
-				memcpy(wps_ie, &in_ie[cnt], in_ie[cnt+1]+2);
+				memcpy(wps_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 
 			if (wps_ielen)
-				*wps_ielen = in_ie[cnt+1]+2;
+				*wps_ielen = in_ie[cnt + 1] + 2;
 
-			cnt += in_ie[cnt+1]+2;
+			cnt += in_ie[cnt + 1] + 2;
 
 			break;
 		} else {
-			cnt += in_ie[cnt+1]+2; /* goto next */
+			cnt += in_ie[cnt + 1] + 2; /* goto next */
 		}
 	}
 	return wpsie_ptr;
@@ -776,12 +776,12 @@ u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8
 
 	if (attr_ptr && attr_len) {
 		if (buf_content)
-			memcpy(buf_content, attr_ptr+4, attr_len-4);
+			memcpy(buf_content, attr_ptr + 4, attr_len - 4);
 
 		if (len_content)
-			*len_content = attr_len-4;
+			*len_content = attr_len - 4;
 
-		return attr_ptr+4;
+		return attr_ptr + 4;
 	}
 
 	return NULL;
@@ -799,7 +799,7 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	if (elen < 4) {
 		if (show_errors) {
 			DBG_88E("short vendor specific information element ignored (len=%lu)\n",
-				(unsigned long) elen);
+				(unsigned long)elen);
 		}
 		return -1;
 	}
@@ -819,7 +819,7 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 		case WME_OUI_TYPE: /* this is a Wi-Fi WME info. element */
 			if (elen < 5) {
 				DBG_88E("short WME information element ignored (len=%lu)\n",
-					(unsigned long) elen);
+					(unsigned long)elen);
 				return -1;
 			}
 			switch (pos[4]) {
@@ -834,7 +834,7 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 				break;
 			default:
 				DBG_88E("unknown WME information element ignored (subtype=%d len=%lu)\n",
-					pos[4], (unsigned long) elen);
+					pos[4], (unsigned long)elen);
 				return -1;
 			}
 			break;
@@ -845,7 +845,7 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			break;
 		default:
 			DBG_88E("Unknown Microsoft information element ignored (type=%d len=%lu)\n",
-				pos[3], (unsigned long) elen);
+				pos[3], (unsigned long)elen);
 			return -1;
 		}
 		break;
@@ -858,13 +858,13 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			break;
 		default:
 			DBG_88E("Unknown Broadcom information element ignored (type=%d len=%lu)\n",
-				pos[3], (unsigned long) elen);
+				pos[3], (unsigned long)elen);
 			return -1;
 		}
 		break;
 	default:
 		DBG_88E("unknown vendor specific information element ignored (vendor OUI %02x:%02x:%02x len=%lu)\n",
-			pos[0], pos[1], pos[2], (unsigned long) elen);
+			pos[0], pos[1], pos[2], (unsigned long)elen);
 		return -1;
 	}
 	return 0;
@@ -898,7 +898,7 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
 		if (elen > left) {
 			if (show_errors) {
 				DBG_88E("IEEE 802.11 element parse failed (id=%d elen=%d left=%lu)\n",
-					id, elen, (unsigned long) left);
+					id, elen, (unsigned long)left);
 			}
 			return ParseFailed;
 		}
@@ -1057,9 +1057,9 @@ void dump_ies(u8 *buf, u32 buf_len)
 	u8 *pos = (u8 *)buf;
 	u8 id, len;
 
-	while (pos-buf <= buf_len) {
+	while (pos - buf <= buf_len) {
 		id = *pos;
-		len = *(pos+1);
+		len = *(pos + 1);
 
 		DBG_88E("%s ID:%u, LEN:%u\n", __func__, id, len);
 		#ifdef CONFIG_88EU_P2P
@@ -1084,11 +1084,11 @@ void dump_wps_ie(u8 *ie, u32 ie_len)
 		return;
 
 	pos += 6;
-	while (pos-ie < ie_len) {
+	while (pos - ie < ie_len) {
 		id = RTW_GET_BE16(pos);
 		len = RTW_GET_BE16(pos + 2);
 		DBG_88E("%s ID:0x%04x, LEN:%u\n", __func__, id, len);
-		pos += (4+len);
+		pos += (4 + len);
 	}
 }
 
@@ -1106,11 +1106,11 @@ void dump_p2p_ie(u8 *ie, u32 ie_len)
 		return;
 
 	pos += 6;
-	while (pos-ie < ie_len) {
+	while (pos - ie < ie_len) {
 		id = *pos;
-		len = get_unaligned_le16(pos+1);
+		len = get_unaligned_le16(pos + 1);
 		DBG_88E("%s ID:%u, LEN:%u\n", __func__, id, len);
-		pos += (3+len);
+		pos += (3 + len);
 	}
 }
 
@@ -1138,7 +1138,7 @@ u8 *rtw_get_p2p_ie(u8 *in_ie, int in_len, u8 *p2p_ie, uint *p2p_ielen)
 			dump_stack();
 			return NULL;
 		}
-		if ((eid == _VENDOR_SPECIFIC_IE_) && !memcmp(&in_ie[cnt+2], p2p_oui, 4)) {
+		if ((eid == _VENDOR_SPECIFIC_IE_) && !memcmp(&in_ie[cnt + 2], p2p_oui, 4)) {
 			p2p_ie_ptr = in_ie + cnt;
 
 			if (p2p_ie)
@@ -1222,12 +1222,12 @@ u8 *rtw_get_p2p_attr_content(u8 *p2p_ie, uint p2p_ielen, u8 target_attr_id, u8 *
 
 	if (attr_ptr && attr_len) {
 		if (buf_content)
-			memcpy(buf_content, attr_ptr+3, attr_len-3);
+			memcpy(buf_content, attr_ptr + 3, attr_len - 3);
 
 		if (len_content)
-			*len_content = attr_len-3;
+			*len_content = attr_len - 3;
 
-		return attr_ptr+3;
+		return attr_ptr + 3;
 	}
 
 	return NULL;
@@ -1259,13 +1259,13 @@ static uint rtw_p2p_attr_remove(u8 *ie, uint ielen_ori, u8 attr_id)
 	while (1) {
 		target_attr = rtw_get_p2p_attr(ie, ielen, attr_id, NULL, &target_attr_len);
 		if (target_attr && target_attr_len) {
-			u8 *next_attr = target_attr+target_attr_len;
-			uint remain_len = ielen-(next_attr-ie);
+			u8 *next_attr = target_attr + target_attr_len;
+			uint remain_len = ielen - (next_attr - ie);
 
 			memset(target_attr, 0, target_attr_len);
 			memcpy(target_attr, next_attr, remain_len);
-			memset(target_attr+remain_len, 0, target_attr_len);
-			*(ie+1) -= target_attr_len;
+			memset(target_attr + remain_len, 0, target_attr_len);
+			*(ie + 1) -= target_attr_len;
 			ielen -= target_attr_len;
 		} else {
 			break;
@@ -1279,17 +1279,17 @@ void rtw_wlan_bssid_ex_remove_p2p_attr(struct wlan_bssid_ex *bss_ex, u8 attr_id)
 	u8 *p2p_ie;
 	uint p2p_ielen, p2p_ielen_ori;
 
-	p2p_ie = rtw_get_p2p_ie(bss_ex->IEs+_FIXED_IE_LENGTH_, bss_ex->IELength-_FIXED_IE_LENGTH_, NULL, &p2p_ielen_ori);
+	p2p_ie = rtw_get_p2p_ie(bss_ex->IEs + _FIXED_IE_LENGTH_, bss_ex->IELength - _FIXED_IE_LENGTH_, NULL, &p2p_ielen_ori);
 	if (p2p_ie) {
 		p2p_ielen = rtw_p2p_attr_remove(p2p_ie, p2p_ielen_ori, attr_id);
 		if (p2p_ielen != p2p_ielen_ori) {
-			u8 *next_ie_ori = p2p_ie+p2p_ielen_ori;
-			u8 *next_ie = p2p_ie+p2p_ielen;
-			uint remain_len = bss_ex->IELength-(next_ie_ori-bss_ex->IEs);
+			u8 *next_ie_ori = p2p_ie + p2p_ielen_ori;
+			u8 *next_ie = p2p_ie + p2p_ielen;
+			uint remain_len = bss_ex->IELength - (next_ie_ori - bss_ex->IEs);
 
 			memcpy(next_ie, next_ie_ori, remain_len);
-			memset(next_ie+remain_len, 0, p2p_ielen_ori-p2p_ielen);
-			bss_ex->IELength -= p2p_ielen_ori-p2p_ielen;
+			memset(next_ie + remain_len, 0, p2p_ielen_ori - p2p_ielen);
+			bss_ex->IELength -= p2p_ielen_ori - p2p_ielen;
 		}
 	}
 }
@@ -1346,20 +1346,20 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	unsigned char *pbuf;
 	int group_cipher = 0, pairwise_cipher = 0, is8021x = 0;
 	int ret = _FAIL;
-	pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
+	pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength - 12);
 
 	if (pbuf && (wpa_ielen > 0)) {
-		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
+		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is8021x)) {
 			pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 			pnetwork->BcnInfo.group_cipher = group_cipher;
 			pnetwork->BcnInfo.is_8021x = is8021x;
 			ret = _SUCCESS;
 		}
 	} else {
-		pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
+		pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength - 12);
 
 		if (pbuf && (wpa_ielen > 0)) {
-			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
+			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is8021x)) {
 				pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 				pnetwork->BcnInfo.group_cipher = group_cipher;
 				pnetwork->BcnInfo.is_8021x = is8021x;
@@ -1491,8 +1491,8 @@ int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category, u8 *act
 
 	fc = le16_to_cpu(((struct rtw_ieee80211_hdr_3addr *)frame)->frame_ctl);
 
-	if ((fc & (RTW_IEEE80211_FCTL_FTYPE|RTW_IEEE80211_FCTL_STYPE)) !=
-	    (RTW_IEEE80211_FTYPE_MGMT|RTW_IEEE80211_STYPE_ACTION))
+	if ((fc & (RTW_IEEE80211_FCTL_FTYPE | RTW_IEEE80211_FCTL_STYPE)) !=
+	    (RTW_IEEE80211_FTYPE_MGMT | RTW_IEEE80211_STYPE_ACTION))
 		return false;
 
 	c = frame_body[0];
-- 
2.32.0

