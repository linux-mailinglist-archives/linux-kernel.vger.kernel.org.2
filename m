Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF63BE726
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 13:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhGGLb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhGGLbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:31:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50FFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 04:29:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id l2so2965415edt.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 04:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2s3+vRvimgOGREoC1YWK8pCOGIptYzVHvOSvN8f2Bc=;
        b=SJyafKVabY88uhN00U5tRFPzPg3CGWiC+j7H7pkCTpfeBbh410sPOigTUdhNzO+fxw
         vkicTgyTxpjvzZLfeNXXTU0xEfqxCT6rg+1RpWV25aBYcLQM1IYtr63xearlTK28rrBp
         NGbR38xwHH55W5++HrekYMn7RV8he4L86OlQCt79BYkJBEw5GWxGcigqBoBpc1ilmAM5
         EDuLNrAAl4LkyVLIG6NQOgn1l4Y4wvijdU11ZzA6LvPD9aNrryQvoI1oHFlloWZ5VYFz
         tfbpOKEYfQx7v2wjELnPst0VoTokSAMyXvPlNZmNyf5LRLikev5xXgK81qonY1ia2YIS
         yylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2s3+vRvimgOGREoC1YWK8pCOGIptYzVHvOSvN8f2Bc=;
        b=UpeZ+aSRgbKkC7nUaAMFy62lh02xUOn5Mmig2WeOO0fhywKIyWotdQUahfhUWUJm5V
         QIQ4+2Fu29a+MvLNdgnrP7uCCnE2672Yl1/VAl2Wiwr2ABedvWE47bN9eXS++GksqIxn
         I0vzRBuxGUxqfLmVIUJFaF5voB2KPnWbWE4QvCIX3G9bRb0QGtUr+yUn3vobd3tRdbKh
         viXKZc+aclGqwSHdEb04VN4Cpp5RJl+nGBmQdSR+EwF/PDEFl0tpkTIkaROwg0XoKUMJ
         Kl69NbmJMivLirMxaaoneTo1o1+XnSA6RCntp3fpCysFVt0wrSQsVdcQuMlmv4fRlHI4
         cb2A==
X-Gm-Message-State: AOAM531GjRzfRwGlx27EvRyWhQabxvd222LueacKfnBajzO95sIkbJNG
        WkeGfsZ2G2EYvbmSPUmyHyQ=
X-Google-Smtp-Source: ABdhPJxi0t40khAFLBpj7mdOR8VqKvNmlk+FN7sDbpL1Chgj8pBaefrV4sSiYqd5M47RuO9A8Iaqxw==
X-Received: by 2002:aa7:d448:: with SMTP id q8mr29648513edr.250.1625657351281;
        Wed, 07 Jul 2021 04:29:11 -0700 (PDT)
Received: from linux.local (host-80-181-152-252.retail.telecomitalia.it. [80.181.152.252])
        by smtp.gmail.com with ESMTPSA id g23sm8631791edp.74.2021.07.07.04.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 04:29:10 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] x86/resctrl: Fix kernel-doc in rdtgroup.c
Date:   Wed,  7 Jul 2021 13:29:06 +0200
Message-Id: <20210707112906.9971-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of undocumented parameters. Issues detected by
scripts/kernel-doc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 01fd30e7829d..b5a30e57ce5f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -877,6 +877,9 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 
 /**
  * rdt_bit_usage_show - Display current usage of resources
+ * @of: kernfs open file
+ * @seq: seq_file for kernfs
+ * @v: unused pointer to void
  *
  * A domain is a shared resource that can now be allocated differently. Here
  * we display the current regions of the domain as an annotated bitmask.
@@ -888,6 +891,8 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
  *   S - currently used and shareable by software only
  *   E - currently used exclusively by one resource group
  *   P - currently pseudo-locked by one resource group
+ *
+ * Return: 0 on success
  */
 static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v)
@@ -1243,6 +1248,7 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 
 /**
  * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusive
+ * @rdtgrp: resource director technology group
  *
  * An exclusive resource group implies that there should be no sharing of
  * its allocated resources. At the time this group is considered to be
@@ -1283,7 +1289,12 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 
 /**
  * rdtgroup_mode_write - Modify the resource group's mode
+ * @of: open file in kernfs
+ * @buf: input data buffer
+ * @nbytes: lenght of input data buffer
+ * @off: offset
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
+ * Return: how many bytes are represented by the bitmask associated with the RDT domain.
  */
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 				  struct rdt_domain *d, unsigned long cbm)
@@ -1389,10 +1402,14 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 
 /**
  * rdtgroup_size_show - Display size in bytes of allocated regions
+ * @of: open file in kernfs
+ * @s: seq_file
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
+ * Return: A bitmap representing a valid contiguous CBM, 0 if @_val is only 0 filled
  */
 static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
 {
-- 
2.32.0

