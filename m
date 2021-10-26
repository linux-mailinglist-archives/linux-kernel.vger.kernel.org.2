Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2828043B67A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhJZQKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhJZQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:10:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA86C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:07:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h7so4688614ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LFIfrPhDzMtnbpEZVPATV5Kch9wCoKpxpC7Ie87gFbI=;
        b=bs16QmQOkeJH5M96StGB5D0kKi6yFSOn6Bb9Z1JxuWPs8n7m9DKoVvOrnj02v/zFzP
         xDOoHIzz+zeajJzCemByRC4cUhlUVLJVjRbHpcKMUnYABP7tE+tsTgFM1I0SHu8abRc8
         ODiLRcwwLBdfek+yo1znmX1Q9TEwfSC5fNtbn5wv1OaBbxTqRsgloUZ+TK0SbXmiGJc6
         G1GHBYDlnnzrXk8efngJ4GTPAToixurpJzxE7zWSYia37K7y1+/QPLPRYdE4AahOmGMH
         lbGNyaSdDwcEo4G2rc2sREnoAaA4RLoLBKyH/sIz8xNUN6PVFS8Z3UgSMF4X9vhzAjci
         1gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LFIfrPhDzMtnbpEZVPATV5Kch9wCoKpxpC7Ie87gFbI=;
        b=tDyCKdcYGhetrJB5H3DP065LmNI12gsAk2SIvc5ov6i7iNhT0zTQDy2/qW85WZW4zc
         2keNdasPE1i2lFnsenYEAJ60pmm0n/n/3azm6rkU5G2vISueNxiOz+2IbUh1BToTlUqg
         J0vJe493nIHMbHX127gHWO0slKf3haaZd8NYAWrcsyB5BSLQjFz966Wv9pk5qaVMAx3V
         KjnJOB3JoN1HKBEfxmP8ZtaSIwqveoNOBRVzJraPcefZNhtMuShGvpWY95tWN1XKRtAu
         qML/xseDRN0vMcHsOLSp5wBSQz+yROmJ8P4JX9bVDKinoCrj8qqieQqzNWBqf/l/awAD
         a3nA==
X-Gm-Message-State: AOAM531iW3lWMbNbxNizNilfu5AcfU1zygyIy+pruhoz10JoNIhahCYl
        wzLQZiLSsphbvjFlqOU2Wm0=
X-Google-Smtp-Source: ABdhPJyDWvPDbHKN80B2wI0HUdKZkTQtxYSe3AhrmMT52rr89emWm0qnYTKAFM1mwoDlbefou8hA/Q==
X-Received: by 2002:a05:6402:486:: with SMTP id k6mr11970130edv.315.1635264321080;
        Tue, 26 Oct 2021 09:05:21 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id eu9sm4025195ejc.14.2021.10.26.09.05.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:05:20 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V2 2/4] arm/xen: Switch to use gnttab_setup_auto_xlat_frames() for DT
Date:   Tue, 26 Oct 2021 19:05:10 +0300
Message-Id: <1635264312-3796-3-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
References: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
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
xen_xlate_map_ballooned_pages().

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
---
 arch/arm/xen/enlighten.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 7f1c106b..dea46ec 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -59,6 +59,9 @@ unsigned long xen_released_pages;
 struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
 
 static __read_mostly unsigned int xen_events_irq;
+static phys_addr_t xen_grant_frames;
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
@@ -310,6 +314,12 @@ static void __init xen_dt_guest_init(void)
 		return;
 	}
 
+	if (of_address_to_resource(xen_node, GRANT_TABLE_INDEX, &res)) {
+		pr_err("Xen grant table region is not found\n");
+		return;
+	}
+	xen_grant_frames = res.start;
+
 	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
 }
 
@@ -317,16 +327,20 @@ static int __init xen_guest_init(void)
 {
 	struct xen_add_to_physmap xatp;
 	struct shared_info *shared_info_page = NULL;
-	int cpu;
+	int rc, cpu;
 
 	if (!xen_domain())
 		return 0;
 
 	if (!acpi_disabled)
 		xen_acpi_guest_init();
-	else
+	else {
 		xen_dt_guest_init();
 
+		if (!xen_grant_frames)
+			return -ENODEV;
+	}
+
 	if (!xen_events_irq) {
 		pr_err("Xen event channel interrupt not found\n");
 		return -ENODEV;
@@ -370,12 +384,16 @@ static int __init xen_guest_init(void)
 	for_each_possible_cpu(cpu)
 		per_cpu(xen_vcpu_id, cpu) = cpu;
 
-	xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
-	if (xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
-					  &xen_auto_xlat_grant_frames.vaddr,
-					  xen_auto_xlat_grant_frames.count)) {
+	if (!acpi_disabled) {
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

