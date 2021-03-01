Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD60329ABC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 11:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348404AbhCBBCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 20:02:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235301AbhCASwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:52:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A880F64F6F;
        Mon,  1 Mar 2021 16:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614616698;
        bh=Tp9ltggiwRXSTkfIIdqdimmKElWMdtXYYiy69l9Sk/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xi638AWm4rQCJwXd13+qanklooGqMJW2YErfJRIjZf/yCu3jZ8vijnUySawIHbMsm
         J+goPRw5N815noPA08r8dPUh9sQWaX4cJrGk/ZDlHOaq9+CKgj4eRhIfM9LejIe4A8
         W8TveFYhZ24NkJVGqNJtIiMzSKCbsfTxy4d7pVNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rakesh Pillai <pillair@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 024/247] ath10k: Fix error handling in case of CE pipe init failure
Date:   Mon,  1 Mar 2021 17:10:44 +0100
Message-Id: <20210301161032.883252534@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161031.684018251@linuxfoundation.org>
References: <20210301161031.684018251@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rakesh Pillai <pillair@codeaurora.org>

[ Upstream commit 31561e8557cd1eeba5806ac9ce820f8323b2201b ]

Currently if the copy engine pipe init fails for snoc based
chipsets, the rri is not freed.

Fix this error handling for copy engine pipe init
failure.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Fixes: 4945af5b264f ("ath10k: enable SRRI/DRRI support on ddr for WCN3990")
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/1607713210-18320-1-git-send-email-pillair@codeaurora.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index e2d78f77edb70..241e6f0e1dfe2 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -789,13 +789,14 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar)
 	ret = ath10k_snoc_init_pipes(ar);
 	if (ret) {
 		ath10k_err(ar, "failed to initialize CE: %d\n", ret);
-		goto err_wlan_enable;
+		goto err_free_rri;
 	}
 
 	napi_enable(&ar->napi);
 	return 0;
 
-err_wlan_enable:
+err_free_rri:
+	ath10k_ce_free_rri(ar);
 	ath10k_snoc_wlan_disable(ar);
 
 	return ret;
-- 
2.27.0



