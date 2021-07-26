Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC53D57E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhGZKRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:17:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33746 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232334AbhGZKRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:17:11 -0400
X-UUID: 28ee40d46c664887908e903d2e78c20b-20210726
X-UUID: 28ee40d46c664887908e903d2e78c20b-20210726
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1134525413; Mon, 26 Jul 2021 18:57:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Jul 2021 18:57:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Jul 2021 18:57:34 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [v14 00/21] Mediatek MT8192 clock support
Date:   Mon, 26 Jul 2021 18:56:58 +0800
Message-ID: <20210726105719.15793-1-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch series is based on 5.14-rc1.

changes since v13:
- no change (rebased to 5.14)

changes since v12:
-  move audsys binding to "mediatek,audsys.txt" (patch 3)

changes since v11:
- move mmsys binding to "mediatek,mmsys.txt" (patch 2)
- fix new DT binding error (patch 1)

change since v10:
- refine binding document in patch 1 (drop the 'oneOf')

change since v9:
- combine similiar dt-binding file for system and functional clock
- change api of getting regmap if it's not a syscon node (patch 3)

change since v8:
- fix mm dt-binding file conflict.

reason for sending v8:
- due to this patch series including dt-binding file, so add
device tree reviewer to mail list, no change between [1] and v8.
[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=454523

reason for resending v7:
- add review history from series below
[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=405295

change since v6:
- update from series below
[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=405295
- fix DT bindings fail
- fix checkpatch warning
- update mux ops without gate control

change since v5:
- remove unused clocks by rolling Tinghan's patches[1][2] into series
[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=398781
[2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=405143
- remove dts related patches from series

change since v4:
- merge some subsystem into same driver
- add a generic probe function to reduce duplicated code

changes since v3:
- add critical clocks
- split large patches into small ones

changes since v2:
- update and split dt-binding documents by functionalities
- add error checking in probe() function
- fix incorrect clock relation and add critical clocks
- update license identifier and minor fix of coding style

changes since v1:
- fix asymmetrical control of PLL
- have en_mask used as divider enable mask on all MediaTek SoC

Chun-Jie Chen (21):
  dt-bindings: ARM: Mediatek: Add new document bindings of MT8192 clock
  dt-bindings: ARM: Mediatek: Add mmsys document binding for MT8192
  dt-bindings: ARM: Mediatek: Add audsys document binding for MT8192
  clk: mediatek: Add dt-bindings of MT8192 clocks
  clk: mediatek: Get regmap without syscon compatible check
  clk: mediatek: Fix asymmetrical PLL enable and disable control
  clk: mediatek: Add configurable enable control to mtk_pll_data
  clk: mediatek: Add mtk_clk_simple_probe() to simplify clock providers
  clk: mediatek: Add MT8192 basic clocks support
  clk: mediatek: Add MT8192 audio clock support
  clk: mediatek: Add MT8192 camsys clock support
  clk: mediatek: Add MT8192 imgsys clock support
  clk: mediatek: Add MT8192 imp i2c wrapper clock support
  clk: mediatek: Add MT8192 ipesys clock support
  clk: mediatek: Add MT8192 mdpsys clock support
  clk: mediatek: Add MT8192 mfgcfg clock support
  clk: mediatek: Add MT8192 mmsys clock support
  clk: mediatek: Add MT8192 msdc clock support
  clk: mediatek: Add MT8192 scp adsp clock support
  clk: mediatek: Add MT8192 vdecsys clock support
  clk: mediatek: Add MT8192 vencsys clock support

 .../bindings/arm/mediatek/mediatek,audsys.txt |    1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt  |    1 +
 .../arm/mediatek/mediatek,mt8192-clock.yaml   |  199 +++
 .../mediatek/mediatek,mt8192-sys-clock.yaml   |   65 +
 drivers/clk/mediatek/Kconfig                  |   80 +
 drivers/clk/mediatek/Makefile                 |   13 +
 drivers/clk/mediatek/clk-cpumux.c             |    2 +-
 drivers/clk/mediatek/clk-mt8192-aud.c         |  118 ++
 drivers/clk/mediatek/clk-mt8192-cam.c         |  107 ++
 drivers/clk/mediatek/clk-mt8192-img.c         |   70 +
 .../clk/mediatek/clk-mt8192-imp_iic_wrap.c    |  119 ++
 drivers/clk/mediatek/clk-mt8192-ipe.c         |   57 +
 drivers/clk/mediatek/clk-mt8192-mdp.c         |   82 +
 drivers/clk/mediatek/clk-mt8192-mfg.c         |   50 +
 drivers/clk/mediatek/clk-mt8192-mm.c          |  108 ++
 drivers/clk/mediatek/clk-mt8192-msdc.c        |   85 ++
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c    |   50 +
 drivers/clk/mediatek/clk-mt8192-vdec.c        |   94 ++
 drivers/clk/mediatek/clk-mt8192-venc.c        |   53 +
 drivers/clk/mediatek/clk-mt8192.c             | 1326 +++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                |   25 +-
 drivers/clk/mediatek/clk-mtk.h                |   28 +-
 drivers/clk/mediatek/clk-mux.c                |   11 +-
 drivers/clk/mediatek/clk-mux.h                |   18 +-
 drivers/clk/mediatek/clk-pll.c                |   31 +-
 drivers/clk/mediatek/reset.c                  |    2 +-
 include/dt-bindings/clock/mt8192-clk.h        |  585 ++++++++
 27 files changed, 3356 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8192-aud.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-ipe.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-mdp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-msdc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-scp_adsp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192.c
 create mode 100644 include/dt-bindings/clock/mt8192-clk.h

-- 
2.18.0

