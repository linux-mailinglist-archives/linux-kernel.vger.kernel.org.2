Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B533F9455
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 08:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244264AbhH0GSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 02:18:30 -0400
Received: from verein.lst.de ([213.95.11.211]:32921 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhH0GS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 02:18:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B7A66736F; Fri, 27 Aug 2021 08:17:37 +0200 (CEST)
Date:   Fri, 27 Aug 2021 08:17:37 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvmet: use passthru cntrl in nvmet_init_cap
Message-ID: <20210827061737.GA22583@lst.de>
References: <20210826211522.308649-1-a.manzanares@samsung.com> <CGME20210826211546uscas1p1e181ca820e506c7c195b933168301dd0@uscas1p1.samsung.com> <20210826211522.308649-3-a.manzanares@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826211522.308649-3-a.manzanares@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Technically this looks good, but the core target code should not have
to poke into the host side data structures.  Does this version still look
good to you?

---
From c5777caf1562df35150a71e5c91c5b272956beee Mon Sep 17 00:00:00 2001
From: Adam Manzanares <a.manzanares@samsung.com>
Date: Thu, 26 Aug 2021 21:15:45 +0000
Subject: nvmet: looks at the passthrough controller when initializing CAP

For a passthru controller make cap initialization dependent on the cap of
the passthru controller, given that multiple Command Set support needs
to be supported by the underlying controller.  For that move the
initialization of CAP later so that it can use the fully initialized
nvmet_ctrl structure.

Fixes: ab5d0b38c047 (nvmet: add Command Set Identifier support)
Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
[hch: refactored the code a bit to keep it more contained in passthru.c]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/core.c     |  6 ++++--
 drivers/nvme/target/nvmet.h    |  2 ++
 drivers/nvme/target/passthru.c | 10 ++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 66d05eecc2a9..11c44706dc2d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1206,6 +1206,9 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	ctrl->cap |= (15ULL << 24);
 	/* maximum queue entries supported: */
 	ctrl->cap |= NVMET_QUEUE_SIZE - 1;
+
+	if (nvmet_passthru_ctrl(ctrl->subsys))
+		nvmet_passthrough_override_cap(ctrl);
 }
 
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
@@ -1363,8 +1366,6 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out_put_subsystem;
 	mutex_init(&ctrl->lock);
 
-	nvmet_init_cap(ctrl);
-
 	ctrl->port = req->port;
 
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
@@ -1378,6 +1379,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
+	nvmet_init_cap(ctrl);
 	WRITE_ONCE(ctrl->aen_enabled, NVMET_AEN_CFG_OPTIONAL);
 
 	ctrl->changed_ns_list = kmalloc_array(NVME_MAX_CHANGED_NAMESPACES,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 06dd3d537f07..183119607968 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -613,6 +613,8 @@ nvmet_req_passthru_ctrl(struct nvmet_req *req)
 	return nvmet_passthru_ctrl(nvmet_req_subsys(req));
 }
 
+void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl);
+
 u16 errno_to_nvme_status(struct nvmet_req *req, int errno);
 u16 nvmet_report_invalid_opcode(struct nvmet_req *req);
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 225cd1ffbe45..8784c487e462 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -20,6 +20,16 @@ MODULE_IMPORT_NS(NVME_TARGET_PASSTHRU);
  */
 static DEFINE_XARRAY(passthru_subsystems);
 
+void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl)
+{
+	/*
+	 * Multiple command set support can only be declared if the underlying
+	 * controller actually supports it.
+	 */
+	if (!nvme_multi_css(ctrl->subsys->passthru_ctrl))
+		ctrl->cap &= ~(1ULL << 43);
+}
+
 static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-- 
2.30.2

