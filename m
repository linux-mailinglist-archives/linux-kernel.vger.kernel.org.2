Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C15931127A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhBESqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhBESm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:42:29 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18BAC061794
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 12:22:34 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id z20so5866242pgh.18
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 12:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PZ+RSQ3La9FqfpAq26CoOCWqjs/GvwGs77snpu64N1Q=;
        b=SgIivOzc5zhDKoGbEw3IXpZs5Ac1v6BUiuNEf6waen1t/bumlH2L9/6FqiiuCF60ec
         M6UO2w/PpCiLcEEcsJodXxbexOICRy/UGShjN7KJxmbqEC0x5dr+Hc09BF6m+644QHmA
         iy69FWlrW1voR24iFJwK/jtOxR5XZA86reU8zDfdJc+HNUkZ6+ifcRzoJ/79xQH94urn
         bJD65L4vK85v/Uls9+3CW1Q0uzqjOUrVPGKnWwRP8AdNAvfXyUAuVh+sIgleydu6rdDr
         PZ6fHgFOsovW64xcMJO374cAoLLVIP4cSvLcpa2L3QgOA0L96SM6dKRhTKjRg0yEBbhN
         +36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PZ+RSQ3La9FqfpAq26CoOCWqjs/GvwGs77snpu64N1Q=;
        b=Xl23JLql7XuaUUe5GkE5OWpI/V2rLnrE4RqpQ6wmiBdQFsZrJ3rU8GQMNV8LqbYYkw
         HHVz0tCobp6I42kqcmLk2rkbf4TKBA870LLZyGBBH2SRKI/GYTFVNs26C9QfOtLue/ja
         xxy4vlb9ne4Qdi0w9l1V+lUmzqIIkZx2APhvj1E55ULXEkTZPnXM6X5i3V1WUPRuCDX3
         RKBEw1fx9H/Wcl12cPAjAhTnUEJC6w8b3I/Ja2XkCmtcaR7Y96olKhdEgocUwM2jPbCJ
         /aNfMIi+umlPchgr+QjfE+TnnPgesb01f0vnPdiRY7EVPH+LPsvbsh0+QneF0dJ/vn2/
         w4jA==
X-Gm-Message-State: AOAM5303a/NNTkno8ND5gRiXCrQN1jxd5kbymicfATT1t1vwWITaJ+px
        Q9SwcZyUWoxXPKQElWhIf+xotZqEHR9EfE+NEDQ=
X-Google-Smtp-Source: ABdhPJxJB8DwKdut//rMtmuCxpHGsLlDNnvPvqiQWMsJzZBI0UleqwQdVFKxjJ3z/g4Kp+c6yv5pE4AG/HwVb+NffyI=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:fce9:1439:f67f:bf26])
 (user=ndesaulniers job=sendgmr) by 2002:a17:90a:8d83:: with SMTP id
 d3mr547381pjo.0.1612556553907; Fri, 05 Feb 2021 12:22:33 -0800 (PST)
Date:   Fri,  5 Feb 2021 12:22:19 -0800
In-Reply-To: <20210205202220.2748551-1-ndesaulniers@google.com>
Message-Id: <20210205202220.2748551-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210205202220.2748551-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v9 2/3] Kbuild: make DWARF version a choice
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chris Murphy <bugzilla@colorremedies.com>,
        Mark Wielaard <mark@klomp.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a default CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT which allows
the implicit default version of DWARF emitted by the toolchain to
progress over time.

Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice, making it
mutually exclusive with CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT. Users
may want to select this if they are using a newer toolchain, but have
consumers of the DWARF debug info that aren't yet ready for newer DWARF
versions' debug info.

Does so in a way that's forward compatible with existing
configs, and makes adding future versions more straightforward. This
patch does not change the current behavior or selection of DWARF
version for users upgrading to kernels with this patch.

GCC since ~4.8 has defaulted to DWARF v4 implicitly, and GCC 11 has
bumped this to v5.

Remove the Kconfig help text  about DWARF v4 being larger.  It's
empirically false for the latest toolchains for x86_64 defconfig, has no
point of reference (I suspect it was DWARF v2 but that's stil
empirically false), and debug info size is not a qualatative measure.

Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Jakub Jelinek <jakub@redhat.com>
Suggested-by: Mark Wielaard <mark@klomp.org>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile          |  5 +++--
 lib/Kconfig.debug | 30 +++++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 28019532e55a..a7eee28dd091 100644
--- a/Makefile
+++ b/Makefile
@@ -829,8 +829,9 @@ ifneq ($(LLVM_IAS),1)
 KBUILD_AFLAGS	+= -Wa,-gdwarf-2
 endif
 
-ifdef CONFIG_DEBUG_INFO_DWARF4
-DEBUG_CFLAGS	+= -gdwarf-4
+ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
+DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
 endif
 
 ifdef CONFIG_DEBUG_INFO_REDUCED
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e906ea906cb7..3ac450346dbe 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -256,13 +256,33 @@ config DEBUG_INFO_SPLIT
 	  to know about the .dwo files and include them.
 	  Incompatible with older versions of ccache.
 
+choice
+	prompt "DWARF version"
+	help
+	  Which version of DWARF debug info to emit.
+
+config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
+	bool "Rely on the toolchain's implicit default DWARF version"
+	help
+	  The implicit default version of DWARF debug info produced by a
+	  toolchain changes over time.
+
+	  This can break consumers of the debug info that haven't upgraded to
+	  support newer revisions, and prevent testing newer versions, but
+	  those should be less common scenarios.
+
+	  If unsure, say Y.
+
 config DEBUG_INFO_DWARF4
-	bool "Generate dwarf4 debuginfo"
+	bool "Generate DWARF Version 4 debuginfo"
 	help
-	  Generate dwarf4 debug info. This requires recent versions
-	  of gcc and gdb. It makes the debug information larger.
-	  But it significantly improves the success of resolving
-	  variables in gdb on optimized code.
+	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
+
+	  If you have consumers of DWARF debug info that are not ready for
+	  newer revisions of DWARF, you may wish to choose this or have your
+	  config select this.
+
+endchoice # "DWARF version"
 
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
-- 
2.30.0.365.g02bc693789-goog

