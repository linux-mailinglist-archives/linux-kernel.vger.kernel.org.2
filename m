Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84453425509
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241965AbhJGOLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbhJGOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:11:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04081C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 07:09:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id n8so24270767lfk.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ddc+nwwGsdqLgmdcD/hKX3FxYNdymv0YTXOgmcVifRo=;
        b=wBqQd5KAYGePtskjlEThq46KUmeWaOwadR0xaQwEv6TQqAbpu5n4IIv+RGQXu44+hq
         rCwICzDehfhfBsegJX7YKUCliq9RV7J6oZDHiWnP37g5Tb73bpfHqsp4TKuhh4PkcqoD
         E5Tc7ZTu2WZX2FAGuYPk36C9BlP3rt4k1SC25uUtmSeojjaXjvOtDhR6BVGZNOld8I++
         NE2zYXU/a8++l04VnE8E2rPaGlySC5dg61hzLKtB/nkLvQ8+Uoe19VtadAVWEkNeY769
         69CAussyY/EQX87bBqyeTZrszANo0nK7OIYH19FdT9KuDWs6QIkxARcP5yycXM+IkIHo
         3Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ddc+nwwGsdqLgmdcD/hKX3FxYNdymv0YTXOgmcVifRo=;
        b=a5e+MjoksCTabRPgMNGvEBvmW2mh3QMhDNhIkterddOqCMBIciuh1SS7K56mTC5AE+
         Tad4iYTzDUhnuaxGZpNO2urjLPAlh6Z3jFX4TG0QYjN3/swWpsqSTR/NXoDHiY7+rNvY
         VuLe6Uw6V9P+eVm+AT3uKXwHT/kHcAV+xCS6L9s/j1SZE+2EJruSmQMwsRyuJzQ+2t97
         0mrrAGaGFQ1zzAnPgMEz+qV3Fi+AIBC2TLUimGCI+7jqFnHpzGwGnkZrELPldjDzlt/M
         5Dd04zj+UYt1bJ8GzxjjK46p3cY8Yen7/5dcsnO8zLja+TGy7mijHPb+M+LjQAl+L2Gc
         v3Ww==
X-Gm-Message-State: AOAM5328nEHMubBPoCljTB4BGD9285WtI+N//iM6Gp95iiRFZlfcK58Z
        BXjvd+Lu9+V7yiTCsmT3B9kPYQ==
X-Google-Smtp-Source: ABdhPJyBGQcI7zWR5C7xj5L81py7OHb42ZN3knmXo3P1F6fFKGqu0cppFDPxTyuglLqzw8bQkCMryQ==
X-Received: by 2002:a2e:b8d3:: with SMTP id s19mr4752838ljp.314.1633615745876;
        Thu, 07 Oct 2021 07:09:05 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id f28sm255550lfk.62.2021.10.07.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 07:09:05 -0700 (PDT)
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
Subject: [PATCH v4] clk: Add write operation for clk_parent debugfs node
Date:   Thu,  7 Oct 2021 17:09:04 +0300
Message-Id: <20211007140904.3085-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful for testing mux clocks. One can write the index of the parent to
be set into clk_parent node, starting from 0. Example

    # cd /sys/kernel/debug/clk/mout_peri_bus
    # cat clk_possible_parrents
      dout_shared0_div4 dout_shared1_div4
    # cat clk_parent
      dout_shared0_div4
    # echo 1 > clk_parent
    # cat clk_parent
      dout_shared1_div4

CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c in
order to use this feature.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - Fixed the commit title

Changes in v3:
  - Removed unwanted changes added by mistake

Changes in v2:
  - Merged write() function into existing 'clk_parent' file
  - Removed 'if (val >= core->num_parents)' check
  - Removed incorrect usage of IS_ERR_OR_NULL()

 drivers/clk/clk.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 806c55f0991b..f57e33efda9b 100644
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
@@ -3291,9 +3331,20 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
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
 
 	if (core->num_parents > 1)
 		debugfs_create_file("clk_possible_parents", 0444, root, core,
-- 
2.30.2

