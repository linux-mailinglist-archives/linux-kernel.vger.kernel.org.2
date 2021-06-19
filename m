Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7F83ADB9F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 22:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhFSUQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 16:16:49 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:51692 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFSUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 16:16:47 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d18 with ME
        id K8Eb2500521Fzsu038EbrF; Sat, 19 Jun 2021 22:14:35 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 19 Jun 2021 22:14:35 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        insafonov@gmail.com, linux@roeck-us.net, straube.linux@gmail.com,
        gustavoars@kernel.org, liushixin2@huawei.com,
        yepeilin.cs@gmail.com, phil@philpotter.co.uk
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] staging: rtl8188eu: remove "rtw_ieee80211_back_parties"
Date:   Sat, 19 Jun 2021 22:14:34 +0200
Message-Id: <f389e0d54a5a8a46c9a696207541aa1cb433676b.1624132543.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <6b6d8d81e7b2115e9206d2960ce09e1b2e8b6381.1624132543.git.christophe.jaillet@wanadoo.fr>
References: <6b6d8d81e7b2115e9206d2960ce09e1b2e8b6381.1624132543.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enum is unused. It is also close to "ieee80211_back_parties" in
"include/linux/ieee80211.h", which should be used if needed.

So remove it

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/rtl8188eu/include/ieee80211.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/staging/rtl8188eu/include/ieee80211.h
index 4becf4edaa25..da6245a77d5d 100644
--- a/drivers/staging/rtl8188eu/include/ieee80211.h
+++ b/drivers/staging/rtl8188eu/include/ieee80211.h
@@ -559,13 +559,6 @@ enum rtw_ieee80211_ht_actioncode {
 	RTW_WLAN_ACTION_HI_INFO_EXCHG = 8,
 };
 
-/* BACK (block-ack) parties */
-enum rtw_ieee80211_back_parties {
-	RTW_WLAN_BACK_RECIPIENT = 0,
-	RTW_WLAN_BACK_INITIATOR = 1,
-	RTW_WLAN_BACK_TIMER = 2,
-};
-
 #define OUI_MICROSOFT 0x0050f2 /* Microsoft (also used in Wi-Fi specs)
 				* 00:50:F2
 				*/
-- 
2.30.2

