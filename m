Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD62E3D9FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 10:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhG2IrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 04:47:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48182 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234949AbhG2IrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 04:47:21 -0400
X-UUID: 250b35e34c1c458c8a39bc00375894b7-20210729
X-UUID: 250b35e34c1c458c8a39bc00375894b7-20210729
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 340655760; Thu, 29 Jul 2021 16:47:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Jul 2021 16:47:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Jul 2021 16:47:11 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <timur@kernel.org>, <linux@armlinux.org.uk>, <alcooperx@gmail.com>,
        <tklauser@distanz.ch>, <sean.wang@kernel.org>
CC:     <srv_heupstream@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <hui.liu@mediatek.com>, <yuchen.huang@mediatek.com>,
        <huihui.wang@mediatek.com>, <eddie.huang@mediatek.com>,
        <sean.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
Subject: [PATCH v2 0/1] Mediatek uart patch 
Date:   Thu, 29 Jul 2021 16:46:39 +0800
Message-ID: <20210729084640.17613-1-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes 1 patches:
1.fix uart corruption issue when rx power off

Changes in patch v2:
1. move the detailed reason explain to patch[1/1].

Changes in patch v1:
1. remove processing mechanism which count value is 0.
2. change patch title and commit message.
3. explain the detailed reason for the patch in changelog.

Zhiyong Tao (1):
  serial: 8250_mtk: fix uart corruption issue when rx power off

 drivers/tty/serial/8250/8250_mtk.c | 5 +++++
 1 file changed, 5 insertions(+)

--
2.18.0


