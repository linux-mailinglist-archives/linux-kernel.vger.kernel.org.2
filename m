Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55E73B63FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbhF1PCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236089AbhF1OqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:46:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D33B161C96;
        Mon, 28 Jun 2021 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624890868;
        bh=ltZV6Jt4ghxEh3yLIw/23FrPMnxa2xTgM43AU+i0y1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcPfst+vEv/5jxMJIpCzB1YgeE9G0xn/O/nn0I/1+BMrIean8lVccjUn2UQGmYVN6
         C+fXXIc771FNeV0MqKzRhYpeubGu3BOMJwHUy8Jh2bIqZx3K5twog4BgAe5vlMytZp
         Fq6OOypEGCPFiM2fjg+mPbn9PMdmvOmhOd9rBSE77Xm0ZGzmKEef0W1eXVV72l3zBw
         pR5XGuvxOKRfD4SxJWBDwCqoDelWyN3Mme+V91awa2msGOyrvXPfO9uuhNS3TlLv6g
         Bhq7dnDxewkGsnN9JAuAnaJApqNbaCuy5yKwDSPPwUUzUEMybO8lsFJIWKQCucM/V/
         LdkWRjl/22j8Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 092/109] mac80211: drop multicast fragments
Date:   Mon, 28 Jun 2021 10:32:48 -0400
Message-Id: <20210628143305.32978-93-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210628143305.32978-1-sashal@kernel.org>
References: <20210628143305.32978-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.196-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.196-rc1
X-KernelTest-Deadline: 2021-06-30T14:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit a9799541ca34652d9996e45f80e8e03144c12949 ]

These are not permitted by the spec, just drop them.

Link: https://lore.kernel.org/r/20210609161305.23def022b750.Ibd6dd3cdce573dae262fcdc47f8ac52b883a9c50@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 2ba19decb126..012697efafc3 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2124,17 +2124,15 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 	sc = le16_to_cpu(hdr->seq_ctrl);
 	frag = sc & IEEE80211_SCTL_FRAG;
 
-	if (is_multicast_ether_addr(hdr->addr1)) {
-		I802_DEBUG_INC(rx->local->dot11MulticastReceivedFrameCount);
-		goto out_no_led;
-	}
-
 	if (rx->sta)
 		cache = &rx->sta->frags;
 
 	if (likely(!ieee80211_has_morefrags(fc) && frag == 0))
 		goto out;
 
+	if (is_multicast_ether_addr(hdr->addr1))
+		return RX_DROP_MONITOR;
+
 	I802_DEBUG_INC(rx->local->rx_handlers_fragments);
 
 	if (skb_linearize(rx->skb))
@@ -2260,7 +2258,6 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 
  out:
 	ieee80211_led_rx(rx->local);
- out_no_led:
 	if (rx->sta)
 		rx->sta->rx_stats.packets++;
 	return RX_CONTINUE;
-- 
2.30.2

