Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F160F37BC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhELLw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELLwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:52:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45D1B61353;
        Wed, 12 May 2021 11:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620820277;
        bh=NmRdc9G7JJFHGfkGyc+LaMf36FTOlxulYuSeArk85go=;
        h=From:To:Cc:Subject:Date:From;
        b=JYIBsc2N2gJ1wUihhjHXfwwG8zZHwoI9PXbiNLIu75YrNBP9bNmT4SpwMSXsgBVo8
         cFmYKz0cXt26BGxcR0PDjK0vRU8Tdgpu5ms+qM2Ogj+i2LJnn+DVmlwUkGSc2zFc0L
         Q4itev67yHXmhYz96ObZrbmzh4Eyk90c4oUccruWT19cazA00ElmOIEnLV0lAEArU3
         p0rZHayfCbWOWfRR8rCkTvmfVzk11SgQ2dPvh76WttUf8gu1Fo4EEKhThfkmonRaJ6
         Mw9ust8x4Q70aGu73UtIWzCLyyldxrTVaqgNdJ24uM3R/OZRTq1u90LBUfdqEYcPyQ
         66LP3DMfeNYFg==
From:   Mark Brown <broonie@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] tools/nolibc: Implement msleep()
Date:   Wed, 12 May 2021 12:47:28 +0100
Message-Id: <20210512114728.19015-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=WROh5SBSWd//p/Sxtx1sSZhXRJr/pNHGmfIOZDLA1ME=; m=DsG0GUH5Pq7W2vv4GT6Z0e1qoDZBWwgUNihInvr8Y2M=; p=goBe/H9D7gHdYDF1GUG3qnE1yXlI/9UHpsYgIuToVI8=; g=e63813b3d0cd70e8afa36d09389e65a5b1a1a1ec
X-Patch-Sig: m=pgp; i=broonie@kernel.org; s=0xC3F436CA30F5D8EB; b=iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCbv/UACgkQJNaLcl1Uh9Dqowf9E16 qjowmtU0rxTE+BOWEJw8Z8f7PM+10vRWw2SjtvvGdKZ065pLYlqLNuvqBjPlIZyUxCk6E0nROrTEE hCX64nrkOCTzxZvz7faioL8p4VQeKMcgJh9kwO4xSUQzRECEw4FHGyv5f4/rWq50mT9tpP9ZaPR7q ed9CkcXUpaGT1wpLTqYwzNIWRLRJWYIZF6QrZRTBtDW7fwG2oCGBWG7KZbMDmQsKGKw3fxPZ0H1Vd K+naIj84fdFH6OVPOClIxOwrKq9Wob1MHh5wfQ8LbQGoDHnJX+9OD3ke7f9b5o/XqQeD6IERPrL2p cKxgBkcnbiBTJHvuTLgaT2Bvl+OfKsw==
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow users to implement shorter delays than a full second by implementing
msleep().

Signed-off-by: Mark Brown <broonie@kernel.org>
---

v2:
 - Support delays of more than a second.
 - Return the number of seconds remaining if the delay does not
   complete.

 tools/include/nolibc/nolibc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 8b7a9830dd22..01400d36ce99 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -2243,6 +2243,17 @@ unsigned int sleep(unsigned int seconds)
 		return 0;
 }
 
+static __attribute__((unused))
+int msleep(unsigned int msecs)
+{
+	struct timeval my_timeval = { msecs / 1000, (msecs % 1000) * 1000 };
+
+	if (sys_select(0, 0, 0, 0, &my_timeval) < 0)
+		return my_timeval.tv_sec + !!my_timeval.tv_usec;
+	else
+		return 0;
+}
+
 static __attribute__((unused))
 int stat(const char *path, struct stat *buf)
 {
-- 
2.20.1

