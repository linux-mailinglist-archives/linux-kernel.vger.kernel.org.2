Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167823138A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 16:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhBHP4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 10:56:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhBHPIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:08:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB83E64EB6;
        Mon,  8 Feb 2021 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612796769;
        bh=zu04za1olHJW9o9M8NvbZ6Jb6iTbCFvbqw7IS6YMdJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdM1l/iZ5Cvx92A2ZOv6TOmxd3nQk8S85yT51pypkt443NEw4IhcCg7cDZNa3f4cU
         ydCuL/ZOooCdZLpx1BYhZ0c08gu6OPWdicBydKlgawUqDZ472m7jmGZ4qnmCiWC6HH
         lEbiLUucQlFO2umW3JKDVQOCRsMgyoXHxygIG7zk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 14/30] mac80211: fix station rate table updates on assoc
Date:   Mon,  8 Feb 2021 16:01:00 +0100
Message-Id: <20210208145805.822210549@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208145805.239714726@linuxfoundation.org>
References: <20210208145805.239714726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

commit 18fe0fae61252b5ae6e26553e2676b5fac555951 upstream.

If the driver uses .sta_add, station entries are only uploaded after the sta
is in assoc state. Fix early station rate table updates by deferring them
until the sta has been uploaded.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://lore.kernel.org/r/20210201083324.3134-1-nbd@nbd.name
[use rcu_access_pointer() instead since we won't dereference here]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/driver-ops.c |    5 ++++-
 net/mac80211/rate.c       |    3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -128,8 +128,11 @@ int drv_sta_state(struct ieee80211_local
 	} else if (old_state == IEEE80211_STA_AUTH &&
 		   new_state == IEEE80211_STA_ASSOC) {
 		ret = drv_sta_add(local, sdata, &sta->sta);
-		if (ret == 0)
+		if (ret == 0) {
 			sta->uploaded = true;
+			if (rcu_access_pointer(sta->sta.rates))
+				drv_sta_rate_tbl_update(local, sdata, &sta->sta);
+		}
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTH) {
 		drv_sta_remove(local, sdata, &sta->sta);
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -941,7 +941,8 @@ int rate_control_set_rates(struct ieee80
 	if (old)
 		kfree_rcu(old, rcu_head);
 
-	drv_sta_rate_tbl_update(hw_to_local(hw), sta->sdata, pubsta);
+	if (sta->uploaded)
+		drv_sta_rate_tbl_update(hw_to_local(hw), sta->sdata, pubsta);
 
 	ieee80211_sta_set_expected_throughput(pubsta, sta_get_expected_throughput(sta));
 


