Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA08E43B681
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhJZQKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbhJZQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:10:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2455C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:08:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w12so9829858edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ajewXwLh6uwl+3oBu0hbZUbC19wx0AYb/I/F6COPjeM=;
        b=U3N/q9FFvFCmmrpMt2cjbyrZGTWLI8aYWMuWlxVKon2BNKrVOdefe0pZcid+IOAgdh
         IHy6lv/3TRCGg/Iqh7kmoF4Fg4rHa+NqfAzaz9wRaL6CVBUvECbpOFAZU6RJESEkB98/
         Y5I9Oq4rdHccg0GEvwvD4whjflY43q2BjErpYMUBRbu2Lwf235S4qZ7o16ywxoHfpuxR
         gx0iLhzdsYDcnbF20A2x+L0EFGx8biMJmfAr6ix03XlJ+JOMk21G6/ZtFcdflkylF4KG
         uXX49KX7gu0kYMlocuPThS66RnoOFnmwRXxDBNs5db/f6mKW8ocFNgIKUqNmy+spVuvX
         O8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ajewXwLh6uwl+3oBu0hbZUbC19wx0AYb/I/F6COPjeM=;
        b=1DQcVXOe/DBi2T27EF+B5AHqkG9J0tuFBKWzAB4nVMO+6COEF0/LRMnGMEpkRHiR2X
         gfnaqF3JssI3/WX9TxEd5r00YyB2qLWgbtmef/9DkkY16OWbTOKdWI/eVbXK+/Eqi3mi
         CFuFvdtj259AUsJ720JwbqLG9hDG30pFXPWrAhsqWaobN0aln6OlWRTEYk/9HL5KHJQt
         NFts4PJmRKTm6gZzhgx4QElV9dW/gy6TrEYDFIauiAV18eQjOg9GOXLpNDQP4mUkDv4c
         SjktCr7z0Pzj8EgVuyngWU4FdgETy0vN0mTXrQt+mHtZJVPucnIGST85KMiRWzVrzw0a
         Tjng==
X-Gm-Message-State: AOAM5307DlGjKpCkggo4ZtTG2yp04jVFYmdJygV56mAfCJQR5XrM4SQJ
        2H0V0RaG0rCLD7V872+6Ra8mXJ9t9ZY=
X-Google-Smtp-Source: ABdhPJyrh0WP1ZENmH/Ydn3rieWDW8GYW8YWGEy1yCC5roMzqs86ACi1TObo2NcZ97xR3N7TTReTvQ==
X-Received: by 2002:a05:6402:2808:: with SMTP id h8mr36760367ede.394.1635264321764;
        Tue, 26 Oct 2021 09:05:21 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id eu9sm4025195ejc.14.2021.10.26.09.05.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:05:21 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V2 3/4] xen/unpopulated-alloc: Add mechanism to use Xen resource
Date:   Tue, 26 Oct 2021 19:05:11 +0300
Message-Id: <1635264312-3796-4-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
References: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

The main reason of this change is that unpopulated-alloc
code cannot be used in its current form on Arm, but there
is a desire to reuse it to avoid wasting real RAM pages
for the grant/foreign mappings.

The problem is that system "iomem_resource" is used for
the address space allocation, but the really unallocated
space can't be figured out precisely by the domain on Arm
without hypervisor involvement. For example, not all device
I/O regions are known by the time domain starts creating
grant/foreign mappings. And following the advise from
"iomem_resource" we might end up reusing these regions by
a mistake. So, the hypervisor which maintains the P2M for
the domain is in the best position to provide unused regions
of guest physical address space which could be safely used
to create grant/foreign mappings.

Introduce new helper arch_xen_unpopulated_init() which purpose
is to create specific Xen resource based on the memory regions
provided by the hypervisor to be used as unused space for Xen
scratch pages.

If arch doesn't implement arch_xen_unpopulated_init() to
initialize Xen resource the default "iomem_resource" will be used.
So the behavior on x86 won't be changed.

Also fall back to allocate xenballooned pages (steal real RAM
pages) if we do not have any suitable resource to work with and
as the result we won't be able to provide unpopulated pages.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Changes RFC -> V2:
   - new patch, instead of
    "[RFC PATCH 2/2] xen/unpopulated-alloc: Query hypervisor to provide unallocated space"
---
 drivers/xen/unpopulated-alloc.c | 89 +++++++++++++++++++++++++++++++++++++++--
 include/xen/xen.h               |  2 +
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/unpopulated-alloc.c b/drivers/xen/unpopulated-alloc.c
index a03dc5b..1f1d8d8 100644
--- a/drivers/xen/unpopulated-alloc.c
+++ b/drivers/xen/unpopulated-alloc.c
@@ -8,6 +8,7 @@
 
 #include <asm/page.h>
 
