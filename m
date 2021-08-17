Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55803EE6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbhHQGlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhHQGkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:40:55 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9663AC061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:22 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id y144so8909691qkb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HyJt6PU8F2AZ27Os2Gh9HToURd99LY2BIrsmeAWc9n0=;
        b=TgSGn5ikHZPvrwUAhmwCeQuflxe6hE3G+KqV+lxzLwtbvh4HUm+5puCcWGjI6Ubwik
         WCRK6pHIgiVdMMbNywWhgoOYdMzV1pyLmACPOBcaV5F8WND/tUItXQRjgLbD8/KD68HQ
         yqEzDaYqg/mw9VjTM8uPUJvSnk0GsVsv/B5SeL9q5ybKPtGvD4fElUoBXvAglx+eV9Wg
         rp6kT9VfZKDul6B6Ju/le7xkoPqVRYqEErjpt2iUZFjyBBEzdTHH6Sc4Vv4uKAjUN2gh
         56r0rRFeSl0ZOsacn+/zTs9GyyfMc4Yy4tfNzm9znGBaB4PMaIx/vWOkhtQbYnkmuuvG
         gMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HyJt6PU8F2AZ27Os2Gh9HToURd99LY2BIrsmeAWc9n0=;
        b=o4dMc6I+trN+BC7wb778RvHN7BIR6rkvhMCspPso9K7OLLZgNEnKXUhqhfFyd3lDbm
         uCJcmK3OOqmrVzTw9IX9YgmkJaKsGtjrvQ7wjresJhcqddnDlHstfDMcjl3VH1qM1/jJ
         UBi47ASaqzd8lrWUDFDo4/B1Mo6EBDpEkjbzDyc/0M38nPb2CjtxRoBRh0KaEb4b8DN4
         1FHNetbuIF94CcIZ1CwlerbgzcQ3TZEmG5LX3PC8R4rYbXai8vFtRaGtX1tjaKncmt4a
         sSlOjkywFEGOTlfg4KeL7MLfb7e04VBz8UOs/awuPYQdVPjk0Fim01Yz8yYV+9p+RRC8
         TH/A==
X-Gm-Message-State: AOAM530krxCt5t0Dl8H4yCnWYXz55WoQnJPr0TRRAd8FfkCKomBmYIji
        ndKrLqdMrTlTHrHbg/+PzSs=
X-Google-Smtp-Source: ABdhPJza9EQHzkCG6O0aPqADck/TyFB2k9uIKI0sPsY2xebEkNIodhaDjf6s+I0OqV+cwhaNBoAfEw==
X-Received: by 2002:ae9:dc82:: with SMTP id q124mr2230762qkf.288.1629182421814;
        Mon, 16 Aug 2021 23:40:21 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
        by smtp.gmail.com with ESMTPSA id c11sm526938qth.29.2021.08.16.23.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 23:40:21 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/11] powerpc/pseries/iommu: Add iommu_pseries_alloc_table() helper
Date:   Tue, 17 Aug 2021 03:39:21 -0300
Message-Id: <20210817063929.38701-4-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817063929.38701-1-leobras.c@gmail.com>
References: <20210817063929.38701-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates a helper to allow allocating a new iommu_table without the need
to reallocate the iommu_group.

This will be helpful for replacing the iommu_table for the new DMA window,
after we remove the old one with iommu_tce_table_put().

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index b1b8d12bab39..33d82865d6e6 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -53,28 +53,31 @@ enum {
 	DDW_EXT_QUERY_OUT_SIZE = 2
 };
 
-static struct iommu_table_group *iommu_pseries_alloc_group(int node)
+static struct iommu_table *iommu_pseries_alloc_table(int node)
 {
-	struct iommu_table_group *table_group;
 	struct iommu_table *tbl;
 
-	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
-			   node);
-	if (!table_group)
-		return NULL;
-
 	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
 	if (!tbl)
-		goto free_group;
+		return NULL;
 
 	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
 	kref_init(&tbl->it_kref);
+	return tbl;
+}
 
-	table_group->tables[0] = tbl;
+static struct iommu_table_group *iommu_pseries_alloc_group(int node)
+{
+	struct iommu_table_group *table_group;
+
+	table_group = kzalloc_node(sizeof(*table_group), GFP_KERNEL, node);
+	if (!table_group)
+		return NULL;
 
-	return table_group;
+	table_group->tables[0] = iommu_pseries_alloc_table(node);
+	if (table_group->tables[0])
+		return table_group;
 
-free_group:
 	kfree(table_group);
 	return NULL;
 }
-- 
2.32.0

