Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E7441112C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhITIpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:45:54 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39905 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230053AbhITIpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:45:52 -0400
Received: from localhost.localdomain (ip5f5aef72.dynamic.kabel-deutschland.de [95.90.239.114])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3FBA161E5FE33;
        Mon, 20 Sep 2021 10:44:25 +0200 (CEST)
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
Subject: [PATCH v3] lib/zlib_inflate/inffast: Check config in C to avoid unused function warning
Date:   Mon, 20 Sep 2021 10:43:33 +0200
Message-Id: <20210920084332.5752-1-pmenzel@molgen.mpg.de>
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
v2: Use IS_ENABLED
v3: Use if statement over ternary operator as requested by Christophe

 lib/zlib_inflate/inffast.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
index f19c4fbe1be7..2843f9bb42ac 100644
--- a/lib/zlib_inflate/inffast.c
+++ b/lib/zlib_inflate/inffast.c
@@ -253,13 +253,12 @@ void inflate_fast(z_streamp strm, unsigned start)
 
 			sfrom = (unsigned short *)(from);
 			loops = len >> 1;
-			do
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-			    *sout++ = *sfrom++;
-#else
-			    *sout++ = get_unaligned16(sfrom++);
-#endif
-			while (--loops);
+			do {
+			    if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
+				*sout++ = *sfrom++;
+			    else
+				*sout++ = get_unaligned16(sfrom++);
+			} while (--loops);
 			out = (unsigned char *)sout;
 			from = (unsigned char *)sfrom;
 		    } else { /* dist == 1 or dist == 2 */
-- 
2.33.0

