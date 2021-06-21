Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AAE3AE58A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFUJFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:05:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34538 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230326AbhFUJFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:05:07 -0400
X-UUID: 261af7a81a5e4405bdd9a1b4ab33cb86-20210621
X-UUID: 261af7a81a5e4405bdd9a1b4ab33cb86-20210621
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <kewei.xu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1925719475; Mon, 21 Jun 2021 17:02:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Jun 2021 17:02:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Jun 2021 17:02:05 +0800
From:   <kewei.xu@mediatek.com>
To:     <bbrezillon@kernel.org>
CC:     <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-i3c@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <liguo.zhang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH V2 0/3] Introduce an attribute to choose timing setting 
Date:   Mon, 21 Jun 2021 17:01:51 +0800
Message-ID: <1624266114-21539-1-git-send-email-kewei.xu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 7f9f31c3e49e67e915a5137259a3f5bd62818339 Mon Sep 17 00:00:00 2001
From: Kewei Xu <kewei.xu@mediatek.com>
Date: Mon, 21 Jun 2021 16:36:09 +0800
Subject: [PATCH V2 0/3] Introduce an attribute to choose timing setting

Main changes compared to V1:
--split OFFSET_EXT_CONF into another patch.
--add attribute default-timing-adjust into dt-binding. 

Kewei Xu (3):
  i2c: mediatek: Add OFFSET_EXT_CONF setting back
  dt-bindings: i2c: add attribute default-timing-adjust
  i2c: mediatek: Isolate speed setting via dts for special devices

 .../devicetree/bindings/i2c/i2c-mt65xx.txt         |  2 +
 drivers/i2c/busses/i2c-mt65xx.c                    | 88 ++++++++++++++++++++--
 2 files changed, 83 insertions(+), 7 deletions(-)

-- 
1.9.1
 
