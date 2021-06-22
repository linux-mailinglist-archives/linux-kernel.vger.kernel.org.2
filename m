Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CDC3B0999
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhFVP4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhFVP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:56:16 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E07BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:53:59 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id q18so18845861ile.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ger/3QB12m3dcmpaPwCpPK3bMdb0m3KEwY9XdC5X/DI=;
        b=QHL2lUfoVvQ/iYj06RKThe9xkW32X15220AJ/5hgyYyFQ6fE5M33R64sjVUDHIN5vn
         IfP2oNUiZ7OxvWGoUEyifXQEj9zEsGf/hUZWVtXAwjOCzMFPGUU+3vNnymDsvEubdBoC
         8NUffjlufOfBpcZJa/KgBvt9MyehkOMaGqdGAJRjtJ/iwXbFHY3Ihm0Hv6k6L4wBaLhZ
         Miuj26cgaQD6UjEltrVC9+uL4vfPfF956CUadincqUt6mrbqmVLw+hMCh9B4LhQNK8Tf
         3eID5uPowHBG/8YY9+7hUoiiiSxtouJ6bjx2ymZDTLDgQCKqP/dF6K7HaaP4I6b7DCn3
         yXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ger/3QB12m3dcmpaPwCpPK3bMdb0m3KEwY9XdC5X/DI=;
        b=EQNi63SfvkAPJR3qteCCIUodKLo1WHJ46/TSbLgEHxSKxuaMWmTjZv71R6T7wE2mA2
         HfdqfX/UjuR0ZNDUmjOsRnQHEbxpVmLQ0Xs/znXd4WOhEFrLiQRirGUSq6N/8dHKabKy
         jL1kY/NBa88ZfWDScW3+hDfqHPMTT5t6tpk66L/Z+/0Hmu0urt2w7ykruafXWp2+vC8y
         po7polO2LKcLAZ0XEVf7Llrql1egAhLXfd43QVKqie9zLJ1sfXLI5S6zXhSyOo5NPB9o
         eaRp/ydcTQ0KuzCnK+dj0nnYA4cFsybNlz9UYbyavNGK5Pvv1Bpy682RmL+83pFpsuHs
         q7GQ==
X-Gm-Message-State: AOAM532hNVZqgKm3P84aG+vtWgMgdIJLe6vTMeAmfDrRinU4Tdme6cpm
        FFdWAO7MjepW+yoa5EGPQcI=
X-Google-Smtp-Source: ABdhPJy/335bkWQKPyFj3R+acDGbK5s43Wp20Vce/klrnGyeZl1VfN68Aed769BmueX46TZhME7vGg==
X-Received: by 2002:a05:6e02:109:: with SMTP id t9mr3057417ilm.235.1624377239080;
        Tue, 22 Jun 2021 08:53:59 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id b6sm3245221ils.68.2021.06.22.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:53:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0267F27C0054;
        Tue, 22 Jun 2021 11:53:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 22 Jun 2021 11:53:58 -0400
X-ME-Sender: <xms:lQfSYE2GJvXUsULbQM8ckgz0ZuQf2Gh6SeLmIgqKX4oTvcaMXJBkRQ>
    <xme:lQfSYPF4AtueniIf33ja6-uq9wIfqdlmc75FL1EIF57TZSidChpMsIxG6fymBlWRL
    XYEiIXi9KUKwsEVQQ>
X-ME-Received: <xmr:lQfSYM5cQuwl8MYBB9sr1cFF3GdMafZJIxg2XFyBiGHvQ_jLPw7at4G3AW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeguddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:lQfSYN0Dbq7NBEmCtGZ4TqdLd1t95idfkBh4g_20b1IrvXgXwGRBlQ>
    <xmx:lQfSYHH3T46A1ImUIL_nLFV6rzRXBzjIcueVRaVsHJgStzmOAviLoQ>
    <xmx:lQfSYG99bgsFWbCyz2bNHGTeMmzEQewmQDHGX9oos5v-SF9D_mr7lw>
    <xmx:lgfSYNYUmgYpL2UzhWA_vNqE1t03ErxlTD6cRtBns5IUC-z5xREKeA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jun 2021 11:53:57 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [RFC 2/2] irqchip/gic-v3-its: Introduce virtual ITS
