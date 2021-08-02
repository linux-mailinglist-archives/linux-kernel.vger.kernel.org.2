Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501E53DD2BC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhHBJPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:15:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44238 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhHBJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:14:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D922621F92;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627895661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CzLqnDMPgV4X2TVtB9CFgIWVEvkNhP+8WThUlGoV9nM=;
        b=N+1n5KRzW6s24ikSgDhL2tmsT39qO2ZRzX8lqB6DJry37dkTREvk4+AYaHPsxAob1wM3Pn
        qTsdtC71CwNssszviWcuD7afElG6Q4Xa/53kt1LoP329io6Zgdn/lFhvYswc3xlaGnKJwu
        hM1FmUZ8RqNAhY3HaFz0fpTtuDRJRJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627895661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CzLqnDMPgV4X2TVtB9CFgIWVEvkNhP+8WThUlGoV9nM=;
        b=e7rMxn/09JBLlBbH/w7K/FuwWZLus0cKadw3g67V22KecwXor6CTEuEA0d15WwjcWT4ZOM
        hC9a9Fn8UJbMCYDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D154BA3BB5;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 22DDE518C097; Mon,  2 Aug 2021 11:14:21 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 8/8] nvme-rdma: Unfreeze queues on reconnect
Date:   Mon,  2 Aug 2021 11:14:19 +0200
Message-Id: <20210802091419.56425-9-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802091419.56425-1-dwagner@suse.de>
References: <20210802091419.56425-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the queue teardown in nvme_rdma_teardown_io_queues() freeze is
called unconditionally. When we reconnect we need to pair the freeze
with an unfreeze to avoid hanging I/Os. For newly created connection
this is not needed.

Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index de2a8950d282..21a8a5353af0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -901,6 +901,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 			error = PTR_ERR(ctrl->ctrl.admin_q);
 			goto out_cleanup_fabrics_q;
 		}
+	} else {
+		nvme_unfreeze(&ctrl->ctrl);
 	}
 
 	error = nvme_rdma_start_queue(ctrl, 0);
-- 
2.29.2

