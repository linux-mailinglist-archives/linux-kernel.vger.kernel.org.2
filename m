Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3504741A464
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 02:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbhI1A6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 20:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238471AbhI1A6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 20:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632790616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2bS5vXfZioW/ha8BY5Ib70bYqfF2A57K9G9K5QgSkM=;
        b=ZM6xk8GvrvaD8ENrNIEx/wYjnZCQTnhtaOK7unfQe0sgVR3iW3vY52y7ZiVwTyLlaVJAMW
        Iwx7hoZwtQVhNuMDlKhQAZzbWLfb2e+e3xUDEPb3RxlMsTq3MvZkVT6GfQBZmEyqLu0QiS
        yILdUODGnOn3/LMZoStPY7MuQ8VH58k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-fDW32QO7NN2d2JbZATkwiw-1; Mon, 27 Sep 2021 20:56:55 -0400
X-MC-Unique: fDW32QO7NN2d2JbZATkwiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28318108087A;
        Tue, 28 Sep 2021 00:56:54 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B038160C13;
        Tue, 28 Sep 2021 00:56:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 6/7] lib/group_cpus: allow to group cpus in case of !CONFIG_SMP
Date:   Tue, 28 Sep 2021 08:55:57 +0800
Message-Id: <20210928005558.243352-7-ming.lei@redhat.com>
In-Reply-To: <20210928005558.243352-1-ming.lei@redhat.com>
References: <20210928005558.243352-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows group_cpus_evenly() to be called in case of !CONFIG_SMP by simply
assigning all CPUs into the 1st group.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/Makefile     |  2 +-
 lib/group_cpus.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index ff1cbe4958a1..3dbdc7f01215 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -338,7 +338,7 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
 
 obj-$(CONFIG_PARMAN) += parman.o
 
-obj-$(CONFIG_SMP) += group_cpus.o
+obj-y += group_cpus.o
 
 # GCC library routines
 obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index f7165b38c9d0..b34f7d309f9c 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -327,6 +327,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 	return done;
 }
 
+#ifdef CONFIG_SMP
 /**
  * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
  * @numgrps: number of groups
@@ -411,4 +412,17 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	}
 	return masks;
 }
+#else
+struct cpumask *group_cpus_evenly(unsigned int numgrps)
+{
+	struct cpumask *masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+
+	if (!masks)
+		return NULL;
+
+	/* assign all CPUs(cpu 0) to the 1st group only */
+	cpumask_copy(&masks[0], cpu_possible_mask);
+	return masks;
+}
+#endif
 EXPORT_SYMBOL_GPL(group_cpus_evenly);
-- 
2.31.1

