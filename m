Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689163EB04A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbhHMGcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:32:46 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:48748 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238959AbhHMGcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:32:31 -0400
X-UUID: a0dd7579e751476c87f8e3f0d4979cbb-20210813
X-UUID: a0dd7579e751476c87f8e3f0d4979cbb-20210813
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 569694505; Fri, 13 Aug 2021 14:32:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 14:31:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 13 Aug
 2021 14:31:58 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 14:31:58 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Pawel Laszczak <pawell@cadence.com>,
        Al Cooper <alcooperx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: [PATCH v3 6/7] usb: gadget: bdc: remove unnecessary AND operation when get ep maxp
Date:   Fri, 13 Aug 2021 14:30:52 +0800
Message-ID: <1628836253-7432-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1628836253-7432-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1628836253-7432-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_endpoint_maxp() already returns actual max packet size, no need
to AND 0x7ff.

Acked-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: fix typo suggested by Sergei
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

