Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF39A3987F4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhFBLWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:22:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38253 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231952AbhFBLWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:22:43 -0400
X-UUID: 725385cad81949abbdea40497ec89e86-20210602
X-UUID: 725385cad81949abbdea40497ec89e86-20210602
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1765001854; Wed, 02 Jun 2021 19:20:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Jun 2021 19:20:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 19:20:53 +0800
From:   James Lo <james.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Add PMIC wrapper support for Mediatek MT8195 SoC IC
Date:   Wed, 2 Jun 2021 19:20:48 +0800
Message-ID: <20210602112050.12338-1-james.lo@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for new SoC MT8195 to the pmic-wrap driver.

Henry Chen (2):
  dt-bindings: mediatek: add compatible for MT8195 pwrap
  soc: mediatek: pwrap: add pwrap driver for MT8195 SoC

 .../bindings/soc/mediatek/pwrap.txt           |  1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 35 +++++++++++++++++++
 2 files changed, 36 insertions(+)


