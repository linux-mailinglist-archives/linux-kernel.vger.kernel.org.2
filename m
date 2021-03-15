Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC8533A97B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 02:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCOB6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 21:58:00 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:39662 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhCOB5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 21:57:32 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 7AC3ECC582;
        Mon, 15 Mar 2021 09:57:07 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P13096T140547972355840S1615773422010804_;
        Mon, 15 Mar 2021 09:57:07 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5d4a416a5e24dd612bca4bf23bd86190>
X-RL-SENDER: maqianga@uniontech.com
X-SENDER: maqianga@uniontech.com
X-LOGIN-NAME: maqianga@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Qiang Ma <maqianga@uniontech.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        singhalsimran0@gmail.com, matthew.v.deangelis@gmail.com,
        hannes@cmpxchg.org, john.oldman@polehill.co.uk, longman@redhat.com,
        izabela.bakollari@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] Staging: rtl8723bs/core: fix space coding style issue
Date:   Mon, 15 Mar 2021 09:56:59 +0800
Message-Id: <20210315015659.2402-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one space around (on each side of) '*' binary operators.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index a311595deafb..6d53c08b29d1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -319,7 +319,7 @@ static u32 secmicgetuint32(u8 *p)
 	u32 res = 0;
 
 	for (i = 0; i < 4; i++)
-		res |= ((u32)(*p++)) << (8*i);
+		res |= ((u32)(*p++)) << (8 * i);
 
 	return res;
 }
-- 
2.20.1



