Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E035734563A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhCWD07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCWD0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:26:38 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA42C061765;
        Mon, 22 Mar 2021 20:26:37 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F4GxR6y4kz9sWC; Tue, 23 Mar 2021 14:26:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1616469995;
        bh=oCVP83reXY5CqSeSdxhQL70bGsRVlM/e497ho1J4FF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=evWkzPLotTXfeJJL/8pnTrk8j8+qXOmddh2ne8LPYkfGrMGwSlUXdULaaK/PVBVcx
         CYrmvJ9fcvJ/hPoJcEU4qBaEznNIAPRwkLfVlfBujIXY4Pwck8bJ3mcK+r3TRFxRYY
         8wndNrheP07HpfMNnudVOD+F91Q2DbrZUPS28byCGw/PjLRPThqzXCLELjn9rx4umD
         rrPlmwqrJLSIfenfHGnqrxbXlz7Kg1CO9gXFa1dfX1f/TuqnBXYfn1iyEnfS4YCfTk
         gkEN5Jqh9yk0outp6JXC/6gIV41Mmv04OXXlAfknXnnZVt3Wt/pKm77G/Hc6QohybM
         /HeMcQz0LlD9Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     rust-for-linux@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] rust: Enable for ppc64le
Date:   Tue, 23 Mar 2021 14:26:24 +1100
Message-Id: <20210323032624.1039422-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323032624.1039422-1-mpe@ellerman.id.au>
References: <20210323032624.1039422-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the pieces are in place now for us to enable building rust support
on ppc64le.

Only works with clang for now.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index d73ac9de186d..ddc2fda1a22c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -58,7 +58,7 @@ config LLD_VERSION
 	default 0
 
 config HAS_RUST
-	depends on ARM64 || X86_64
+	depends on ARM64 || X86_64 || (PPC64 && CPU_LITTLE_ENDIAN && CC_IS_CLANG)
 	def_bool $(success,$(RUSTC) --version)
 
 config RUSTC_VERSION
-- 
2.25.1

