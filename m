Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E3C38FD4C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhEYJBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:01:08 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:43218 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232137AbhEYJBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:01:05 -0400
X-UUID: e5adcea2bc644d8cbd4a1a63529765f3-20210525
X-UUID: e5adcea2bc644d8cbd4a1a63529765f3-20210525
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 69365162; Tue, 25 May 2021 16:59:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 16:59:27 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 16:59:26 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/3] usb: common: move usb_get_dr_mode() kerneldoc next to its definition
Date:   Tue, 25 May 2021 16:59:23 +0800
Message-ID: <1621933165-9661-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2977430AD55DCCDB2143F58A4BF46AD99FC6668D274A0FBE524214208E31C2FE2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following a general rule, add the kerneldoc for a function next
to it's definition, but not next to its declaration in a header
file, meanwhile fix typo 'correspondig'

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/common/common.c | 7 +++++++
 include/linux/usb/otg.h     | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 347fb3d3894a..fff318597337 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -187,6 +187,13 @@ static enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
 	return (ret < 0) ? USB_DR_MODE_UNKNOWN : ret;
 }
 
+/**
+ * usb_get_dr_mode - Get dual role mode for given device
+ * @dev: Pointer to the given device
+ *
+ * The function gets phy interface string from property 'dr_mode',
+ * and returns the corresponding enum usb_dr_mode
+ */
 enum usb_dr_mode usb_get_dr_mode(struct device *dev)
 {
 	const char *dr_mode;
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 69f1b6328532..a86ee6aad51b 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -120,13 +120,6 @@ enum usb_dr_mode {
 	USB_DR_MODE_OTG,
 };
 
-/**
- * usb_get_dr_mode - Get dual role mode for given device
- * @dev: Pointer to the given device
- *
- * The function gets phy interface string from property 'dr_mode',
- * and returns the correspondig enum usb_dr_mode
- */
 extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
 
 #endif /* __LINUX_USB_OTG_H */
-- 
2.18.0

