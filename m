Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AEB4607E1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358812AbhK1RPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358583AbhK1RNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:13:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E18C061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:51 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c4so31351544wrd.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSyWvZx3eDkxPjxqzfYvtkxGCKAVHYBLh3L+7jrtBns=;
        b=ZllLeEGCc7s7MINftbGJsXIYUsCNebAbcQ4hEcWT3Wwmqe6drlxQ6F+1UCbhP4bQZH
         Dhfp3vUd4V2bgstg1pc6mbXjr4U4N/hvz9u7+nq0XbvIRxbNDsLH097qS58rbaXiy4WS
         XqY3LhiAFqnIj2vDaRJNiofDeLSLu70wZsEfYAbyBPPS3nfc5QQ8btz7tAxfM+AC5NdD
         t5GFokPf0BqzT2TrrG6CAkskk+MlP6ScbrInfTE1Q5J6dCZaqYJMp6FAtgQNUuXxGQWC
         IvzyX5vJPBdBR5sck/ss1q/8ST3Kg101Mj8bp00Xz1TuhjtxdU4t5FlmapavoCP58+z3
         Q5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSyWvZx3eDkxPjxqzfYvtkxGCKAVHYBLh3L+7jrtBns=;
        b=a2hHtE93GMn1RybnY4RlwRH/gdaeEtUuQmjv25pvZy1wIOhB5hSmVgGeTMC6C+ftaD
         ZM3Ulr8s3Ju4yXVx80weW8TZQw4TCVI/uNv7SfY8HiKkRYtyH3+nMYugs0E/edsDpAJz
         HELS47YuSvKGppaYsI6o9sHaW0/+hGr+F6pMXkdq7z4cgAxc1S2/82orQRqfXRKZtcAz
         y55rp0sNFrc4iQP6q27fcTV//jbMQg/1qkBDyr3nLN0iZDNkCJAogSAbfFinLbliLEMT
         74dzJHDdY38j4hbukBPEzg5piQJbsOIhJmR7weBbsOpP+wfP8pu0guT3LAIoEmRCwKtz
         1iNw==
X-Gm-Message-State: AOAM531lgBhKuKNgWB80lnepC4hpirYt6mEMUcBcGa36Jf4WRlFNSvpW
        xLObqnn7Lrs18v4gdIbLtZw=
X-Google-Smtp-Source: ABdhPJxiC8AKppWqDImCABdZlrCBa3uTf8rYJUtkiUvPBlTkSrxuFCJUG97zmN8TQTb9Ir7BkAX/0w==
X-Received: by 2002:a5d:5988:: with SMTP id n8mr27400277wri.309.1638119389837;
        Sun, 28 Nov 2021 09:09:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id n15sm18243845wmq.38.2021.11.28.09.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:09:49 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 02/10] staging: r8188eu: remove rf_type from issue_assocreq()
Date:   Sun, 28 Nov 2021 18:09:16 +0100
Message-Id: <20211128170924.5874-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128170924.5874-1-straube.linux@gmail.com>
References: <20211128170924.5874-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rf_type is always RF_1T1R. Remove it from issue_assocreq() and remove
related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 25 +++++----------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 55c3d4a6faeb..bb0b565833cb 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5060,7 +5060,7 @@ void issue_assocreq(struct adapter *padapter)
 	__le16 *fctrl;
 	__le16		le_tmp;
 	unsigned int	i, j, ie_len, index = 0;
-	unsigned char	rf_type, bssrate[NumRates], sta_bssrate[NumRates];
+	unsigned char bssrate[NumRates], sta_bssrate[NumRates];
 	struct ndis_802_11_var_ie *pIE;
 	struct registry_priv	*pregpriv = &padapter->registrypriv;
 	struct xmit_priv		*pxmitpriv = &padapter->xmitpriv;
@@ -5185,25 +5185,10 @@ void issue_assocreq(struct adapter *padapter)
 			/* todo: disable SM power save mode */
 			pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info |= cpu_to_le16(0x000c);
 
-			GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
-			switch (rf_type) {
-			case RF_1T1R:
-				if (pregpriv->rx_stbc)
-					pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info |= cpu_to_le16(0x0100);/* RX STBC One spatial stream */
-				memcpy(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_rate_1R, 16);
-				break;
-			case RF_2T2R:
-			case RF_1T2R:
-			default:
-				if ((pregpriv->rx_stbc == 0x3) ||/* enable for 2.4/5 GHz */
-				    ((pmlmeext->cur_wireless_mode & WIRELESS_11_24N) && (pregpriv->rx_stbc == 0x1)) || /* enable for 2.4GHz */
-				    (pregpriv->wifi_spec == 1)) {
-					DBG_88E("declare supporting RX STBC\n");
-					pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info |= cpu_to_le16(0x0200);/* RX STBC two spatial stream */
-				}
-				memcpy(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_rate_2R, 16);
-				break;
-			}
+			if (pregpriv->rx_stbc)
+				pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info |= cpu_to_le16(0x0100);/* RX STBC One spatial stream */
+			memcpy(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_rate_1R, 16);
+
 			pframe = rtw_set_ie(pframe, _HT_CAPABILITY_IE_, ie_len, (u8 *)(&pmlmeinfo->HT_caps), &pattrib->pktlen);
 		}
 	}
-- 
2.34.0

