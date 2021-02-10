Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E0B317368
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhBJWdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhBJWdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:33:39 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CD3C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:32:58 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t26so2202225pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VsbMCxTtdvlOFCnXGlkrpcWY7egsi5VCqOPmThmfB80=;
        b=CY6W6zgFQUcoGd00h6NX4x4EXPAE3mu6QeelJJW72Azjxl6Gvq+f+D/9QPRq5vvBss
         OG+OG6tZZtH1ASf4TezDSMAjekwt6+CG++5MameA37Q/sS7oQ/11cl7KIUq3NqIfokUR
         aAUqMWV86KfcJVtnZQ1aWcqOgsNemFadRvuUoZ8DQMQ9r7gIfMTHSIm60lIKbZ4XbVaV
         Nxe8HYGGVmXdyYG43z27O9MfUi46eEQchF43xXRAbHpv9ac5veQmEymXwQH1nV/EFtum
         BXtG1WoFeWM1D81tItAgO6SjT9prsitSwIAJCvh7s5NW4+b5UGtuUdCcAbyXHz3DhWTF
         FJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VsbMCxTtdvlOFCnXGlkrpcWY7egsi5VCqOPmThmfB80=;
        b=d29YS1dkbSMfadiegKdznxHNUtPwJIq69lwxtvBMmS7HP6SsD60DZCiOd7DieUN76T
         xwwYblo4+ByqWzTguf2uUYDtUF0y4xTNCyb0Em2JDPg34vDvJ4POlGhusssTn2mQ9S3n
         mr0RG8r1C3mDZ4KItrpYpj7mrNuPUnZwHzKNbedQZ8uw6dDPLh931tBwYVY6o+YWz7z/
         Wm4hp/j7mxeyTZLuK10yvAH5oPk8mcPv2ZPjwPSvD9J7MxArFnH0bFq8Kwwqa6ep7NKF
         wYPffv2g6m5Jws94CgTsM+jq3NLSy/tYV/pQoJmFRth1Cay7Gq/xPiky1IzYXykvLTea
         0PKA==
X-Gm-Message-State: AOAM533A9w/rWfAZrYmJT0IeYfSzs7sjKSC650V7jquzOsZKSCCOKpfs
        c4y8AlsL+R90QPxYMYqbtfD+9A==
X-Google-Smtp-Source: ABdhPJwkxVbtjV3jPupR3hPdBKiUdYBSkQtWEFcUA5UaFwtsgsTeqlmD5JjOYzyiDlS8THRH/9eckQ==
X-Received: by 2002:a63:4d41:: with SMTP id n1mr5222989pgl.147.1612996378524;
        Wed, 10 Feb 2021 14:32:58 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:7b19:df69:92d6:528e])
        by smtp.gmail.com with ESMTPSA id t17sm3686307pgk.25.2021.02.10.14.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:32:57 -0800 (PST)
From:   Drew Fustini <drew@beagleboard.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v4 2/2] pinctrl: pinmux: Add pinmux-select debugfs file
Date:   Wed, 10 Feb 2021 14:28:54 -0800
Message-Id: <20210210222851.232374-3-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210222851.232374-1-drew@beagleboard.org>
References: <20210210222851.232374-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "pinmux-select" to debugfs which will activate a function and group
when "<function-name group-name>" are written to the file. The write
operation pinmux_select() handles this by checking that the names map to
valid selectors and then calling ops->set_mux().

The existing "pinmux-functions" debugfs file lists the pin functions
registered for the pin controller. For example:

function: pinmux-uart0, groups = [ pinmux-uart0-pins ]
function: pinmux-mmc0, groups = [ pinmux-mmc0-pins ]
function: pinmux-mmc1, groups = [ pinmux-mmc1-pins ]
function: pinmux-i2c0, groups = [ pinmux-i2c0-pins ]
function: pinmux-i2c1, groups = [ pinmux-i2c1-pins ]
function: pinmux-spi1, groups = [ pinmux-spi1-pins ]

To activate function pinmux-i2c1 and group pinmux-i2c1-pins:

echo "pinmux-i2c1 pinmux-i2c1-pins" > pinmux-select

Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 drivers/pinctrl/pinmux.c | 107 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index c651b2db0925..23fa32f0a067 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -673,6 +673,111 @@ void pinmux_show_setting(struct seq_file *s,
 DEFINE_SHOW_ATTRIBUTE(pinmux_functions);
 DEFINE_SHOW_ATTRIBUTE(pinmux_pins);
 
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
+	buf = kzalloc(PINMUX_MAX_NAME * 2, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	fname = kzalloc(PINMUX_MAX_NAME, GFP_KERNEL);
+	if (!fname) {
+		ret = -ENOMEM;
+		goto free_buf;
+	}
+
+	gname = kzalloc(PINMUX_MAX_NAME, GFP_KERNEL);
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
+
+free_gname:
+	devm_kfree(pctldev->dev, gname);
+free_fname:
+	devm_kfree(pctldev->dev, fname);
+free_buf:
+	devm_kfree(pctldev->dev, buf);
+
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
@@ -680,6 +785,8 @@ void pinmux_init_device_debugfs(struct dentry *devroot,
 			    devroot, pctldev, &pinmux_functions_fops);
 	debugfs_create_file("pinmux-pins", 0444,
 			    devroot, pctldev, &pinmux_pins_fops);
+	debugfs_create_file("pinmux-select", 0200,
+			    devroot, pctldev, &pinmux_select_ops);
 }
 
 #endif /* CONFIG_DEBUG_FS */
-- 
2.25.1

