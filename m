Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E743EA21F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhHLJgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:36:01 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:60874 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236130AbhHLJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:35:58 -0400
X-UUID: 6dea35020b5040b6970cedcc73875c81-20210812
X-UUID: 6dea35020b5040b6970cedcc73875c81-20210812
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2015877794; Thu, 12 Aug 2021 17:35:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 17:35:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Aug 2021 17:35:22 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        <inux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH 1/4] clk: composite: export clk_register_composite
Date:   Thu, 12 Aug 2021 17:35:16 +0800
Message-ID: <20210812093519.3550-2-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210812093519.3550-1-miles.chen@mediatek.com>
References: <20210812093519.3550-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support module build of mediatek clk drivers,
it is necessary to export clk_register_composite.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/clk-composite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 0506046a5f4b..c7b97fb0051b 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -362,6 +362,7 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		return ERR_CAST(hw);
 	return hw->clk;
 }
+EXPORT_SYMBOL_GPL(clk_register_composite);
 
 struct clk *clk_register_composite_pdata(struct device *dev, const char *name,
 			const struct clk_parent_data *parent_data,
-- 
2.18.0

