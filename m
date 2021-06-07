Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A5639D804
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGI7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:59:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49222 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:59:04 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 297F121A5B;
        Mon,  7 Jun 2021 08:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623056232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=70d+eeUNUJUrApqI9dcysM+A4Ouzv/oKGOxjeF7oXZo=;
        b=jWgCRi59aEiHaDvW/KVX0XjMm20RZwopSJiDit2t46cZbiXznJ7t3XhxHg+bVH6jNAvcgx
        40W103nVzIqtB2LfpOTYG3unnCnkURo3c/+YO8DiacHJq+16wXhRvEOgIgcw8WtWYo7OKY
        PO8PcLSbzcdg9m34g4vfGGUrUvhJIk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623056232;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=70d+eeUNUJUrApqI9dcysM+A4Ouzv/oKGOxjeF7oXZo=;
        b=3IYcJthl7lzsUQ9np6thDiH1QtqT+G3oQEEA3Bxv63MhPO96ocbjjSbhCRaBjTHFGnoGju
        lIXfTDc0b8pm29BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id EC4C4A3B83;
        Mon,  7 Jun 2021 08:57:11 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id DF693516FDED; Mon,  7 Jun 2021 10:57:11 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2] nvme: verify MNAN value if ANA is enabled
Date:   Mon,  7 Jun 2021 10:56:56 +0200
Message-Id: <20210607085656.101772-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The controller is required to have a non-zero MNAN value if it supports
ANA:

   If the controller supports Asymmetric Namespace Access Reporting, then
   this field shall be set to a non-zero value that is less than or equal
   to the NN value.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

v2: - moved the check to nvme_mpath_init_identify
    - added reviewed tags

 drivers/nvme/host/multipath.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a501917d4c6e..23573fe3fc7d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -813,6 +813,13 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
 		return 0;
 
+	if (!ctrl->max_namespaces ||
+	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
+		dev_err(ctrl->device,
+			"Invalid MNAN value %u\n", ctrl->max_namespaces);
+		return -EINVAL;
+	}
+
 	ctrl->anacap = id->anacap;
 	ctrl->anatt = id->anatt;
 	ctrl->nanagrpid = le32_to_cpu(id->nanagrpid);
-- 
2.29.2

