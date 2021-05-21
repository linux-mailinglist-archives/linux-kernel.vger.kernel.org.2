Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBD938CF1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhEUUdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhEUUdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:33:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:32:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so7801970pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zAjIInRkcAPnvRSXRMSjpPPh//qx55oU9vc7kwz7eTI=;
        b=HLJFTCkJnkgtGXJar/MP5LyxaXIiy8UFFTe4SrefUSwsXqHT46bQ02vWXFLGWogWmt
         2UTnGSMSLEAwh15w0v6hHyPlr4I0SgWsw3Hjmeq11TpBkH0MfhbigKo1E+5bDqvu6S3I
         0dULC5M4VPchq8IhIE4+Kf7yfyNZFrzQPfm1PQOCYJZtc19/LBJN3yjXND4EKNKkXtz9
         TUUiEwBbR+fbyKmMmhY/0FZPAjC/t1vPTe2hi6ia/41KwNYx6xCXMgRlWVvFqEN3gLIf
         rbHwOVgGb1Cpt1TbQMTZYFqaX8FkAVOnrople0Ed2OoB/ZgS3oMzkHj1h3lbzCrTnyK9
         0uEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zAjIInRkcAPnvRSXRMSjpPPh//qx55oU9vc7kwz7eTI=;
        b=eKq0pqdFBdA3CzagyQFn76ypnSSliiIEFaERWjmSEjleXPH/Xj4dG3Jmja4oykO0SB
         oc2vLBQmMJ2MYUKHUdw96WVRhKSoppSLsPaYljsjJxClaDH2lVPUW/zI2QAh+G7ft4oO
         zHk+WhKBEVp8Mq2wV491Nbjyk3a3050jMnhCFOaTgzAicWmZ4XnED9qNQYFCRo98bAqf
         7nkVp2CVzpbj1G6v46rDcBHrD1W5NtJoXCqreDYPYUR3E0kXSRZK7+ZOLClXdWoMEF8n
         yiDPRvvGxaxrwDwouo0bNTDAND/bhdtPvJkNUVsOxkTZmZwQ0w3Kof7mPZmd210103PS
         6IMA==
X-Gm-Message-State: AOAM532CFvmblyvHeIOUnPp937t7vo3jExfSmilSKuu288LXkQwEKxev
        Ey5eCsLzgYRnB0hdWJsm1PbyWks4q+CyxZua
X-Google-Smtp-Source: ABdhPJx7suhiAoRfRREnlx7pp89xajFo2U9nwC6XlOYf/5DcMpfekpbbwjBkcMjpo4wNJI3+Pnz9ag==
X-Received: by 2002:a17:90b:14c3:: with SMTP id jz3mr12491599pjb.152.1621629126162;
        Fri, 21 May 2021 13:32:06 -0700 (PDT)
Received: from fedora ([112.79.121.149])
        by smtp.gmail.com with ESMTPSA id d22sm5028761pgb.15.2021.05.21.13.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:32:05 -0700 (PDT)
Date:   Sat, 22 May 2021 02:02:00 +0530
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, straube.linux@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: staging: rtl8723bs: questions regarding refactor for reducing
 indents in core/rtw_wlan_util.c
Message-ID: <YKgYwFlnGI6Tk7fB@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to fix the following warnings by checkpatch for the file
core/rtw_wlan_util.c:

WARNING: Too many leading tabs - consider code refactoring
#887: FILE: rtw_wlan_util.c:887:
+                                               if ((edca[j] >> 16) > (edca[i] >> 16))

WARNING: Too many leading tabs - consider code refactoring
#1529: FILE: rtw_wlan_util.c:1529:
+                                               if (pIE->data[5] & RT_HT_CAP_USE_92SE)

WARNING: Too many leading tabs - consider code refactoring
#1537: FILE: rtw_wlan_util.c:1537:
+                                               if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT)

WARNING: Too many leading tabs - consider code refactoring
#1540: FILE: rtw_wlan_util.c:1540:
+                                               if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT)

Would a patch similar to this diff be fine?

I am unsure about the names of these functions. I tried searching about
what the code is doing, and came accross probing, authentication and
association phases between a station and an AP. However, I wasn't able
to find anything about what the code is trying to do by updating the
edca ac parameters.

If these names are not fine, (which they probably aren't,) please
suggest better names. It might help me better understand what the code
in these functions actually does.

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index ce47ef4edea0..c4dda6a585f3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -777,6 +777,32 @@ int WMM_param_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 	return true;
 }

