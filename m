Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03213E575B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbhHJJqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbhHJJqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:46:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67300C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:45:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g21so29351052edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ogyvnxy9MiKmDXlkGlmvp5AGKwNfrTFO1X1znrt/jok=;
        b=qZ4WH31eeRvzQdE3vyXSRkS2OHJWCwe17O7sxqyn57vuGSQL3YvmMLfUGkg0idTkxT
         tBikBWcCV3fcQBcOWmuhelBpR1oHG2g29LXUk7Pb8KFdapfqqVSjGTdfQaV8AQONTiL4
         nTRnBhgTdBg86HJliVuM94DkRmxqBvZgYEHtvd4E4iNTJ4S/E2z+iRjEe9gsd4sqg6vS
         4eBllNE2Qsbznnq/cSUoNJ8zsLaTS9KC0yZpyTFZkFvAGqkU+mm1lejfzCPeto4z1FMS
         De6EcMaPb8Uo8R69DXm8rAm+9xwLDeIgQONtqkbjXV7NL4Hy4X9Wq85OaawskhaTp3Wn
         4iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ogyvnxy9MiKmDXlkGlmvp5AGKwNfrTFO1X1znrt/jok=;
        b=KQYFryzX1SdYB2oNTWMRK896GK1ewikd4KkOYMQV0ZFNDBBFIP6+xEGOzM4iia6fdE
         nnDYqpHgpeojRj33N/NumgJ0gHdKOyCOqryGlSOEn570bSLDl0jZR33j6iS0w96SXO3X
         uBGmeWRAmz7O7urYvu3JGSGX+7OSHNqI0sV1HcoFcvZXdK/dSIpmtCJ+rpN62MISIWDw
         OHQIjB7Mox2hj6tIUR4/BmCCxrqlIuIuwAHYFuKs7/0wJP8MtHwfjgllQKGTJzDH6fsy
         gIT8dXxhPR5ItxPCjBMRW5otRlGfVUpSIFX2bKbE4m02uJgpeZDmJROrS+YIZN9+jfm9
         oxAw==
X-Gm-Message-State: AOAM532xfCu6UcFxpxQwULXsxMx/ilbmalZINXX4BrHXhO2MILVqgnHh
        3lTwyH70Pe5Rjza4NyUCW5s=
X-Google-Smtp-Source: ABdhPJw9ZqJZ+5HNKiDVvwB53cxTTinyk+anW2nzxXe2SGUrlwu7b3ZgiSEBTUymiGZFDcN4fnW1Bg==
X-Received: by 2002:a50:ac82:: with SMTP id x2mr617169edc.350.1628588740028;
        Tue, 10 Aug 2021 02:45:40 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-26-100.retail.telecomitalia.it. [79.50.26.100])
        by smtp.gmail.com with ESMTPSA id v24sm6219536edt.41.2021.08.10.02.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:45:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 RESEND] x86/resctrl: Fix kernel-doc in rdtgroup.c
Date:   Tue, 10 Aug 2021 11:45:33 +0200
Message-Id: <20210810094533.16806-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of undocumented parameters. Issues detected by
scripts/kernel-doc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v2->v3:
	Change the commit message by adding a "Reviewed-by" and remove a
	"Suggested-by" tag because its use is incorrect in this specific case.

v1->v2:
	Change some parameter descriptions according to the suggestions of
	Reinette Chatre.

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 01fd30e7829d..b51513661469 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -877,6 +877,9 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 
 /**
  * rdt_bit_usage_show - Display current usage of resources
+ * @of: pointer to opened "bit_usage" info file
+ * @seq: seq_file used to format output to "bit_usage"
+ * @v: unused pointer to void
  *
  * A domain is a shared resource that can now be allocated differently. Here
  * we display the current regions of the domain as an annotated bitmask.
@@ -888,6 +891,8 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
  *   S - currently used and shareable by software only
  *   E - currently used exclusively by one resource group
  *   P - currently pseudo-locked by one resource group
+ *
+ * Return: 0
  */
 static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v)
@@ -1243,6 +1248,7 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 
 /**
  * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusive
+ * @rdtgrp: resource group
  *
  * An exclusive resource group implies that there should be no sharing of
  * its allocated resources. At the time this group is considered to be
@@ -1283,7 +1289,12 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 
 /**
  * rdtgroup_mode_write - Modify the resource group's mode
+ * @of: pointer to opened "mode" file of a resource group
+ * @buf: data from user-space
+ * @nbytes: length of input data buffer
+ * @off: unsupported offset to input
  *
+ * Return: @nbytes on success, <0 on failure
  */
 static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 				   char *buf, size_t nbytes, loff_t off)
@@ -1367,6 +1378,8 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
  *
  * @cbm is unsigned long, even if only 32 bits are used to make the
  * bitmap functions work correctly.
+ *
+ * Return: how many bytes of the cache are represented by @cbm.
  */
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 				  struct rdt_domain *d, unsigned long cbm)
@@ -1389,10 +1402,14 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 
 /**
  * rdtgroup_size_show - Display size in bytes of allocated regions
+ * @of: pointer to opened "size" file of a resource group
+ * @s: seq_file used to format output to "size"
+ * @v: unused pointer to void
  *
  * The "size" file mirrors the layout of the "schemata" file, printing the
  * size in bytes of each region instead of the capacity bitmask.
  *
+ * Return: 0 on success, <0 on failure
  */
 static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
@@ -2618,6 +2635,8 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
  * resource group is initialized. The user can follow this with a
  * modification to the CBM if the default does not satisfy the
  * requirements.
+ *
+ * Return: A valid CBM, 0 if @_val is only 0 filled
  */
 static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
 {
-- 
2.32.0

