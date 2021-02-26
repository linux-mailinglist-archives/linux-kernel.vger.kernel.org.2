Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A333263FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBZOX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBZOXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:23:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B93164DE3;
        Fri, 26 Feb 2021 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614349356;
        bh=IscUE33njMPiVfvfUyjcKdZCxN3HpR68Nvvh7cCbHws=;
        h=From:To:Cc:Subject:Date:From;
        b=BO8GncTN/3+5/nrOKmXhLN/kayMmjVF8zfxh3Tnyqbm4LTzd/h9Zq7q5NPYgKasJy
         3akSDqpje6K0b49u3O9RX5bgUrdH1IsGxQHE3aNu0ZlT2+9dgjRS1cog550IGoUS/R
         oBI4b1lvqZapmKv3D6yk8sl+ghIdwsWuykj7Pbi5fbX6samUdH+CmonOiD5jgUk3Ae
         el5aMWCd1bNKWWggvQSyAz5hpvDxs1SB9rjgHFpbkDdgcyqdvsUhrQ7j1Gcj5qKcFo
         QbtQugKHAxsY8ozewjcp1qWrjTBycHXY9kW0L8jzk1fsYOOqXK+Wvf1HFQ7EwtmPp1
         HLGTiU3rb1vUw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ryder Lee <ryder.lee@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] mt76: mt7915: fix unused 'mode' variable
Date:   Fri, 26 Feb 2021 15:21:27 +0100
Message-Id: <20210226142215.3482168-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang points out a possible corner case in the mt7915_tm_set_tx_cont()
function if called with invalid arguments:

drivers/net/wireless/mediatek/mt76/mt7915/testmode.c:593:2: warning: variable 'mode' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
        default:
        ^~~~~~~
drivers/net/wireless/mediatek/mt76/mt7915/testmode.c:597:13: note: uninitialized use occurs here
        rateval =  mode << 6 | rate_idx;
                   ^~~~
drivers/net/wireless/mediatek/mt76/mt7915/testmode.c:506:37: note: initialize the variable 'mode' to silence this warning
        u8 rate_idx = td->tx_rate_idx, mode;
                                           ^

Change it to return an error instead of continuing with invalid data
here.

Fixes: 3f0caa3cbf94 ("mt76: mt7915: add support for continuous tx in testmode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: remove the extra 'break;' after return.
---
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 7fb2170a9561..bd798df748ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -543,7 +543,7 @@ mt7915_tm_set_tx_cont(struct mt7915_phy *phy, bool en)
 		tx_cont->bw = CMD_CBW_20MHZ;
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	if (!en) {
@@ -591,7 +591,7 @@ mt7915_tm_set_tx_cont(struct mt7915_phy *phy, bool en)
 		mode = MT_PHY_TYPE_HE_MU;
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	rateval =  mode << 6 | rate_idx;
-- 
2.29.2

