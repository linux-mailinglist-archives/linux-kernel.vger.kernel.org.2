Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1366D39C1F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFDVLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhFDVLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:11:12 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5778C061789
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 14:09:25 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id f19-20020a056a002393b02902d8b0956281so5893373pfc.19
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P+DRV+1kr28zVJ/U3wDOfdSPd3HkANrRfuFzxqlC4Pc=;
        b=BD3ZmfBd88tZgrK5VWyAdL43R8ifUsR8x6sFdE82nRuDKynYAWDrzE4ViAPmykHBE4
         iyytiZIYdAESIcvzY6xdWybqTUGCNisGZiXWYfKieKbymZmV/yt7zvjY9NFl3juibb/s
         ikEDpwDO3GTB7QBr/5PZz/yTynDJQ+EVyDbqXYxqVspW4jHjr6GfHmb6aePCiI+9M6Vd
         nAWhQ+RRLTv2OXSWhOZSnRNx4+nvq3NfPSSnycc4sLlhRuBgnNb++2d32IlTONdzLlpM
         5aRbbSRXEHIXxwZ6wYXd6/i1swYlGsa4c2M1WAwUuXtMLF2EffxUpGOmrT0pPALk2QKG
         mb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P+DRV+1kr28zVJ/U3wDOfdSPd3HkANrRfuFzxqlC4Pc=;
        b=hiCbzdvihJfw6vVj7xhKiHViadLeEcDX1aPfGCc698ocFl807uARanNS9+ELKff9JN
         unMAewe5p0JDB2U7FotNAzSSSJgvT9B9GLSwDZfG9/RCuhqYdiNpw1/sQD+iF7nAxQjV
         +i94BvTsBVWrESaP1n9Kb3cbkmjqgf4jdhDz6dO1jXCH+Wb/XVZpFYSXAgjln0YoT0JD
         34kjkzh75S3p5KJFFVfMcGkkdKTRgwA/dQeCmWvMAeP+AinwxXw9mUysG9QxdKsOphpq
         CWW3lZ+y35M6duA9Vm174ZXptrTD2rtq/ea/SxeAJ2tH8ZzqL/0qA8Dep/KDSnMdrvMI
         9W6g==
X-Gm-Message-State: AOAM533ytO0k4pcaaLeE2QIp22SX6xUHSEeBzSy4SFguRWPEWRU2TlQl
        An5Jw1UqMRBQ01j1FJEOdBC5Sot/wqw=
X-Google-Smtp-Source: ABdhPJxmL8KM/5Kv0n8tQo795U2DFcdkGRAYUhSqHM6sj42QWQ+C3ACMCn3W2CeCnI48cqnYWj3LpGGCTK0=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a63:1e55:: with SMTP id p21mr6828807pgm.412.1622840965137;
 Fri, 04 Jun 2021 14:09:25 -0700 (PDT)
Date:   Fri,  4 Jun 2021 21:09:07 +0000
In-Reply-To: <20210604210908.2105870-1-satyat@google.com>
Message-Id: <20210604210908.2105870-9-satyat@google.com>
Mime-Version: 1.0
References: <20210604210908.2105870-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v9 8/9] f2fs: support direct I/O with fscrypt using blk-crypto
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

Wire up f2fs with fscrypt direct I/O support. direct I/O with fscrypt is
only supported through blk-crypto (i.e. CONFIG_BLK_INLINE_ENCRYPTION must
have been enabled, the 'inlinecrypt' mount option must have been specified,
and either hardware inline encryption support must be present or
CONFIG_BLK_INLINE_ENCYRPTION_FALLBACK must have been enabled). Further,
direct I/O on encrypted files is only supported when the *length* of the
I/O is aligned to the filesystem block size (which is *not* necessarily the
same as the block device's block size).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c83d90125ebd..a416ea3a1a04 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4181,7 +4181,11 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int rw = iov_iter_rw(iter);
 
-	if (f2fs_post_read_required(inode))
+	if (!fscrypt_dio_supported(iocb, iter))
+		return true;
+	if (fsverity_active(inode))
+		return true;
+	if (f2fs_compressed_file(inode))
 		return true;
 	if (f2fs_is_multi_device(sbi))
 		return true;
-- 
2.32.0.rc1.229.g3e70b5a671-goog

