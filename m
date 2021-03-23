Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3077345636
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCWD0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhCWD0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:26:38 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E843BC061763;
        Mon, 22 Mar 2021 20:26:36 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F4GxQ630wz9sW1; Tue, 23 Mar 2021 14:26:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1616469994;
        bh=EFE7LyzDCiEWIHFaedOFWCyrUEJoHI74qld4WEFKn3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/X4a01pBGNQ0E7iGEGTXqBkaFXCLUS1utAGlpBvkKPgXS/3LFCJ/bhAKxQMO8AoT
         etI6y3FipOVcwPKneIm4TwVez8UUfubKkfYjFPPJUPX6/b5kxS+m49bTDXJtYNl6hp
         Jk9I4oWdEiX/AXTVi2xyzitxx1O7tGKf3pjVTPGC6NqDcfmTUQpJov8aJW6sMlamKN
         IU+nrAG55IRfhLsoKvIfkcW3wd2KDoSXzdn7qXeIQn/GbinoB2DVGm5sU9VnHoFO0a
         r83/JyYtnoYU2DoSwgw9i/LF9zxchioclkcsOanRDbmVibg2q4Sia3DgMgFkewaNrM
         x/joZen5exSsg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     rust-for-linux@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] rust: Add powerpc64 as a 64-bit target_arch in c_types.rs
Date:   Tue, 23 Mar 2021 14:26:22 +1100
Message-Id: <20210323032624.1039422-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323032624.1039422-1-mpe@ellerman.id.au>
References: <20210323032624.1039422-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc kernel code uses int-ll64.h.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 rust/kernel/c_types.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/c_types.rs b/rust/kernel/c_types.rs
index 423ac1108ddb..988fd84b0d66 100644
--- a/rust/kernel/c_types.rs
+++ b/rust/kernel/c_types.rs
@@ -60,7 +60,7 @@ mod c {
     pub type c_size_t = usize;
 }
 
-#[cfg(any(target_arch = "aarch64", target_arch = "x86_64"))]
+#[cfg(any(target_arch = "aarch64", target_arch = "x86_64", target_arch = "powerpc64"))]
 mod c {
     /// C `void` type.
     pub type c_void = core::ffi::c_void;
-- 
2.25.1

