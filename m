Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF17323AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhBXKxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhBXKxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:53:44 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07590C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 02:53:01 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id lr13so2257390ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 02:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hg6HWR5e/o2fjZiKVbSJJcv/7HlVrgm4ZudMig7R0Es=;
        b=eQfRdeLlNwywZ3VO5Ag/LtBRTWyRHGqhLYlryXGkDitRLxjsM1HYDPw1lpw4i+6fKj
         kD8xp4xaxYSuA5x1XLeEI1fwE5/YbP2FTfePTkBmZA6OJnEVD4pdnzmx+zInUtF0T+eY
         EnkTL2XICUxVx3qIiFgsIeO7hKilM+LATpSTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hg6HWR5e/o2fjZiKVbSJJcv/7HlVrgm4ZudMig7R0Es=;
        b=drQxbkm0z9wJ3JoNNGu2+XCg6DprfvVBH34reQtvr6MjDU5L2SxCUavscQo0s1JaCv
         CofO09gzintGbilJxQlKFJuvugrJnkq/4as/PSEU3M9GmBWBdwVdNCh94B4JNkGsTv+W
         gUk9kLm1pgeT0vHnhT+NhB8+u/pdnYUw/uYUSxUnMj5vQv1PfzJ8ah2LSRQBq4l8QJRk
         ZsJGGSzsyEbxWmkORYQMe35rc8qe+adGIL4BZxol+/q4d4wyysYFMox1dMwOKZaowTXr
         yyYxcuscxo/TXZZJm1Cy7ooXuYwnBMygBIIcbNq0pHbXxqo0JOpCQ0AvtTe38sEFWka9
         gB9g==
X-Gm-Message-State: AOAM531o1IdcGXDJc2ytL+zwMrMC9u2zY9i3VodaBm1hCAjKDupC9kQV
        diudMWT7OWRSdqHfMssVcIKsiw==
X-Google-Smtp-Source: ABdhPJx9mntsNxQt94eKyBdg0ZATMqpYxIVyemxFMXGrTJh1KmX3ygLn7VbNon//73V0QbsbcJjWTg==
X-Received: by 2002:a17:907:a087:: with SMTP id hu7mr14819167ejc.122.1614163979808;
        Wed, 24 Feb 2021 02:52:59 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id pk5sm1036529ejb.119.2021.02.24.02.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 02:52:59 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: add CONFIG_VMLINUX_MAP expert option
Date:   Wed, 24 Feb 2021 11:52:55 +0100
Message-Id: <20210224105256.1939169-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be quite useful to have ld emit a link map file, in order to
debug or verify that special sections end up where they are supposed
to, and to see what LD_DEAD_CODE_DATA_ELIMINATION manages to get rid
of.

The only reason I'm not just adding this unconditionally is that the
.map file can be rather large (several MB), and that's a waste of
space when one isn't interested in these things. Also hide the prompt
behind CONFIG_EXPERT.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .gitignore              | 1 +
 Makefile                | 3 ++-
 lib/Kconfig.debug       | 9 +++++++++
 scripts/link-vmlinux.sh | 9 +++++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 3af66272d6f1..d3038aff4485 100644
--- a/.gitignore
+++ b/.gitignore
@@ -58,6 +58,7 @@ modules.order
 /TAGS
 /linux
 /vmlinux
+/vmlinux.map
 /vmlinux.32
 /vmlinux.symvers
 /vmlinux-gdb.py
diff --git a/Makefile b/Makefile
index b18dbc634690..be6fbd99a214 100644
--- a/Makefile
+++ b/Makefile
@@ -1501,7 +1501,8 @@ endif # CONFIG_MODULES
 # Directories & files removed with 'make clean'
 CLEAN_FILES += include/ksym vmlinux.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
-	       compile_commands.json
+	       compile_commands.json \
+	       vmlinux.map
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES += include/config include/generated          \
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5ea0c1773b0a..d6af084c11ae 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -412,6 +412,15 @@ config VMLINUX_VALIDATION
 	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
 	default y
 
+config VMLINUX_MAP
+	bool "Generate vmlinux.map file when linking" if EXPERT
+	help
+	  Selecting this option will pass "-Map=vmlinux.map" to ld
+	  when linking vmlinux. That file can be useful for verifying
+	  and debugging magic section games, and for seeing which
+	  pieces of code get eliminated with
+	  CONFIG_LD_DEAD_CODE_DATA_ELIMINATION.
+
 config DEBUG_FORCE_WEAK_PER_CPU
 	bool "Force weak per-cpu definitions"
 	depends on DEBUG_KERNEL
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 3b261b0f74f0..bba58839db40 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -166,6 +166,12 @@ vmlinux_link()
 		strip_debug=-Wl,--strip-debug
 	fi
 
+	if [ -n "${CONFIG_VMLINUX_MAP}" ]; then
+		map_option="-Map=${output}.map"
+	else
+		map_option=""
+	fi
+
 	if [ "${SRCARCH}" != "um" ]; then
 		if [ -n "${CONFIG_LTO_CLANG}" ]; then
 			# Use vmlinux.o instead of performing the slow LTO
@@ -187,6 +193,7 @@ vmlinux_link()
 		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}	\
 			${strip_debug#-Wl,}			\
 			-o ${output}				\
+			${map_option}				\
 			-T ${lds} ${objects}
 	else
 		objects="-Wl,--whole-archive			\
@@ -200,6 +207,7 @@ vmlinux_link()
 		${CC} ${CFLAGS_vmlinux}				\
 			${strip_debug}				\
 			-o ${output}				\
+			${map_option:+-Wl,${map_option}}	\
 			-Wl,-T,${lds}				\
 			${objects}				\
 			-lutil -lrt -lpthread
@@ -303,6 +311,7 @@ cleanup()
 	rm -f .tmp_vmlinux*
 	rm -f System.map
 	rm -f vmlinux
+	rm -f vmlinux.map
 	rm -f vmlinux.o
 }
 
-- 
2.29.2

