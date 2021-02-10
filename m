Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE011316063
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhBJHwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhBJHvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:51:23 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A88C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 23:50:43 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id j11so735068plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 23:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=naMFlYH6UhpEHmxz8VEooRy+MFEkCdlTQ0W0MTZJ7X4=;
        b=pE+etDMi+lgK9jmZte9q0cGLwj+h3PK29yLX+ClA/x/LI8kv6b6PPNWZPhYcqzpsFx
         KfAMYgQUYhgUi7VF2AIHVwgrtLwzv2Ufq63Zo5vdzI3aj+ySoYnm3FnQMka81ZGBJPqf
         7vJG0ONhhGD71IFc8N2ByEwmdwChzZtF90qAt/giypuFvWD8Bewyw+I/tb9D8AxI8FL5
         lE9Yxe1PCAMGf0/OHTZoV+nA5zfCv3BHcOqjW275N33xo/PQ+0peoM+syLh+lkL1YikN
         O3iUqd9tm3MSX3aapxGkog9QFJLdG+PvV45JXmGkxoxiyfMS9LTahPNpVwjZs73IZMfA
         YwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=naMFlYH6UhpEHmxz8VEooRy+MFEkCdlTQ0W0MTZJ7X4=;
        b=ZCrfrSKrbJ60XflNfyMvYoyIjI8sfbFe7/K702nRAJ3nFWgXX6AQgaFR4twutsABDh
         FsUDq6lpJbfUz6sWU6x1n5t2McLRx1ivzQy4jmvKH+9PTaqSf86q6ccKp1Nila69d9j9
         vlZk9dTqQqQAKNYEd4ujyM5Uja3Fi3iuDFI9uybpOBpkTtG375wzIXJZ3XQpBG2LfB7u
         xtrE6KWTEjeP8V02Fo5XBrwyaDQPCajPCvkNrutQG8xHHdospm+J6Mi+k7RW1VwBW3gz
         BWcTBWTs1/LKZMKLJw+TOAYYAhSWidwg93kjpXdbZdXrDrRcA2wVD2wQjOrZlPbh4CrN
         l8Pg==
X-Gm-Message-State: AOAM531oiQBcQJtusmLjFIKG+DxcjzJKvcSh/uuOt7tlWRLmr0gEUsj1
        oimCZJ+BAKlKKb92eRMIN6x6vw==
X-Google-Smtp-Source: ABdhPJzU1TbjG7FA2zFcbiny6Opf8oep9SSpoWE65laH/UwIwPU28PZ1LvRbpS++r0Iz25E2eUpW5Q==
X-Received: by 2002:a17:90a:7404:: with SMTP id a4mr1877586pjg.167.1612943442715;
        Tue, 09 Feb 2021 23:50:42 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:7b19:df69:92d6:528e])
        by smtp.gmail.com with ESMTPSA id b25sm1261710pfp.26.2021.02.09.23.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 23:50:42 -0800 (PST)
From:   Drew Fustini <drew@beagleboard.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v2 2/2] pinctrl: pinmux: Add pinmux-select debugfs file
Date:   Tue,  9 Feb 2021 23:49:47 -0800
Message-Id: <20210210074946.155417-3-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210074946.155417-1-drew@beagleboard.org>
References: <20210210074946.155417-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "pinmux-select" to debugfs which will activate a function and group
when 2 integers "<function-selector> <group-selector>" are written to
the file. The write operation pinmux_select() handles this by checking
if fsel and gsel are valid selectors and then calling ops->set_mux().

The existing "pinmux-functions" debugfs file lists the pin functions
registered for the pin controller. For example:

function: pinmux-uart0, groups = [ pinmux-uart0-pins ]
function: pinmux-mmc0, groups = [ pinmux-mmc0-pins ]
function: pinmux-mmc1, groups = [ pinmux-mmc1-pins ]
function: pinmux-i2c0, groups = [ pinmux-i2c0-pins ]
function: pinmux-i2c1, groups = [ pinmux-i2c1-pins ]
function: pinmux-spi1, groups = [ pinmux-spi1-pins ]

To activate function pinmux-i2c1 (fsel 4) and group pinmux-i2c1-pins
(gsel 4):

