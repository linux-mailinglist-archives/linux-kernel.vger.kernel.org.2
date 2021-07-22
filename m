Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232C93D228C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 13:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhGVK0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 06:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhGVK0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:26:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33C5C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 04:07:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v1so6274366edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dAEvhUeD66nUbNb/n9v7UyoUFPyD324CJ5HdOHQZfg=;
        b=S4+nVujj4N6ZlzuMd4MpKyZ4gYEcwDkwwhMomn5ACtWX2G5UGq8ZsCjLX7M0vJzRt8
         NMPz/XqoXhmplRLpXpsc9j2KE0D3rJa9BQA/j7Xz9i1bf7+iGOFQQHmW9S1oZ84ZRuZa
         OfSOkQETUveh96SRmOsdQLnUj9qynBvrW7ds1cNKLadYIME4NwciK0PMkfe7XklymyZ3
         Ov11shcrVJmGiW6f+G7iX3PDQQjdFBnqzwHzF5Mz4YgfkfcIknrVvqD9kidX5863AFas
         WJVWqebr/MnmO+veAoYMUnUNc64Oa2XooAKwr/o9QCTL/PrTaTddQUEb49OdGIhE4GL0
         gbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dAEvhUeD66nUbNb/n9v7UyoUFPyD324CJ5HdOHQZfg=;
        b=mldQbtLysMS1A9gwbLApvH01+5m3BcO3QCeckSB6hb46q3pfaNm/WOh/4qdYT3lT0O
         QorDa33MwcBA/52cn7SkoS6htGKYOWezrLrMIu+iT3sKShSqD+P3oNn9I5qk45peh6vH
         q+ExwiRzXI3Tp/uW+JPQevvtkUBEHMlIWw2f1Bx2Cq2NkZP+dgcgfjYDIkijYrFv0Wjt
         e2fa8HZl8sVBJ6dV6dKLWOQF16iCR95zm1gT2K6qJMlBn0MNTeG3x6g15+C6wJy6YDpe
         UgPk7+4hHPDxhiyW0sTSn8A7FtLrPOersixBHCvC56JYf6sNHtwUYP7cslg8Y+QoCVNc
         Z8NA==
X-Gm-Message-State: AOAM532qopb+Wd97FqlHjz6eCA51VGUXdqVe4WqTWyWW76QVeynAHi/v
        6aJg4z/ZU2t5YquKVBUgLmA=
X-Google-Smtp-Source: ABdhPJyLVoUg56zspewc06FlTOGX0INnj3disqADClQ5c5vRU/jcR3dt8Qp0OBAec0mIQQ33I9Epbg==
X-Received: by 2002:a05:6402:1b06:: with SMTP id by6mr52743669edb.95.1626952041301;
        Thu, 22 Jul 2021 04:07:21 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id m3sm7671270edb.7.2021.07.22.04.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 04:07:20 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3] x86/resctrl: Fix kernel-doc in rdtgroup.c
Date:   Thu, 22 Jul 2021 13:07:15 +0200
Message-Id: <20210722110715.8572-1-fmdefrancesco@gmail.com>
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

v2 --> v3:
Change the commit message by adding a "Reviewed-by" and remove a
"Suggested-by" tag because its use is incorrect in this specific case.

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

