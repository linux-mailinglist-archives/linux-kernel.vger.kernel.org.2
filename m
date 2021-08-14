Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9473EC613
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 01:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhHNX65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 19:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233237AbhHNX6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 19:58:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD30260F4B;
        Sat, 14 Aug 2021 23:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628985501;
        bh=t8Q+1vcbRYWm0DqjrS1nRd/+A1arBzQyYrDSspaqKe0=;
        h=From:To:Cc:Subject:Date:From;
        b=K1qJ92ZnvsqrMKYnSPkc+Qh3yLLopJOit2/jGIOmrzNDHmVlQWCMzxW3fje3w0ziT
         4a2s+UEKQAd7/8doDZ4n/FgQzuK1XTSkLgpYDvGWmxh7umx2EhHyodhZjJTlEoMS2r
         A7uZJ9g7rHXkrCkcoPR49p0PM5K/zQ0TWdXJJ7D2Tlu8Ts18b/wPCCHpc1K3Gxs77E
         MJsHPJ+ZDEPqG7bNkDlK1kgVo6Pg+0W0cq7g8fbGBV+p1QCQMoBieEGJAuEqxcXcPY
         Onl1MmNJolZ2Ph2yL+CmkTRd90rn6mR92aOrjDb3/Xa2mA18G3MUxc/h5UD2GLQpzW
         y5zB1eI02J2wA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] staging: rtl8192u: Fix bitwise vs logical operator in TranslateRxSignalStuff819xUsb()
Date:   Sat, 14 Aug 2021 16:56:26 -0700
Message-Id: <20210814235625.1780033-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns:

drivers/staging/rtl8192u/r8192U_core.c:4268:20: warning: bitwise and of
boolean expressions; did you mean logical and? [-Wbool-operation-and]
        bpacket_toself =  bpacket_match_bssid &
                          ^~~~~~~~~~~~~~~~~~~~~
                                              &&
1 warning generated.

Replace the bitwise AND with a logical one to clear up the warning, as
that is clearly what was intended.

Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index db26edeccea6..b6698656fc01 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4265,7 +4265,7 @@ static void TranslateRxSignalStuff819xUsb(struct sk_buff *skb,
 	bpacket_match_bssid = (type != IEEE80211_FTYPE_CTL) &&
 			       (ether_addr_equal(priv->ieee80211->current_network.bssid,  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 : (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 : hdr->addr3))
 			       && (!pstats->bHwError) && (!pstats->bCRC) && (!pstats->bICV);
-	bpacket_toself =  bpacket_match_bssid &
+	bpacket_toself =  bpacket_match_bssid &&
 			  (ether_addr_equal(praddr, priv->ieee80211->dev->dev_addr));
 
 	if (WLAN_FC_GET_FRAMETYPE(fc) == IEEE80211_STYPE_BEACON)

base-commit: 0bd35146642bdc56f1b87d75f047b1c92bd2bd39
-- 
2.33.0.rc2

