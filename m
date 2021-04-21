Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC92D366BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbhDUNHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238294AbhDUNFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F1D561463;
        Wed, 21 Apr 2021 13:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010302;
        bh=tKWWxmEKW5e7z8Nhqa7Lvp+xmzZj0UfNCnUfuz+9UDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1eqikCjwo2yi6wpFfdt7wn6NJA3b1o53pGbxmZ/GAgYK9XSOQ2YD/LRa45CmcLxcC
         4AEenZLv66GLKPuECN+fs2WEgYUWHTniajIMl6Wx+wpDQm4LUnRipUSddsrR1kwqrA
         LmdtQkv+RKXKL030w8g4OeZrShmgHWMKDV/yyOiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 069/190] Revert "mac80211: Remove redundant assertion"
Date:   Wed, 21 Apr 2021 14:59:04 +0200
Message-Id: <20210421130105.1226686-70-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1ee7826ab68f7e9fa1a01533983acf6a6f62e297.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: https
Cc: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c0fa526a45b4..2de2e655be59 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -39,6 +39,7 @@ const void *const mac80211_wiphy_privid = &mac80211_wiphy_privid;
 struct ieee80211_hw *wiphy_to_ieee80211_hw(struct wiphy *wiphy)
 {
 	struct ieee80211_local *local;
+	BUG_ON(!wiphy);
 
 	local = wiphy_priv(wiphy);
 	return &local->hw;
-- 
2.31.1

