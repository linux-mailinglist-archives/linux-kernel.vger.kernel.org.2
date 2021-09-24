Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4556D416A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244077AbhIXDlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:41:20 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:46956 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244042AbhIXDlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:41:15 -0400
X-UUID: f41acd261c1349da9bb366197fbd01c0-20210924
X-UUID: f41acd261c1349da9bb366197fbd01c0-20210924
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 632914846; Fri, 24 Sep 2021 11:39:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Sep 2021 11:39:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Sep 2021 11:39:37 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v7 0/6] Mediatek MT8195 SCP support
Date:   Fri, 24 Sep 2021 11:39:29 +0800
Message-ID: <20210924033935.2127-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v6:
- no change (rebased to 5.15-rc1)

Change since v5:
- Drop adding new vendor-prefix
- Rename rpmsg property from "mtk," to "mediatek," to use the name
  defined in 
  vendor-prefix.yaml for Mediatek Co.

Changes since v4:
- Move clock acquirement to mtk_scp_of_data
- Add new vendor-prefix for Mediatek SCP
- Refine mtk,scp.yaml
  - Remove '|' in 'description'
  - Add 'items' to replace 'description' in reg-names property
  - Add 'const' to replace 'description' in clock-names property
  - Add required property for mt8183 and mt8192
  - Rewrite 'patternProperties' by 'additionalProperties'
  - Rewrite example with 1 address and size-cell.
  - Drop dts label from example 

Changes since v3:
- Add missing patch version in mail subject
- No change to patches.

Changes since v2:
- Add compatible for mt8192
- Convert mtk,scp.txt to mtk,scp.yaml 
- Refine clock checking method

Changes since v1:
- Fix missing 'compatible' line in binding document

Tinghan Shen (6):
  dt-bindings: remoteproc: mediatek: Add binding for mt8195 scp
  dt-bindings: remoteproc: mediatek: Add binding for mt8192 scp
  dt-bindings: remoteproc: mediatek: Convert mtk,scp to json-schema
  remoteproc: mediatek: Support mt8195 scp
  rpmsg: change naming of mediatek rpmsg property
  arm64: dts: mt8183: change rpmsg property name

 .../bindings/remoteproc/mtk,scp.txt           | 36 --------
 .../bindings/remoteproc/mtk,scp.yaml          | 92 +++++++++++++++++++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  2 +-
 drivers/remoteproc/mtk_common.h               |  1 +
 drivers/remoteproc/mtk_scp.c                  | 48 +++++++++-
 drivers/rpmsg/mtk_rpmsg.c                     |  2 +-
 6 files changed, 138 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml

-- 
2.18.0

