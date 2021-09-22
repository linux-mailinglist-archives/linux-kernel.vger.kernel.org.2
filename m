Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91BA415107
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbhIVUHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbhIVUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07DDC061787
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t8so10455438wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9I9vMIQg+0BbxbJjr8qu2UfCcY+b7hViYPAZXGsXVmA=;
        b=PE6tE7UlAFr855Szmqol3jDht1Gyv779EH2/G5xvSaJBgGcirkh9lCUx3FofHAvRMQ
         HqMK0iv2JE3R7YlBJagAF0nKyQ2TfKMh9MIoAZaYO8ja4d9IaO7jwQvGZ3TUNDBtxXgV
         aCmJ9D3aSZmNcI7vD4OiAwBZrP/52kUeocjVRA5d+t/YmCCrmj6bZ+MkdnD7vOW3UvKg
         aXF4aaUV6y0ruMrziAMdAo5WQRIU2PqOsHPimMjkXI+DC1alvt+aSJSCaaJJA2bua/yW
         WifwWzRBGFdIg7lDuqFovbrZ7x4YXmt4Rks7n/Bi04ROmuzlKvScE93nzLkJIKWCOQIQ
         nKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9I9vMIQg+0BbxbJjr8qu2UfCcY+b7hViYPAZXGsXVmA=;
        b=EuVAFiwtOPMCZlWpygFAOP0aNYRXnBkSZjHLJducd84TA5UTj4GuQL+y5Tp40bmAoh
         exl40klLAxBUf0Cz/AQwNyYRhujWaab1Lngur89dO955gb47jhtM3NrsFbMia3y0nFsH
         lqz0PD2aJ9n0LNsEdcKp4LFGXoMEWvNv41Hy8o9zjSIaWSZm3m9wQxeyUS+UxbjCymBW
         VRPzX9QidzNVi5zqg9CT2hRc2sv6o6zZ7GW2O/O0oWHmyl2GSxqmR4oDojEEHtV0KH1P
         yL4IPb3L3cxtp1okbwzJf6fkZrAramVm2hF34pfTgZsDdiNDMXxkCFInifdzk7TVZ80R
         v8Bw==
X-Gm-Message-State: AOAM531beDKT6lXmQHoZK3tpsj2BMCToiXsvEnBOq2KbTvpIp5fNs5wq
        uUAl0Z03KSYGMzFEz7K4osc=
X-Google-Smtp-Source: ABdhPJw/7GPr8tf8j6SwTtOldZluGYGnhLBPWF0DbxCRbtDbfzgFaJVvE0IXSACvnpHRUbYtPvp+yQ==
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr881451wmq.62.1632341147475;
        Wed, 22 Sep 2021 13:05:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 23/47] staging: r8188eu: remove rtw_validate_ssid()
Date:   Wed, 22 Sep 2021 22:03:56 +0200
Message-Id: <20210922200420.9693-24-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_validate_ssid() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  | 23 -------------------
 .../staging/r8188eu/include/rtw_ioctl_set.h   |  1 -
 2 files changed, 24 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 222c7f696279..62ab7fbdcee0 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -13,29 +13,6 @@
 
 extern void indicate_wx_scan_complete_event(struct adapter *padapter);
 
-u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
-{
-	u8	 i;
-	u8	ret = true;
-
-	if (ssid->SsidLength > 32) {
-		ret = false;
-		goto exit;
-	}
-
-	for (i = 0; i < ssid->SsidLength; i++) {
-		/* wifi, printable ascii code must be supported */
-		if (!((ssid->Ssid[i] >= 0x20) && (ssid->Ssid[i] <= 0x7e))) {
-			ret = false;
-			break;
-		}
-	}
-
-exit:
-
-	return ret;
-}
-
 u8 rtw_do_join(struct adapter *padapter)
 {
 	struct list_head *plist, *phead;
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_set.h b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
index 32885d8e42ff..d84ae57494e7 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl_set.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
@@ -19,7 +19,6 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter*adapter,
 u8 rtw_set_802_11_infrastructure_mode(struct adapter *adapter,
 				      enum ndis_802_11_network_infra type);
 u8 rtw_set_802_11_ssid(struct adapter *adapt, struct ndis_802_11_ssid *ssid);
-u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid);
 u16 rtw_get_cur_max_rate(struct adapter *adapter);
 int rtw_set_channel_plan(struct adapter *adapter, u8 channel_plan);
 int rtw_change_ifname(struct adapter *padapter, const char *ifname);
-- 
2.33.0

