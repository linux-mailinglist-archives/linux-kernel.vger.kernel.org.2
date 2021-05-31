Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDB4395909
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhEaKij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:38:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:37354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhEaKie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 06:38:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622457413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=spA1WpO8iPOW7X7Idno4u2SyDNrcS/UVwi7LqykGzYY=;
        b=HF8BnQwNDq7jA0Z/NRVOmZUW2OeI3vziHM4gCVcXUu8QS08TKOXZOzHRnrQqW/qvkwDXmu
        RMQLsopql4cqMM59ldVhjvuRdoZP2cwUZ0OvV1bZ+PQKkwMBNpQ6VHzqlELDRFCmY0MHvx
        /v1f+lZqeajy2pNbKEPrTv04MD9z+5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622457413;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=spA1WpO8iPOW7X7Idno4u2SyDNrcS/UVwi7LqykGzYY=;
        b=M91Qa1eZM9y91OgG+J6EbX/7qNYePKUlEeZgOpqEOWKPhneXRvvM0q5rHHA3FDhXS2zcsQ
        H/iDKro39JCfZ6Dw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 802EAAE72;
        Mon, 31 May 2021 10:36:53 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme: verify MNAN value if ANA is enabled
Date:   Mon, 31 May 2021 12:36:51 +0200
Message-Id: <20210531103651.109426-1-dwagner@suse.de>
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

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
This is a follow up to the discussion in

  https://lore.kernel.org/linux-nvme/20210521144734.90044-1-dwagner@suse.de/

 drivers/nvme/host/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb1a76a3d42a..4c412adc9e14 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2972,6 +2972,16 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		goto out_free;
 
+#ifdef CONFIG_NVME_MULTIPATH
+	if (ctrl->ana_log_buf && (!ctrl->max_namespaces ||
+				  ctrl->max_namespaces > le32_to_cpu(id->nn))) {
+		dev_err(ctrl->device,
+			"Invalid MNAN value %u\n", ctrl->max_namespaces);
+		ret = -EINVAL;
+		goto out_free;
+	}
+#endif
+
 	if (ctrl->apst_enabled && !prev_apst_enabled)
 		dev_pm_qos_expose_latency_tolerance(ctrl->device);
 	else if (!ctrl->apst_enabled && prev_apst_enabled)
-- 
2.29.2

