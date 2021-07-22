Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916C13D2A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhGVQMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233376AbhGVQHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:07:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 134DD61D2F;
        Thu, 22 Jul 2021 16:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626972470;
        bh=d1M0x49w8WIFJ0m9cEwCh1sdeHXQq5Jtzmrwe9B4Vio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1jK+fLQhFhDx2LhX1Iye2d/ogdTEf4mofrE0am5QSxGb090eOQ3uyoZ+R+oRDc4uq
         LnOQbIYSNZ/Ez+k9y6i8UIW+/IevTTyD9hBcvK/Pp6C6DdGd4X/LyAFNoE2toFRSbM
         zZr9HY9favss3L2Fy49PTSsx/GnBHoRJAn0b/Tmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.13 127/156] net: qcom/emac: fix UAF in emac_remove
Date:   Thu, 22 Jul 2021 18:31:42 +0200
Message-Id: <20210722155632.467108686@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722155628.371356843@linuxfoundation.org>
References: <20210722155628.371356843@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

commit ad297cd2db8953e2202970e9504cab247b6c7cb4 upstream.

adpt is netdev private data and it cannot be
used after free_netdev() call. Using adpt after free_netdev()
can cause UAF bug. Fix it by moving free_netdev() at the end of the
function.

Fixes: 54e19bc74f33 ("net: qcom/emac: do not use devm on internal phy pdev")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/emac/emac.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -735,12 +735,13 @@ static int emac_remove(struct platform_d
 
 	put_device(&adpt->phydev->mdio.dev);
 	mdiobus_unregister(adpt->mii_bus);
-	free_netdev(netdev);
 
 	if (adpt->phy.digital)
 		iounmap(adpt->phy.digital);
 	iounmap(adpt->phy.base);
 
+	free_netdev(netdev);
+
 	return 0;
 }
 


