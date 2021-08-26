Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216DF3F83D5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 10:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbhHZIhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 04:37:33 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:37886 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240327AbhHZIha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:37:30 -0400
X-UUID: b7d5cd35f7c14ea2af0eb9581e375b0e-20210826
X-UUID: b7d5cd35f7c14ea2af0eb9581e375b0e-20210826
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 91827292; Thu, 26 Aug 2021 16:36:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 26 Aug
 2021 16:36:38 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 26 Aug 2021 16:36:38 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH next 1/2] usb: mtu3: return successful suspend status
Date:   Thu, 26 Aug 2021 16:36:36 +0800
Message-ID: <20210826083637.33237-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot 'return 0;' when suspend successfully, make the mistake
when I split patches.

Fixes: 6b587394c65c ("usb: mtu3: support suspend/resume for dual-role mode")
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_plat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 81266f34986f..5b3f7f73cb40 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -502,6 +502,7 @@ static int mtu3_suspend_common(struct device *dev, pm_message_t msg)
 	ssusb_phy_power_off(ssusb);
 	clk_bulk_disable_unprepare(BULK_CLKS_CNT, ssusb->clks);
 	ssusb_wakeup_set(ssusb, true);
+	return 0;
 
 sleep_err:
 	resume_ip_and_ports(ssusb, msg);
-- 
2.18.0

