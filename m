Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7103F0076
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhHRJbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232579AbhHRJ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629278923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yx3CKjzfifLZuvsmKfKPxJm45kH1LWGVrXCZ9eoFqpc=;
        b=UEmAWHA6az87olDU5M++4+RE3yxTR1wcy4oHt8TKp8BV8LUIIaAxjbt91z0P8s1YqAvv7T
        pfEmledvldpqAZmIO/SSAphLB2a/NVhsaOfIAn7AYsvIhjU8vKkqJB8PvF7SpHC1WCDXN1
        Xb5hKTwqU+/tubKm3L+DIhwjMjd+rkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-ZAlCm_EuOyya3pk6DNcwKA-1; Wed, 18 Aug 2021 05:28:42 -0400
X-MC-Unique: ZAlCm_EuOyya3pk6DNcwKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 246C71082924;
        Wed, 18 Aug 2021 09:28:41 +0000 (UTC)
Received: from localhost (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD5825D9CA;
        Wed, 18 Aug 2021 09:28:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/7] genirq/affinity: don't pass irq_affinity_desc array to irq_build_affinity_masks
Date:   Wed, 18 Aug 2021 17:28:08 +0800
Message-Id: <20210818092812.787558-4-ming.lei@redhat.com>
In-Reply-To: <20210818092812.787558-1-ming.lei@redhat.com>
References: <20210818092812.787558-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for abstracting irq_build_affinity_masks() into one public helper
for assigning all CPUs evenly into several groups. Don't pass
irq_affinity_desc array to irq_build_affinity_masks, instead return
a cpumask array by storing each assigned group into one element of
the array.

This way helps us to provide generic interface for grouping all CPUs
evenly from NUMA and CPU locality viewpoint, and the cost is one extra
allocation in irq_build_affinity_masks(), which should be fine since
it is done via GFP_KERNEL and irq_build_affinity_masks() is called very
less.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 0bc83d57cb34..aef12ec05dcf 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -249,7 +249,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 				      cpumask_var_t *node_to_cpumask,
 				      const struct cpumask *cpu_mask,
 				      struct cpumask *nmsk,
-				      struct irq_affinity_desc *masks)
+				      struct cpumask *masks)
 {
 	unsigned int i, n, nodes, cpus_per_vec, extra_vecs, done = 0;
 	unsigned int last_affv = numvecs;
@@ -268,7 +268,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	 */
 	if (numvecs <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
+			cpumask_or(&masks[curvec], &masks[curvec],
 				   node_to_cpumask[n]);
 			if (++curvec == last_affv)
 				curvec = 0;
@@ -320,7 +320,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 			 */
 			if (curvec >= last_affv)
 				curvec = 0;
-			irq_spread_init_one(&masks[curvec].mask, nmsk,
+			irq_spread_init_one(&masks[curvec], nmsk,
 						cpus_per_vec);
 		}
 		done += nv->nvectors;
@@ -334,16 +334,16 @@ static int __irq_build_affinity_masks(unsigned int startvec,
  *	1) spread present CPU on these vectors
  *	2) spread other possible CPUs on these vectors
  */
-static int irq_build_affinity_masks(unsigned int numvecs,
-				    struct irq_affinity_desc *masks)
+static struct cpumask *irq_build_affinity_masks(unsigned int numvecs)
 {
 	unsigned int curvec = 0, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
+	struct cpumask *masks = NULL;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-		return ret;
+		return NULL;
 
 	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
 		goto fail_nmsk;
@@ -352,6 +352,10 @@ static int irq_build_affinity_masks(unsigned int numvecs,
 	if (!node_to_cpumask)
 		goto fail_npresmsk;
 
+	masks = kcalloc(numvecs, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		goto fail_node_to_cpumask;
+
 	/* Stabilize the cpumasks */
 	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
@@ -385,6 +389,7 @@ static int irq_build_affinity_masks(unsigned int numvecs,
 	if (ret >= 0)
 		WARN_ON(nr_present + nr_others < numvecs);
 
+ fail_node_to_cpumask:
 	free_node_to_cpumask(node_to_cpumask);
 
  fail_npresmsk:
@@ -392,7 +397,11 @@ static int irq_build_affinity_masks(unsigned int numvecs,
 
  fail_nmsk:
 	free_cpumask_var(nmsk);
-	return ret < 0 ? ret : 0;
+	if (ret < 0) {
+		kfree(masks);
+		return NULL;
+	}
+	return masks;
 }
 
 static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
@@ -456,13 +465,18 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	 */
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int this_vecs = affd->set_size[i];
-		int ret;
+		int j;
+		struct cpumask *result = irq_build_affinity_masks(this_vecs);
 
-		ret = irq_build_affinity_masks(this_vecs, &masks[curvec]);
-		if (ret) {
+		if (!result) {
 			kfree(masks);
 			return NULL;
 		}
+
+		for (j = 0; j < this_vecs; j++)
+			cpumask_copy(&masks[curvec + j].mask, &result[j]);
+		kfree(result);
+
 		curvec += this_vecs;
 		usedvecs += this_vecs;
 	}
-- 
2.31.1

