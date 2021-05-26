Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CD9392086
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 21:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhEZTHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 15:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234245AbhEZTHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 15:07:18 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 807CB613CC;
        Wed, 26 May 2021 19:05:46 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1llyqe-003o26-RV; Wed, 26 May 2021 20:05:44 +0100
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
        Moritz Fischer <mdf@kernel.org>, kernel-team@android.com
Subject: [PATCH 3/4] kernel/resource: Add walk_excluding_child_res() helper
Date:   Wed, 26 May 2021 20:05:30 +0100
Message-Id: <20210526190531.62751-4-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526190531.62751-1-maz@kernel.org>
References: <20210526190531.62751-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org, mark.rutland@arm.com, james.morse@arm.com, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, ebiederm@xmission.com, bhupesh.sharma@linaro.org, takahiro.akashi@linaro.org, dyoung@redhat.com, mdf@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we have obtained a resource of a certain type from
find_next_iomem_res(), it doesn't necessarily mean that the whole
resource is usable, and we have cases where a child resource
denotes an exclusion in the initial resource.

Provide a new walker that deals with this exact case, and calls
a callback on each resource fragment that doesn't have a child.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/ioport.h |  4 +++
 kernel/resource.c      | 80 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 8359c50f9988..526314a42ad2 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -323,6 +323,10 @@ extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
+extern int
+walk_excluding_child_res(struct resource *res, void *arg,
+			 int (*func)(struct resource *, void *));
+
 struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size);
 struct resource *request_free_mem_region(struct resource *base,
diff --git a/kernel/resource.c b/kernel/resource.c
index 311b8d2c9957..1d9b5f653938 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -318,6 +318,86 @@ int release_resource(struct resource *old)
 
 EXPORT_SYMBOL(release_resource);
 
+/**
+ * walk_excluding_child_res - call a callback function on each fragment of
+ *			      a resource that do not have a child resource
+ *
+ * @res: the root resource containing the initial range
+ * @arg: function argument for the callback @func
+ * @func: callback function that is called for each qualifying resource area
+ *
+ * For a given resource, remove all the child resources and feed the
+ * resulting fragments to kexec_locate_mem_hole_callback().
+ */
+int walk_excluding_child_res(struct resource *res, void *arg,
+			     int (*func)(struct resource *, void *))
+{
+	struct resource *tmp, cursor;
+	int ret = 0;
+
+	cursor = *res;
+
+	/* Use .child for the head of the list, .sibling for the tail */
+	cursor.child = cursor.sibling = NULL;
+
+	read_lock(&resource_lock);
+
+	for (tmp = res->child; tmp; tmp = tmp->sibling) {
+		struct resource *new;
+
+		if (cursor.start < tmp->start) {
+			new = kmalloc(sizeof(*new), GFP_KERNEL);
+			if (!new)
+				goto cleanup;
+
+			*new = (struct resource) {
+				.start	= cursor.start,
+				.end	= tmp->start - 1,
+				.flags	= res->flags,
+				.desc	= res->desc,
+				.parent	= res->parent,
+			};
+
+			if (!cursor.child)
+				cursor.child = new;
+			if (cursor.sibling)
+				cursor.sibling->sibling = new;
+			cursor.sibling = new;
+		}
+
+		/*
+		 * This may result in a resource with a negative size
+		 * at the very end of the loop.
+		 */
+		cursor.start = tmp->end + 1;
+	}
+
+	read_unlock(&resource_lock);
+
+	/*
+	 * At this stage, the list pointed to by cursor.child contains
+	 * every non-reserved blocks, completed by 'cursor' which
+	 * contains the potential last block (may be empty).
+	 */
+	for (tmp = cursor.child; tmp; tmp = tmp->sibling) {
+		ret = func(tmp, arg);
+		if (ret)
+			break;
+	}
+
+	if (!ret && cursor.start <= cursor.end)
+		ret = func(&cursor, tmp);
+
+cleanup:
+	while (cursor.child) {
+		tmp = cursor.child;
+		cursor.child = cursor.child->sibling;
+		kfree(tmp);
+	}
+
+	return ret;
+}
+
 /**
  * find_next_iomem_res - Finds the lowest iomem resource that covers part of
  *			 [@start..@end].
-- 
2.30.2