echo '4 4' > pinmux-select

Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 drivers/pinctrl/pinmux.c | 106 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 7f6190eaedbb..b8cd0c3bedf7 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -673,6 +673,110 @@ void pinmux_show_setting(struct seq_file *s,
 DEFINE_SHOW_ATTRIBUTE(pinmux_functions);
 DEFINE_SHOW_ATTRIBUTE(pinmux_pins);
 
+
+#define PINMUX_MAX_NAME 64
+static ssize_t pinmux_select(struct file *file, const char __user *user_buf,
+				   size_t len, loff_t *ppos)
+{
+	struct seq_file *sfile = file->private_data;
+	struct pinctrl_dev *pctldev = sfile->private;
+	const struct pinmux_ops *pmxops = pctldev->desc->pmxops;
+	const char *const *groups;
+	char *buf, *fname, *gname;
+	unsigned int num_groups;
+	int fsel, gsel, ret;
+
+	if (len > (PINMUX_MAX_NAME * 2)) {
+		dev_err(pctldev->dev, "write too big for buffer");
+		return -EINVAL;
+	}
+
+	buf = devm_kzalloc(pctldev->dev, PINMUX_MAX_NAME * 2, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	fname = devm_kzalloc(pctldev->dev, PINMUX_MAX_NAME, GFP_KERNEL);
+	if (!fname) {
+		ret = -ENOMEM;
+		goto free_buf;
+	}
+
+	gname = devm_kzalloc(pctldev->dev, PINMUX_MAX_NAME, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto free_fname;
+	}
+
+	ret = strncpy_from_user(buf, user_buf, PINMUX_MAX_NAME * 2);
+	if (ret < 0) {
+		dev_err(pctldev->dev, "failed to copy buffer from userspace");
+		goto free_gname;
+	}
+	buf[len-1] = '\0';
+
+	ret = sscanf(buf, "%s %s", fname, gname);
+	if (ret != 2) {
+		dev_err(pctldev->dev, "expected format: <function-name> <group-name>");
+		goto free_gname;
+	}
+
+	fsel = pinmux_func_name_to_selector(pctldev, fname);
+	if (fsel < 0) {
+		dev_err(pctldev->dev, "invalid function %s in map table\n", fname);
+		ret = -EINVAL;
+		goto free_gname;
+	}
+
+	ret = pmxops->get_function_groups(pctldev, fsel, &groups, &num_groups);
+	if (ret) {
+		dev_err(pctldev->dev, "no groups for function %d (%s)", fsel, fname);
+		goto free_gname;
+
+	}
+
+	ret = match_string(groups, num_groups, gname);
+	if (ret < 0) {
+		dev_err(pctldev->dev, "invalid group %s", gname);
+		goto free_gname;
+	}
+
+	ret = pinctrl_get_group_selector(pctldev, gname);
+	if (ret < 0) {
+		dev_err(pctldev->dev, "failed to get group selectorL %s", gname);
+		goto free_gname;
+	}
+	gsel = ret;
+
+	ret = pmxops->set_mux(pctldev, fsel, gsel);
+	if (ret) {
+		dev_err(pctldev->dev, "set_mux() failed: %d", ret);
+		goto free_gname;
+	}
+
+	return len;
+free_buf:
+	devm_kfree(pctldev->dev, buf);
+free_fname:
+	devm_kfree(pctldev->dev, fname);
+free_gname:
+	devm_kfree(pctldev->dev, gname);
+	return ret;
+}
+
+static int pinmux_select_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, NULL, inode->i_private);
+}
+
+static const struct file_operations pinmux_select_ops = {
+	.owner = THIS_MODULE,
+	.open = pinmux_select_open,
+	.read = seq_read,
+	.write = pinmux_select,
+	.llseek = no_llseek,
+	.release = single_release,
+};
+
 void pinmux_init_device_debugfs(struct dentry *devroot,
 			 struct pinctrl_dev *pctldev)
 {
@@ -680,6 +784,8 @@ void pinmux_init_device_debugfs(struct dentry *devroot,
 			    devroot, pctldev, &pinmux_functions_fops);
 	debugfs_create_file("pinmux-pins", 0400,
 			    devroot, pctldev, &pinmux_pins_fops);
+	debugfs_create_file("pinmux-select", 0200,
+			    devroot, pctldev, &pinmux_select_ops);
 }
 
 #endif /* CONFIG_DEBUG_FS */
-- 
2.25.1

