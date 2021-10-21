Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1638143599C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 05:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhJUEBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 00:01:10 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:36024 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229450AbhJUEBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 00:01:09 -0400
X-UUID: bac1888e3b3d40c59257dc7eb9aad423-20211021
X-UUID: bac1888e3b3d40c59257dc7eb9aad423-20211021
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yc.hung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1747227135; Thu, 21 Oct 2021 11:58:46 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Oct 2021 11:58:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 21 Oct
 2021 11:58:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Oct 2021 11:58:45 +0800
From:   YC Hung <yc.hung@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <yc.hung@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <daniel.baluta@nxp.com>, <trevor.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 0/2] Add code to manage DSP clocks and provide dts-binding document
Date:   Thu, 21 Oct 2021 11:58:39 +0800
Message-ID: <20211021035841.2365-1-yc.hung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "yc.hung" <yc.hung@mediatek.com>

This code is based on top of SOF topic/sof-dev branch and we want to have a review 
with ALSA and device Tree communities the it will be merged to SOF tree and then
merged into ALSA tree. It provides two patches, one is for mt8195 dsp clocks related.
Another is for mt8195 dsp dts binding decription.

YC Hung (2):
  ASoC: SOF: mediatek: Add mt8195 dsp clock support
  dt-bindings: dsp: mediatek: Add mt8195 DSP binding support

 .../bindings/dsp/mtk,mt8195-dsp.yaml          | 139 +++++++++++++++
 sound/soc/sof/mediatek/mt8195/Makefile        |   2 +-
 sound/soc/sof/mediatek/mt8195/mt8195-clk.c    | 164 ++++++++++++++++++
 sound/soc/sof/mediatek/mt8195/mt8195-clk.h    |  29 ++++
 sound/soc/sof/mediatek/mt8195/mt8195.c        |  23 ++-
 5 files changed, 354 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
 create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.c
 create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.h

-- 
2.18.0

