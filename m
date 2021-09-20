Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EDB411074
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhITHsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:48:52 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:48275 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229839AbhITHsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:48:51 -0400
Received: from localhost.localdomain (ip5f5aef72.dynamic.kabel-deutschland.de [95.90.239.114])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6ED0F61E5FE00;
        Mon, 20 Sep 2021 09:47:22 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2] lib/zlib_inflate/inffast: Check config in C to avoid unused function warning
Date:   Mon, 20 Sep 2021 09:46:33 +0200
Message-Id: <20210920074633.13089-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building Linux for ppc64le with Ubuntu clang version 12.0.0-3ubuntu1~21.04.1
shows the warning below.

    arch/powerpc/boot/inffast.c:20:1: warning: unused function 'get_unaligned16' [-Wunused-function]
    get_unaligned16(const unsigned short *p)
    ^
    1 warning generated.

Fix it, by moving the check from the preprocessor to C, so the compiler
sees the use.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 lib/zlib_inflate/inffast.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
index f19c4fbe1be7..fb87a3120f0f 100644
--- a/lib/zlib_inflate/inffast.c
+++ b/lib/zlib_inflate/inffast.c
@@ -254,11 +254,8 @@ void inflate_fast(z_streamp strm, unsigned start)
 			sfrom = (unsigned short *)(from);
 			loops = len >> 1;
 			do
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-			    *sout++ = *sfrom++;
-#else
-			    *sout++ = get_unaligned16(sfrom++);
-#endif
+			    *sout++ = IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ?
+				*sfrom++ : get_unaligned16(sfrom++);
 			while (--loops);
 			out = (unsigned char *)sout;
 			from = (unsigned char *)sfrom;
-- 
2.33.0

