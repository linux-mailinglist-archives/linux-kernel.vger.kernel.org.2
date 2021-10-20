Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85804345BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJTHQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:16:51 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44310 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229817AbhJTHQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:16:50 -0400
X-UUID: 424603061424453fab1ea939c1861b06-20211020
X-UUID: 424603061424453fab1ea939c1861b06-20211020
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 756023333; Wed, 20 Oct 2021 15:14:33 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 20 Oct 2021 15:14:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Oct
 2021 15:14:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Oct 2021 15:14:31 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <pierre-louis.bossart@linux.intel.com>
Subject: [RESEND,v2 0/2] ASoC: mediatek: Add support for MT8195 sound card with rt1011 and rt5682
Date:   Wed, 20 Oct 2021 15:14:26 +0800
Message-ID: <20211020071428.14297-1-trevor.wu@mediatek.com>
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

Changes since v1:
  - refined code based on Pierre-Louis's suggestions
  - added missing of_node_put
  - fixed wrong fixup assignment on HDMITX

Trevor Wu (2):
  ASoC: mediatek: mt8195: add machine driver with mt6359, rt1011 and
    rt5682
  dt-bindings: mediatek: mt8195: add mt8195-mt6359-rt1011-rt5682
    document

 .../sound/mt8195-mt6359-rt1011-rt5682.yaml    |   47 +
 sound/soc/mediatek/Kconfig                    |   15 +
 sound/soc/mediatek/mt8195/Makefile            |    1 +
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      | 1155 +++++++++++++++++
 4 files changed, 1218 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c

-- 
2.18.0

