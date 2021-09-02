Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F883FE74E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 03:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhIBBxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 21:53:42 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:56132 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229910AbhIBBxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 21:53:41 -0400
X-UUID: ec05276ee034453ca8f4f362d2a32c28-20210902
X-UUID: ec05276ee034453ca8f4f362d2a32c28-20210902
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 606596165; Thu, 02 Sep 2021 09:52:41 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 09:52:40 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 09:52:38 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yue Hu <huyue2@yulong.com>, Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] mmc: mediatek: Add HS400 online tuning support
Date:   Thu, 2 Sep 2021 09:52:35 +0800
Message-ID: <1630547557-1573-1-git-send-email-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change in v2:
- remove the check "mmc_can_ext_csd"
- change the hs400 tuning condition for "msdc_cmd_done" function and
"msdc_cmd_next" function
- use "-EIO" instead of "-ERANGE"

Wenbin Mei (2):
  dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
  mmc: mediatek: Add HS400 online tuning support

 .../devicetree/bindings/mmc/mtk-sd.yaml       |   7 ++
 drivers/mmc/core/mmc.c                        |   8 ++
 drivers/mmc/host/mtk-sd.c                     | 118 +++++++++++++++++-
 include/linux/mmc/host.h                      |   3 +
 4 files changed, 134 insertions(+), 2 deletions(-)

--
2.17.1
