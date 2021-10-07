Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0C44254B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbhJGNwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbhJGNwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:52:07 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53648C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 06:50:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y15so25323209lfk.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PSfrIbkMTQ1HdGmDy7QPzG/bI9Btr9cDuF+9gXLPAE=;
        b=WJcJtLiJreWLmywPc2jp3x7not6dDr0Zb7+jZbMu+bWuqy4CQD/T3UUOGUcCeCw9zi
         NlLPt1pc4hPvAERDYQqi7OqvDA/x6ZTGOJiJx+mVIThSTo+uwEo2JsqS1H03ep7zsjSx
         CNbSY6/nmMaYFqV6RvkZAARfhAlh1iDP9Xdk+zknkF7iX/tCLyHhbAQsHj9wD82Z3aqQ
         3Z/3XOTm6a6KzJvyj27+bbB24s53yzF1w/EUnLQFLwGi9SeY8R2Ke7Fh9cW4RM5sC2yn
         R2fufhRigyfO9BLiacU45nLiwd0pPeSXIVZHmNEZ1kyBUHxtwVfYjepQanegfMQ/4+36
         2FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PSfrIbkMTQ1HdGmDy7QPzG/bI9Btr9cDuF+9gXLPAE=;
        b=uKCcRd4ePC8aWNgDqkiFmGoYecEHC/n76aO/UmokuoURrXm2Ufok72DlDDrAT8fIzg
         ySCaCwWYd5x/+pljrXLNtnJmh0wAqLQV//xycO81WrMpGQBMRl7XXpCSYnngeghnGvfh
         Vva9spIlAFcDRzxDrt9Bl03skL2dO43XoGsQbj7iTBxFq89B/Exg2ghFdD3On9qZKxcW
         gSbiQqnMeRvs6r+1UNRnNvSL1S2meHRkG5MmaLONOJ72Gz4hxFGIbq/UMjWko1kaksru
         MmDaKodL1aDE6qEd8uuf8RuRRbL1DHZ1n1nA2aA2fzh3varLc4wlig+M+ymRZtDqk8XB
         K4Hw==
X-Gm-Message-State: AOAM533xgALscY8hcT6+F43w7VnglFFsUunWwk+LpvsWy6RchIpbQmtl
        mQzpViBH8RNMRsGpgLoMADcglqQtcIm+arxc
X-Google-Smtp-Source: ABdhPJyhApVyHPK1Cwqr4udEJhbfha3UuzSWVDodocsqtXvf7OgkWfBfR885j3TLc7K5GzItI7BksQ==
X-Received: by 2002:a05:651c:1025:: with SMTP id w5mr4038161ljm.282.1633614605590;
        Thu, 07 Oct 2021 06:50:05 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id q14sm1111160lfe.118.2021.10.07.06.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 06:50:04 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: Add clk_set_parent debugfs node
Date:   Thu,  7 Oct 2021 16:50:03 +0300
Message-Id: <20211007135003.2229-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful for testing mux clocks. One can write the index of the parent to
set into clk_parent node, starting from 0. Example

    # cd /sys/kernel/debug/clk/mout_peri_bus
    # cat clk_possible_parrents
      dout_shared0_div4 dout_shared1_div4
    # cat clk_parent
      dout_shared0_div4
    # echo 1 > clk_parent
    # cat clk_parent
      dout_shared1_div4

One needs to define CLOCK_ALLOW_WRITE_DEBUGFS in drivers/clk/clk.c in
order to use this feature.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Merged write() function into existing 'clk_parent' file
  - Removed 'if (val >= core->num_parents)' check
  - Removed incorrect usage of IS_ERR_OR_NULL()

 drivers/clk/clk.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 806c55f0991b..5776efab4739 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3224,6 +3224,46 @@ static int current_parent_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(current_parent);
 
+#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
+static ssize_t current_parent_write(struct file *file, const char __user *ubuf,
+				    size_t count, loff_t *ppos)
+{
+	struct seq_file *s = file->private_data;
+	struct clk_core *core = s->private;
+	struct clk_core *parent;
+	char buf[4] = { 0 };
+	u8 idx;
+	int err;
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	err = kstrtou8(buf, 0, &idx);
+	if (err)
+		return err;
+
+	parent = clk_core_get_parent_by_index(core, idx);
+	if (!parent)
+		return -ENOENT;
+
+	clk_prepare_lock();
+	err = clk_core_set_parent_nolock(core, parent);
+	clk_prepare_unlock();
+	if (err)
+		return err;
+
+	return count;
+}
+
+static const struct file_operations current_parent_rw_fops = {
+	.open		= current_parent_open,
+	.write		= current_parent_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif
+
 static int clk_duty_cycle_show(struct seq_file *s, void *data)
 {
 	struct clk_core *core = s->private;
@@ -3291,13 +3331,25 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
 			    &clk_prepare_enable_fops);
 #endif
 
-	if (core->num_parents > 0)
+	if (core->num_parents > 0) {
+#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
+		if (core->num_parents > 1) {
+			debugfs_create_file("clk_parent", 0644, root, core,
+					    &current_parent_rw_fops);
+		} else {
+			debugfs_create_file("clk_parent", 0444, root, core,
+					    &current_parent_fops);
+		}
+#else
 		debugfs_create_file("clk_parent", 0444, root, core,
 				    &current_parent_fops);
+#endif
+	}
 
-	if (core->num_parents > 1)
+	if (core->num_parents > 1) {
 		debugfs_create_file("clk_possible_parents", 0444, root, core,
 				    &possible_parents_fops);
+	}
 
 	if (core->ops->debug_init)
 		core->ops->debug_init(core->hw, core->dentry);
-- 
2.30.2

