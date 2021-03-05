Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D7F32E4C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhCEJ1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCEJ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:27:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6F1C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:27:15 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b7so1609745edz.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxJmRko8zfsnlnfj+4nCVTlalJzJ5o7jDUz31ZEenxc=;
        b=WYzFtrqAtFmeJiWRU0sKPU3fozVGqNEbo5BB28EDzF0zCCut67hVDjus9nAEI9F2dF
         WV/PC+IiB3FVUYngCCTs+7Thn253+HMXpBGVXIX+PM34uYb3UrDfo3ka2o4o+016vrP6
         m4AC3FWWmS/ojc24NaV6u2X8qHjuCOx2Xe5OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxJmRko8zfsnlnfj+4nCVTlalJzJ5o7jDUz31ZEenxc=;
        b=HU473N1RwvXBF/NntbsLYH4B7X2Z/HVYueWWlgE1Ya6PWdSocZZInLZgxUM+JOaEa/
         zH361DRq0JwOSZOZlileFsNaZmBBrgAjVSBSyx5vLjiS7nlRJz6/gyTm1q5C5rmjnTYv
         vSSeltiGhGZh+gmE/iZWMuK+onxXCYgcgDBFUOQoIdmDIuGlQjcFqNGPBqX26KYOHDT4
         wFuTWYbEjVsSaxwrOEY3ydr+gav8LatghYFphzbx5/IPh1nXQcv56zJjk63q2M4oW+sK
         oWlBoZft9bdb5XqwANoCMNpwEGOoV6sV8lk/SOiLWvWhTezIvkzsQeiukGP5ck1tvACA
         h3LA==
X-Gm-Message-State: AOAM530eg73yh03NbZvgNepmOX4hQTZqNjku4qZ939+QQVfF537ysQiW
        oLLDBb7lwwaBF7bRwItoJBRHtQ==
X-Google-Smtp-Source: ABdhPJwqMTg6XSO15OOv6ShlcEyyPdz3FDam4sT7aPKjfjhlL33Dknw/bFp2OUPAFUYSOTRtgMx+Tg==
X-Received: by 2002:aa7:ce16:: with SMTP id d22mr8301819edv.95.1614936433889;
        Fri, 05 Mar 2021 01:27:13 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id n5sm1240929edw.7.2021.03.05.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:27:13 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH v2] kbuild: add CONFIG_VMLINUX_MAP expert option
Date:   Fri,  5 Mar 2021 10:27:07 +0100
Message-Id: <20210305092707.740539-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <CAK7LNAQ_CuUOH7mY8Rf3kxLxXKm0oxBsK=XgAS9ScMaW-55OuQ@mail.gmail.com>
References: <CAK7LNAQ_CuUOH7mY8Rf3kxLxXKm0oxBsK=XgAS9ScMaW-55OuQ@mail.gmail.com>
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
space when one isn't interested in these things. Also make it depend
on CONFIG_EXPERT.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .gitignore              |  1 +
 Documentation/dontdiff  |  1 +
 lib/Kconfig.debug       | 10 ++++++++++
 scripts/link-vmlinux.sh |  8 ++++++++
 4 files changed, 20 insertions(+)

diff --git a/.gitignore b/.gitignore
index 3af66272d6f1..3adea59847ce 100644
--- a/.gitignore
+++ b/.gitignore
@@ -59,6 +59,7 @@ modules.order
 /linux
 /vmlinux
 /vmlinux.32
+/vmlinux.map
 /vmlinux.symvers
 /vmlinux-gdb.py
 /vmlinuz
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index e361fc95ca29..ac42ad8d430d 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -252,6 +252,7 @@ vmlinux-*
 vmlinux.aout
 vmlinux.bin.all
 vmlinux.lds
+vmlinux.map
 vmlinux.symvers
 vmlinuz
 voffset.h
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5ea0c1773b0a..663c1cd5018c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -412,6 +412,16 @@ config VMLINUX_VALIDATION
 	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
 	default y
 
+config VMLINUX_MAP
+	bool "Generate vmlinux.map file when linking"
+	depends on EXPERT
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
index 3b261b0f74f0..855fd4e6f03e 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -155,6 +155,7 @@ vmlinux_link()
 	local output=${1}
 	local objects
 	local strip_debug
+	local map_option
 
 	info LD ${output}
 
@@ -166,6 +167,10 @@ vmlinux_link()
 		strip_debug=-Wl,--strip-debug
 	fi
 
+	if [ -n "${CONFIG_VMLINUX_MAP}" ]; then
+		map_option="-Map=${output}.map"
+	fi
+
 	if [ "${SRCARCH}" != "um" ]; then
 		if [ -n "${CONFIG_LTO_CLANG}" ]; then
 			# Use vmlinux.o instead of performing the slow LTO
@@ -187,6 +192,7 @@ vmlinux_link()
 		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}	\
 			${strip_debug#-Wl,}			\
 			-o ${output}				\
+			${map_option}				\
 			-T ${lds} ${objects}
 	else
 		objects="-Wl,--whole-archive			\
@@ -200,6 +206,7 @@ vmlinux_link()
 		${CC} ${CFLAGS_vmlinux}				\
 			${strip_debug}				\
 			-o ${output}				\
+			${map_option:+-Wl,${map_option}}	\
 			-Wl,-T,${lds}				\
 			${objects}				\
 			-lutil -lrt -lpthread
@@ -303,6 +310,7 @@ cleanup()
 	rm -f .tmp_vmlinux*
 	rm -f System.map
 	rm -f vmlinux
+	rm -f vmlinux.map
 	rm -f vmlinux.o
 }
 
-- 
2.29.2

