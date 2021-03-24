Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BED0347D03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbhCXPv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbhCXPuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:50:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD01C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:50:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so1498431wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ee/0DFi50t32XH2vtWd2YSvKTPzoN1Hc/KWGiRKf/k0=;
        b=q2pjfXDPZmZDFvQEbRQdPNP5ZxWTNSAZCgF8iEQBVdMfUXd0Xefg9qL/qLAbQUcgld
         ECaV1vg5Ak8FPaIkFlk/uJY7jQXxbeF4+9Qf93qoWmgjVhZGeO5XpBO2S4HyeE6L8irc
         QH8e8zDBw3qtxvA4IVFEMdTmHbGaNlJJbfUfzzZAHN+5Pp6YWFYwR0kJiWemjAMpq/nR
         sJK5CFvZp4Mzkq0CdXH2fNf4S9iT/i/iUMFY934YsZHx+hUPYO36MN7H9oA5QuaE0ikb
         X3Td+H+m2qEF1WM6j0BkG/JFkzlu+EAOCJo3O1+MteAUgKksgWU6nAzXkGtzR3Abp69Q
         qzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ee/0DFi50t32XH2vtWd2YSvKTPzoN1Hc/KWGiRKf/k0=;
        b=c26VmmWQqtc/Wjil8k2gUM1/979fMtjSaLu1jtnJBcjCScs9XF+g8pqt6K5c0GLIeG
         EWRniJLBtQt7asstRcDuzJQvjNmFVqXhBC2W13uPzYL5FPM7tSuPagZn4rND0DtlTjp/
         FDpSvtdmIkAtIRPILHx7RB+S1bhubyIfom3aPxalNSO0Gk7elO70/FTY5OnsjT10TQmb
         fUCxsTj2Y2KjWfRQkMSBjSdsFXoFzJ5Ad2wC7aUCXhFj5+VOnIKUjfT/GjTThFy8Ioha
         nmRuArOmh7hbgogwi2tenME6a2UAJ8Iep7rkerwqg2Pl5i8waKOzOAYLo83fS3jr9uPm
         XtRQ==
X-Gm-Message-State: AOAM531gq4fcZNy7S8WBE9aWBuVGhwRKbjLOnztKMwVktBbBCQXMf7Oe
        i0abd1IANyFGzz6GFuPJSdE=
X-Google-Smtp-Source: ABdhPJyZi1nYik2DJCGgHYA3he+heaO9joG9ZXpBUAUOR3NBMcMY/G+meputvIuMS6le/OOKgId6FQ==
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr3623314wml.22.1616601052494;
        Wed, 24 Mar 2021 08:50:52 -0700 (PDT)
Received: from agape ([5.171.72.168])
        by smtp.gmail.com with ESMTPSA id i26sm3011798wmb.18.2021.03.24.08.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:50:52 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 2/3] staging: rtl8723bs: remove assignment in condition in os_dep/ioctl_cfg80211.c
Date:   Wed, 24 Mar 2021 16:50:35 +0100
Message-Id: <cc687c2ff614da3e110addd1c5cd610e3356cbd7.1616600897.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616600897.git.fabioaiuto83@gmail.com>
References: <cover.1616600897.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warning:

ERROR: do not use assignment in if condition
1440: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:1440:
+		if ((wps_ie = rtw_get_wps_ie(buf, len, NULL, &wps_ielen)))
--
ERROR: do not use assignment in if condition
2465: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2465:
+		if ((pmgntframe = alloc_mgtxmitframe(pxmitpriv)) == NULL)
--
ERROR: do not use assignment in if condition
2937: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2937:
+	if ((pmgntframe = alloc_mgtxmitframe(pxmitpriv)) == NULL) {
--
ERROR: do not use assignment in if condition
3335: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:3335:
+	if (!(ndev = wdev_to_ndev(wdev)))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 03a784558d79..8deaf98a83dd 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1437,7 +1437,8 @@ static int rtw_cfg80211_set_probe_req_wpsp2pie(struct adapter *padapter, char *b
 
 	if (len > 0)
 	{
-		if ((wps_ie = rtw_get_wps_ie(buf, len, NULL, &wps_ielen)))
+		wps_ie = rtw_get_wps_ie(buf, len, NULL, &wps_ielen);
+		if (wps_ie)
 		{
 			#ifdef DEBUG_CFG80211
 			DBG_8192C("probe_req_wps_ielen =%d\n", wps_ielen);
@@ -2462,7 +2463,8 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 			DBG_871X("RTW_Tx:category(%u), action(%u)\n", category, action);
 
 		/* starting alloc mgmt frame to dump it */
-		if ((pmgntframe = alloc_mgtxmitframe(pxmitpriv)) == NULL)
+		pmgntframe = alloc_mgtxmitframe(pxmitpriv);
+		if (!pmgntframe)
 			goto fail;
 
 		/* update attribute */
@@ -2934,7 +2936,8 @@ static int _cfg80211_rtw_mgmt_tx(struct adapter *padapter, u8 tx_ch, const u8 *b
 	}
 
 	/* starting alloc mgmt frame to dump it */
-	if ((pmgntframe = alloc_mgtxmitframe(pxmitpriv)) == NULL) {
+	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
+	if (!pmgntframe) {
 		/* ret = -ENOMEM; */
 		ret = _FAIL;
 		goto exit;
@@ -3331,8 +3334,8 @@ void rtw_wdev_unregister(struct wireless_dev *wdev)
 
 	if (!wdev)
 		return;
-
-	if (!(ndev = wdev_to_ndev(wdev)))
+	ndev = wdev_to_ndev(wdev);
+	if (!ndev)
 		return;
 
 	adapter = rtw_netdev_priv(ndev);
-- 
2.20.1

