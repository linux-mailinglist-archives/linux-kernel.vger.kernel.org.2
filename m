Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1CD3A75FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 06:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhFOEjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 00:39:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39441 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229488AbhFOEjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 00:39:17 -0400
X-UUID: 78e40e087f014655a02336ed96a4c73c-20210615
X-UUID: 78e40e087f014655a02336ed96a4c73c-20210615
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1056129317; Tue, 15 Jun 2021 12:37:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Jun 2021 12:37:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Jun 2021 12:37:08 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [PATCH 4/4] soc: mediatek: pm-domains: Remove unused macro
Date:   Tue, 15 Jun 2021 12:36:03 +0800
Message-ID: <20210615043603.20412-5-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210615043603.20412-1-chun-jie.chen@mediatek.com>
References: <20210615043603.20412-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to clk resource data will be allocated dynamically by
searching parent count of clk in power domain node, so remove
the unused marco MAX_SUBSYS_CLKS for static allocation.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-pm-domains.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index caaa38100093..1b8967b9829e 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -72,8 +72,6 @@ struct scpsys_bus_prot_data {
 	bool ignore_clr_ack;
 };
 
-#define MAX_SUBSYS_CLKS 10
-
 /**
  * struct scpsys_domain_data - scp domain data for power on/off flow
  * @name: The name of the power domain.
-- 
2.18.0

