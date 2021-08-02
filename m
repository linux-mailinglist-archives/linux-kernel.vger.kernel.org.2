Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C959F3DD2B9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhHBJOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:14:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58824 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhHBJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:14:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D9F071FF58;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627895661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXNn5WZQMOzF4wr03lXtsXvUZdT/MzSbG6ALi9FuFQs=;
        b=FrbDu/GECJXSQF+Vtmepd0NXebbc87vd1PuyPzvMqKS7H0XCksAzJYN9z8zTQos/4XZCGh
        xYIqdQAxE6rYCoHnh5OWjbQo08PxoL7Qug6fPlKWuckgQPgROTIvnERjw9SchInZXRfr4K
        /3h82gByhMBNjn/qW2xfpu5KO78UXE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627895661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXNn5WZQMOzF4wr03lXtsXvUZdT/MzSbG6ALi9FuFQs=;
        b=P4ansKEO2x5jLeMFJh7wSAI6zhRnb+PPnnjW0J0gTS+/2PYLpLPMJMhrc1ermx28j3qr0g
        QLGbElG2mhXs3yBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D0507A3BB3;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 1D959518C095; Mon,  2 Aug 2021 11:14:21 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 7/8] nvme-tcp: Unfreeze queues on reconnect
Date:   Mon,  2 Aug 2021 11:14:18 +0200
Message-Id: <20210802091419.56425-8-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802091419.56425-1-dwagner@suse.de>
References: <20210802091419.56425-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the queue teardown in nvme_tcp_teardown_io_queues() freeze is
called unconditionally. When we reconnect we need to pair the freeze
with an unfreeze to avoid hanging I/Os. For newly created connection
this is not needed.

Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 32268f24f62a..097f7dd10ed3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1819,9 +1819,11 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
 			ctrl->queue_count - 1);
-		nvme_unfreeze(ctrl);
 	}
 
+	if (!new)
+		nvme_unfreeze(ctrl);
+
 	ret = nvme_tcp_start_io_queues(ctrl);
 	if (ret)
 		goto out_cleanup_connect_q;
-- 
2.29.2

