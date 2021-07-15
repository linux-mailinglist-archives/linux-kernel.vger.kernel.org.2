Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102883C9669
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 05:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhGODVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 23:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhGODVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:21:07 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D4C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 20:18:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id jx12-20020a17090b46ccb029017365ced08eso4959910pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 20:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ELXiQ/boC/pi2iqX6O1F2ZYnc5Ss3U5Itstg3UP3lpk=;
        b=SKYvVVF/Ba9JnT1E3LD81oH4nf11iM1+mKyAnaCfx5VoWmKsp2YhjEGJ7OSmV7Xfwo
         FVfv3KqrN192AQNDItmJlkqkbwxxsJ7YSULjtzXQqpo4MiA6l7pvBfcEa1Z6Vx29gqQN
         ti+CPJZeK2tnagn6OZEm+lpjlvS8/zK14ZknVaZ4lioetm9AyVMui9gOQnsjQpqQLve+
         1B7GqsmU1j8NGSRF56Xd4a5sKeTB2Xq5MivTncG5AeAm82/tv/MRKl6LrRQmamMh2Vbl
         5k9opJurPPybBuvTv6Er05jFTh6L8UZZS7o7MYg29rpCjtM7lztQ6y/PzQ/IlZ6yI242
         0kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ELXiQ/boC/pi2iqX6O1F2ZYnc5Ss3U5Itstg3UP3lpk=;
        b=fngQh/EyuX1QsfgG0acplk+l5+rIy80ZclkVn5zvHZtx+I1AK8btJnBluPyewmXIjM
         mZLBiEt7saIaRBv3YaVujiqU9myoXyeYbBZ0UuP0BbCxrr5DssIG77gxclFLUYnsGODc
         3UgCWwgCmdAD+FefaoagFSxaWpqTSXUY0imF/VbFhdDlFhoKDJxZTDEsERPEkxn67ksp
         Aq9abR3IXaPugjURKI8UwYX8tBxEx08yPzNlWz1+SMYybtzquhitc2OO9mECSFuIaeTs
         SeaW7PNVYGexwmLIojbInoW1XPpcystxbKhNoZDOaRu9qsq57AAdaSti7j0IaV3B/kWB
         Gnbg==
X-Gm-Message-State: AOAM532fMRdpRsb+eVE48gBNf8MVh+e6KytE6K90l9sGrcdaUfEO0it6
        k4hwuAfMZCk+XGspVM7mWbv8J0LjoC7ZzQ==
X-Google-Smtp-Source: ABdhPJz4do9FmarH89/SWPvSShDcb+iaO4yQRNRsJJ1XNKOLZR3VTo4tuzDIo55Hp9DESpIBk4omlEn4cgHxoQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:b1])
 (user=cmllamas job=sendgmr) by 2002:a62:1450:0:b029:32b:247e:c4e4 with SMTP
 id 77-20020a6214500000b029032b247ec4e4mr1859309pfu.7.1626319093105; Wed, 14
 Jul 2021 20:18:13 -0700 (PDT)
Date:   Thu, 15 Jul 2021 03:18:03 +0000
In-Reply-To: <20210707162419.15510-1-cmllamas@google.com>
Message-Id: <20210715031805.1725878-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20210707162419.15510-1-cmllamas@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 1/3] binderfs: add support for feature files
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

Provide userspace with a mechanism to discover features supported by
the binder driver to refrain from using any unsupported ones in the
first place. Starting with "oneway_spam_detection" only new features
are to be listed under binderfs and all previous ones are assumed to
be supported.

Assuming an instance of binderfs has been mounted at /dev/binderfs,
binder feature files can be found under /dev/binderfs/features/.
Usage example:

  $ mkdir /dev/binderfs
  $ mount -t binder binder /dev/binderfs
  $ cat /dev/binderfs/features/oneway_spam_detection
  1

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binderfs.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index e80ba93c62a9..e3605cdd4335 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -58,6 +58,10 @@ enum binderfs_stats_mode {
 	binderfs_stats_mode_global,
 };
 
+struct binder_features {
+	bool oneway_spam_detection;
+};
+
 static const struct constant_table binderfs_param_stats[] = {
 	{ "global", binderfs_stats_mode_global },
 	{}
@@ -69,6 +73,10 @@ static const struct fs_parameter_spec binderfs_fs_parameters[] = {
 	{}
 };
 
+static struct binder_features binder_features = {
+	.oneway_spam_detection = true,
+};
+
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
 {
 	return sb->s_fs_info;
@@ -583,6 +591,33 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
 	return dentry;
 }
 
+static int binder_features_show(struct seq_file *m, void *unused)
+{
+	bool *feature = m->private;
+
+	seq_printf(m, "%d\n", *feature);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(binder_features);
+
+static int init_binder_features(struct super_block *sb)
+{
+	struct dentry *dentry, *dir;
+
+	dir = binderfs_create_dir(sb->s_root, "features");
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	dentry = binderfs_create_file(dir, "oneway_spam_detection",
+				      &binder_features_fops,
+				      &binder_features.oneway_spam_detection);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	return 0;
+}
+
 static int init_binder_logs(struct super_block *sb)
 {
 	struct dentry *binder_logs_root_dir, *dentry, *proc_log_dir;
@@ -723,6 +758,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			name++;
 	}
 
+	ret = init_binder_features(sb);
+	if (ret)
+		return ret;
+
 	if (info->mount_opts.stats_mode == binderfs_stats_mode_global)
 		return init_binder_logs(sb);
 
-- 
2.32.0.93.g670b81a890-goog

