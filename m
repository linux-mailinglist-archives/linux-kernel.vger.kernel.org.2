Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9FB3AE74F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFUKm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:42:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50405 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229707AbhFUKmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:42:25 -0400
X-UUID: 61f869a0794f4faab27feb09e09962da-20210621
X-UUID: 61f869a0794f4faab27feb09e09962da-20210621
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <kewei.xu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 626648486; Mon, 21 Jun 2021 18:40:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Jun 2021 18:40:06 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Jun 2021 18:40:05 +0800
From:   <kewei.xu@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <bbrezillon@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <liguo.zhang@mediatek.com>,
        <xinping.qian@mediatek.com>, <ot_daolong.zhu@mediatek.com>
Subject: [PATCH V3 0/3] Introduce an attribute to choose timing setting 
Date:   Mon, 21 Jun 2021 18:39:42 +0800
Message-ID: <1624271985-23591-1-git-send-email-kewei.xu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 5359d08e7af0c7981d08cb37555491d098f3e61a Mon Sep 17 00:00:00 2001
From: Kewei Xu <kewei.xu@mediatek.com>
Date: Mon, 21 Jun 2021 18:21:44 +0800
Subject: [PATCH V3 0/3] Introduce an attribute to choose timing setting

Main changes compared to V2:
--add back misdelete statement.

Kewei Xu (3):
  i2c: mediatek: Add OFFSET_EXT_CONF setting back
  dt-bindings: i2c: add attribute default-timing-adjust
  i2c: mediatek: Isolate speed setting via dts for special devices

 .../devicetree/bindings/i2c/i2c-mt65xx.txt         |  2 +
 drivers/i2c/busses/i2c-mt65xx.c                    | 86 ++++++++++++++++++++--
 2 files changed, 83 insertions(+), 5 deletions(-)

-- 
1.9.1
 
