Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5971C43B688
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhJZQLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbhJZQKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:10:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A02C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:08:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 5so15460903edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wgCQ3QpgBU+9Jo1johQyA8YH17F0xtomZ9AsDb/n0+k=;
        b=ErjQU0xF7MucZPckHXbirk+HxNHRkSp0ftkyRu6h2iwOhEb1+8lpFeakKm96+M1vrt
         vbgqEK316lrbPhq56wyunZz1slXFzySXAHjpl7l2X1RylcVS5UjbXcavz+df5VluZeo5
         rhqg08YnA4j2D0jcYNVpA0/aT3jPn+lsaOITDNiwlSeIGHChg+T/kdFrahVXgd0v5QnV
         b/7SP50ygKAhav42t9BKm78sXv9KGYT1kZ6ZI3AN/0kEHd2F7FnWdty0PGISoNyIfYQW
         1GEU778jvDLC9NnLu992kgqal847kKCrc3m3R2RYsoFeXGhbY9qA+qG+EkMzLsJsrCVR
         lVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wgCQ3QpgBU+9Jo1johQyA8YH17F0xtomZ9AsDb/n0+k=;
        b=QO4NNKkSk7WyQtbYKy68h10MRpknSB5sBlVR4gnWk2Hnee8ZO9kVs+d8yJHCHhGsDs
         5zwqIrTet9i5/ItVxlBFQJI1Dvn+XSZCmcxZMWtMGKXo/KVZVUoFVxWG2Hgv5BYPojxX
         PXrgRUAVuIiTh6ZFSEo6U7uXcc3EJcBIdeLYpkGPjMdsvJrcCs2Bqw414p/I2jH6z7Jt
         ntBXEIwm6oMrS9ycWfPP3lNf9c1ts2PxcLKOfdGJLZDfVucQZ/mXLoOr8IU0ukCri0DO
         2xar2QlqAmKG2EmOQpvl4A7Mp6bzVgn+tVmshI/q47zilwnGSr5fSlz58h9+rLKQWGi0
         AYFA==
X-Gm-Message-State: AOAM532I+Y4pUc9ou4ZvvJvZwDYvLp+zNHrW8yLUI3rpbjGDCfK2fDqk
        ahIr1JMRCuzmnh15yMFoHpo=
X-Google-Smtp-Source: ABdhPJxHzSGaUiizFl6ReNX7rAoYCSY51GxR2/K5Ko9EJMbZTxjP/iW8YNrB1UrUQguQ3zP8KNzhvg==
X-Received: by 2002:a05:6402:190e:: with SMTP id e14mr37063692edz.20.1635264322584;
        Tue, 26 Oct 2021 09:05:22 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id eu9sm4025195ejc.14.2021.10.26.09.05.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:05:22 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: [PATCH V2 4/4] arm/xen: Read extended regions from DT and init Xen resource
Date:   Tue, 26 Oct 2021 19:05:12 +0300
Message-Id: <1635264312-3796-5-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
References: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

This patch implements arch_xen_unpopulated_init() on Arm where
the extended regions (if any) are gathered from DT and inserted
into passed Xen resource to be used as unused address space
for Xen scratch pages by unpopulated-alloc code.

The extended region (safe range) is a region of guest physical
address space which is unused and could be safely used to create
grant/foreign mappings instead of wasting real RAM pages from
the domain memory for establishing these mappings.

The extended regions are chosen by the hypervisor at the domain
creation time and advertised to it via "reg" property under
hypervisor node in the guest device-tree. As region 0 is reserved
for grant table space (always present), the indexes for extended
regions are 1...N.

If arch_xen_unpopulated_init() fails for some reason the default
behaviour will be restored (allocate xenballooned pages).

This patch also removes XEN_UNPOPULATED_ALLOC dependency on x86.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Changes RFC -> V2:
   - new patch, instead of
    "[RFC PATCH 2/2] xen/unpopulated-alloc: Query hypervisor to provide unallocated space"
---
 arch/arm/xen/enlighten.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/xen/Kconfig      |   2 +-
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index dea46ec..1a1e0d3 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -62,6 +62,7 @@ static __read_mostly unsigned int xen_events_irq;
 static phys_addr_t xen_grant_frames;
 
 #define GRANT_TABLE_INDEX   0
