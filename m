Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BA23BEC98
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhGGQxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhGGQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:53:35 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E98C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 09:50:54 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s5-20020aa78d450000b02902ace63a7e93so1919443pfe.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mDncmzLGteyPekcgzGwrNHHfMFLg/jutBeeWKGXX5js=;
        b=oWvob/cudwepk3+0arpOzuwpuOl7y7/Cwn3yeUIUhviDXyy3ELCDMKL6GciEA6KbAB
         qzzc4MUCUdYuQULE+1HJI7iXox7J9HKzTt+R5mpnuDjQl9D/EyaF8ymvT8xSA4Hks/0u
         VNibIWxLxz4jPTjL26KXT7cPgSIuzUKkBEFnmFE3Mdw6HJRf1Se2TtewEqfr9tGPIoHp
         GYTWWc4urqUqaie5ZQeiiBcO5ywbx3zz80GHFHcGgTZ5ggb5ZobX7sSaU1DnwPFmRBwc
         5hzx3JaZg3UpwxWUw0eiOVkSHRDFW2zF+mneNqot8Sx0RQWI5VMsvPo77KhD8DaL2aVr
         vjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mDncmzLGteyPekcgzGwrNHHfMFLg/jutBeeWKGXX5js=;
        b=CHxjIwK/CMyFFcOAlVPVbXJM/OxyYXK3CWKlZ9Vc69rQmzdqWPTZtJtRCzIxosMgby
         KWc27rQ4id0+3jG0CvpCPUh8KZawrWVXxoLB1zAbuw++mp9xrUqTjAIe7YH2J2urq6TN
         uEgFpn5Bl0J/oiizQTwF4nZyqYt+Dgsg+TmzpqqMnayuLaWC02UBq+imjdkPySiye6mP
         uA7t+bBgohl4YhjKCa0eBBJ+HK4kfWtFcfYoJZwglyWhFIDAE0jr771zImZveF4gZD13
         7isUZyLPk0HFecf4+sOQL3IJSSf1ELfkpjGYu/h8msaCAwGNpJz/9BtDhzlBXAndbhuH
         HnKQ==
X-Gm-Message-State: AOAM533RStsWrsKVMKzUPDwrisfcTCaxVOReBXWUZ+Y7De6uooWnWVyl
        6H6eFPoH48vwxALRzZKiEoKJmOdpSAJhMw==
X-Google-Smtp-Source: ABdhPJxXcRjS1V2NMcW7S3JYOAGGh0CTsus8BeF6UjvhTDX7Az6NbMK+TIfiXlu5Ldj0EWP5O667VCvqM8NKmQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:b1])
 (user=cmllamas job=sendgmr) by 2002:aa7:9517:0:b029:314:1313:227 with SMTP id
 b23-20020aa795170000b029031413130227mr26415260pfp.47.1625676654233; Wed, 07
 Jul 2021 09:50:54 -0700 (PDT)
Date:   Wed,  7 Jul 2021 16:24:19 +0000
Message-Id: <20210707162419.15510-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] ANDROID: binderfs: add capabilities support
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Moreland <smoreland@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide userspace with a mechanism to discover binder driver
capabilities to refrain from using these unsupported features
in the first place. Note that older capabilities are assumed
to be supported and only new ones will be added.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binderfs.c | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index e80ba93c62a9..f793887f6dc8 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -58,6 +58,10 @@ enum binderfs_stats_mode {
 	binderfs_stats_mode_global,
 };
 
+struct binder_capabilities {
+	bool oneway_spam;
+};
+
 static const struct constant_table binderfs_param_stats[] = {
 	{ "global", binderfs_stats_mode_global },
 	{}
@@ -69,6 +73,10 @@ static const struct fs_parameter_spec binderfs_fs_parameters[] = {
 	{}
 };
 
+static struct binder_capabilities binder_caps = {
+	.oneway_spam = true,
+};
+
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
 {
 	return sb->s_fs_info;
@@ -583,6 +591,39 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
 	return dentry;
 }
 
+static int binder_caps_show(struct seq_file *m, void *unused)
+{
+	bool *cap = m->private;
+
+	seq_printf(m, "%d\n", *cap);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(binder_caps);
+
+static int init_binder_caps(struct super_block *sb)
+{
+	struct dentry *dentry, *root;
+	int ret = 0;
+
+	root = binderfs_create_dir(sb->s_root, "caps");
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
+		goto out;
+	}
+
+	dentry = binderfs_create_file(root, "oneway_spam",
+				      &binder_caps_fops,
+				      &binder_caps.oneway_spam);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
 static int init_binder_logs(struct super_block *sb)
 {
 	struct dentry *binder_logs_root_dir, *dentry, *proc_log_dir;
@@ -723,6 +764,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			name++;
 	}
 
+	ret = init_binder_caps(sb);
+	if (ret)
+		return ret;
+
 	if (info->mount_opts.stats_mode == binderfs_stats_mode_global)
 		return init_binder_logs(sb);
 
-- 
2.32.0.93.g670b81a890-goog

