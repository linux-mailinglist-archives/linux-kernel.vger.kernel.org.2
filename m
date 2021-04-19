Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3945E3638EB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 02:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbhDSA4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 20:56:45 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:46689 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbhDSA4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 20:56:31 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 13J0u0FZ011027
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 03:56:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1618793755; x=1621385755;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wxGhN8nAcE8ZMkJvgZHhZ03S5qvYuAPZ5ZFNQvpL6qQ=;
        b=gH0uHd9KL6uuEYeLMB+Ee55llaOyKBRjifdcpilstjoowjvOq/+l9sr1JO1kwt0X
        yC85a0PWn9ElA/xGLy6QZ4KMODUGAW4CPI4IsAgHT78UZhdoqCgdXx1XqWeslq2H
        PtHUZnRAP8g/aYIoPPhBe8Lx3FJC09f8OQB+IeFiidvRc9A1K374LmLa8fWLEj92
        Cb0mU7Y0tZcdUk/3aFowMgXKCJEjIpV2xUlFR+U7QtbfGQNgR5fNRSoyvoiBEnPw
        qFXlzLTrM8vF3r5uQOOqPKz07mR+r+RzbyOPTXFUwJRSXPFFPwHAK9DWy1qRmYqX
        CiuUjWOFbQpGD2hcodhnow==;
X-AuditID: 8b5b014d-a70347000000209f-e5-607cd51b5a9e
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 24.FF.08351.B15DC706; Mon, 19 Apr 2021 03:55:55 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick@ics.forth.gr at ics.forth.gr
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH v4 3/5] RISC-V: Improve init_resources
Date:   Mon, 19 Apr 2021 03:55:37 +0300
Message-Id: <20210419005539.22729-4-mick@ics.forth.gr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210419005539.22729-1-mick@ics.forth.gr>
References: <20210419005539.22729-1-mick@ics.forth.gr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsXSHT1dWVf6ak2CwfWnchaXd81hs9j2uYXN
        ovndOXaLl5d7mC3aZvE7sHq8efmSxePhpktMHpuX1Htcar7O7vF5k1wAaxSXTUpqTmZZapG+
        XQJXxqF1X9kLbhtWHDmzhK2BsVeji5GTQ0LAROLyrxnMXYxcHEICRxklbixvYoRIuEncvr+T
        FcRmE9CUmH/pIAuILSJgLtE88zVYDbNAhsTRfb/YQWxhATOJSdevsoHYLAKqEv9O3mcCsXmB
        4t8PfmGBmCkv0b58O1gNJ9CcKRM+g80RAqqZ9/8uVL2gxMmZT1gg5stLNG+dzTyBkW8WktQs
        JKkFjEyrGAUSy4z1MpOL9dLyi0oy9NKLNjGCQ4/Rdwfj7c1v9Q4xMnEwHmKU4GBWEuG9X1uT
        IMSbklhZlVqUH19UmpNafIhRmoNFSZyXV29CvJBAemJJanZqakFqEUyWiYNTqoFp6q6zc400
        ufyXzf/RvsH6/u+IBQJFIanSzxf80wp8zGN6IK2q+1lo29Oy1Zax6QIbDtU2WRZ1K9iFLS4z
        dFlZ62q+RXCPLK/+OqP4s+JVugcUl6TysicvcfG3dZH9diNz3+I2nxdWej9u/WzJsNgSxmSW
        v3T21bPCPYZvRR601d5xn6jbMf/5Gm9meZfCt/GH+DJ594a4nm2w94vQUdR1NvnW9sP72gmH
        +Utzn/hrLWZWmvbt6zM3ewmtJS3h7TM+iDMnyJWuelKVx8PDJ5vCcDj2+PKCvshpup+XdKRc
        9b00ef0PgZ0mNYdjZvkkaduGzzod2Hf/yTyVThPP0syyQ6dY35cL/HB7MCl7thJLcUaioRZz
        UXEiAHDZpBusAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kernel region is always present and we know where it is, no
need to look for it inside the loop, just ignore it like the
rest of the reserved regions within system's memory.

* Don't call memblock_free inside the loop, if called it'll split
the region of pre-allocated resources in two parts, messing things
up, just re-use the previous pre-allocated resource and free any
unused resources after both loops finish.

Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
---
 arch/riscv/kernel/setup.c | 91 ++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f8f15332c..030554bab 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -60,6 +60,7 @@ static DEFINE_PER_CPU(struct cpu, cpu_devices);
  * also add "System RAM" regions for compatibility with other
  * archs, and the rest of the known regions for completeness.
  */
+static struct resource kimage_res = { .name = "Kernel image", };
 static struct resource code_res = { .name = "Kernel code", };
 static struct resource data_res = { .name = "Kernel data", };
 static struct resource rodata_res = { .name = "Kernel rodata", };
@@ -80,45 +81,54 @@ static int __init add_resource(struct resource *parent,
 	return 1;
 }
 
