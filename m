Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6016B34563B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCWD1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhCWD0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:26:38 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820BDC061764;
        Mon, 22 Mar 2021 20:26:37 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F4GxR2gfXz9sW4; Tue, 23 Mar 2021 14:26:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1616469995;
        bh=GgBnlOVa1gpDB3kjVxAHIqLt6CNMfTOeOQdVmnuVbJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVmvizCHuqyRuLLo/WiwPhXby0g4q7HkR/xLhPyPQP/08WIKejYjYrqjQDS4kVdl6
         rjSHfnr3EVw2B7QNt31yduqU0GZ+R9xibo+LxljBGwx3M4A/IyLblK2YL0tAJKi7D+
         G81hs/nK2xs3AvHAn+nay+4pAJDRGEIRtx7xQiH3SaK8RM6JZf3Tocm7wwWJXQpyKH
         DjPOgUt2Dq+agm3Lv1uQKDn5g5R+D/MsgeqmsWaL6nPvJP3cAnM2i6b5rAuFun501h
         KLG0oNiBrE840QRlaKlSTkYm2SpWi0IUtv3c4ekVvED0EK9W9F7tlwJsNo0at+h0oX
         1Nrc4vAOEbXqA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     rust-for-linux@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] powerpc/rust: Add target.json for ppc64le
Date:   Tue, 23 Mar 2021 14:26:23 +1100
Message-Id: <20210323032624.1039422-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323032624.1039422-1-mpe@ellerman.id.au>
References: <20210323032624.1039422-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the x86 and arm64 versions, as well as output from:

  $ rustc +nightly -Z unstable-options --target=powerpc64le-unknown-linux-gnu --print target-spec-json

Notably disables altivec, vsx and hard-float.

The very cryptic data-layout:

  "data-layout": "e-m:e-i64:64-n32:64-S128",

Has the following meaning:

  e:     little endian
  m:e    ELF name mangling
  i64:64 64-bit integers 64-bit aligned
  n32:64 Native integer widths, 32-bit and 64-bit.
  S128   16-byte stack alignment

Those all come from the rustc output, with the exception of the stack
alignment. We obviously do have 8-bit & 16-bit integer types, but I'm
not sure if there's any need to specify that.

ppc64le only for now. We'll eventually need to come up with some way to
change the target.json that's used based on more than just $(ARCH).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/rust/target.json | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 arch/powerpc/rust/target.json

diff --git a/arch/powerpc/rust/target.json b/arch/powerpc/rust/target.json
new file mode 100644
index 000000000000..1e53f8308092
--- /dev/null
+++ b/arch/powerpc/rust/target.json
@@ -0,0 +1,30 @@
+{
+  "arch": "powerpc64",
+  "code-mode": "kernel",
+  "cpu": "ppc64le",
+  "data-layout": "e-m:e-i64:64-n32:64",
+  "env": "gnu",
+  "features": "-altivec,-vsx,-hard-float",
+  "function-sections": false,
+  "is-builtin": true,
+  "linker-flavor": "gcc",
+  "linker-is-gnu": true,
+  "llvm-target": "powerpc64le-elf",
+  "max-atomic-width": 64,
+  "os": "none",
+  "panic-strategy": "abort",
+  "position-independent-executables": true,
+  "pre-link-args": {
+    "gcc": [
+      "-Wl,--as-needed",
+      "-Wl,-z,noexecstack",
+      "-m64"
+    ]
+  },
+  "relocation-model": "static",
+  "relro-level": "full",
+  "target-family": "unix",
+  "target-mcount": "_mcount",
+  "target-endian": "little",
+  "target-pointer-width": "64"
+}
-- 
2.25.1

