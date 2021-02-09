Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0113144B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhBIAMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBIAMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:12:38 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D26C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 16:11:58 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u14so19443317wri.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 16:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RNW9Ks+8Ua7hv7uVipZV2262XdqhcTBizCH/T1G1OgM=;
        b=ew3ObgYGsAgy2WlW1nZF1b84IQzCCvSkXE3pxwMfh7cMkJvzoTDMG9h+j3bejFPXfP
         gntAoSNN3+jlaTiNM+BlcD489HFYpb/C8fHpqU7rjecGQsr7v5kU1IHdGuK78fXugFWt
         J/uBV8XZdVp7NqkPXWy0JmG3M6xmtGiD+j1FQpmiS6HdrRybyLU0yhwjUvT+GI8UhHuK
         HCDnLm6w6GqusKXvizy3B1BXegPVFh2acBBtzSuG7jEgaEJkBwLB5LF7wGN8yU+VMwJ0
         b1EGfJQARqVBZkCi9KQlpds/InTivMsWD7pjYjXcsf9PXWeo/danYlCyUoD3GNlVfQlu
         ZKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RNW9Ks+8Ua7hv7uVipZV2262XdqhcTBizCH/T1G1OgM=;
        b=pOvfB/HvQ52Aw6HauY2GpwlOZKcqdUOYfjctR0Irc0x1+AkX+MucxSmxWca8aLzU88
         cP9ZYDJZcprcWQssiko+jfX5A5Ni/b0aOPgrRyHv2rFWAnxAp4hzxaAfglwi13eZ0YF9
         PMY576QwAikkn5RSzvNfLn8sz3PlN/ZUHMhruaAf+sJlqU4ufsdYILI/+Ez8FwIkKpPi
         CIPJCwLxpEtKDausUBD+uM7qTjCjomq5fkBKrh+PDxvZIpIfH2dEWjcNTXtspoZcnrG/
         XHPCYJgVk/JC85Kea2QTzG8X47cBdiL1UXDieTA7M8Of5R7ws9wa5WSx4DSmDwQw90yY
         p3XA==
X-Gm-Message-State: AOAM53348Cd5M5tSLDEMquzlp3aL1BrTutj04kCh4TGV01p1IpajtQ3m
        nloSroYE+dPIIIKrHJRBSa0/Eg==
X-Google-Smtp-Source: ABdhPJxe3gEKcJS8/btTXIimaLI1D3TrigItjihX2tvAPs1upNlCdd52JUQ14jY21e/iPKjqcbcZ0Q==
X-Received: by 2002:adf:ee09:: with SMTP id y9mr22494142wrn.74.1612829516674;
        Mon, 08 Feb 2021 16:11:56 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id h9sm7983357wrc.94.2021.02.08.16.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 16:11:56 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     luk@wybcz.pl, ross.schm.dev@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix braces for os_dep/mlme_linux.c
Date:   Tue,  9 Feb 2021 00:11:53 +0000
Message-Id: <20210209001153.165135-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add braces to both branches of an if block for consistency, and also
remove braces from a single line for loop. Fixes a checkpatch check
and warning, thus clearing this file of any brace check/warning
notices.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index fb2df871c0cb..d46c65ab384b 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -48,8 +48,9 @@ void rtw_os_indicate_connect(struct adapter *adapter)
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
 		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
 		rtw_cfg80211_ibss_indicate_connect(adapter);
-	} else
+	} else {
 		rtw_cfg80211_indicate_connect(adapter);
+	}
 
 	rtw_indicate_wx_assoc_event(adapter);
 	netif_carrier_on(adapter->pnetdev);
@@ -163,9 +164,8 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 		len = sec_ie[1] + 2;
 		len = (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX;
 
-		for (i = 0; i < len; i++) {
+		for (i = 0; i < len; i++)
 			p += sprintf(p, "%02x", sec_ie[i]);
-		}
 
 		p += sprintf(p, ")");
 
-- 
2.29.2