-static int __init add_kernel_resources(struct resource *res)
+static int __init add_kernel_resources(void)
 {
 	int ret = 0;
 
 	/*
 	 * The memory region of the kernel image is continuous and
-	 * was reserved on setup_bootmem, find it here and register
-	 * it as a resource, then register the various segments of
-	 * the image as child nodes
+	 * was reserved on setup_bootmem, register it here as a
+	 * resource, with the various segments of the image as
+	 * child nodes.
 	 */
-	if (!(res->start <= code_res.start && res->end >= data_res.end))
-		return 0;
 
-	res->name = "Kernel image";
-	res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+	code_res.start = __pa_symbol(_text);
+	code_res.end = __pa_symbol(_etext) - 1;
+	code_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 
-	/*
-	 * We removed a part of this region on setup_bootmem so
-	 * we need to expand the resource for the bss to fit in.
-	 */
-	res->end = bss_res.end;
+	rodata_res.start = __pa_symbol(__start_rodata);
+	rodata_res.end = __pa_symbol(__end_rodata) - 1;
+	rodata_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	data_res.start = __pa_symbol(_data);
+	data_res.end = __pa_symbol(_edata) - 1;
+	data_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	bss_res.start = __pa_symbol(__bss_start);
+	bss_res.end = __pa_symbol(__bss_stop) - 1;
+	bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	kimage_res.start = code_res.start;
+	kimage_res.end = bss_res.end;
+	kimage_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 
-	ret = add_resource(&iomem_resource, res);
+	ret = add_resource(&iomem_resource, &kimage_res);
 	if (ret < 0)
 		return ret;
 
-	ret = add_resource(res, &code_res);
+	ret = add_resource(&kimage_res, &code_res);
 	if (ret < 0)
 		return ret;
 
-	ret = add_resource(res, &rodata_res);
+	ret = add_resource(&kimage_res, &rodata_res);
 	if (ret < 0)
 		return ret;
 
-	ret = add_resource(res, &data_res);
+	ret = add_resource(&kimage_res, &data_res);
 	if (ret < 0)
 		return ret;
 
-	ret = add_resource(res, &bss_res);
+	ret = add_resource(&kimage_res, &bss_res);
 
 	return ret;
 }
@@ -129,54 +139,42 @@ static void __init init_resources(void)
 	struct resource *res = NULL;
 	struct resource *mem_res = NULL;
 	size_t mem_res_sz = 0;
-	int ret = 0, i = 0;
-
-	code_res.start = __pa_symbol(_text);
-	code_res.end = __pa_symbol(_etext) - 1;
-	code_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-
-	rodata_res.start = __pa_symbol(__start_rodata);
-	rodata_res.end = __pa_symbol(__end_rodata) - 1;
-	rodata_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-
-	data_res.start = __pa_symbol(_data);
-	data_res.end = __pa_symbol(_edata) - 1;
-	data_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-
-	bss_res.start = __pa_symbol(__bss_start);
-	bss_res.end = __pa_symbol(__bss_stop) - 1;
-	bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+	int num_resources = 0, res_idx = 0;
+	int ret = 0;
 
 	/* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
-	mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt + 1) * sizeof(*mem_res);
+	num_resources = memblock.memory.cnt + memblock.reserved.cnt + 1;
+	res_idx = num_resources - 1;
+
+	mem_res_sz = num_resources * sizeof(*mem_res);
 	mem_res = memblock_alloc(mem_res_sz, SMP_CACHE_BYTES);
 	if (!mem_res)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, mem_res_sz);
+
 	/*
 	 * Start by adding the reserved regions, if they overlap
 	 * with /memory regions, insert_resource later on will take
 	 * care of it.
 	 */
+	ret = add_kernel_resources();
+	if (ret < 0)
+		goto error;
+
 	for_each_reserved_mem_region(region) {
-		res = &mem_res[i++];
+		res = &mem_res[res_idx--];
 
 		res->name = "Reserved";
 		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 		res->start = __pfn_to_phys(memblock_region_reserved_base_pfn(region));
 		res->end = __pfn_to_phys(memblock_region_reserved_end_pfn(region)) - 1;
 
-		ret = add_kernel_resources(res);
-		if (ret < 0)
-			goto error;
-		else if (ret)
-			continue;
-
 		/*
 		 * Ignore any other reserved regions within
 		 * system memory.
 		 */
 		if (memblock_is_memory(res->start)) {
-			memblock_free((phys_addr_t) res, sizeof(struct resource));
+			/* Re-use this pre-allocated resource */
+			res_idx++;
 			continue;
 		}
 
@@ -187,7 +185,7 @@ static void __init init_resources(void)
 
 	/* Add /memory regions to the resource tree */
 	for_each_mem_region(region) {
-		res = &mem_res[i++];
+		res = &mem_res[res_idx--];
 
 		if (unlikely(memblock_is_nomap(region))) {
 			res->name = "Reserved";
@@ -205,6 +203,9 @@ static void __init init_resources(void)
 			goto error;
 	}
 
+	/* Clean-up any unused pre-allocated resources */
+	mem_res_sz = (num_resources - res_idx + 1) * sizeof(*mem_res);
+	memblock_free((phys_addr_t) mem_res, mem_res_sz);
 	return;
 
  error:
-- 
2.26.2

