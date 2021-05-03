Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71038371509
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhECMEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234014AbhECMC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CAA961077;
        Mon,  3 May 2021 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043294;
        bh=UwR8hxuOP2LjMNeNYjtnGsV7B+45DJNQUCAyp8dcpXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoA0NMxGSD0gDa5YaisF+ipivuUk2Dr6G3gZ2550dpeyEQzxTewtZ5JtScqzgCZh6
         1XQZWZ/NQ4gZASwM+i058RngjEZzB10BxugERid5kWt/9YiP8ZoquaLbJD7DEt9oOo
         RWv+OVz/5Pl4qtId/53ywLj0VWrOS7oIVfeMGD60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 43/69] ath6kl: return error code in ath6kl_wmi_set_roam_lrssi_cmd()
Date:   Mon,  3 May 2021 13:57:10 +0200
Message-Id: <20210503115736.2104747-44-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anirudh Rayabharam <mail@anirudhrb.com>

Propagate error code from failure of ath6kl_wmi_cmd_send() to the
caller.

Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath6kl/debug.c | 5 ++++-
 drivers/net/wireless/ath/ath6kl/wmi.c   | 4 +---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/debug.c b/drivers/net/wireless/ath/ath6kl/debug.c
index 7506cea46f58..433a047f3747 100644
--- a/drivers/net/wireless/ath/ath6kl/debug.c
+++ b/drivers/net/wireless/ath/ath6kl/debug.c
@@ -1027,14 +1027,17 @@ static ssize_t ath6kl_lrssi_roam_write(struct file *file,
 {
 	struct ath6kl *ar = file->private_data;
 	unsigned long lrssi_roam_threshold;
+	int ret;
 
 	if (kstrtoul_from_user(user_buf, count, 0, &lrssi_roam_threshold))
 		return -EINVAL;
 
 	ar->lrssi_roam_threshold = lrssi_roam_threshold;
 
-	ath6kl_wmi_set_roam_lrssi_cmd(ar->wmi, ar->lrssi_roam_threshold);
+	ret = ath6kl_wmi_set_roam_lrssi_cmd(ar->wmi, ar->lrssi_roam_threshold);
 
+	if (ret)
+		return ret;
 	return count;
 }
 
diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index aca9732ec1ee..b137e7f34397 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -776,10 +776,8 @@ int ath6kl_wmi_set_roam_lrssi_cmd(struct wmi *wmi, u8 lrssi)
 	cmd->info.params.roam_rssi_floor = DEF_LRSSI_ROAM_FLOOR;
 	cmd->roam_ctrl = WMI_SET_LRSSI_SCAN_PARAMS;
 
-	ath6kl_wmi_cmd_send(wmi, 0, skb, WMI_SET_ROAM_CTRL_CMDID,
+	return ath6kl_wmi_cmd_send(wmi, 0, skb, WMI_SET_ROAM_CTRL_CMDID,
 			    NO_SYNC_WMIFLAG);
-
-	return 0;
 }
 
 int ath6kl_wmi_force_roam_cmd(struct wmi *wmi, const u8 *bssid)
-- 
2.31.1

