Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C685F31125D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBESli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:41:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43358 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhBESkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:40:22 -0500
Received: from mail-oo1-f69.google.com ([209.85.161.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1l87cA-0006NN-Gn
        for linux-kernel@vger.kernel.org; Fri, 05 Feb 2021 20:22:02 +0000
Received: by mail-oo1-f69.google.com with SMTP id r17so4217989ooq.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 12:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0bw6oVJwOT2t9qNI5fK7SsA/zUrGWqj0vb55juGkY3Q=;
        b=T8qvT4ekU+f+hbhcX8cW+F0qJ18uyEfwUWgikmsTWXIJdq7TrYM9I94GnLkLJnAzFT
         AGwUO6Fs5L10LxSzzAlUq1GyRicNV5XrimY+Y03lDxTJV2dq2fwQi8Cgav1SXFgCAOOT
         AbTFuww5tvrELikZ8aiTvDeNkBg69y9voZqy9IQAUyi0KFppE4ogwtWsV3W6eKlQm53z
         5fKHdGvhW2kusjNOfZ4Yo7DW02vB7mBudncFty+XonvHu/KGWt8aDLlU4X+eGvDA8wUn
         GPDQUlo39zkvsM3o7tRazEYuO5VfjS/ATZlWogTigjPTCbNTCOP8jZZdj1XO/sqgIavc
         0dMA==
X-Gm-Message-State: AOAM531WJ5NjHKefSrTbmhDIQIfUn72L/u/rFxGh18hUqQNOJzfBv610
        aYgtgoeFSoqbltTpHgAwR5f50RtYCuQ27MlfAsRMA/d+yxa3YFLGx+RlIMlwsc+T23aJ7lOjttg
        4epWtjFSs/xO/c3Af8is221xUoXIgeeijeEjBFyd1Lw==
X-Received: by 2002:a9d:4e8d:: with SMTP id v13mr4872233otk.12.1612556521520;
        Fri, 05 Feb 2021 12:22:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeRYO0Gii1AiiU6vwb6xkD5hVvY7rrtIc7AlQKKKr/BBUQ9P2nvMQroMv9GQCIOuiVz/HXyw==
X-Received: by 2002:a9d:4e8d:: with SMTP id v13mr4872214otk.12.1612556521299;
        Fri, 05 Feb 2021 12:22:01 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:2b7:eb67:ff8d:8b15])
        by smtp.gmail.com with ESMTPSA id y24sm2018025oos.44.2021.02.05.12.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 12:22:00 -0800 (PST)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Down <chris@chrisdown.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs: Don't use 64-bit inodes by defulat with 32-bit ino_t
Date:   Fri,  5 Feb 2021 14:21:59 -0600
Message-Id: <20210205202159.505612-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there seems to be an assumption in tmpfs that 64-bit
architectures also have a 64-bit ino_t. This is not true; s390 at
least has a 32-bit ino_t. With CONFIG_TMPFS_INODE64=y tmpfs
mounts will get 64-bit inode numbers and display "inode64" in the
mount options, but passing the "inode64" mount option will fail.
This leads to the following behavior:

 # mkdir mnt
 # mount -t tmpfs nodev mnt
 # mount -o remount,rw mnt
 mount: /home/ubuntu/mnt: mount point not mounted or bad option.

As mount sees "inode64" in the mount options and thus passes it
in the options for the remount.

Ideally CONFIG_TMPFS_INODE64 would depend on sizeof(ino_t) < 8,
but I don't think it's possible to test for this (potentially
CONFIG_ARCH_HAS_64BIT_INO_T or similar could be added, but I'm
not sure whether or not that is wanted). So fix this by simply
refusing to honor the CONFIG_TMPFS_INODE64 setting when
sizeof(ino_t) < 8.

Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7c6b6d8f6c39..efde42acdc7a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3733,7 +3733,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 			ctx->blocks = shmem_default_max_blocks();
 		if (!(ctx->seen & SHMEM_SEEN_INODES))
 			ctx->inodes = shmem_default_max_inodes();
-		if (!(ctx->seen & SHMEM_SEEN_INUMS))
+		if (!(ctx->seen & SHMEM_SEEN_INUMS) && sizeof(ino_t) >= 8)
 			ctx->full_inums = IS_ENABLED(CONFIG_TMPFS_INODE64);
 	} else {
 		sb->s_flags |= SB_NOUSER;
-- 
2.29.2