Date:   Tue, 22 Jun 2021 23:53:13 +0800
Message-Id: <20210622155313.3819952-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210622155313.3819952-1-boqun.feng@gmail.com>
References: <20210622155313.3819952-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GICv3 allows supporting LPI without an ITS, and in order to support
such a platform, a virtual ITS is introduced. The virtual ITS has the
same software part as a real ITS: having an irq domain, maintaining
->collections and maintaining the list of devices. The only difference
is the virtual ITS doesn't have a backed ITS therefore it cannot issue
ITS commands nor set up device tables. The virtual ITS only manages LPIs
and the LPIs are configured via DirectLPI interfaces.

And currently the virtual ITS is initialized only if there is no ITS in
the system and yet DirectLPI is support.

The virtual ITS approach provides the support for LPI without an ITS and
reuses as much exisiting code as possible, and is the preparation for
virtual PCI support on ARM64 Hyper-V guests.

Co-developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 114 ++++++++++++++++++++++++++++---
 1 file changed, 106 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1916ac5d6371..4f2600377039 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -117,9 +117,16 @@ struct its_node {
 	int			vlpi_redist_offset;
 };
 
+/*
+ * LPI can be supported without ITS, in which case, a virtual its_node is
+ * initialized to allow configuring LPI with the DirectLPI approach.
+ */
+static struct its_node *virtual_its_node;
+
 #define is_v4(its)		(!!((its)->typer & GITS_TYPER_VLPIS))
 #define is_v4_1(its)		(!!((its)->typer & GITS_TYPER_VMAPP))
 #define device_ids(its)		(FIELD_GET(GITS_TYPER_DEVBITS, (its)->typer) + 1)
+#define is_virtual(its)		((its) == virtual_its_node)
 
 #define ITS_ITT_ALIGN		SZ_256
 
@@ -1096,6 +1103,10 @@ void name(struct its_node *its,						\
 	unsigned long flags;						\
 	u64 rd_idx;							\
 									\
+	/* Virtual ITS doesn't support ITS commands */			\
+	if (is_virtual(its))						\
+		return;							\
+									\
 	raw_spin_lock_irqsave(&its->lock, flags);			\
 									\
 	cmd = its_allocate_entry(its);					\
@@ -1464,7 +1475,8 @@ static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
 
 	lpi_write_config(d, clr, set);
 	if (gic_rdists->has_direct_lpi &&
-	    (is_v4_1(its_dev->its) || !irqd_is_forwarded_to_vcpu(d)))
+	    (is_v4_1(its_dev->its) || !irqd_is_forwarded_to_vcpu(d) ||
+	     is_virtual(its_dev->its)))
 		direct_lpi_inv(d);
 	else if (!irqd_is_forwarded_to_vcpu(d))
 		its_send_inv(its_dev, its_get_event_id(d));
@@ -1690,6 +1702,10 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 	u64 addr;
 
 	its = its_dev->its;
+
+	/* Virtual ITS doesn't have ->get_msi_base function, skip */
+	if (!its->get_msi_base)
+		return;
 	addr = its->get_msi_base(its_dev);
 
 	msg->address_lo		= lower_32_bits(addr);
@@ -3217,7 +3233,17 @@ static void its_cpu_init_collections(void)
 	raw_spin_lock(&its_lock);
 
 	list_for_each_entry(its, &its_nodes, entry)
