Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B51B3FD6B9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbhIAJ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:26:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60280 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243418AbhIAJ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:26:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1303F1FED2;
        Wed,  1 Sep 2021 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630488329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+YRDyHEd0/BbrJjaiTEJ0u9b/syuNDaZjHPGP+HRcTk=;
        b=gxZAuuRYo4um9VhWmQFpBfBzUkO/Vvk6T+X3j6soRekCeo9n2WkXLR+VdAGXgd69xuIm4+
        vu5ihxduiVqWosyO5yVWspxwM3jJoHK7hCoRAmrO6jxIBy/Xd96OIHMExRFscPFV9jJCEj
        2pCXl/PbWWkElgsSKnwCGmQkBrLGZjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630488329;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+YRDyHEd0/BbrJjaiTEJ0u9b/syuNDaZjHPGP+HRcTk=;
        b=Q5ZeS9YcXGgTK6kCB8wv6MUKYl1FiJ9GAlmTRGQnMNpDwnSHEATh6C2MQji69bGpmWYMma
        EvsNgdyHP2yxXKAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 0D54EA3B9C;
        Wed,  1 Sep 2021 09:25:29 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id F3DE5518DE46; Wed,  1 Sep 2021 11:25:28 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1] nvme: only call synhronize_srcu when clearing current path
Date:   Wed,  1 Sep 2021 11:25:24 +0200
Message-Id: <20210901092524.131610-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function nmve_mpath_clear_current_path returns true if the current
path has changed. In this case we have to wait for all concurrent
submissions to finish. But if we didn't change the current path, there
is no point in waiting for another RCU period to finish.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d5cc947525..5b3c74fa89bd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3814,8 +3814,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	synchronize_rcu(); /* guarantee not available in head->list */
-	nvme_mpath_clear_current_path(ns);
-	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
+	if (nvme_mpath_clear_current_path(ns))
+		synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
 
 	if (ns->disk->flags & GENHD_FL_UP) {
 		if (!nvme_ns_head_multipath(ns->head))
-- 
2.29.2

