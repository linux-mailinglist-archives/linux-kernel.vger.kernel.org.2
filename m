Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3A347226
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhCXHMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:12:42 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:51420 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbhCXHMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:12:14 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 12O7BVKu022145;
        Wed, 24 Mar 2021 16:11:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 12O7BVKu022145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1616569891;
        bh=E24/Hi4hh0dLHOpU4tPgNkmKmpiDpZO+w1BHFp1aBEQ=;
        h=From:To:Cc:Subject:Date:From;
        b=sK5TV14pjccbzlNGSwDQxOMJog2/cutWLa7DQ/9xDlb1Z7MYBXWeMZBbYHqQ5aeSr
         J2eWZuQZQhUnpsJuwUR7tJjXkg9WLDScoPBtNJ/cyXh98mjHmATpKVB7J+4qGVC13q
         beKX7X14+s5zK9ilmy/F392UQA3luT9Fmv5s7Zt2ZveM6YroK3GFNLj5zx0rlohR9Y
         JuYZqh92lrrYKk3xshdUq7ii21IGeUpuEV/Pi3O33iCIxKl2MGXfJdy8R2Bk0AbIBy
         H5El8PooQqXxcY9s7EnsdAlgzbmpGSNYc1SnnREBfUKC8LX/uq3j3EcCYQnt13NnIv
         SUDQqAbSzm94w==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] arm64: move --fix-cortex-a53-843419 linker test to Kconfig
Date:   Wed, 24 Mar 2021 16:11:28 +0900
Message-Id: <20210324071128.1723273-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$(call ld-option, --fix-cortex-a53-843419) in arch/arm64/Makefile is
evaluated every time even for Make targets that do not need the linker,
such as "make ARCH=arm64 install".

Recently, the Kbuild tree queued up a patch to avoid needless
compiler/linker flag evaluation. I beleive it is a good improvement
itself, but causing a false-positive warning for arm64 installation
in linux-next. (Thanks to Nathan for the report)

Kconfig can test the linker capability just once, and store it in the
.config file. The build and installation steps that follow do not need
to test the liniker over again.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

I was not sure what the preferred CONFIG option name is.
Please suggest a one if you have a better idea.


 arch/arm64/Kconfig  | 3 +++
 arch/arm64/Makefile | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5656e7aacd69..4a33428de8ac 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -521,6 +521,9 @@ config ARM64_ERRATUM_843419
 
 	  If unsure, say Y.
 
+config ARM64_LD_HAS_FIX_ERRATUM_843419
+	def_bool $(ld-option,--fix-cortex-a53-843419)
+
 config ARM64_ERRATUM_1024718
 	bool "Cortex-A55: 1024718: Update of DBM/AP bits without break before make might result in incorrect update"
 	default y
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 5b84aec31ed3..7ef44478560d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -21,7 +21,7 @@ LDFLAGS_vmlinux		+= -shared -Bsymbolic -z notext \
 endif
 
 ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
-  ifeq ($(call ld-option, --fix-cortex-a53-843419),)
+  ifneq ($(CONFIG_ARM64_LD_HAS_FIX_ERRATUM_843419),y)
 $(warning ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum)
   else
 LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
-- 
2.27.0

