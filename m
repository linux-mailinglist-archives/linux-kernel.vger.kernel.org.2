Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7AC41E524
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 01:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350830AbhI3X5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 19:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350480AbhI3X5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 19:57:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDF9C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 16:55:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v17so12633574wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 16:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5BrSuGYueWf6EfrUyyUD6C+VJ4gRKADB8g+IHAwfFGg=;
        b=aqKXppeMugpli8ejwnQ6/HAAv7/Tgkab/3kWMDC9hqyyJjXEaBiA4Adrc4wtKh87CM
         5DWcVYWDBPFL2XJILqSSjLHecQIuyYhgaM8ESb+WTyGQtUmcZH3pXL6pmGqLzzQwypSz
         5XBZj3VwRwHpPjEVfOpV1z2nEcrFMogiBk9mdYvyFVphRvZWIfnX6uxQJeOSl6/CqQb3
         ZguF37TN6VstUBDIsgi4tocYqpnyA8gDa5gC3ymwHuxXVHE8kTxGITaSkFdMmhJRMf+8
         1aAdyGdnWhJ2jsyzDwTGUUfV1B+w9NKcvR7pzMPmVl8rT3WIUGbuJPhoxfD+7QwW5VQ8
         ngsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5BrSuGYueWf6EfrUyyUD6C+VJ4gRKADB8g+IHAwfFGg=;
        b=a/NOKwbOlztBJrf+GqflQ7+AhAJ1rJPfrxrK2S8grssCNMOQXG71dfxcHAarhpamO2
         D2eSbYj1FiqMfUT+OEtTW1toVFrJy4snqoXBjDWLiqeD7cSDEEXqCSkwAHP0tOKaIT0T
         q2p1ZIZI36G92N26nC2L+WFwt1L/JPDlZFLEmxpVVRniv0OTVAhL+x5DGNbWY/OVKfpb
         TFkTs7M2apyAqHZzQI3tPKYRJN1kLhREyOt0/fUjzZan2xdlKaKipTWbldPGjMQjvxG3
         vSb2lSa+krbp9VfspVU1pzADXCk1MGe00uJf2Jpx7ygXPwrOuaGKZE38pRM5zGliuxf2
         PCew==
X-Gm-Message-State: AOAM532QOl2qG143J38NtnNhVaA2ZejuDJJ4m/vvXUvMrHMkqMiYdUK8
        xc5dbDu3WrsorQ8pC9FqI9WhjeLhMU+uVw==
X-Google-Smtp-Source: ABdhPJw01j7WcnhLmp3/4huTZDs72+/5mFipVznMuysmGkpjEJl521nXmUYbcUjQry4flDJzDMq1qw==
X-Received: by 2002:adf:a1d4:: with SMTP id v20mr5352257wrv.168.1633046124310;
        Thu, 30 Sep 2021 16:55:24 -0700 (PDT)
Received: from localhost.localdomain ([197.49.49.194])
        by smtp.googlemail.com with ESMTPSA id r2sm4479114wmq.28.2021.09.30.16.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 16:55:24 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: fix minor indentation and codestyle
Date:   Fri,  1 Oct 2021 01:55:03 +0200
Message-Id: <20210930235503.126033-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warnings found by checkpatch.pl

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 fs/9p/vfs_dir.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index b6a5a0be444d..61b29bad6d9a 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -71,6 +71,7 @@ static inline int dt_type(struct p9_wstat *mistat)
 static struct p9_rdir *v9fs_alloc_rdir_buf(struct file *filp, int buflen)
 {
 	struct p9_fid *fid = filp->private_data;
+
 	if (!fid->rdir)
 		fid->rdir = kzalloc(sizeof(struct p9_rdir) + buflen, GFP_KERNEL);
 	return fid->rdir;
@@ -108,6 +109,7 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 		if (rdir->tail == rdir->head) {
 			struct iov_iter to;
 			int n;
+
 			iov_iter_kvec(&to, READ, &kvec, 1, buflen);
 			n = p9_client_read(file->private_data, ctx->pos, &to,
 					   &err);
@@ -233,5 +235,5 @@ const struct file_operations v9fs_dir_operations_dotl = {
 	.iterate_shared = v9fs_dir_readdir_dotl,
 	.open = v9fs_file_open,
 	.release = v9fs_dir_release,
-        .fsync = v9fs_file_fsync_dotl,
+	.fsync = v9fs_file_fsync_dotl,
 };
-- 
2.25.1

