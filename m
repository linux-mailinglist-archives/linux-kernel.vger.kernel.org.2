Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729E133F804
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhCQSRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:17:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59328 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhCQSRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:17:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A0F991F45484
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Collabora Kernel ML <kernel@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] soc: mediatek: Prepare MMSYS for DDP routing using tables
Date:   Wed, 17 Mar 2021 19:17:08 +0100
Message-Id: <20210317181711.795245-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

This is the second version of this series intended to prepare the
mtk-mmsys driver to allow different DDP (Data Display Path) routing
tables per SoC. Note that the series has been tested only on MT8173 platform,
for MT2701 and MT2712 based devices we're using a default routing table
that should just work.

Thanks,
  Enric

Changes in v2:
- Use a default table for mt2701, mt2712 and mt8173.
- Remove the mask field from routes struct as is not needed.

CK Hu (2):
  soc: mediatek: mmsys: Create struct mtk_mmsys to store context data
  soc: mediatek: mmsys: Use an array for setting the routing registers

 drivers/soc/mediatek/mtk-mmsys.c | 300 +++++--------------------------
 drivers/soc/mediatek/mtk-mmsys.h | 215 ++++++++++++++++++++++
 2 files changed, 257 insertions(+), 258 deletions(-)
 create mode 100644 drivers/soc/mediatek/mtk-mmsys.h

-- 
2.30.2

