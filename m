Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270A1425A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbhJGSX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbhJGSX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:23:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E903DC061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 11:22:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m3so28729692lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RePy4YWN0QrSCoH4w20ZWl3nlKJKvtiMzhDlSX/yriY=;
        b=OxR9W+NREOChsdjDuhEuI7PNX0M+3YLpGr9UjwguYPWOZggjQMn2QUNfNgwKQqa9F6
         V9Hi+egHduzv1YkEWEIr0SXHe5LUb2XrzrH3xfDwldcbiabvUcr0hAzwcJf7jZstBoZu
         CGOHJtz9COkNmXL3XHmax8r2WkMjR955917ml2JcoOtjl1WmlYbbCDsIsR5f06uTagC6
         L46CjBUSPiYsunaYJw854kzuBjBmCw6/mEWboopgjBGwk0WeHLpWg2FvkuWTss0M2SUS
         r42QUzwMI0ksMLJoMFMUYdA4C9cae8/e6GSFC/97DaBFUUIoEVgYkZU2V3ctO94khGhb
         vHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RePy4YWN0QrSCoH4w20ZWl3nlKJKvtiMzhDlSX/yriY=;
        b=gwx09xadVH+P+qABh4q81efkS22Z4gCuZUUx7WJqTfutJ1QpeVk+bLWw7w1F2lZ/l1
         ncZshZIlBY1eximtOcDQ1gGvWVsPWx4YcUqUOL3OLU2Pf2zN8ghNCBtQUKurMwSx4c/H
         vPzlMmtKopoZ0TBypmmqsdGK/JB90w7EFuRuOJLOSnCDVAAWywCnP2VSLuj4IcRegR5C
         4FThcRlQlJu/xEopDZbLca489YLgTgitKJLNF+dueRi40qGC8kF/PFq6pfFV1MtQj6rS
         R7A3uwAKPsfxfJlV0UAEii5jMS0zFHa5EfE3+rblqWCvNx4UgSJd4w/D83km1oVABAoK
         Hbpw==
X-Gm-Message-State: AOAM532jZ1s9vEmkTkhd9+i7Ho1/SFQzNyOgp3AtGltiLUjdXk4x6hJ7
        E/f9mcH0xq0ZkuCqUTyX2hGQGw==
X-Google-Smtp-Source: ABdhPJykk3FE+YFgHXntejj5zMNl7VFdjwhG6jc9O1q6+cMbS6+8ktVb/uAvHVg8NfSkvUmr3wsIAQ==
X-Received: by 2002:a05:6512:3c95:: with SMTP id h21mr5851195lfv.128.1633630920288;
        Thu, 07 Oct 2021 11:22:00 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id v23sm8069ljj.97.2021.10.07.11.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:21:59 -0700 (PDT)
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
        Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] clk: Add write operation for clk_parent debugfs node
Date:   Thu,  7 Oct 2021 21:21:58 +0300
Message-Id: <20211007182158.7490-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful for testing mux clocks. One can write the index of the parent to
be set into clk_parent node, starting from 0. Example

    # cd /sys/kernel/debug/clk/mout_peri_bus
    # cat clk_possible_parents
      dout_shared0_div4 dout_shared1_div4
    # cat clk_parent
      dout_shared0_div4
    # echo 1 > clk_parent
    # cat clk_parent
      dout_shared1_div4

CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c in
order to use this feature.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v5:
  - Used kstrtou8_from_user() API
  - Got rid of code duplication
  - Fixed typo in commit message
  - Added R-b tag by Andy Shevchenko

Changes in v4:
  - Fixed the commit title

Changes in v3:
  - Removed unwanted changes added by mistake

Changes in v2:
  - Merged write() function into existing 'clk_parent' file
  - Removed 'if (val >= core->num_parents)' check
  - Removed incorrect usage of IS_ERR_OR_NULL()

 drivers/clk/clk.c | 50 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 806c55f0991b..6154d5bc2b45 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3224,6 +3224,42 @@ static int current_parent_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(current_parent);
 
+#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
+static ssize_t current_parent_write(struct file *file, const char __user *ubuf,
+				    size_t count, loff_t *ppos)
+{
+	struct seq_file *s = file->private_data;
+	struct clk_core *core = s->private;
+	struct clk_core *parent;
+	u8 idx;
+	int err;
+
+	err = kstrtou8_from_user(ubuf, count, 0, &idx);
+	if (err < 0)
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
@@ -3291,9 +3327,17 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
 			    &clk_prepare_enable_fops);
 #endif
 
-	if (core->num_parents > 0)
-		debugfs_create_file("clk_parent", 0444, root, core,
-				    &current_parent_fops);
+#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
+	if (core->num_parents > 1)
+		debugfs_create_file("clk_parent", 0644, root, core,
+				    &current_parent_rw_fops);
+	else
+#endif
+	{
+		if (core->num_parents > 0)
+			debugfs_create_file("clk_parent", 0444, root, core,
+					    &current_parent_fops);
+	}
 
 	if (core->num_parents > 1)
 		debugfs_create_file("clk_possible_parents", 0444, root, core,
-- 
2.30.2

