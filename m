Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35FC306761
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhA0W7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232220AbhA0W4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:56:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE60B64DD7;
        Wed, 27 Jan 2021 22:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611787564;
        bh=uROissysf+CU6pZjzSRwu08EBosF7bzlGdIMuNFG3zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOQIW5BS1ZFMSzOuJ9u+9XhodGwsSr5aV8xy1886Ou4+dKQzm5cisXenswjogpF30
         jJUQM1o28F4IPO9y8MMxxovXTcOmucI4uoxm1XOvWYtaf+2NSupdtKT9llqm9Mtlnt
         cXrtGy2xjs5dc8dqWgNBzSu+xfOKiwXuZvkaKpckUb6FFLOHPBAa1ZSfYWzSFc+c/r
         lstY66RnwNggohTgRyG4bFGr18473Zt+KSA1AeREgb2+v2QT3YqVMOK3BvsCtm2/ZU
         tpLMfXgksSIAP+M5tx3UAUOZANRqUPSZaiAbf2Y5oFa2WkeL0GHocTIcksUq6VCxio
         lz8Synao9jD7w==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v3] ubsan: Implement __ubsan_handle_alignment_assumption
Date:   Wed, 27 Jan 2021 15:44:52 -0700
Message-Id: <20210127224451.2587372-1-nathan@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113001242.1662786-1-natechancellor@gmail.com>
References: <20210113001242.1662786-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building ARCH=mips 32r2el_defconfig with CONFIG_UBSAN_ALIGNMENT:

ld.lld: error: undefined symbol: __ubsan_handle_alignment_assumption
>>> referenced by slab.h:557 (include/linux/slab.h:557)
>>>               main.o:(do_initcalls) in archive init/built-in.a
>>> referenced by slab.h:448 (include/linux/slab.h:448)
>>>               do_mounts_rd.o:(rd_load_image) in archive init/built-in.a
>>> referenced by slab.h:448 (include/linux/slab.h:448)
>>>               do_mounts_rd.o:(identify_ramdisk_image) in archive init/built-in.a
>>> referenced 1579 more times

Implement this for the kernel based on LLVM's
handleAlignmentAssumptionImpl because the kernel is not linked against
the compiler runtime.

Link: https://github.com/ClangBuiltLinux/linux/issues/1245
Link: https://github.com/llvm/llvm-project/blob/llvmorg-11.0.1/compiler-rt/lib/ubsan/ubsan_handlers.cpp#L151-L190
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v2 -> v3:

* Add prototype right above definition to avoid introducing a warning
  with W=1.

v1 -> v2:

* Use __ffs instead of ffs because due to size of input (unsigned long
  vs int) and we want a zero based index (Nick Desaulniers).

* Pick up Kees's ack.

 lib/ubsan.c | 31 +++++++++++++++++++++++++++++++
 lib/ubsan.h |  6 ++++++
 2 files changed, 37 insertions(+)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 3e3352f3d0da..bec38c64d6a6 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -427,3 +427,34 @@ void __ubsan_handle_load_invalid_value(void *_data, void *val)
 	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
+
+void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
+					 unsigned long align,
+					 unsigned long offset);
+void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
+					 unsigned long align,
+					 unsigned long offset)
+{
+	struct alignment_assumption_data *data = _data;
+	unsigned long real_ptr;
+
+	if (suppress_report(&data->location))
+		return;
+
+	ubsan_prologue(&data->location, "alignment-assumption");
+
+	if (offset)
+		pr_err("assumption of %lu byte alignment (with offset of %lu byte) for pointer of type %s failed",
+		       align, offset, data->type->type_name);
+	else
+		pr_err("assumption of %lu byte alignment for pointer of type %s failed",
+		       align, data->type->type_name);
+
+	real_ptr = ptr - offset;
+	pr_err("%saddress is %lu aligned, misalignment offset is %lu bytes",
+	       offset ? "offset " : "", BIT(real_ptr ? __ffs(real_ptr) : 0),
+	       real_ptr & (align - 1));
+
+	ubsan_epilogue();
+}
+EXPORT_SYMBOL(__ubsan_handle_alignment_assumption);
diff --git a/lib/ubsan.h b/lib/ubsan.h
index 7b56c09473a9..9a0b71c5ff9f 100644
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -78,6 +78,12 @@ struct invalid_value_data {
 	struct type_descriptor *type;
 };
 
+struct alignment_assumption_data {
+	struct source_location location;
+	struct source_location assumption_location;
+	struct type_descriptor *type;
+};
+
 #if defined(CONFIG_ARCH_SUPPORTS_INT128)
 typedef __int128 s_max;
 typedef unsigned __int128 u_max;

base-commit: 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04
-- 
2.30.0

