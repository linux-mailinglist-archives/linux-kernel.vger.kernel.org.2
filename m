Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237143816CC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 10:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhEOIQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 04:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhEOIQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 04:16:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6412BC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 01:15:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pf4-20020a17090b1d84b029015ccffe0f2eso2799763pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2myGYY0cziyB2Ci5y2caQQe9yM5HE5UndBsXhuUUdA=;
        b=HWz5EW4lytfdAJkp5Euu1d4tmtWlZAMAUArBHbeM1lePTgWmTYF0+cD0IENgL4ugco
         D0OCRwENTS0aWD3Q1WLq1bpHz/oHbUKg371P0/0a/woiSkwHvOlH+mZE9DasB8VtLRtk
         rNFR7BC4zc7/kttAChiyuX3s1m8aMh+u9y+NHzGZH+TDHPp4noS6lst3wZsVp4EFhDkh
         S7i/0BkrUqoTedWsjanOY4FzwI0hEMFJi17YMumFx4xiykDqDl7cezUrdf433gueuHpx
         JMaZM9f3ax2VtfS8bPKUezAT3OceqQ/qOPrMr1Fk2qsSj92tAX/v165KSLsPpQkZyWRC
         /uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2myGYY0cziyB2Ci5y2caQQe9yM5HE5UndBsXhuUUdA=;
        b=gcqDjtz6kjaHud5mxSzJV0rMtUpyqvJRmKSmI3aeAqQtmdB8eLzbyOynISh2nuDMKL
         +LAh1xRIOIdLFpSAvn/J+0er60E/wfnyMmGYv1wm7MatYsUxjF4Uky6P50i7zSqX806J
         lJbEC18FKZqQgOJvnPXwEjSgde0nx0tFMocYopOpyQXivPIsYffs5W5RMhr0Pw19fMmk
         WpmcXfA6aFDgjcurQCXo/hztoNpZQpS3GSx8KmdFxXY15T/sSRuXFhWCnMUwOYrXrG0f
         n4AkZz1aTpfiOmXAsep9SQUL9Fmk32Tgw8eWXKQ7lwwyL2te+g3drlA9qiGvrGEmhpo3
         QVQQ==
X-Gm-Message-State: AOAM531hDHLdSplnKfCjbWjgNHAJuxfgTTHY5nZzWGCw2qzGQ8s98Sw3
        NJX4Y4D+dSFSdxdw5pt7OSaoY3RC4Y3SzAlWyOc=
X-Google-Smtp-Source: ABdhPJzmvbkYAoM/LWw0+auTR8kwciuWbWxmAwLtdcz0IBgKxbYb9mVUFMNbVam22XEfnvskjR98cA==
X-Received: by 2002:a17:902:ee54:b029:ef:8497:e097 with SMTP id 20-20020a170902ee54b02900ef8497e097mr16983949plo.22.1621066525874;
        Sat, 15 May 2021 01:15:25 -0700 (PDT)
Received: from fedora.. ([2405:201:6008:61b4:4e16:5348:d963:c66d])
        by smtp.googlemail.com with ESMTPSA id b15sm5552085pfi.100.2021.05.15.01.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 01:15:25 -0700 (PDT)
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        deborahbrouwer3563@gmail.com, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, linux@roeck-us.net, phil@philpotter.co.uk
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix coding style for if comparisions
Date:   Sat, 15 May 2021 13:44:46 +0530
Message-Id: <20210515081446.676500-1-chouhan.shreyansh630@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Placed constants on the right side of the equality tests in rtw_xmit.c

Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 7e3477a45a0f..b46646c74f2d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -645,7 +645,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 	pattrib->pktlen = pktfile.pkt_len;
 
-	if (ETH_P_IP == pattrib->ether_type) {
+	if (pattrib->ether_type == ETH_P_IP) {
 		/*  The following is for DHCP and ARP packet, we use cck1M to tx these packets and let LPS awake some time */
 		/*  to prevent DHCP protocol fail */
 
@@ -655,7 +655,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 		pattrib->dhcp_pkt = 0;
 		if (pktfile.pkt_len > 282) {/* MINIMUM_DHCP_PACKET_SIZE) { */
-			if (ETH_P_IP == pattrib->ether_type) {/*  IP header */
+			if (pattrib->ether_type == ETH_P_IP) {/*  IP header */
 				if (((tmp[21] == 68) && (tmp[23] == 67)) ||
 					((tmp[21] == 67) && (tmp[23] == 68))) {
 					/*  68 : UDP BOOTP client */
@@ -673,7 +673,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 			if (piphdr->protocol == 0x1) /*  protocol type in ip header 0x1 is ICMP */
 				pattrib->icmp_pkt = 1;
 		}
-	} else if (0x888e == pattrib->ether_type) {
+	} else if (pattrib->ether_type == 0x888e) {
 		netdev_dbg(padapter->pnetdev, "send eapol packet\n");
 	}
 
-- 
2.31.1

