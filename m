Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0172633A9C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 04:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhCODJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 23:09:04 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:36780 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhCODIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:08:32 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 9A34BA80E5;
        Mon, 15 Mar 2021 11:08:19 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P13096T140547589097216S1615777695681307_;
        Mon, 15 Mar 2021 11:08:20 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <165e4deda2583fa7c5e784b9575b96a8>
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
        john.oldman@polehill.co.uk, izabela.bakollari@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] staging: rtl8723bs: add spaces between operators
Date:   Mon, 15 Mar 2021 11:08:13 +0800
Message-Id: <20210315030813.19445-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces between operators for a better readability
in function 'rtw_secgetmic'.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 6d53c08b29d1..3e576cbe4712 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -397,7 +397,7 @@ void rtw_secgetmic(struct mic_data *pmicdata, u8 *dst)
 		rtw_secmicappendbyte(pmicdata, 0);
 	/*  The appendByte function has already computed the result. */
 	secmicputuint32(dst, pmicdata->L);
-	secmicputuint32(dst+4, pmicdata->R);
+	secmicputuint32(dst + 4, pmicdata->R);
 	/*  Reset to the empty message. */
 	secmicclear(pmicdata);
 }
-- 
2.20.1



