Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B57450D35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 18:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbhKORw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 12:52:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237633AbhKORXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 12:23:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0B8F6104F;
        Mon, 15 Nov 2021 17:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636996648;
        bh=5jbtJzueWBn2Jx8k8fUeUCJsL15SMZZxzoP1+3EQwQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neFyg+aH3dGZICwReuZJGxENDnRgV0l/jyf3+PuksEgdWs9j+WgWUDGQfL2TYA4ea
         WnUIsSzoGHWRbKZUX62EBctdHUYNnyJvXRjrhmS1RFjTAiKEBOoYdbbfLUPbRR8tO5
         6k2/9sTLwOZYlhGJkLPZturHrcBRsgYfFiZrZ6ys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Michael=20B=C3=BCsch?= <m@bues.ch>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 217/355] b43: fix a lower bounds test
Date:   Mon, 15 Nov 2021 18:02:21 +0100
Message-Id: <20211115165320.781639836@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165313.549179499@linuxfoundation.org>
References: <20211115165313.549179499@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 9b793db5fca44d01f72d3564a168171acf7c4076 ]

The problem is that "channel" is an unsigned int, when it's less 5 the
value of "channel - 5" is not a negative number as one would expect but
is very high positive value instead.

This means that "start" becomes a very high positive value.  The result
of that is that we never enter the "for (i = start; i <= end; i++) {"
loop.  Instead of storing the result from b43legacy_radio_aci_detect()
it just uses zero.

Fixes: ef1a628d83fc ("b43: Implement dynamic PHY API")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Michael Büsch <m@bues.ch>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20211006073621.GE8404@kili
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/b43/phy_g.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/phy_g.c b/drivers/net/wireless/broadcom/b43/phy_g.c
index 1e022ec733a37..8b8fdb4965bde 100644
--- a/drivers/net/wireless/broadcom/b43/phy_g.c
+++ b/drivers/net/wireless/broadcom/b43/phy_g.c
@@ -2297,7 +2297,7 @@ static u8 b43_gphy_aci_scan(struct b43_wldev *dev)
 	b43_phy_mask(dev, B43_PHY_G_CRS, 0x7FFF);
 	b43_set_all_gains(dev, 3, 8, 1);
 
-	start = (channel - 5 > 0) ? channel - 5 : 1;
+	start = (channel > 5) ? channel - 5 : 1;
 	end = (channel + 5 < 14) ? channel + 5 : 13;
 
 	for (i = start; i <= end; i++) {
-- 
2.33.0



