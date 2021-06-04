Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0622539C207
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhFDVMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:12:07 -0400
Received: from mail-qv1-f73.google.com ([209.85.219.73]:35776 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhFDVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:12:05 -0400
Received: by mail-qv1-f73.google.com with SMTP id v7-20020a0ccd870000b0290219d3e21c4eso7597513qvm.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9BcqtLCkYahip03kuRnuf7gXu/E/crKmMbXBSPc/Uvg=;
        b=QW5Kxzl6EXIE5ugNtoOGXViSlNInd8SrlO8Beh/QzLyDbfSyMdTdmYKbRpLpu68sod
         XDCQBa4ui+uU1IuoV4WMm3lNyBElOUbgc7+HQyR9AIl6hQ5XEqQ1V0rji9JD/Nspg6y4
         RakQjBXdNV9KepJ9OqowwQvnDS8Ouo0vJGyEJe47wFSn7tbgQ4Zh3NuuG+9FVTwsZsFd
         ZiYbIprwR+8eyGGwjm98fHgm3bY3Q699yk5zFWUsRxSkon77390wrHMmB8vtjUsLC5af
         9+OCpw8xRk1QegJsOwD64XDcoYUtUYbbiBMJC9RgHShDwlE7+QaapU57T6I+Yt8FYaqR
         h71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9BcqtLCkYahip03kuRnuf7gXu/E/crKmMbXBSPc/Uvg=;
        b=g5xTdHfVCgK/thnWK6y6Wkp1YB913/jjSdMoaJPTZ58NtYw482g4sVkPmUzrpuZAy9
         ZAjVarEKa9w0CaHmbnxDZGvzMKYA/8XeDp/kgGaTfVwGn5MG19wO/QdkolLganmPRLTo
         f6oLoVorYdEa0AHBK8CJ4hN0t3cGPFxc2CcS0S+LZvX6/8D7ka4Rix6aU+1zlyrTzVid
         7dOnbGLtJ+dWKu7xWq38EvR1FZDYFoUKCyDMEuzY1TyybnxGpYCy+pJ+3HMK7fAn6c5R
         1JgLVaGsaEnlo5nwxlc0XvSffk9vpi7LhqrG1Br8n+5x9eQQ2VPFg6gas1dkdQX8b30O
         7JHQ==
X-Gm-Message-State: AOAM531NP+neFi6k80zv4YQMng8pFLFYJ5kbwxof/C5U5UwM+twiFVcq
        PN1/VCEusjfErvbCLtPd6vXDs3MZ2ao=
X-Google-Smtp-Source: ABdhPJxgk02c9+fXdTtbO2iZcSrGJNMdNgq2Ji6Xc1aRp0U/sfalFFR8mjElyDxbEU1XEUxA6IbhvBZxcCk=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a0c:e84b:: with SMTP id l11mr6830971qvo.52.1622840958230;
 Fri, 04 Jun 2021 14:09:18 -0700 (PDT)
Date:   Fri,  4 Jun 2021 21:09:03 +0000
In-Reply-To: <20210604210908.2105870-1-satyat@google.com>
Message-Id: <20210604210908.2105870-5-satyat@google.com>
Mime-Version: 1.0
References: <20210604210908.2105870-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v9 4/9] direct-io: add support for fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Set bio crypt contexts on bios by calling into fscrypt when required,
and explicitly check for DUN continuity when adding pages to the bio.
(While DUN continuity is usually implied by logical block contiguity,
this is not the case when using certain fscrypt IV generation methods
like IV_INO_LBLK_32).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/direct-io.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b2e86e739d7a..328ed7ac0094 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/fs.h>
+#include <linux/fscrypt.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/highmem.h>
@@ -392,6 +393,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	      sector_t first_sector, int nr_vecs)
 {
 	struct bio *bio;
+	struct inode *inode = dio->inode;
 
 	/*
 	 * bio_alloc() is guaranteed to return a bio when allowed to sleep and
@@ -399,6 +401,9 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	 */
 	bio = bio_alloc(GFP_KERNEL, nr_vecs);
 
+	fscrypt_set_bio_crypt_ctx(bio, inode,
+				  sdio->cur_page_fs_offset >> inode->i_blkbits,
+				  GFP_KERNEL);
 	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = first_sector;
 	bio_set_op_attrs(bio, dio->op, dio->op_flags);
@@ -765,9 +770,17 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 		 * current logical offset in the file does not equal what would
 		 * be the next logical offset in the bio, submit the bio we
 		 * have.
+		 *
+		 * When fscrypt inline encryption is used, data unit number
+		 * (DUN) contiguity is also required.  Normally that's implied
+		 * by logical contiguity.  However, certain IV generation
+		 * methods (e.g. IV_INO_LBLK_32) don't guarantee it.  So, we
+		 * must explicitly check fscrypt_mergeable_bio() too.
 		 */
 		if (sdio->final_block_in_bio != sdio->cur_page_block ||
-		    cur_offset != bio_next_offset)
+		    cur_offset != bio_next_offset ||
+		    !fscrypt_mergeable_bio(sdio->bio, dio->inode,
+					   cur_offset >> dio->inode->i_blkbits))
 			dio_bio_submit(dio, sdio);
 	}
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

