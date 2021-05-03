Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261F6371508
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhECMEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233475AbhECMC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:02:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC33C6137D;
        Mon,  3 May 2021 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043292;
        bh=mQAn/d+T9CdkIkUGZLwRh58/2LvPC5iU2UtBb/2oOR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cu1AzX6FMMuK3Xu94m/cj0YzbGNsJwDntWzfFvYRqShxWDQnsSkAYW4Pc5DzmcTQy
         omadXoFPhZyH5iFb+Crwxsmu8eXApeJQ4jGyLLox1eQJ5aQWhuBPP4wj0EUFWET+hP
         w7AS7zXsNFECe0rc/Od3ZmQLhS9eQQCLnGMJd5Nw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 42/69] Revert "ath6kl: return error code in ath6kl_wmi_set_roam_lrssi_cmd()"
Date:   Mon,  3 May 2021 13:57:09 +0200
Message-Id: <20210503115736.2104747-43-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fc6a6521556c8250e356ddc6a3f2391aa62dc976.

Because of recent interactions with developers from @umn.edu, all
commits from them have been recently re-reviewed to ensure if they were
correct or not.

Upon review, this commit was found to be incorrect for the reasons
below, so it must be reverted.  It will be fixed up "correctly" in a
later kernel change.

The change being reverted does NOTHING as the caller to this function
does not even look at the return value of the call.  So the "claim" that
this fixed an an issue is not true.  It will be fixed up properly in a
future patch by propagating the error up the stack correctly.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath6kl/wmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index b137e7f34397..aca9732ec1ee 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -776,8 +776,10 @@ int ath6kl_wmi_set_roam_lrssi_cmd(struct wmi *wmi, u8 lrssi)
 	cmd->info.params.roam_rssi_floor = DEF_LRSSI_ROAM_FLOOR;
 	cmd->roam_ctrl = WMI_SET_LRSSI_SCAN_PARAMS;
 
-	return ath6kl_wmi_cmd_send(wmi, 0, skb, WMI_SET_ROAM_CTRL_CMDID,
+	ath6kl_wmi_cmd_send(wmi, 0, skb, WMI_SET_ROAM_CTRL_CMDID,
 			    NO_SYNC_WMIFLAG);
+
+	return 0;
 }
 
 int ath6kl_wmi_force_roam_cmd(struct wmi *wmi, const u8 *bssid)
-- 
2.31.1

