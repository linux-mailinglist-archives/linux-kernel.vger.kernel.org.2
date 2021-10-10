Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A034283CA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 23:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhJJVeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 17:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233097AbhJJVeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 17:34:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A14C60F23;
        Sun, 10 Oct 2021 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633901525;
        bh=npnSU4nb33fksWbkboptClZqb5ckMMSYa0HSCr/9huI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVwHcDz+zpa+qmVOZOLTbMQO0SxIZ5TqzekqxEc3xa2s8bLa4l945wmqDjknHWQoc
         qoqe5Cj20tzeECtjxQN7aEAUUgVQLFmA9+5S+V6q0/Hckuox16k6BvCH7vrwip1Cge
         U6OBmlD9pJbMq+X8RYnWGMB4UsNZG6mtGslP0JQtWCultrW/vXGyMXaADsXP3F3/pZ
         mS7HJD1SIWwC8yyQebyPMfyMADKG3nV7k0dEiDCLGfig65fkyb+x6++IgqzsXsy7Vn
         N00VB6y+1dbtkEsWbrnb2Iq5ZiJd+MT7lx7JyUWnx9A/TYP40I/2IhIKGrDnP4o+fO
         Cp9t7HrAYjVvw==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Lasse Collin <lasse.collin@tukaani.org>, Chao Yu <chao@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/7] lib/xz: Avoid overlapping memcpy() with invalid input with in-place decompression
Date:   Mon, 11 Oct 2021 05:31:39 +0800
Message-Id: <20211010213145.17462-2-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010213145.17462-1-xiang@kernel.org>
References: <20211010213145.17462-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lasse Collin <lasse.collin@tukaani.org>

With valid files, the safety margin described in lib/decompress_unxz.c
ensures that these buffers cannot overlap. But if the uncompressed size
of the input is larger than the caller thought, which is possible when
the input file is invalid/corrupt, the buffers can overlap. Obviously
the result will then be garbage (and usually the decoder will return
an error too) but no other harm will happen when such an over-run occurs.

This change only affects uncompressed LZMA2 chunks and so this
should have no effect on performance.

Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/decompress_unxz.c |  2 +-
 lib/xz/xz_dec_lzma2.c | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index a2f38e23004a..f7a3dc13316a 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -167,7 +167,7 @@
  * memeq and memzero are not used much and any remotely sane implementation
  * is fast enough. memcpy/memmove speed matters in multi-call mode, but
  * the kernel image is decompressed in single-call mode, in which only
- * memcpy speed can matter and only if there is a lot of uncompressible data
+ * memmove speed can matter and only if there is a lot of uncompressible data
  * (LZMA2 stores uncompressible chunks in uncompressed form). Thus, the
  * functions below should just be kept small; it's probably not worth
  * optimizing for speed.
diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index 7a6781e3f47b..d548cf0e59fe 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -387,7 +387,14 @@ static void dict_uncompressed(struct dictionary *dict, struct xz_buf *b,
 
 		*left -= copy_size;
 
-		memcpy(dict->buf + dict->pos, b->in + b->in_pos, copy_size);
+		/*
+		 * If doing in-place decompression in single-call mode and the
+		 * uncompressed size of the file is larger than the caller
+		 * thought (i.e. it is invalid input!), the buffers below may
+		 * overlap and cause undefined behavior with memcpy().
+		 * With valid inputs memcpy() would be fine here.
+		 */
+		memmove(dict->buf + dict->pos, b->in + b->in_pos, copy_size);
 		dict->pos += copy_size;
 
 		if (dict->full < dict->pos)
@@ -397,7 +404,11 @@ static void dict_uncompressed(struct dictionary *dict, struct xz_buf *b,
 			if (dict->pos == dict->end)
 				dict->pos = 0;
 
-			memcpy(b->out + b->out_pos, b->in + b->in_pos,
+			/*
+			 * Like above but for multi-call mode: use memmove()
+			 * to avoid undefined behavior with invalid input.
+			 */
+			memmove(b->out + b->out_pos, b->in + b->in_pos,
 					copy_size);
 		}
 
@@ -421,6 +432,12 @@ static uint32_t dict_flush(struct dictionary *dict, struct xz_buf *b)
 		if (dict->pos == dict->end)
 			dict->pos = 0;
 
+		/*
+		 * These buffers cannot overlap even if doing in-place
+		 * decompression because in multi-call mode dict->buf
+		 * has been allocated by us in this file; it's not
+		 * provided by the caller like in single-call mode.
+		 */
 		memcpy(b->out + b->out_pos, dict->buf + dict->start,
 				copy_size);
 	}
-- 
2.20.1

