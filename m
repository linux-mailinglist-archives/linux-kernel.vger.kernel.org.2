Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A367310B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhBEM1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhBEMXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:23:31 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740F4C0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 04:22:49 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id q2so8622984edi.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 04:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Lw/znXvFSVyy9RpJZDySvtEr6oJORuBhhFt4eQjE6g=;
        b=NnHjxWJQ9K9qnXP+r7MinGrS46yeObSlFp2IeIDSpivDKFuWg3TAwrs6E3cfEMsoy8
         aTcJV46dvuOpGhjfjHvOZLAPu3r4sqXEGBUTdFiwGtG6HkBmSxKvBIm7SgmvIgvpyb3e
         2pHiQ10fPPpA+FaHkjWJp2pW1tf5wZtMJ7jucVk03ee4eVD2qYhQ1VYJu1y0UZj2g30Q
         khMmiiZQaTAwdWMHix4Y6mgfufuvASni+vYBXTfpHqfj10fawe8lMffgLEyND9h4dNKY
         AEQGqlJphySYys0EFvsOXKHik5uQBEFkvlOmntKeUcorsCx7BtwNBRXRj1qno7tuQZwe
         2j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Lw/znXvFSVyy9RpJZDySvtEr6oJORuBhhFt4eQjE6g=;
        b=IRKauUo9fedW6RTYY1MElWiwi50+MFWgnJ7ItumwLDKSeDVokG09wzPsiPavvqpCun
         D39FkDvr9xYDSo6X7R6ADNMgZST8GfFWL1frDUTeTNGRhubSOciRYznifzyvvFJV30ap
         3lDnjT7xGkTB+0yFKXXEAYaKK4pYKyoKiTEKAYRipe3R7JsElv0u5Cy+eWxXc24u+AnA
         03NFr+5nkM0sTAsqR3NAttv4Hi6kZrSeLAfZxqInzrCqS7YW3lGwuvJ5ML275uajYxfz
         u8ZrLTuUqENqU0zk13pZXd5GldpJBi5OKqGD0V3A/DregLozsI/5T3srk9PcC6wFL5/H
         B73g==
X-Gm-Message-State: AOAM531pfKkn0MVuk0CM1GK85KX7s6ec6rYuoHxMsxEFI9FoQCLdS9eE
        cTMcXjvfZdpShw==
X-Google-Smtp-Source: ABdhPJyD3O+6IBdsWzPsKAncBTf9+J0u+k2QhIOzMjfeXGV8PfjDrzfykCFcucsE2k6Pb+GW9yTU2g==
X-Received: by 2002:a05:6402:323:: with SMTP id q3mr3266062edw.115.1612527767980;
        Fri, 05 Feb 2021 04:22:47 -0800 (PST)
Received: from md2k7s8c.ad001.siemens.net ([2a02:810d:9040:4c1f:e0b6:d0e7:64d2:f3a0])
        by smtp.gmail.com with ESMTPSA id f6sm1177590edr.72.2021.02.05.04.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 04:22:47 -0800 (PST)
From:   Andreas Oetken <ennoerlangen@googlemail.com>
X-Google-Original-From: Andreas Oetken <ennoerlangen@gmail.com>
To:     Ley Foon Tan <ley.foon.tan@intel.com>, linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Oetken <ennoerlangen@gmail.com>,
        Andreas Oetken <andreas.oetken@siemens.com>
Subject: [PATCH] nios2: Don't use _end for calculating min_low_pfn
Date:   Fri,  5 Feb 2021 13:22:43 +0100
Message-Id: <20210205122243.1059897-1-ennoerlangen@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Oetken <andreas.oetken@siemens.com>

If there is a initramfs linked into the kernel which will be
freed later on there is free memory somewhere between _etext
and _end, thus using _end for min_low_pfn is not correct.
This may lead to issues in dma_capable when checking
'min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))'
as the address addr might be below min_low_pfn. Picked
find_limits from architecture arm for applying min_low_pfn and
max_low_pfn. Maybe using _etext for min_low_pfn would be
fine too.

Signed-off-by: Andreas Oetken <andreas.oetken@siemens.com>
---
 arch/nios2/kernel/setup.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 3c6e3c813a0b..d2f21957e99c 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -32,8 +32,6 @@ EXPORT_SYMBOL(memory_start);
 unsigned long memory_end;
 EXPORT_SYMBOL(memory_end);
 
-unsigned long memory_size;
-
 static struct pt_regs fake_regs = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 					0, 0, 0, 0, 0, 0,
 					0};
@@ -141,16 +139,22 @@ asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
 	parse_early_param();
 }
 
+static void __init find_limits(unsigned long *min, unsigned long *max_low,
+			       unsigned long *max_high)
+{
+	*max_low = PFN_DOWN(memblock_get_current_limit());
+	*min = PFN_UP(memblock_start_of_DRAM());
+	*max_high = PFN_DOWN(memblock_end_of_DRAM());
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	int dram_start;
 
 	console_verbose();
 
-	dram_start = memblock_start_of_DRAM();
-	memory_size = memblock_phys_mem_size();
-	memory_start = PAGE_ALIGN((unsigned long)__pa(_end));
-	memory_end = (unsigned long) CONFIG_NIOS2_MEM_BASE + memory_size;
+	memory_start = memblock_start_of_DRAM();
+	memory_end = memblock_end_of_DRAM();
 
 	init_mm.start_code = (unsigned long) _stext;
 	init_mm.end_code = (unsigned long) _etext;
@@ -161,11 +165,10 @@ void __init setup_arch(char **cmdline_p)
 	/* Keep a copy of command line */
 	*cmdline_p = boot_command_line;
 
-	min_low_pfn = PFN_UP(memory_start);
-	max_low_pfn = PFN_DOWN(memory_end);
+	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
 	max_mapnr = max_low_pfn;
 
-	memblock_reserve(dram_start, memory_start - dram_start);
+	memblock_reserve(__pa_symbol(_stext), _end - _stext);
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start) {
 		memblock_reserve(virt_to_phys((void *)initrd_start),
-- 
2.30.0

