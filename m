Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5955353047
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhDBU1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:27:12 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:52962 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBU1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:27:11 -0400
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Apr 2021 16:27:11 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 453F93FC44;
        Fri,  2 Apr 2021 22:18:42 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b="FX11u6qA";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a_yO88S5N50N; Fri,  2 Apr 2021 22:18:41 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 9BC823F735;
        Fri,  2 Apr 2021 22:18:38 +0200 (CEST)
Received: by flawful.org (Postfix, from userid 1001)
        id 7076414BC; Fri,  2 Apr 2021 22:18:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1617394717; bh=vpKvFQbGdigWLDUL0qg1CLF78XoNpFYhqw/S6OoC9+g=;
        h=From:To:Cc:Subject:Date:From;
        b=FX11u6qAi3wJU0uoJklPU5sH89JHNd8rZI+gOpAAMXLXJwwr7SfWehZ2UYuu6wgGp
         oFdqxdQQZ3Qcn6xEE5uZzl9NjPRsTfe4kHsd8eUCYKr7jXYRiGACQwmLj+m1ZUlr78
         5UBQunp/raXNNZGGtzC27VgDmzjd7g3VqlzvC0Bw=
From:   Niklas Cassel <nks@flawful.org>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     niklas.cassel@wdc.com, joshi.k@samsung.com, javier@javigon.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] nvme: disallow passthru cmd from targeting a nsid != nsid of the block dev
Date:   Fri,  2 Apr 2021 22:18:08 +0200
Message-Id: <20210402201808.31979-1-nks@flawful.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

When a passthru command targets a specific namespace, the ns parameter to
nvme_user_cmd()/nvme_user_cmd64() is set. However, there is currently no
validation that the nsid specified in the passthru command targets the
namespace/nsid represented by the block device that the ioctl was
performed on.

Add a check that validates that the nsid in the passthru command matches
that of the supplied namespace.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Javier González <javier@javigon.com>
---
Changes since v2:
-Picked up Reviewed-by-tags.
-Send from a mail server that doesn't mangle the mail.

 drivers/nvme/host/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f13eb4ded95f..a50352ea3f7b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1599,6 +1599,12 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
+	if (ns && cmd.nsid != ns->head->ns_id) {
+		dev_err(ctrl->device,
+			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
+			current->comm, cmd.nsid, ns->head->ns_id);
+		return -EINVAL;
+	}
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
@@ -1643,6 +1649,12 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
+	if (ns && cmd.nsid != ns->head->ns_id) {
+		dev_err(ctrl->device,
+			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
+			current->comm, cmd.nsid, ns->head->ns_id);
+		return -EINVAL;
+	}
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
-- 
2.30.2

