Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D88D3EA58B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbhHLNXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:23:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41762 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237524AbhHLNTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:19:12 -0400
X-UUID: 0b173581f66d46b9b09453b488510056-20210812
X-UUID: 0b173581f66d46b9b09453b488510056-20210812
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2032732695; Thu, 12 Aug 2021 21:18:43 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 21:18:42 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Aug 2021 21:18:41 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Pawel Laszczak <pawell@cadence.com>,
        Al Cooper <alcooperx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v2 6/7] usb: gadget: bdc: remove unnecessary AND operation when get ep maxp
Date:   Thu, 12 Aug 2021 21:18:02 +0800
Message-ID: <1628774283-475-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1628774283-475-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1628774283-475-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_endpoint_maxp() already returns actual max packet size, no need
AND 0x7ff.

Acked-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: add acked-by felipe
---
 drivers/usb/gadget/udc/bdc/bdc_cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_cmd.c b/drivers/usb/gadget/udc/bdc/bdc_cmd.c
index 995f79c79f96..67887316a1a6 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_cmd.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_cmd.c
@@ -153,7 +153,6 @@ int bdc_config_ep(struct bdc *bdc, struct bdc_ep *ep)
 	si = clamp_val(si, 1, 16) - 1;
 
 	mps = usb_endpoint_maxp(desc);
-	mps &= 0x7ff;
 	param2 |= mps << MP_SHIFT;
 	param2 |= usb_endpoint_type(desc) << EPT_SHIFT;
 
-- 
2.18.0

