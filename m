Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D455E37CFC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhELRSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 13:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238632AbhELQFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:05:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6332461CEE;
        Wed, 12 May 2021 15:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620833678;
        bh=HqFDUzOklbgDX99UW3CBa/QeqsjsalZmuMTAG8kXo3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBc1qC+cxuQ3k5ytcNOh4Q78JJH0hFc5NgMYIAGTyrzMhqWwfneBHMpf4TNe8Eigd
         hJAkG6Fc9nKs5VSgNn8zYoPnxdP7xU4gXTbnm427Qu+Mu/A4Fc03d54I3WlDV0C/Bi
         WN9IG8IRLAogFTzbFEWRcVftzE7CzsYPTtCOqx/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.11 218/601] phy: ralink: phy-mt7621-pci: fix return value check in mt7621_pci_phy_probe()
Date:   Wed, 12 May 2021 16:44:55 +0200
Message-Id: <20210512144835.022297327@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512144827.811958675@linuxfoundation.org>
References: <20210512144827.811958675@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit b976c987511e34a2e9b23545de912a121a9eded5 ]

Fix the return value check which testing the wrong variable
in mt7621_pci_phy_probe().

Fixes: d87da32372a0 ("phy: ralink: Add PHY driver for MT7621 PCIe PHY")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Link: https://lore.kernel.org/r/20210305034931.3237558-1-weiyongjun1@huawei.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ralink/phy-mt7621-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ralink/phy-mt7621-pci.c b/drivers/phy/ralink/phy-mt7621-pci.c
index 84ee2b5c2228..753cb5bab930 100644
--- a/drivers/phy/ralink/phy-mt7621-pci.c
+++ b/drivers/phy/ralink/phy-mt7621-pci.c
@@ -319,9 +319,9 @@ static int mt7621_pci_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(phy->regmap);
 
 	phy->phy = devm_phy_create(dev, dev->of_node, &mt7621_pci_phy_ops);
-	if (IS_ERR(phy)) {
+	if (IS_ERR(phy->phy)) {
 		dev_err(dev, "failed to create phy\n");
-		return PTR_ERR(phy);
+		return PTR_ERR(phy->phy);
 	}
 
 	phy_set_drvdata(phy->phy, phy);
-- 
2.30.2



