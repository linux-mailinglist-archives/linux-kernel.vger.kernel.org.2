Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8596F359213
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhDICj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:39:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32851 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232616AbhDICj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:39:27 -0400
X-UUID: 42acbb786ab846b5aa462aae7e359e64-20210409
X-UUID: 42acbb786ab846b5aa462aae7e359e64-20210409
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1531868952; Fri, 09 Apr 2021 10:39:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 10:39:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 10:39:08 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [RFC PATCH] usb: core: reduce power-on-good delay time of root hub
Date:   Fri, 9 Apr 2021 10:39:07 +0800
Message-ID: <1617935947-24045-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E08103E15D8BA582B180E4E4D7CBAA8F1514BC09414DEEB178647A498EF9A0E32000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return the exactly delay time given by root hub descriptor,
this helps to reduce resume time etc.

Due to the root hub descriptor is usually provided by the host
controller driver, if there is compatibility for a root hub,
we can fix it easily without affect other root hub

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/core/hub.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 73f4482d833a..22ea1f4f2d66 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -148,8 +148,10 @@ static inline unsigned hub_power_on_good_delay(struct usb_hub *hub)
 {
 	unsigned delay = hub->descriptor->bPwrOn2PwrGood * 2;
 
-	/* Wait at least 100 msec for power to become stable */
-	return max(delay, 100U);
+	if (!hub->hdev->parent)	/* root hub */
+		return delay;
+	else /* Wait at least 100 msec for power to become stable */
+		return max(delay, 100U);
 }
 
 static inline int hub_port_debounce_be_connected(struct usb_hub *hub,
-- 
2.18.0