+#define EXT_REGION_INDEX    1
 
 uint32_t xen_start_flags;
 EXPORT_SYMBOL(xen_start_flags);
@@ -303,6 +304,117 @@ static void __init xen_acpi_guest_init(void)
 #endif
 }
 
+#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
+int arch_xen_unpopulated_init(struct resource *res)
+{
+	struct device_node *np;
+	struct resource *regs, *tmp_res;
+	uint64_t min_gpaddr = -1, max_gpaddr = 0;
+	unsigned int i, nr_reg = 0;
+	struct range mhp_range;
+	int rc;
+
+	if (!xen_domain())
+		return -ENODEV;
+
+	np = of_find_compatible_node(NULL, NULL, "xen,xen");
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	/* Skip region 0 which is reserved for grant table space */
+	while (of_get_address(np, nr_reg + EXT_REGION_INDEX, NULL, NULL))
+		nr_reg++;
+
+	if (!nr_reg) {
+		pr_err("No extended regions are found\n");
+		return -EINVAL;
+	}
+
+	regs = kcalloc(nr_reg, sizeof(*regs), GFP_KERNEL);
+	if (!regs)
+		return -ENOMEM;
+
+	/*
+	 * Create resource from extended regions provided by the hypervisor to be
+	 * used as unused address space for Xen scratch pages.
+	 */
+	for (i = 0; i < nr_reg; i++) {
+		rc = of_address_to_resource(np, i + EXT_REGION_INDEX, &regs[i]);
+		if (rc)
+			goto err;
+
+		if (max_gpaddr < regs[i].end)
+			max_gpaddr = regs[i].end;
+		if (min_gpaddr > regs[i].start)
+			min_gpaddr = regs[i].start;
+	}
+
+	/* Check whether the resource range is within the hotpluggable range */
+	mhp_range = mhp_get_pluggable_range(true);
+	if (min_gpaddr < mhp_range.start)
+		min_gpaddr = mhp_range.start;
+	if (max_gpaddr > mhp_range.end)
+		max_gpaddr = mhp_range.end;
+
+	res->start = min_gpaddr;
+	res->end = max_gpaddr;
+
+	/*
+	 * Mark holes between extended regions as unavailable. The rest of that
+	 * address space will be available for the allocation.
+	 */
+	for (i = 1; i < nr_reg; i++) {
+		resource_size_t start, end;
+
+		start = regs[i - 1].end + 1;
+		end = regs[i].start - 1;
+
+		if (start > (end + 1)) {
+			rc = -EINVAL;
+			goto err;
+		}
+
+		/* There is no hole between regions */
+		if (start == (end + 1))
+			continue;
+
+		/* Check whether the hole range is within the resource range */
+		if (start < res->start || end > res->end) {
+			if (start < res->start)
+				start = res->start;
+			if (end > res->end)
+				end = res->end;
+
+			if (start >= (end + 1))
+				continue;
+		}
+
+		tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
+		if (!tmp_res) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		tmp_res->name = "Unavailable space";
+		tmp_res->start = start;
+		tmp_res->end = end;
+
+		rc = insert_resource(res, tmp_res);
+		if (rc) {
+			pr_err("Cannot insert resource [%llx - %llx] %d\n",
+					tmp_res->start, tmp_res->end, rc);
+			kfree(tmp_res);
+			goto err;
+		}
+	}
+
+err:
+	kfree(regs);
+
+	return rc;
+}
+#endif
+
 static void __init xen_dt_guest_init(void)
 {
 	struct device_node *xen_node;
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 1b2c3ac..e6031fc 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -297,7 +297,7 @@ config XEN_FRONT_PGDIR_SHBUF
 
 config XEN_UNPOPULATED_ALLOC
 	bool "Use unpopulated memory ranges for guest mappings"
-	depends on X86 && ZONE_DEVICE
+	depends on ZONE_DEVICE
 	default XEN_BACKEND || XEN_GNTDEV || XEN_DOM0
 	help
 	  Use unpopulated memory ranges in order to create mappings for guest
-- 
2.7.4

