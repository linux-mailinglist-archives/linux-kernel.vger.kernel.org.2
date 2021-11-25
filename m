Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCB545E140
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350828AbhKYUFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhKYUDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:03:02 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FA7C06175E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 11:59:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r8so13868956wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 11:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/cNpwvsVw5GnP7KSiepDl/i+9GFtJwQXsibbr5JQe8=;
        b=pYeGygMRdsV3331w3VLITX78jVO5iIYPmE8miaanEBH4h2twT4wKUw/H1yAuF9CVwg
         3PVPrBD1EBvjB0mtH5KOitqTI5lT8xidGBpDOnmufGuHRR7YJrj5T0UuHgDP8KuSFrlP
         pNMj5aMIl3SVtlnFLGtGdP5iN8q5rMxe9fL3eaWjXHRm3t3tlQj7Lp23HKLx3xZb9agM
         9mBuCZvoD7YBtA7Jg67jgzVpVP8cgL8ZLDJStygP0VTsOL3EQovsn7THVti7MOGhKc63
         dd997/SI+4K961h8X+dFdXyXhKxfxtbEdjDyluT+FPrqlfFideWVZqIuUnM2XhIBLAZz
         0e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/cNpwvsVw5GnP7KSiepDl/i+9GFtJwQXsibbr5JQe8=;
        b=giUHzc6m6163QNB2d4xt4FFxWxkIr8aD1p9UZChB0W2Kmc31/Rp0wQSgov03stGYYu
         G9N07x2cEtXMB4CkR8SHhCvznF4WJ0ODuIPs9ACgi99yXjISD4BFXHysxvRn9dCrWVg2
         KDTbFi+t/mkFlEJ5PIhCtZFYCKRa1uSyWe6dKvy6TY97TwTQPsOjhl3fUvwIMzCQtyGR
         T3ya/nJCPlMqt72506FLRmtlAYkaWIs0LzSSon2zRFrXKmy8o+H8ZG/N9l8iPgGg75DI
         vuJJljO6YRLylqlFpJvNgLwtpKmhCr3zAAEfWmFoMKXWMq+9YrzyvZqo1m1dubyiT5Hl
         Tykg==
X-Gm-Message-State: AOAM532I1GAGcn2knrvTCDpor0zW+6+p1Yg3TDOFE3X9Zkr2FGFW0UlB
        PtuzrYGGHobXuVJ1RbkDJMWA/3X4+MU=
X-Google-Smtp-Source: ABdhPJz/WtcDeDn7aR33eiKK836tVo64FoUHD8vjC83csXPi4iJRqN/ymLL2HdOClqFh4aZQ8c3rVg==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr9763270wrx.156.1637870389525;
        Thu, 25 Nov 2021 11:59:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id h13sm3762721wrx.82.2021.11.25.11.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 11:59:49 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: r8188eu: remove rf_type from issue_assocreq()
Date:   Thu, 25 Nov 2021 20:59:33 +0100
Message-Id: <20211125195936.10060-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211125195936.10060-1-straube.linux@gmail.com>
References: <20211125195936.10060-1-straube.linux@gmail.com>
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
2.33.1

