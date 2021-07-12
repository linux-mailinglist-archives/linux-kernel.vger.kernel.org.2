Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3FB3C584C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhGLIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 04:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350916AbhGLHvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:51:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E50B60241;
        Mon, 12 Jul 2021 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626076114;
        bh=nCY0O7Xs2mDDV3SEfbR1Gg3tytI5zQHQN7SsSXeUlM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3EZF2gFE0VTbMxqKcIvX7OXHqX06eviCVBFN+lkNPtI6u4ul4eVl9s856IFI/Rym
         pfxS6HHZ5DHTOzp8HOGOZ+cnq/BGp0wp2cbBi4s6tY7R8C5oUsyIchgCDeg9GqSxfA
         m+dG3CoAd/D1Qz4P6qhGgwOW7LMjoldYxrVu4gaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.13 503/800] mt76: mt7615: fix potential overflow on large shift
Date:   Mon, 12 Jul 2021 08:08:46 +0200
Message-Id: <20210712061020.698251469@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712060912.995381202@linuxfoundation.org>
References: <20210712060912.995381202@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

[ Upstream commit 3253f8fddd954aba9ac88ce3c34551dcca505b21 ]

Fix the following static checker warning:
error: undefined (user controlled) shift '(((1))) << (c->omac_idx)'

Fixes: 402a695b1ae6 ("mt76: mt7615: fix CSA notification for DBDC")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index aa42af9ebfd6..ae2191371f51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -411,6 +411,9 @@ mt7615_mcu_rx_csa_notify(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	c = (struct mt7615_mcu_csa_notify *)skb->data;
 
+	if (c->omac_idx > EXT_BSSID_MAX)
+		return;
+
 	if (ext_phy && ext_phy->omac_mask & BIT_ULL(c->omac_idx))
 		mphy = dev->mt76.phy2;
 
-- 
2.30.2



