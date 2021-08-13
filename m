Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772AE3EAEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 05:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbhHMDZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 23:25:09 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:34774 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237331AbhHMDZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 23:25:02 -0400
X-UUID: a0c93a041a0d403abbff998b899ebcce-20210813
X-UUID: a0c93a041a0d403abbff998b899ebcce-20210813
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1254128783; Fri, 13 Aug 2021 11:24:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 11:24:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 11:24:30 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [RESEND PATCH 0/4] clk: mediatek: modularize COMMON_CLK_MT6779
Date:   Fri, 13 Aug 2021 11:24:25 +0800
Message-ID: <20210813032429.14715-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set makes COMMON_CLK_MEDIATEK and COMMON_CLK_MT6779*
be able to built as kernel modules. Necessary symbols are exported
in this patch.

In previous discussion [1], Stephen commented that there must
be a user before exporting a symbol:

"
Is the mediatek driver compilable as a module? Last time I checked it
wasn't a module. I want an upstream modular driver that uses the symbol.
Otherwise we're exporting symbols when it doesn't need to be.
"

[1] https://lore.kernel.org/patchwork/patch/1278089/

Miles Chen (4):
  clk: composite: export clk_register_composite
  clk: mediatek: modularize COMMON_CLK_MEDIATEK
  clk: mediatek: modularize COMMON_CLK_MT6779*
  clk: mediatek: use tristate for COMMON_CLK_MEDAITEK and
    COMMON_CLK_MT6779

 drivers/clk/clk-composite.c            |  1 +
 drivers/clk/mediatek/Kconfig           | 20 ++++++++++----------
 drivers/clk/mediatek/clk-apmixed.c     |  3 +++
 drivers/clk/mediatek/clk-cpumux.c      |  3 +++
 drivers/clk/mediatek/clk-gate.c        |  8 ++++++++
 drivers/clk/mediatek/clk-mt6779-aud.c  |  2 ++
 drivers/clk/mediatek/clk-mt6779-cam.c  |  2 ++
 drivers/clk/mediatek/clk-mt6779-img.c  |  2 ++
 drivers/clk/mediatek/clk-mt6779-ipe.c  |  2 ++
 drivers/clk/mediatek/clk-mt6779-mfg.c  |  2 ++
 drivers/clk/mediatek/clk-mt6779-mm.c   |  2 ++
 drivers/clk/mediatek/clk-mt6779-vdec.c |  2 ++
 drivers/clk/mediatek/clk-mt6779-venc.c |  2 ++
 drivers/clk/mediatek/clk-mt6779.c      |  2 ++
 drivers/clk/mediatek/clk-mtk.c         |  8 ++++++++
 drivers/clk/mediatek/clk-mux.c         |  4 ++++
 drivers/clk/mediatek/clk-pll.c         |  4 ++++
 drivers/clk/mediatek/reset.c           |  2 ++
 18 files changed, 61 insertions(+), 10 deletions(-)

-- 
2.18.0

