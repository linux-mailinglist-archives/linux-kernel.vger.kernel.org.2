Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C8D443FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhKCKDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:03:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42816 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231338AbhKCKDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:03:24 -0400
X-UUID: da6ae55821ea4e10bbf10a84365b9deb-20211103
X-UUID: da6ae55821ea4e10bbf10a84365b9deb-20211103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1341963609; Wed, 03 Nov 2021 18:00:45 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 3 Nov 2021 18:00:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Nov
 2021 18:00:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Nov 2021 18:00:44 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yc.hung@mediatek.com>, <daniel.baluta@nxp.com>
Subject: [PATCH 0/4] ASoC: mediatek: Update MT8195 machine driver
Date:   Wed, 3 Nov 2021 18:00:36 +0800
Message-ID: <20211103100040.11933-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thes series of patches adds support for RT5682s headset codec and
create a new machine driver for SOF support.
Patches are based on broonie tree "for-next" branch.


Trevor Wu (4):
  ASoC: mediatek: mt8195: add headset codec rt5682s support
  dt-bindings: mediatek: mt8195: add model property
  ASoC: mediatek: mt8195: separate the common code from machine driver
  ASoC: mediatek: mt8195: add machine driver for MT8195 SOF support

 .../sound/mt8195-mt6359-rt1011-rt5682.yaml    |   4 +
 .../sound/mt8195-mt6359-rt1019-rt5682.yaml    |   4 +
 sound/soc/mediatek/Kconfig                    |   2 +
 sound/soc/mediatek/mt8195/Makefile            |  16 +-
 sound/soc/mediatek/mt8195/mt8195-common.c     | 398 ++++++++++++
 sound/soc/mediatek/mt8195/mt8195-common.h     |  33 +
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      | 591 +-----------------
 .../mt8195/mt8195-mt6359-rt1019-rt5682-sof.c  | 557 +++++++++++++++++
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      | 551 +---------------
 .../mediatek/mt8195/mt8195-realtek-common.c   | 161 +++++
 .../mediatek/mt8195/mt8195-realtek-common.h   |  34 +
 11 files changed, 1267 insertions(+), 1084 deletions(-)
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-common.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-common.h
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682-sof.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-realtek-common.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-realtek-common.h

-- 
2.18.0

