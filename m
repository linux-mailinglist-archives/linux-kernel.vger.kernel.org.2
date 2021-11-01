Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549BA441961
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhKAKHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhKAKGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:06:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761CDC046387
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 02:38:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso999979pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 02:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6yohF2CSWjC3LsvVI22Z8PlivnfwVBj5ZtiMUVaGtY=;
        b=mzuvMX+4chqMVT0iYc+IhCfBAqatIym+HQ1bjJlyTR6q4qhAXhWl2wBw+jgE+KB7zQ
         cOuHGsAkMIabUSMjfGoRteLsWroEQRZx6958z1jWSGFf6Ltl+jwZHQ5aNX4HlqoNLslo
         FSoQgmzp3/wfn4CP/DUlh09YOY2TSyNVanfhkjL927OnkgIv1QwpBGGezEzLzV5PC5EW
         VRz5pBfiSBDBTUHzVsY5zswUXubDoW8EQcJgOtZGZOOw4a+0qdIVjwbMZ/SIfu7NIEqv
         zjA7kQmPvGh+TWf+Fmoe3XQ0+ZFhFGwlRmU559PdXX6pzbRf235XjPOaGBxL//8B/wIc
         2ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6yohF2CSWjC3LsvVI22Z8PlivnfwVBj5ZtiMUVaGtY=;
        b=UC36SnNx3zgbKhJitphyKYwlDs2sU3Bskt9EeRV+GoRN/U+6oP3z35Nzula7VTphMi
         zMqVipYqJTsnbwbrZy0JOWG58PY7aq0X/AMO/2UV87eVikkjMYpTtw4zbPM5b7a/hkeu
         iMH6g8C1ymd1LTwqaOS4h1pQk8iecU3tTJ+ExXveuTwDsp70p42RaTnYRHqkZAG3jVeW
         AnVic1w0v8V7/s9yxS9V7TQJ/u7u7d1id01vrxPhHEbqdTk48ZXxCN0jja2d9o7Ia3wi
         9AF/TQQ6QhzBpS3nMDv0TLpbgR0iE5/TG5B73eML/TPNzfKG4d6m8DqNMLi0+j1cedHu
         wl4Q==
X-Gm-Message-State: AOAM533ZneBdE7wIYiP3gzJeUMlNtJZxCYd8VuBtCTgDsvBespWN7AZ9
        yY1rt0oe5VJW7Zt3RnJF9xH2iw==
X-Google-Smtp-Source: ABdhPJwn5N0tQoKNKwyBnrs3GBXI5qSniHBxGzqSUvkTmDtkXbSjuDos5b4Uq5S6uORQYX54zbRtew==
X-Received: by 2002:a17:90a:49:: with SMTP id 9mr36945036pjb.80.1635759494060;
        Mon, 01 Nov 2021 02:38:14 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id p16sm15738259pfh.97.2021.11.01.02.38.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 02:38:13 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        gladkov.alexey@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/4] fs: proc: use DEFINE_PROC_SHOW_ATTRIBUTE() to simplify the code
Date:   Mon,  1 Nov 2021 17:35:18 +0800
Message-Id: <20211101093518.86845-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211101093518.86845-1-songmuchun@bytedance.com>
References: <20211101093518.86845-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEFINE_PROC_SHOW_ATTRIBUTE() can be used here to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/cifs/cifs_debug.c | 17 ++---------------
 fs/nfsd/stats.c      | 15 ++-------------
 net/sunrpc/stats.c   | 15 ++-------------
 3 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index de2c12bcfa4b..52afe68dc7d0 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -1002,7 +1002,7 @@ static const struct proc_ops cifs_security_flags_proc_ops = {
 };
 
 /* To make it easier to debug, can help to show mount params */
-static int cifs_mount_params_proc_show(struct seq_file *m, void *v)
+static int cifs_mount_params_show(struct seq_file *m, void *v)
 {
 	const struct fs_parameter_spec *p;
 	const char *type;
@@ -1030,20 +1030,7 @@ static int cifs_mount_params_proc_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-
-static int cifs_mount_params_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, cifs_mount_params_proc_show, NULL);
-}
-
-static const struct proc_ops cifs_mount_params_proc_ops = {
-	.proc_open	= cifs_mount_params_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
-	/* No need for write for now */
-	/* .proc_write	= cifs_mount_params_proc_write, */
-};
+DEFINE_PROC_SHOW_ATTRIBUTE(cifs_mount_params);
 
 #else
 inline void cifs_proc_init(void)
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 1d3b881e7382..47af3e7bfe9a 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -32,7 +32,7 @@ struct svc_stat		nfsd_svcstats = {
 	.program	= &nfsd_program,
 };
 
-static int nfsd_proc_show(struct seq_file *seq, void *v)
+static int nfsd_show(struct seq_file *seq, void *v)
 {
 	int i;
 
@@ -71,18 +71,7 @@ static int nfsd_proc_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-static int nfsd_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nfsd_proc_show, NULL);
-}
-
-static const struct proc_ops nfsd_proc_ops = {
-	.proc_open	= nfsd_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
-};
+DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
 int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
 {
diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 3d1c4f9a5191..110bbc260933 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -34,7 +34,7 @@
 /*
  * Get RPC client stats
  */
-static int rpc_proc_show(struct seq_file *seq, void *v) {
+static int rpc_show(struct seq_file *seq, void *v) {
 	const struct rpc_stat	*statp = seq->private;
 	const struct rpc_program *prog = statp->program;
 	unsigned int i, j;
@@ -63,18 +63,7 @@ static int rpc_proc_show(struct seq_file *seq, void *v) {
 	}
 	return 0;
 }
-
-static int rpc_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rpc_proc_show, inode->i_private);
-}
-
-static const struct proc_ops rpc_proc_ops = {
-	.proc_open	= rpc_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
-};
+DEFINE_PROC_SHOW_ATTRIBUTE(rpc);
 
 /*
  * Get RPC server stats
-- 
2.11.0

