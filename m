Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A14E3CD15C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhGSJRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236048AbhGSJRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626688671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=59iFVD/auyINWDPkiN6tHAy2s2cQYkANCZ5O2x5bXF4=;
        b=d/jyFk+QR9Vxi0r4T3pA3ryF3hRWCuGougW0RPrfnZ0ar7fetX+g/jt0FGhhlqqq/5qBpa
        Cg31wzbpxSMOP4tCrxIfvBWt4fwRVcE95CH0rJ4E9cSl9/3J3oDndqy6ZNGe7AO3a+o3Hf
        d0hHOjmTVR/uRmC6F/7jlI7DRHFEGk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-RF72CA9VO7Knc73e5PGyhg-1; Mon, 19 Jul 2021 05:57:49 -0400
X-MC-Unique: RF72CA9VO7Knc73e5PGyhg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5213B100C609;
        Mon, 19 Jul 2021 09:57:48 +0000 (UTC)
Received: from localhost (ovpn-12-118.pek2.redhat.com [10.72.12.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3B6B60CC9;
        Mon, 19 Jul 2021 09:57:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 1/7] genirq/affinity: remove the 'firstvec' parameter from irq_build_affinity_masks
Date:   Mon, 19 Jul 2021 17:57:23 +0800
Message-Id: <20210719095729.834332-2-ming.lei@redhat.com>
In-Reply-To: <20210719095729.834332-1-ming.lei@redhat.com>
References: <20210719095729.834332-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'firstvec' parameter is always same with the parameter of
'startvec', so use 'startvec' directly inside irq_build_affinity_masks().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 735f697d7d15..0c535591f2f2 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -336,10 +336,10 @@ static int __irq_build_affinity_masks(unsigned int startvec,
  *	2) spread other possible CPUs on these vectors
  */
 static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
-				    unsigned int firstvec,
 				    struct irq_affinity_desc *masks)
 {
 	unsigned int curvec = startvec, nr_present = 0, nr_others = 0;
+	unsigned int firstvec = startvec;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
@@ -469,8 +469,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
-		ret = irq_build_affinity_masks(curvec, this_vecs,
-					       curvec, masks);
+		ret = irq_build_affinity_masks(curvec, this_vecs, masks);
 		if (ret) {
 			kfree(masks);
 			return NULL;
-- 
2.31.1

