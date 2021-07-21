Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1C33D1602
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhGURfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbhGURes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:34:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29815C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:15:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ec55so3565982edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4SoqdozxhmlUDI6hmwPzOl9mnJYC1Q+1VvOSdi9uBu4=;
        b=J1B9Tx724sIp1SYzgBokmaupYKUgmqiecjWFKu63GpvNzdyFocpQmsUYXUu+1DcTgF
         r4MUjQq5MpdZvjSIi7kScylDTy2CAdOjHG7sRP77HgIU6csvzQnriP2KADPGgsRwOVoG
         AffuH/tnX7ojOM+G9fwKC30LVuGX3eo1WMtZ5wf9oQ9kYiByNgwfeO1eDUeDTG6LtvFR
         yKmvBSqPBC8pcFw2+ZP8fmShn1qp0C/xukoKjB2TA9CJkQaF221lzztXRK625PHnO/Io
         mDyDdSavnBYz3PI7LH+67nJ5BIhjGQv4o4mTruTEXFXLEl+s0iynEyLuznlqnSHyo0nG
         07tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4SoqdozxhmlUDI6hmwPzOl9mnJYC1Q+1VvOSdi9uBu4=;
        b=aNV2JT6ebCTwSSyxRZhPLbxW/ED8YKIja2yOK9wOO4E00K5vVfGsPJk7qOQ/wrOWdY
         t3COq4mWtmVA/sHrKvB8BenovMEnILOU16IBNQBbYuPE1LUUSIsus2/f1DoDWhyoZA8Z
         sOAXFYOhxgolAFAEtHtkX5KsREzLQKVIlpmFj4vcxfSjyt4525LxnvpdPDNi3oAbm7QC
         tzjNOHEmlKAcyQnc60i2ni5b9efo/KS7xr55qDcebhLED0af8ZcNfxH/her8TDXBpWWq
         wc6VlVubRJqWsjn8ERt2fYPrmDNQz6UuNngLP+wasKmUXJ+Vkw6QeDxnZmb4Jeu9TN0b
         muZw==
X-Gm-Message-State: AOAM5310FBvl/6k0+HXwTM7iO6w86gyZv0VQYqjb6xNR3EEuuZQLkCZ2
        Ker9IoLswBj5dKCF+e8sTpU=
X-Google-Smtp-Source: ABdhPJwRFv+mQfFkZ4qczVOVHtB4jGKDEmUFKXKm41ymKSLSoy8qQtmANA+TypSHj3NNAXZrbacWTQ==
X-Received: by 2002:a05:6402:5142:: with SMTP id n2mr50123888edd.10.1626891322775;
        Wed, 21 Jul 2021 11:15:22 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id y15sm11173801edd.14.2021.07.21.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 11:15:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] x86/resctrl: Fix kernel-doc in rdtgroup.c
Date:   Wed, 21 Jul 2021 20:15:19 +0200
Message-Id: <20210721181519.6620-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of undocumented parameters. Issues detected by
scripts/kernel-doc.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1 --> v2:
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