For the following function, I read the comment right next to the
declaration of wmm_para_seq in the xmit_priv struct (include/rtw_xmit.h
line #270) and saw that the code essentially was a bubble sort,
(mentioned after this paragraph,) and kept the name sort_wmm_ac_params.

/*
 * sequence for wmm ac parameter strength
 * from large to small. it's value is 0->vo,
 * 1->vi, 2->be, 3->bk.
 */

+static void sort_wmm_ac_params(u32 *inx, u32 *edca)
+{
+	u32 i, j, change_inx = false;
+
+	/* entry indx: 0->vo, 1->vi, 2->be, 3->bk. */
+	for (i = 0; i < 4; i++) {
+		for (j = i + 1; j < 4; j++) {
+			/* compare CW and AIFS */
+			if ((edca[j] & 0xFFFF) < (edca[i] & 0xFFFF)) {
+				change_inx = true;
+			} else if ((edca[j] & 0xFFFF) == (edca[i] & 0xFFFF)) {
+				/* compare TXOP */
+				if ((edca[j] >> 16) > (edca[i] >> 16))
+					change_inx = true;
+			}
+
+			if (change_inx) {
+				swap(edca[i], edca[j]);
+				swap(inx[i], inx[j]);
+
+				change_inx = false;
+			}
+		}
+	}
+}
+
 void WMMOnAssocRsp(struct adapter *padapter)
 {
 	u8 ACI, ACM, AIFS, ECWMin, ECWMax, aSifsTime;
@@ -873,35 +899,8 @@ void WMMOnAssocRsp(struct adapter *padapter)

 		inx[0] = 0; inx[1] = 1; inx[2] = 2; inx[3] = 3;

-		if (pregpriv->wifi_spec == 1) {
-			u32 j, tmp, change_inx = false;
-
-			/* entry indx: 0->vo, 1->vi, 2->be, 3->bk. */
-			for (i = 0; i < 4; i++) {
-				for (j = i+1; j < 4; j++) {
-					/* compare CW and AIFS */
-					if ((edca[j] & 0xFFFF) < (edca[i] & 0xFFFF)) {
-						change_inx = true;
-					} else if ((edca[j] & 0xFFFF) == (edca[i] & 0xFFFF)) {
-						/* compare TXOP */
-						if ((edca[j] >> 16) > (edca[i] >> 16))
-							change_inx = true;
-					}
-
-					if (change_inx) {
-						tmp = edca[i];
-						edca[i] = edca[j];
-						edca[j] = tmp;
-
-						tmp = inx[i];
-						inx[i] = inx[j];
-						inx[j] = tmp;
-
-						change_inx = false;
-					}
-				}
-			}
-		}
+		if (pregpriv->wifi_spec == 1)
+			sort_wmm_ac_params(inx, edca);

 		for (i = 0; i < 4; i++)
 			pxmitpriv->wmm_para_seq[i] = inx[i];
@@ -1496,6 +1495,34 @@ void set_sta_rate(struct adapter *padapter, struct sta_info *psta)
 	Update_RA_Entry(padapter, psta);
 }

I tried naming the following function according to what I think it is doing.

+static u32 get_realtek_assoc_AP_vendor(struct ndis_80211_var_ie *pIE)
+{
+	u32 Vendor = HT_IOT_PEER_REALTEK;
+
+	if (pIE->Length >= 5) {
+		// get_vendor(pIE->data);
+		if (pIE->data[4] == 1)
+			/* if (pIE->data[5] & RT_HT_CAP_USE_LONG_PREAMBLE) */
+			/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_LONG_PREAMBLE; */
+			if (pIE->data[5] & RT_HT_CAP_USE_92SE)
+				/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_92SE; */
+				Vendor = HT_IOT_PEER_REALTEK_92SE;
+
+		if (pIE->data[5] & RT_HT_CAP_USE_SOFTAP)
+			Vendor = HT_IOT_PEER_REALTEK_SOFTAP;
+
+		if (pIE->data[4] == 2) {
+			if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT)
+				Vendor = HT_IOT_PEER_REALTEK_JAGUAR_BCUTAP;
+
+			if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT)
+				Vendor = HT_IOT_PEER_REALTEK_JAGUAR_CCUTAP;
+		}
+	}
+
+	return Vendor;
+}
+
 unsigned char check_assoc_AP(u8 *pframe, uint len)
 {
 	unsigned int	i;
@@ -1519,29 +1546,7 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 			} else if (!memcmp(pIE->data, CISCO_OUI, 3)) {
 				return HT_IOT_PEER_CISCO;
 			} else if (!memcmp(pIE->data, REALTEK_OUI, 3)) {
-				u32 Vender = HT_IOT_PEER_REALTEK;
-
-				if (pIE->Length >= 5) {
-					if (pIE->data[4] == 1)
-						/* if (pIE->data[5] & RT_HT_CAP_USE_LONG_PREAMBLE) */
-						/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_LONG_PREAMBLE; */
-						if (pIE->data[5] & RT_HT_CAP_USE_92SE)
-							/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_92SE; */
-							Vender = HT_IOT_PEER_REALTEK_92SE;
-
-					if (pIE->data[5] & RT_HT_CAP_USE_SOFTAP)
-						Vender = HT_IOT_PEER_REALTEK_SOFTAP;
-
-					if (pIE->data[4] == 2) {
-						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT)
-							Vender = HT_IOT_PEER_REALTEK_JAGUAR_BCUTAP;
-
-						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT)
-							Vender = HT_IOT_PEER_REALTEK_JAGUAR_CCUTAP;
-					}
-				}
-
-				return Vender;
+				return get_realtek_assoc_AP_vendor(pIE);
 			} else if (!memcmp(pIE->data, AIRGOCAP_OUI, 3)) {
 				return HT_IOT_PEER_AIRGO;
 			} else {

Thanks,
-- Shreyansh
