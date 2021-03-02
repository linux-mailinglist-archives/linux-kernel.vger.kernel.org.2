Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66ADB32A1CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836251AbhCBG7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 01:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577068AbhCBFlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:41:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B57C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 21:32:11 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id i14so1159232pjz.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 21:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OBtTzri1cScqDnwkEDlkQhcrUhTCJcMkyhXW4hdMGZI=;
        b=jYWUj8OoBTXpu+pMQ4fcdORETfW/Bf/pxOZj7O7/gPDHthH3U+905vAkTuJzu9vK5l
         u/+49Td2YCEo9A2dZODhfbjNE1RY07kueM/NwnbwTed5pst/lgg8MZYpCt9uV5cnBjYa
         uM7YV/DT8Nqc8C2G848hHfdSCRR1oWZ4Nwc+yJXJ3q9Qn5/yJiLO8MqINOS1ixC8UhxG
         Oe7cxGZCXmW2N1dnAXu3AycwBQmLLmWvOFJt7a5SKRwAOCLgv4okupl2ZzmIa2kmti4P
         F8gCnC0SQuptVvpi6t63X9IKyJpbQvakCsnznznFBWn6G6WtAVGTBM02e4Z5ti9vhcnf
         tnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBtTzri1cScqDnwkEDlkQhcrUhTCJcMkyhXW4hdMGZI=;
        b=FejZeZEds32U8t+EKK86YiwWcRjGgtC8V2tyW86OE1y2aybbDSfxqdhL41k/03rJpg
         h29Ntewdyjhg558h3Mq0fK2vnBf7rGQj2Mslw4iv8GYybpwMs6V2eovHlGefPeH6/4Z2
         MHoDpgzhyTjbcJVu8Mbn+Hm7AurLlLIeWYOX0Ac+g602yFerJ+SNOKBzTkQD62nEr3Gm
         5NdiDavL1up8lfPUPY6bFNTMrIlfWAeCWXEw9kbiZGYVmtKZ8qqBuc4E2kEgzFYOqaSE
         xRafKRQpicIVY5l8cu+0Wm2RdONa/CLILZWHxpLUlhyPCE+Lltx8cYXPz94+o6NKK3QO
         ZcaQ==
X-Gm-Message-State: AOAM5307CQVcOs/sopoglWRMNK2dLtfrTawmO8w8tuiX0Zf1kunzzeo3
        Y1WHJoOX5nYP1c0OgpTOBxHRBuim1I3Texi+
X-Google-Smtp-Source: ABdhPJxn8nC172YgtSyXX/HMh++2JDs6jjdJS7TaGnM1IMkw+enErGzNIsP7CpSmG9XYKTYoWn1r9Q==
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr2619580pja.228.1614663131101;
        Mon, 01 Mar 2021 21:32:11 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:37ab:7b44:a136:e385])
        by smtp.gmail.com with ESMTPSA id o129sm17929757pgo.27.2021.03.01.21.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 21:32:10 -0800 (PST)
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
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Drew Fustini <drew@beagleboard.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v9 1/4] pinctrl: use to octal permissions for debugfs files
Date:   Mon,  1 Mar 2021 21:30:56 -0800
Message-Id: <20210302053059.1049035-2-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302053059.1049035-1-drew@beagleboard.org>
References: <20210302053059.1049035-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch over pinctrl debugfs files to use octal permissions as they are
preferred over symbolic permissions. Refer to commit f90774e1fd27
("checkpatch: look for symbolic permissions and suggest octal instead").

Note: S_IFREG flag is added to the mode by __debugfs_create_file()
in fs/debugfs/inode.c

Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 drivers/pinctrl/core.c    | 12 ++++++------
 drivers/pinctrl/pinconf.c |  4 ++--
 drivers/pinctrl/pinmux.c  |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 3663d87f51a0..07458742bc0f 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1888,11 +1888,11 @@ static void pinctrl_init_device_debugfs(struct pinctrl_dev *pctldev)
 			dev_name(pctldev->dev));
 		return;
 	}
-	debugfs_create_file("pins", S_IFREG | S_IRUGO,
+	debugfs_create_file("pins", 0444,
 			    device_root, pctldev, &pinctrl_pins_fops);
-	debugfs_create_file("pingroups", S_IFREG | S_IRUGO,
+	debugfs_create_file("pingroups", 0444,
 			    device_root, pctldev, &pinctrl_groups_fops);
-	debugfs_create_file("gpio-ranges", S_IFREG | S_IRUGO,
+	debugfs_create_file("gpio-ranges", 0444,
 			    device_root, pctldev, &pinctrl_gpioranges_fops);
 	if (pctldev->desc->pmxops)
 		pinmux_init_device_debugfs(device_root, pctldev);
@@ -1914,11 +1914,11 @@ static void pinctrl_init_debugfs(void)
 		return;
 	}
 
-	debugfs_create_file("pinctrl-devices", S_IFREG | S_IRUGO,
+	debugfs_create_file("pinctrl-devices", 0444,
 			    debugfs_root, NULL, &pinctrl_devices_fops);
-	debugfs_create_file("pinctrl-maps", S_IFREG | S_IRUGO,
+	debugfs_create_file("pinctrl-maps", 0444,
 			    debugfs_root, NULL, &pinctrl_maps_fops);
-	debugfs_create_file("pinctrl-handles", S_IFREG | S_IRUGO,
+	debugfs_create_file("pinctrl-handles", 0444,
 			    debugfs_root, NULL, &pinctrl_fops);
 }
 
diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index 02c075cc010b..d9d54065472e 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -370,9 +370,9 @@ DEFINE_SHOW_ATTRIBUTE(pinconf_groups);
 void pinconf_init_device_debugfs(struct dentry *devroot,
 			 struct pinctrl_dev *pctldev)
 {
-	debugfs_create_file("pinconf-pins", S_IFREG | S_IRUGO,
+	debugfs_create_file("pinconf-pins", 0444,
 			    devroot, pctldev, &pinconf_pins_fops);
-	debugfs_create_file("pinconf-groups", S_IFREG | S_IRUGO,
+	debugfs_create_file("pinconf-groups", 0444,
 			    devroot, pctldev, &pinconf_groups_fops);
 }
 
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index bab888fe3f8e..c651b2db0925 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -676,9 +676,9 @@ DEFINE_SHOW_ATTRIBUTE(pinmux_pins);
 void pinmux_init_device_debugfs(struct dentry *devroot,
 			 struct pinctrl_dev *pctldev)
 {
-	debugfs_create_file("pinmux-functions", S_IFREG | S_IRUGO,
+	debugfs_create_file("pinmux-functions", 0444,
 			    devroot, pctldev, &pinmux_functions_fops);
-	debugfs_create_file("pinmux-pins", S_IFREG | S_IRUGO,
+	debugfs_create_file("pinmux-pins", 0444,
 			    devroot, pctldev, &pinmux_pins_fops);
 }
 
-- 
2.25.1

