Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11CA394E1B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhE2UF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhE2UE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:27 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBBDC061349
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:47 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so7001438otp.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8mc4Mnq2w66cDwa5BzKSAD3u3Z2TCO2giZT6obK4h0=;
        b=RGe/pRGSDonPbkyDu0MgFNYGX35oD98yih7wbadJ6Z5klVcu2sbellZVD8sJtJhFGj
         lwe5/M6K2680S/S9zSZTEu33p1xKF4kNBrDzHAWT2iqxXM0fduMZJnygtcrvpH0i7FSV
         MMsqGdvuIMwpbm9ZIKK1/kwEnpCpEVfz4x4yRHuT3KhDS8cfJ6h/hI4XDbCeYga8pK2D
         4iuvi/UTGN5Q9FSQ/SesE3swONGj/zr3T0OUwim9eA9CJP5bXhsQWHxEf3C8WhMJH8BF
         arIhS8KQhrO6cSxMh9jiz7FIsuFURS1CAfokdHuZtUt2gePlF+a4Cucy6R6dTmr+YaUr
         PnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8mc4Mnq2w66cDwa5BzKSAD3u3Z2TCO2giZT6obK4h0=;
        b=X4BTAjftejQef4fL1F5qm2JQmJ2rNeykLTDxfGZkDYS3yjQCB9VTn5ziKVawLNQMpU
         HqE3K6TZMWgY5boOdZ9e4Wft+sKAQf01PO10YzvKeUAKIJy5GsfcR1bqktidqFgUMxb0
         If7l0C5c96AjNH3Kh0U0qtordddXuYpr0+4aCEqNDm1WiHvCwdpJ8MC1NQ3AQHnmxrOD
         Ht83Vq7TSP8QJfqiQBZHruTWFiSeOEsMhcRRV8nJF69MUPyMavKBbdZ59px9k2ppFSfT
         221nvte0ib+pAVLQur+K7O9dZklGyAxhr1R5ZuzEkzJlt83Z8cMzjy1Qi5X9SnGuf9yv
         bNcA==
X-Gm-Message-State: AOAM532w4GYuskCYL+JIBkCve11cPD3UOx/QlPrUIhuIoBS2qlP8dG++
        OexwjWsGB0ocFv9keOhpL1w=
X-Google-Smtp-Source: ABdhPJx3OkM8um+qi1YvCp1zGHQnExGAK6MBPofgAB2EAY/o3fL0BgWPsWGks2L4tfNhwoLQRyTKXw==
X-Received: by 2002:a9d:68d8:: with SMTP id i24mr11487200oto.347.1622318566407;
        Sat, 29 May 2021 13:02:46 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:46 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 32/34] dyndbg: pack module pr_debug sites
Date:   Sat, 29 May 2021 14:00:27 -0600
Message-Id: <20210529200029.205306-33-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ddebug_add_module, repack the module's sites[] sub-vector.

The previous commit detected 1st site for each function, and ._map'd
2nd-Nth repeats to the 1st.  Instead, we now pack the sites[]
sub-vector, by treating it as a stack, and pushing each distinct
site-rec on top, then ._map's 2nd-Nth sites to that top-of-stack.

For loadable modules, this is enough to repack the __dyndbg_sites
elf section.  If that section is separately kalloc'd, we could
probably just krealloc it to free the chunk past stack-top.

booting with dynamic_debug.verbose=3 will show:
- cols 3,4 row 1 - skip header
- cols 3,4 - full pack in module's slice of array
- fn count off by 1

rcu: Hierarchical SRCU implementation.
dyndbg: add-module: head64.1 sites
dyndbg:  skip header head64
dyndbg: add-module: main.6 sites
Callback from call_rcu_tasks_trace() invoked.
dyndbg:  0 0 1 1 main.run_init_process.1358
dyndbg:  1 0 2 1 main.run_init_process.1356
dyndbg:  2 0 3 1 main.run_init_process.1355
dyndbg:  3 0 4 1 main.run_init_process.1353
dyndbg:  4 1 5 2 main.initcall_blacklisted.1142
dyndbg:  5 2 6 3 main.initcall_blacklist.1103
dyndbg:   6 debug prints in module main (in 2 functions)
dyndbg: add-module: initramfs.1 sites
dyndbg:  0 0 7 7 initramfs.unpack_to_rootfs.496
dyndbg:   1 debug prints in module initramfs (in 0 functions)
dyndbg: add-module: ibs.3 sites
dyndbg:  0 0 8 8 ibs.force_ibs_eilvt_setup.926
dyndbg:  1 1 9 9 ibs.setup_ibs_ctl.897
dyndbg:  2 1 10 9 ibs.setup_ibs_ctl.890
dyndbg:   3 debug prints in module ibs (in 1 functions)

for a loadable module:
- fn-ct looks good
- 1st-fn, packing looks good

dyndbg: add-module: intel_rapl_common.13 sites
dyndbg:  1 1 1 1 intel_rapl_common.rapl_remove_package.1279
dyndbg:  2 2 2 2 intel_rapl_common.rapl_detect_domains.1245
dyndbg:  3 2 3 2 intel_rapl_common.rapl_detect_domains.1242
dyndbg:  4 3 4 3 intel_rapl_common.rapl_package_register_powercap.1159
dyndbg:  5 3 5 3 intel_rapl_common.rapl_package_register_powercap.1145
dyndbg:  6 3 6 3 intel_rapl_common.rapl_package_register_powercap.1114
dyndbg:  7 3 7 3 intel_rapl_common.rapl_package_register_powercap.1108
dyndbg:  8 4 8 4 intel_rapl_common.rapl_update_domain_data.1083
dyndbg:  9 5 9 5 intel_rapl_common.rapl_check_unit_atom.824
dyndbg:  10 6 10 6 intel_rapl_common.rapl_check_unit_core.796
dyndbg:  11 7 11 7 intel_rapl_common.rapl_read_data_raw.722
dyndbg:  12 8 12 8 intel_rapl_common.contraint_to_pl.303
dyndbg:  13 debug prints in module intel_rapl_common (in 8 functions)
dyndbg: add-module: intel_rapl_msr.3 sites
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e12538640b51..43f4c82d24c3 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1073,7 +1073,7 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 {
 	struct ddebug_table *dt;
 	union _ddebug_header *dh = (union _ddebug_header *) &tab[0];
-	int i, j, ct;
+	int i, j;
 
 	v3pr_info("add-module: %s.%d sites\n", modname, numdbgs);
 
@@ -1113,13 +1113,14 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	 * we watch for repeats on site.function, and reuse the index
 	 * of the 1st site record in a repeating block.
 	 */
-	for (ct = i = j = 0; i < numdbgs; i++) {
+	for (i = j = 0; i < numdbgs; i++) {
 		tab[i]._back = base + i; /* index back to header */
 
-		if (sites[i].function != sites[j].function) {
-			j = i; /* remember 1st row with new fn */
-			ct++;
-		}
+		/* find 1st row with new fn, copy it to stack on j */
+		if (sites[i].function != sites[j].function)
+			memcpy((void *) &sites[++j], (void *) &sites[i],
+			       sizeof(struct _ddebug_site));
+
 		tab[i]._map = base + j;
 
 		v3pr_info(" %d %d %d %d %s.%s.%d\n", i, j, tab[i]._back, tab[i]._map,
@@ -1131,7 +1132,7 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	mutex_unlock(&ddebug_lock);
 
 	v2pr_info("%3u debug prints in module %s (in %d functions)\n",
-		  numdbgs, modname, ++ct);
+		  numdbgs, modname, j);
 
 	return 0;
 }
-- 
2.31.1