+#include <xen/balloon.h>
 #include <xen/page.h>
 #include <xen/xen.h>
 
@@ -15,13 +16,29 @@ static DEFINE_MUTEX(list_lock);
 static struct page *page_list;
 static unsigned int list_count;
 
+static struct resource *target_resource;
+static struct resource xen_resource = {
+	.name = "Xen unused space",
+};
+
+/*
+ * If arch is not happy with system "iomem_resource" being used for
+ * the region allocation it can provide it's own view by initializing
+ * "xen_resource" with unused regions of guest physical address space
+ * provided by the hypervisor.
+ */
+int __weak arch_xen_unpopulated_init(struct resource *res)
+{
+	return -ENOSYS;
+}
+
 static int fill_list(unsigned int nr_pages)
 {
 	struct dev_pagemap *pgmap;
-	struct resource *res;
+	struct resource *res, *tmp_res = NULL;
 	void *vaddr;
 	unsigned int i, alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
-	int ret = -ENOMEM;
+	int ret;
 
 	res = kzalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
@@ -30,7 +47,7 @@ static int fill_list(unsigned int nr_pages)
 	res->name = "Xen scratch";
 	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 
-	ret = allocate_resource(&iomem_resource, res,
+	ret = allocate_resource(target_resource, res,
 				alloc_pages * PAGE_SIZE, 0, -1,
 				PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
 	if (ret < 0) {
@@ -38,6 +55,31 @@ static int fill_list(unsigned int nr_pages)
 		goto err_resource;
 	}
 
+	/*
+	 * Reserve the region previously allocated from Xen resource to avoid
+	 * re-using it by someone else.
+	 */
+	if (target_resource != &iomem_resource) {
+		tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
+		if (!res) {
+			ret = -ENOMEM;
+			goto err_insert;
+		}
+
+		tmp_res->name = res->name;
+		tmp_res->start = res->start;
+		tmp_res->end = res->end;
+		tmp_res->flags = res->flags;
+
+		ret = insert_resource(&iomem_resource, tmp_res);
+		if (ret < 0) {
+			pr_err("Cannot insert IOMEM resource [%llx - %llx]\n",
+			       tmp_res->start, tmp_res->end);
+			kfree(tmp_res);
+			goto err_insert;
+		}
+	}
+
 	pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
 	if (!pgmap) {
 		ret = -ENOMEM;
@@ -95,12 +137,40 @@ static int fill_list(unsigned int nr_pages)
 err_memremap:
 	kfree(pgmap);
 err_pgmap:
+	if (tmp_res) {
+		release_resource(tmp_res);
+		kfree(tmp_res);
+	}
+err_insert:
 	release_resource(res);
 err_resource:
 	kfree(res);
 	return ret;
 }
 
+static void unpopulated_init(void)
+{
+	static bool inited = false;
+	int ret;
+
+	if (inited)
+		return;
+
+	/*
+	 * Try to initialize Xen resource the first and fall back to default
+	 * resource if arch doesn't offer one.
+	 */
+	ret = arch_xen_unpopulated_init(&xen_resource);
+	if (!ret)
+		target_resource = &xen_resource;
+	else if (ret == -ENOSYS)
+		target_resource = &iomem_resource;
+	else
+		pr_err("Cannot initialize Xen resource\n");
+
+	inited = true;
+}
+
 /**
  * xen_alloc_unpopulated_pages - alloc unpopulated pages
  * @nr_pages: Number of pages
@@ -112,6 +182,16 @@ int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
 	unsigned int i;
 	int ret = 0;
 
+	unpopulated_init();
+
+	/*
+	 * Fall back to default behavior if we do not have any suitable resource
+	 * to allocate required region from and as the result we won't be able to
+	 * construct pages.
+	 */
+	if (!target_resource)
+		return alloc_xenballooned_pages(nr_pages, pages);
+
 	mutex_lock(&list_lock);
 	if (list_count < nr_pages) {
 		ret = fill_list(nr_pages - list_count);
@@ -159,6 +239,9 @@ void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
 {
 	unsigned int i;
 
+	if (!target_resource)
+		return free_xenballooned_pages(nr_pages, pages);
+
 	mutex_lock(&list_lock);
 	for (i = 0; i < nr_pages; i++) {
 		pages[i]->zone_device_data = page_list;
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 43efba0..55d2ef8 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -55,6 +55,8 @@ extern u64 xen_saved_max_mem_size;
 #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
 int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
 void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
+struct resource;
+int arch_xen_unpopulated_init(struct resource *res);
 #else
 #define xen_alloc_unpopulated_pages alloc_xenballooned_pages
 #define xen_free_unpopulated_pages free_xenballooned_pages
-- 
2.7.4

