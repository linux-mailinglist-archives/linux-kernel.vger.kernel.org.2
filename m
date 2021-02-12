Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C931A7FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 23:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhBLWpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhBLWda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:33:30 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442FEC06178A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 14:30:27 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r38so542935pgk.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 14:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kRQyzW+k1IRH4R+HarppwyyaLUjMFuIFVi6ARjRjxtA=;
        b=d1vhf4eVeouPnG88sIroW/z7jNiI7TBPiaEhLZb1xHEh1WBWoTfAcVjeEicdBj0/3w
         AvvaTHfcq1IT4zb/eD5gKooPpDWfaJW4UzHPmo3YGxoRwOYOPzeY0q9TAoBKcqkWCCRZ
         cIMUmDZlLz4PKZpxCBinDBl0VQUPt0QeCYscJijLwbPaTNTN+fnG+w0kP+HYeA638TWm
         MNH3JVfQyQ28+uN9FitZsaXDbFomPIPnMmLRAeUnIOTVWrUFsFNOKHJT28QpsVI/WzTp
         YMBGSX3Sz4x+XCuvRiTSbNkl/ayu06HAOcugCwhu4LngpLAQU0jRC/3SzcjoNAqC89q1
         Qwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kRQyzW+k1IRH4R+HarppwyyaLUjMFuIFVi6ARjRjxtA=;
        b=U8UDX1Hm+/nS1lKh/Oy6/LSgX/5h1DFUYZgjtWPMiNpWQvLpSKK7nOdgIcxzSDvfPd
         52tUBwgrqRoI0wo/b3J8jG/sn2hRc09gHuWd4WDpBzrK6paFmtIbsjv05tmbXEByLoOk
         M6qCWOUZrYxTecZogleiVxLlIdi9aH8udnDFrqRi1EEzJX6RqYAPlCYfLf/5W9+nhO3U
         oz2sHfQ5kSXDAoVBFDn+HwMsFY1n/lcwn8AcN1mSll7r9JRd4rgyd7M7bS4opbNoITfc
         KoKWTnVO30m0nqDa35d5sa6GrpvsOsSsn76hSWnbXMmvDQO7zt7I3X3oyXz3p/Ewclg/
         uRxw==
X-Gm-Message-State: AOAM530ufLrUc3Nd1p5ebzC2YsJdLk9ytXxfc+RsAp6DhjSLGnTRNmJA
        MyQa4rYTWXsWOnrrm8HwRPgyLg==
X-Google-Smtp-Source: ABdhPJyXHL8XNU0IidIP8aBSb0OBcIjWH1cL5U41FYVG/feor/z/OUWFX8yf4Mx3x09DuPtfwxC61Q==
X-Received: by 2002:a63:515e:: with SMTP id r30mr5257278pgl.253.1613169026821;
        Fri, 12 Feb 2021 14:30:26 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:55c2:10c0:c1dd:8558])
        by smtp.gmail.com with ESMTPSA id j26sm9530351pfa.35.2021.02.12.14.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 14:30:26 -0800 (PST)
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
Subject: [PATCH v5 2/2] pinctrl: pinmux: Add pinmux-select debugfs file
Date:   Fri, 12 Feb 2021 14:30:15 -0800
Message-Id: <20210212223015.727608-3-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210212223015.727608-1-drew@beagleboard.org>
References: <20210212223015.727608-1-drew@beagleboard.org>
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
 drivers/pinctrl/pinmux.c | 99 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index c651b2db0925..c16a6167ac3a 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -673,6 +673,103 @@ void pinmux_show_setting(struct seq_file *s,
 DEFINE_SHOW_ATTRIBUTE(pinmux_functions);
 DEFINE_SHOW_ATTRIBUTE(pinmux_pins);
 
+#define PINMUX_SELECT_MAX 128
+static ssize_t pinmux_select(struct file *file, const char __user *user_buf,
+				   size_t len, loff_t *ppos)
+{
+	const char *usage =
+		"usage: echo '<function-name> <group-name>' > pinmux-select";
+	struct seq_file *sfile = file->private_data;
+	struct pinctrl_dev *pctldev = sfile->private;
+	const struct pinmux_ops *pmxops = pctldev->desc->pmxops;
+	const char *const *groups;
+	char *buf, *fname, *gname;
+	unsigned int num_groups;
+	int fsel, gsel, ret;
+
+	if (len > PINMUX_SELECT_MAX) {
+		dev_err(pctldev->dev, "write too big for buffer");
+		return -EINVAL;
+	}
+
+	buf = kzalloc(PINMUX_SELECT_MAX, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = strncpy_from_user(buf, user_buf, PINMUX_SELECT_MAX);
+	if (ret < 0) {
+		dev_err(pctldev->dev, "failed to copy buffer from userspace");
+		goto free_buf;
+	}
+	buf[len-1] = '\0';
+
+	fname = strstrip(buf);
+	if (*fname == '\0') {
+		dev_err(pctldev->dev, usage);
+		ret = -EINVAL;
+		goto free_buf;
+	}
+
+	gname = strchr(fname, ' ');
+	if (!gname) {
+		dev_err(pctldev->dev, usage);
+		ret = -EINVAL;
+		goto free_buf;
+	}
+	*gname++ = '\0';
+
+	fsel = pinmux_func_name_to_selector(pctldev, fname);
+	if (fsel < 0) {
+		dev_err(pctldev->dev, "invalid function %s in map table\n", fname);
+		ret = fsel;
+		goto free_buf;
+	}
+
+	ret = pmxops->get_function_groups(pctldev, fsel, &groups, &num_groups);
+	if (ret) {
+		dev_err(pctldev->dev, "no groups for function %d (%s)", fsel, fname);
+		goto free_buf;
+	}
+
+	ret = match_string(groups, num_groups, gname);
+	if (ret < 0) {
+		dev_err(pctldev->dev, "invalid group %s", gname);
+		goto free_buf;
+	}
+
+	gsel = pinctrl_get_group_selector(pctldev, gname);
+	if (gsel < 0) {
+		dev_err(pctldev->dev, "failed to get group selector for %s", gname);
+		ret = gsel;
+		goto free_buf;
+	}
+
+	ret = pmxops->set_mux(pctldev, fsel, gsel);
+	if (ret) {
+		dev_err(pctldev->dev, "set_mux() failed: %d", ret);
+		goto free_buf;
+	}
+	ret = len;
+
+free_buf:
+	kfree(buf);
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
+	.write = pinmux_select,
+	.llseek = no_llseek,
+	.release = single_release,
+};
+
 void pinmux_init_device_debugfs(struct dentry *devroot,
 			 struct pinctrl_dev *pctldev)
 {
@@ -680,6 +777,8 @@ void pinmux_init_device_debugfs(struct dentry *devroot,
 			    devroot, pctldev, &pinmux_functions_fops);
 	debugfs_create_file("pinmux-pins", 0444,
 			    devroot, pctldev, &pinmux_pins_fops);
+	debugfs_create_file("pinmux-select", 0200,
+			    devroot, pctldev, &pinmux_select_ops);
 }
 
 #endif /* CONFIG_DEBUG_FS */
-- 
2.25.1

