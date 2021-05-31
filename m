Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D008F395891
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhEaKAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhEaJ7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:59:41 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E24F8611EE;
        Mon, 31 May 2021 09:58:01 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lnegJ-004Z7v-UA; Mon, 31 May 2021 10:58:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Bhupesh SHARMA <bhupesh.sharma@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Moritz Fischer <mdf@kernel.org>, kernel-team@android.com
Subject: [PATCH v2 3/5] kernel/resource: Allow find_next_iomem_res() to exclude overlapping child resources
Date:   Mon, 31 May 2021 10:57:18 +0100
Message-Id: <20210531095720.77469-4-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531095720.77469-1-maz@kernel.org>
References: <20210531095720.77469-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org, mark.rutland@arm.com, james.morse@arm.com, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, ebiederm@xmission.com, bhupesh.sharma@linaro.org, takahiro.akashi@linaro.org, dyoung@redhat.com, akpm@linux-foundation.org, mdf@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_next_iomem_res() returns the first resource that matches the
input parameters (range, flags, desc). It however ignores any
sub-resource that may invalidate the usefulness of such resource.

Allow find_next_iomem_res() to filter out such sub-resources and
wire it into the callers. As nobody is interested in this type
of filtering yet, there shouldn't be any functional change.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/resource.c | 67 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index ca9f5198a01f..0e4d2ca763cd 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -318,6 +318,42 @@ int release_resource(struct resource *old)
 
 EXPORT_SYMBOL(release_resource);
 
+static int exclude_overlapping_child_res(struct resource *res,
+					 struct resource *child)
+{
+	struct resource cursor = *res;
+
+	for (; child; child = child->sibling) {
+		if (!resource_overlaps(&cursor, child))
+			continue;
+
+		if (cursor.start < child->start) {
+			*res = (struct resource) {
+				.start	= cursor.start,
+				.end	= child->start - 1,
+				.flags	= res->flags,
+				.desc	= res->desc,
+				.parent	= res->parent,
+			};
+
+			return 0;
+		}
+
+		/*
+		 * This may result in a resource with a negative size
+		 * at the very end of the loop.
+		 */
+		cursor.start = child->end + 1;
+	}
+
+	if (cursor.start <= cursor.end) {
+		*res = cursor;
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
 /**
  * find_next_iomem_res - Finds the lowest iomem resource that covers part of
  *			 [@start..@end].
@@ -330,6 +366,7 @@ EXPORT_SYMBOL(release_resource);
  * @end:	end address of same resource
  * @flags:	flags which the resource must have
  * @desc:	descriptor the resource must have
+ * @exclude_child_res: exclude parts of resource that have overlapping children
  * @res:	return ptr, if resource found
  *
  * The caller must specify @start, @end, @flags, and @desc
@@ -337,7 +374,7 @@ EXPORT_SYMBOL(release_resource);
  */
 static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			       unsigned long flags, unsigned long desc,
-			       struct resource *res)
+			       bool exclude_child_res, struct resource *res)
 {
 	struct resource *p;
 
@@ -348,7 +385,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 		return -EINVAL;
 
 	read_lock(&resource_lock);
-
+again:
 	for (p = iomem_resource.child; p; p = next_resource(p)) {
 		/* If we passed the resource we are looking for, stop */
 		if (p->start > end) {
@@ -378,6 +415,15 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			.desc = p->desc,
 			.parent = p->parent,
 		};
+
+		if (exclude_child_res &&
+		    exclude_overlapping_child_res(res, p->child)) {
+			start = res->end + 1;
+			if (start >= end)
+				p = NULL;
+			else
+				goto again;
+		}
 	}
 
 	read_unlock(&resource_lock);
@@ -386,6 +432,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 
 static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 				 unsigned long flags, unsigned long desc,
+				 bool exclude_child_res,
 				 void *arg,
 				 int (*func)(struct resource *, void *))
 {
@@ -393,7 +440,8 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 	int ret = -EINVAL;
 
 	while (start < end &&
-	       !find_next_iomem_res(start, end, flags, desc, &res)) {
+	       !find_next_iomem_res(start, end, flags, desc,
+				    exclude_child_res, &res)) {
 		ret = (*func)(&res, arg);
 		if (ret)
 			break;
@@ -424,7 +472,7 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
 		u64 end, void *arg, int (*func)(struct resource *, void *))
 {
-	return __walk_iomem_res_desc(start, end, flags, desc, arg, func);
+	return __walk_iomem_res_desc(start, end, flags, desc, false, arg, func);
 }
 EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
 
@@ -440,8 +488,8 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 {
 	unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 
-	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, arg,
-				     func);
+	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE,
+				     false, arg, func);
 }
 
 /*
@@ -453,8 +501,8 @@ int walk_mem_res(u64 start, u64 end, void *arg,
 {
 	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 
-	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, arg,
-				     func);
+	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE,
+				     false, arg, func);
 }
 
 /*
@@ -475,7 +523,8 @@ int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
 	end = ((u64)(start_pfn + nr_pages) << PAGE_SHIFT) - 1;
 	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 	while (start < end &&
-	       !find_next_iomem_res(start, end, flags, IORES_DESC_NONE, &res)) {
+	       !find_next_iomem_res(start, end, flags, IORES_DESC_NONE,
+				    false, &res)) {
 		pfn = PFN_UP(res.start);
 		end_pfn = PFN_DOWN(res.end + 1);
 		if (end_pfn > pfn)
-- 
2.30.2

