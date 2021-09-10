Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D43406A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 12:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhIJKp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 06:45:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39512 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232148AbhIJKpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 06:45:22 -0400
X-UUID: 24772706d476420db0b2b7adf5a743d7-20210910
X-UUID: 24772706d476420db0b2b7adf5a743d7-20210910
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1340919098; Fri, 10 Sep 2021 18:44:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 10 Sep 2021 18:44:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 10 Sep 2021 18:44:07 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>
Subject: [PATCH 0/2] ASoC: mediatek: Add support for MT8195 sound card with rt1011 and rt5682
Date:   Fri, 10 Sep 2021 18:44:03 +0800
Message-ID: <20210910104405.11420-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds support for mt8195 board with mt6359, rt1011
and rt5682.
Patches are based on broonie tree "for-next" branch.

Trevor Wu (2):
  ASoC: mediatek: mt8195: add machine driver with mt6359, rt1011 and
    rt5682
  dt-bindings: mediatek: mt8195: add mt8195-mt6359-rt1011-rt5682
    document

 .../sound/mt8195-mt6359-rt1011-rt5682.yaml    |   47 +
 sound/soc/mediatek/Kconfig                    |   15 +
 sound/soc/mediatek/mt8195/Makefile            |    1 +
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      | 1140 +++++++++++++++++
 4 files changed, 1203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c

-- 
2.18.0

