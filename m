Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66FC3F01A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhHRKc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:32:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49474 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230424AbhHRKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:32:56 -0400
X-UUID: d6b23e4ec1794ed392210f166d0c1cb4-20210818
X-UUID: d6b23e4ec1794ed392210f166d0c1cb4-20210818
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1659944535; Wed, 18 Aug 2021 18:32:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 Aug 2021 18:32:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Aug 2021 18:32:19 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <bicycle.tsai@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <cychiang@google.com>, <aaronyu@google.com>, <wenst@chromium.org>
Subject: [PATCH v4 00/11] ASoC: mediatek: Add support for MT8195 SoC
Date:   Wed, 18 Aug 2021 18:32:04 +0800
Message-ID: <20210818103215.9186-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds support for Mediatek AFE of MT8195 SoC.
Patches are based on broonie tree "for-next" branch.

Changes since v3:
  - fixed warnings found by kernel test robot
  - removed unused critical section
  - corrected the lock protected sections on etdm driver
  - added DPTX and HDMITX audio support

Changes since v2:
  - added audio clock gate control
  - added 'mediatek' prefix to private dts properties
  - added consumed clocks to dt-bindins and adopted suggestions from Rob
  - refined clock usage and remove unused clock and control code
  - fixed typos

Changes since v1:
  - fixed some problems related to dt-bindings
  - added some missing properties to dt-bindings
  - added depency declaration on dt-bindings
  - fixed some warnings found by kernel test robot

Trevor Wu (11):
  ASoC: mediatek: mt8195: update mediatek common driver
  ASoC: mediatek: mt8195: support audsys clock control
  ASoC: mediatek: mt8195: support etdm in platform driver
  ASoC: mediatek: mt8195: support adda in platform driver
  ASoC: mediatek: mt8195: support pcm in platform driver
  ASoC: mediatek: mt8195: add platform driver
  dt-bindings: mediatek: mt8195: add audio afe document
  ASoC: mediatek: mt8195: add machine driver with mt6359, rt1019 and
    rt5682
  ASoC: mediatek: mt8195: add DPTX audio support
  ASoC: mediatek: mt8195: add HDMITX audio support
  dt-bindings: mediatek: mt8195: add mt8195-mt6359-rt1019-rt5682
    document

 .../bindings/sound/mt8195-afe-pcm.yaml        |  184 +
 .../sound/mt8195-mt6359-rt1019-rt5682.yaml    |   47 +
 sound/soc/mediatek/Kconfig                    |   24 +
 sound/soc/mediatek/Makefile                   |    1 +
 sound/soc/mediatek/common/mtk-afe-fe-dai.c    |   22 +-
 sound/soc/mediatek/common/mtk-base-afe.h      |   10 +-
 sound/soc/mediatek/mt8195/Makefile            |   15 +
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c    |  441 +++
 sound/soc/mediatek/mt8195/mt8195-afe-clk.h    |  109 +
 sound/soc/mediatek/mt8195/mt8195-afe-common.h |  158 +
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c    | 3281 +++++++++++++++++
 sound/soc/mediatek/mt8195/mt8195-audsys-clk.c |  214 ++
 sound/soc/mediatek/mt8195/mt8195-audsys-clk.h |   15 +
 .../soc/mediatek/mt8195/mt8195-audsys-clkid.h |   93 +
 sound/soc/mediatek/mt8195/mt8195-dai-adda.c   |  830 +++++
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c   | 2639 +++++++++++++
 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c    |  389 ++
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      | 1093 ++++++
 sound/soc/mediatek/mt8195/mt8195-reg.h        | 2796 ++++++++++++++
 19 files changed, 12356 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
 create mode 100644 sound/soc/mediatek/mt8195/Makefile
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-audsys-clk.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-audsys-clk.h
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-audsys-clkid.h
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-reg.h

-- 
2.18.0

