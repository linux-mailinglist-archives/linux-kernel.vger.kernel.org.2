Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3B331C817
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBPJai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:30:38 -0500
Received: from m12-17.163.com ([220.181.12.17]:59332 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbhBPJaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=F5hFEu4WoRLmj8hgaV
        VMY5sXYf4aZH9TX/Q1ftKv6Jw=; b=V1MubvXSdA60PlK76UixGpS+KIMZpIqjYR
        H9zBvjJYEg+SfIcgtLML7Gjd5ZewtWNxkPX3IJyNQ57SaOFGUYF1Q7i61YhOzehi
        e8oRlHt7dxYIJVeX20gq/aMuutAG24f4ZV6pZKKtwgPG+1xwZy2dyUPSVAP+IjiJ
        IztefF7z0=
Received: from localhost.localdomain (unknown [125.70.193.99])
        by smtp13 (Coremail) with SMTP id EcCowADnGzicQStgm20klQ--.45213S2;
        Tue, 16 Feb 2021 11:53:03 +0800 (CST)
From:   Chen Lin <chen45464546@163.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Chen Lin <chen.lin5@zte.com.cn>
Subject: [PATCH] staging: wlan-ng: Remove unused function pointer typedef freebuf_method_t
Date:   Tue, 16 Feb 2021 11:54:06 +0800
Message-Id: <1613447646-4678-1-git-send-email-chen45464546@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: EcCowADnGzicQStgm20klQ--.45213S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFW8try8WryruF4DJr1DWrg_yoWxurX_Cr
        1IqrWxXr1DZrWxt340yrnxZrW0gFs3Wa18t3WS9FZxC3yYya1rGw1kXF15ZF9xK3s7KF9r
        C39YqF1FyrykXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0c_-DUUUUU==
X-Originating-IP: [125.70.193.99]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/xtbBzh87nlQHLpOwKgAAsA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Lin <chen.lin5@zte.com.cn>

Remove the 'freebuf_method_t' typedef as it is not used.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
---
 drivers/staging/wlan-ng/p80211conv.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211conv.h b/drivers/staging/wlan-ng/p80211conv.h
index 827002c..15fd635 100644
--- a/drivers/staging/wlan-ng/p80211conv.h
+++ b/drivers/staging/wlan-ng/p80211conv.h
@@ -122,9 +122,6 @@ struct p80211_caphdr {
 	__be32 encoding;
 };
 
-/* buffer free method pointer type */
-typedef void (*freebuf_method_t) (void *buf, int size);
-
 struct p80211_metawep {
 	void *data;
 	u8 iv[4];
-- 
1.7.9.5


