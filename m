Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070C0403232
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 03:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346191AbhIHBdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 21:33:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44824 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229946AbhIHBdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 21:33:31 -0400
X-UUID: 7be96b5b8aa34593acb250edd54c3ab2-20210908
X-UUID: 7be96b5b8aa34593acb250edd54c3ab2-20210908
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 662536991; Wed, 08 Sep 2021 09:32:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 09:32:19 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Sep 2021 09:32:18 +0800
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
Subject: [PATCH v3 0/2] mmc: mediatek: Add HS400 online tuning support
Date:   Wed, 8 Sep 2021 09:32:16 +0800
Message-ID: <20210908013218.29702-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change in v3:
- add detail descripthion for hs400 dly3

Change in v2:
- remove the check "mmc_can_ext_csd"
- change the hs400 tuning condition for "msdc_cmd_done" function and
"msdc_cmd_next" function
- use "-EIO" instead of "-ERANGE"

Wenbin Mei (2):
  dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
  mmc: mediatek: Add HS400 online tuning support

 .../devicetree/bindings/mmc/mtk-sd.yaml       |  12 ++
 drivers/mmc/core/mmc.c                        |   8 ++
 drivers/mmc/host/mtk-sd.c                     | 118 +++++++++++++++++-
 include/linux/mmc/host.h                      |   3 +
 4 files changed, 139 insertions(+), 2 deletions(-)

--
2.25.1