-		its_cpu_init_collection(its);
+		/*
+		 * Only initializes the software part of collections for virtual
+		 * ITS.
+		 */
+		if (is_virtual(its)) {
+			int cpu = smp_processor_id();
+
+			its->collections[cpu].col_id = cpu;
+		} else {
+			its_cpu_init_collection(its);
+		}
 
 	raw_spin_unlock(&its_lock);
 }
@@ -3364,7 +3390,8 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	int nr_ites;
 	int sz;
 
-	if (!its_alloc_device_table(its, dev_id))
+	/* No need to allocate device table for virtual ITS */
+	if (!is_virtual(its) && !its_alloc_device_table(its, dev_id))
 		return NULL;
 
 	if (WARN_ON(!is_power_of_2(nvecs)))
@@ -3551,9 +3578,12 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (err)
 		return err;
 
-	err = iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev));
-	if (err)
-		return err;
+	/* Virtual ITS doesn't have ->get_msi_base function, skip */
+	if (its->get_msi_base) {
+		err = iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev));
+		if (err)
+			return err;
+	}
 
 	for (i = 0; i < nr_irqs; i++) {
 		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
@@ -5121,6 +5151,63 @@ static int __init its_probe_one(struct resource *res,
 	return err;
 }
 
+static int __init virtual_its_init(void)
+{
+	struct its_node *its;
+	struct fwnode_handle *fwnode;
+	int err;
+
+	fwnode = irq_domain_alloc_named_fwnode("Virtual ITS");
+	if (!fwnode)
+		return -ENOMEM;
+
+	/*
+	 * Use 0 as the ID for virtual ITS, since we only init virtual ITS if
+	 * there is no real ITS in the system, so it's fine.
+	 */
+	err = iort_register_domain_token(0, 0, fwnode);
+	if (err)
+		goto out_free_fwnode;
+
+	its = kzalloc(sizeof(*its), GFP_KERNEL);
+	if (!its) {
+		err = -ENOMEM;
+		goto out_unregister_fwnode;
+	}
+
+	raw_spin_lock_init(&its->lock);
+	mutex_init(&its->dev_alloc_lock);
+	INIT_LIST_HEAD(&its->entry);
+	INIT_LIST_HEAD(&its->its_device_list);
+	its->numa_node = NUMA_NO_NODE;
+	its->msi_domain_flags = IRQ_DOMAIN_FLAG_MSI_REMAP;
+	err = its_alloc_collections(its);
+	if (err)
+		goto out_free_its;
+
+	err = its_init_domain(fwnode, its);
+	if (err)
+		goto out_free_collections;
+
+	raw_spin_lock(&its_lock);
+	virtual_its_node = its;
+	list_add(&its->entry, &its_nodes);
+	raw_spin_unlock(&its_lock);
+
+	return 0;
+
+out_free_collections:
+	its_free_collections(its);
+out_free_its:
+	kvfree(its);
+out_unregister_fwnode:
+	iort_deregister_domain_token(0);
+out_free_fwnode:
+	irq_domain_free_fwnode(fwnode);
+	return err;
+
+}
+
 static bool gic_rdists_supports_plpis(void)
 {
 	return !!(gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER) & GICR_TYPER_PLPIS);
@@ -5414,8 +5501,19 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		its_acpi_probe();
 
 	if (list_empty(&its_nodes)) {
-		pr_warn("ITS: No ITS available, not enabling LPIs\n");
-		return -ENXIO;
+		/* Initialize virtual ITS only if DirectLPI is set. */
+		if (gic_rdists->has_direct_lpi) {
+			pr_info("ITS: No ITS available, using virtual ITS\n");
+			err = virtual_its_init();
+			if (err) {
+				pr_info("ITS: Virtual ITS creation fails\n");
+				return err;
+			}
+			pr_info("ITS: Virtual ITS created\n");
+		} else {
+			pr_warn("ITS: No ITS available, not enabling LPIs\n");
+			return -ENXIO;
+		}
 	}
 
 	err = allocate_lpi_tables();
-- 
2.30.2

