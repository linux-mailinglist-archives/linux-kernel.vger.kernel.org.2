Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007FF45CE74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244580AbhKXU5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244099AbhKXU5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:57:07 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C694C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:53:57 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m27so10495073lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I5Ua+XOo9ED8QtDOWHq4o6dMZ+6zt8B38QrRs94d3jQ=;
        b=N719U68AvD57cSsDPqL5VUMkg/l6W7dFaBn0ds0pOblImoqD4O8SZtTVbiKUWXvfVM
         QwgG8Z6Ro3SdIlXgsHzI0FIZjBoGs6sAhbvkMgKp55HqgPCIvBZ/bDrqp+nLkExXIDXk
         85VfW8+LD7yFAUgUpvJ/2m018THtiaHbBxWJqD8iahLuB6p5h86QVJOti4p/Vko/73Z+
         qaK9Vh/scmIZQ9BMI7l50DJ1kbaNGmaBXek6irskc4a0CJq/yZOsKvS2cCwp3ouJixdO
         l2ac3Q50aoO+804982jn926QvZK1sKU0l7f4bskWWYtjonKnDPp3c5jE7tbHdbSGR8QN
         +RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I5Ua+XOo9ED8QtDOWHq4o6dMZ+6zt8B38QrRs94d3jQ=;
        b=haj7YdjxoPdYP4A2e/7dDZgl1eq8cfWjH1siqBDcN2ns3QA4aERLXyDedY6IjAZGwR
         f2B+M4vy74N9H8UzL0sTuvWmd72hqDMf8oWlRpDEpDU+ThxRaTwfTyG+lj3cBb9vFYpJ
         BQyb/+54A/Qdkp0YTfogmtvc36ncHlwVtlxA4gzolEMq5QcQBeMUXlFf3VnaQY6SWZOY
         /g0I/C2eozcLDvUid1SUbwRFYuHWQl+n0J64XLdNtxtl4Stlj2C5gj7v7audS6erlfXG
         HfF91kre3FbT2YLgtLx1L/qYsWly9KgwaW6k7Klp92ddh2AbSdLDDaNBIBJi/fivv3Fe
         JyRA==
X-Gm-Message-State: AOAM531O1oV9Xq9I0iFJ36V+dG4OE+Da1WsJ1MEscYX+IAUsungRUuuE
        i8LXS9/6dXr47DUuwId2tCc=
X-Google-Smtp-Source: ABdhPJwpqCkahz5EbzD+MVB6XyFKIyWyAaQlqRXN5qpJziSHo0yhzGV2dme1YXtZkarUALEtZaAUbg==
X-Received: by 2002:a05:6512:20d4:: with SMTP id u20mr18715939lfr.339.1637787235341;
        Wed, 24 Nov 2021 12:53:55 -0800 (PST)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id j11sm97608ljc.9.2021.11.24.12.53.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 12:53:55 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V3 2/6] arm/xen: Switch to use gnttab_setup_auto_xlat_frames() for DT
Date:   Wed, 24 Nov 2021 22:53:39 +0200
Message-Id: <1637787223-21129-3-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
References: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Read the start address of the grant table space from DT
(region 0).

This patch mostly restores behaviour before commit 3cf4095d7446
("arm/xen: Use xen_xlate_map_ballooned_pages to setup grant table")
but trying not to break the ACPI support added after that commit.
So the patch touches DT part only and leaves the ACPI part with
xen_xlate_map_ballooned_pages(). Also in order to make a code more
resilient use a fallback to xen_xlate_map_ballooned_pages() if grant
table region wasn't found.

This is a preparation for using Xen extended region feature
where unused regions of guest physical address space (provided
by the hypervisor) will be used to create grant/foreign/whatever
mappings instead of wasting real RAM pages from the domain memory
for establishing these mappings.

The immediate benefit of this change:
- Avoid superpage shattering in Xen P2M when establishing
  stage-2 mapping (GFN <-> MFN) for the grant table space
- Avoid wasting real RAM pages (reducing the amount of memory
  usuable) for mapping grant table space
- The grant table space is always mapped at the exact
  same place (region 0 is reserved for the grant table)

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Changes RFC -> V2:
   - new patch

Changes V2 -> V3:
   - add __read_mostly specifier to xen_grant_frames
   - retain a fallback to xen_xlate_map_ballooned_pages() if
     xen_grant_frames is invalid
   - process xen_events_irq before xen_grant_frames in
     xen_dt_guest_init()
   - update patch description
---
 arch/arm/xen/enlighten.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 7619fbf..3fb3384 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -59,6 +59,9 @@ unsigned long xen_released_pages;
 struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
 
 static __read_mostly unsigned int xen_events_irq;
+static __read_mostly phys_addr_t xen_grant_frames;
+
+#define GRANT_TABLE_INDEX   0
 
 uint32_t xen_start_flags;
 EXPORT_SYMBOL(xen_start_flags);
@@ -303,6 +306,7 @@ static void __init xen_acpi_guest_init(void)
 static void __init xen_dt_guest_init(void)
 {
 	struct device_node *xen_node;
+	struct resource res;
 
 	xen_node = of_find_compatible_node(NULL, NULL, "xen,xen");
 	if (!xen_node) {
@@ -311,13 +315,19 @@ static void __init xen_dt_guest_init(void)
 	}
 
 	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
+
+	if (of_address_to_resource(xen_node, GRANT_TABLE_INDEX, &res)) {
+		pr_err("Xen grant table region is not found\n");
+		return;
+	}
+	xen_grant_frames = res.start;
 }
 
 static int __init xen_guest_init(void)
 {
 	struct xen_add_to_physmap xatp;
 	struct shared_info *shared_info_page = NULL;
-	int cpu;
+	int rc, cpu;
 
 	if (!xen_domain())
 		return 0;
@@ -370,12 +380,16 @@ static int __init xen_guest_init(void)
 	for_each_possible_cpu(cpu)
 		per_cpu(xen_vcpu_id, cpu) = cpu;
 
-	xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
-	if (xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
-					  &xen_auto_xlat_grant_frames.vaddr,
-					  xen_auto_xlat_grant_frames.count)) {
+	if (!acpi_disabled || !xen_grant_frames) {
+		xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
+		rc = xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
+										   &xen_auto_xlat_grant_frames.vaddr,
+										   xen_auto_xlat_grant_frames.count);
+	} else
+		rc = gnttab_setup_auto_xlat_frames(xen_grant_frames);
+	if (rc) {
 		free_percpu(xen_vcpu_info);
-		return -ENOMEM;
+		return rc;
 	}
 	gnttab_init();
 
-- 
2.7.4

