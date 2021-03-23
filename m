Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93669345639
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhCWD04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhCWD0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:26:38 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64B4C061574;
        Mon, 22 Mar 2021 20:26:36 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F4GxQ2Fdxz9sVt; Tue, 23 Mar 2021 14:26:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1616469994;
        bh=pI3r2Prfzt94X/Go8BVnLJk6iersevs1fjV3F+dAlsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vbg7Kgy5nKoxbRoiK5LmncSHeETXcsRbXXaj5+ZaXVf5z2MAeaATJf2u6+0D+AEde
         tc0RIiwAVBDT9qPA9miYAojJ/cnpDs5JTNxZUagM9uqYUYdbVMFPC754wsZr6t1mN+
         IKTwL+WYim4u9aaBP4CV5jEpfHkFoopKXHLGzHXBSH0Ie9juWEzK+i8dR8RATcZ7NK
         PTSduRN2WpSETdR9D/9fFYjc6MRQ1yLqty+V39RUq/MKoY9yikXa4djkrJSMtQX+BI
         pa7mRhcgxkmOdI2HfB9ol1XtcszjHC5iIo7uLpLHOY/JMc7Zv1iIBDqlAcsGNGYrg5
         sWtFiXxyssNxg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     rust-for-linux@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] rust: Export symbols in initialized data section
Date:   Tue, 23 Mar 2021 14:26:21 +1100
Message-Id: <20210323032624.1039422-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323032624.1039422-1-mpe@ellerman.id.au>
References: <20210323032624.1039422-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On powerpc some symbols end up in the initialized data section, which
means they aren't detected by the logic in cmd_export, leading to errors
such as:

  ERROR: modpost: "_RNvNtCsbDqzXfLQacH_6kernel12module_param15PARAM_OPS_USIZE" [drivers/char/rust_example_4.ko] undefined!

nm represents the "initialized data section" with "D", so also look for
that when exporting symbols.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 rust/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index eb8f12ce1644..4cddae9d4a25 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -73,7 +73,7 @@ $(objtree)/rust/bindings_generated.rs: $(srctree)/rust/kernel/bindings_helper.h
 quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
 	$(NM) -p --defined-only $< \
-		| grep -E ' (T|R) ' | cut -d ' ' -f 3 | grep -E '^(__rust_|_R)' \
+		| grep -E ' (T|R|D) ' | cut -d ' ' -f 3 | grep -E '^(__rust_|_R)' \
 		| xargs -n1 -Isymbol \
 		echo 'EXPORT_SYMBOL$(exports_target_type)(symbol);' > $@
 
-- 
2.25.1

