Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D18F3BF793
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhGHJaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:30:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35980 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhGHJav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:30:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7603421FAA;
        Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625736488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l81TcQcEiPKe4gM3TQv02D1ncgjljmX/9B8BQR7UWLI=;
        b=NZaTPneCcMj+dF+qGEacb0tHKXeQkFDmgxh0Le5B5Nxn4pRdgHWYavPW8H4tGwklDAMocn
        oZCQBlVUZBq9icXLbYC1c0nGrta/9kuCV9FVwEhz//Tzfsz1YaPF6xHkq0h6Ie6tCRFl4y
        yR3Cqn+KrrgV3EYKCjhfg7aOVltYAgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625736488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l81TcQcEiPKe4gM3TQv02D1ncgjljmX/9B8BQR7UWLI=;
        b=g0z/l+1gS+anvJDWnEp4fN0+omGHZuUywQ+axMrmYVOFavfhyJzNtLIukirwsvNShtQX4S
        BbaDqwTSn3zG5+BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 6DD9CA3B88;
        Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 6705B5171154; Thu,  8 Jul 2021 11:28:08 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 5/5] nvme-fc: Freeze queues before destroying them
Date:   Thu,  8 Jul 2021 11:27:55 +0200
Message-Id: <20210708092755.15660-6-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210708092755.15660-1-dwagner@suse.de>
References: <20210708092755.15660-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvme_wait_freeze_timeout() in nvme_fc_recreate_io_queues() needs to be
paired with a nvme_start_freeze(). Without freezing first we will always
timeout in nvme_wait_freeze_timeout().

Note there is a similiar fix for RDMA 9f98772ba307 ("nvme-rdma: fix
controller reset hang during traffic") which happens to follow the PCI
strategy how to handle resetting the queues.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8e1fc3796735..a38b01485939 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3249,6 +3249,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 		nvme_fc_xmt_ls_rsp(disls);
 
 	if (ctrl->ctrl.tagset) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_fc_delete_hw_io_queues(ctrl);
 		nvme_fc_free_io_queues(ctrl);
 	}
-- 
2.29.2

