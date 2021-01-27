Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1B305887
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhA0Kd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:33:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:58288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235714AbhA0KbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:31:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E36EAD26;
        Wed, 27 Jan 2021 10:30:42 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2] nvme-multipath: Early exit if no path is available
Date:   Wed, 27 Jan 2021 11:30:33 +0100
Message-Id: <20210127103033.15318-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvme_round_robin_path() should test if the return ns pointer is
valid. nvme_next_ns() will return a NULL pointer if there is no path
left.

Fixes: 75c10e732724 ("nvme-multipath: round-robin I/O policy")
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
v2:
  - moved NULL test into the if conditional statement
  - added Fixes tag

 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9ac762b28811..282b7a4ea9a9 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -221,7 +221,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 	}
 
 	for (ns = nvme_next_ns(head, old);
-	     ns != old;
+	     ns && ns != old;
 	     ns = nvme_next_ns(head, ns)) {
 		if (nvme_path_is_disabled(ns))
 			continue;
-- 
2.29.2

