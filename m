Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140C3397A6A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhFATHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhFATH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:07:29 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EDEC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:05:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q15so113200pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhFeeCG6jJPdjIf7Su+v/ZA3C7ivdOdJ2XJwAQEYzFg=;
        b=kJQhTJTBfu/xt9UmScSYZWlaFIajB0fK5+vO+mYWkt5N/Q3KMgFtvzGcdW2/dr1Fur
         YaXC2oIJSXhELwhYsueGqqOT1HE7goHTHXOW2hL763oNjbDrLNvYNF8B0NhnuobGMVdG
         jk5rYktHkg4v50bn5Ncr8q16jKeFaYdyR1Z3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhFeeCG6jJPdjIf7Su+v/ZA3C7ivdOdJ2XJwAQEYzFg=;
        b=IUVOQOH8Ag/LxBAzjgFMBtT9jWcGv7Q/RmSdVrkcu85qNAdtkuF117j7LRbdMRXyz+
         poEm/3nR8a5BDNnmTeAHc/igoLvre0kFrs4W/ft8PtBq4SUaed4QFdoDm1n5XaiQHqL7
         R9Ma+Yp1d3Jshk09d4sQAxTBKv07MMX0oH5kLX0j6mF8JQKuEuoGY9H6eVB8OMuXzu62
         5gDlgVd5ronXspbv5TJz1tAwxQ8kCiQlNwbCUG8cHsfmTAyZEZS472amth3SSRcfddn6
         xLFJU4RFEiog+mfOUevRcHH0cWIgRYQyHtF4DsCSgJ1wI3c0BPlZ36I2KrN0BBZRHZMo
         WDKQ==
X-Gm-Message-State: AOAM531L59KwycXiGUCsNA0JqgBILYqg4MWWxvVJINufs8fbNoS0eOy6
        rqueMynqu/fRiQYEs5aO4fw87A==
X-Google-Smtp-Source: ABdhPJyj/B6/z0VRUbltjQvnuYCzwfePsZfXYBkTJH1CluQq0KBVRvlBkbYopiMQ/HoAl3yGXtwXaQ==
X-Received: by 2002:a63:1c52:: with SMTP id c18mr29829680pgm.258.1622574345824;
        Tue, 01 Jun 2021 12:05:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a9sm13477233pfo.69.2021.06.01.12.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:05:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Expand and relocate PGO entry
Date:   Tue,  1 Jun 2021 12:05:41 -0700
Message-Id: <20210601190541.1446239-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=a2e53c0b44ad39c78ed7bc7aad40d133548a13b5; i=epkwXI7v45FSzXf5mkFhBtxZv1zlpgta2n0TdjAB7VU=; m=UHdiPvCSSYNXcblaQ0hYR032Ex0utU1lScs3qjbpcLw=; p=XvTTT72GYcElJDrPTjwa+OWmIpDEZqpWG1Hb0q9FcjY=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmC2hQQACgkQiXL039xtwCYmkw/9F0r ocHrbJeRlydh2BeRQVrQTEhXL3uZf+pm4mIOSSCJmo/dmgX/DrOYYJN51ThmEtyU3yzUPMUS+UNJS KftzjubmATbposIb4DlQAYfo7XdTYYnteTk7D+xLZqL5/iAvcOxfc/fr580EbIva/MtgLe5ikKFam +gSLkWDagbBr68t49oyB/Oc5toGnSKWyjcw6VRGR8DZhSUOhRiX/4aPFsvh5bZEt1J9rFLl8sytai df9L4T5WZj5+W1QwZIwewZxDo3nwWkXSCB5s2BFARG1Setze7CY6gwzodixb/k2nqxBKyA7DEZks6 FVIM18YPqJuddTK4aj/6gPcEtOfFJfMEpd7yehB3GSRbckC01HuYekcg0kYcAk5PU92KlWwQWu6a2 QO87qL/9TBWgs9HRtcjNvMvhIP209kGCUz1LsWN74T6s0yeNjEEQLe6k2Q0+BrTDXD2NUkZWnL/hc 97Oy2813DVc3J7H3+LS6/CaFE27T+0bHaJ/HnhFDz5SUzhHYgKkh+tVmchgoG1IJmDNxg/uQHB538 IMlkiIzyF6RdpKiiQNy/1Gl0ZiXw4UoGce1UeHsz3kkOH0NcVhtfh/jvxAV8w9MazUrETYdJfcSn1 7kSTQZsIZtUkiBfPTtW79PNgrKoMVsfg16+8/rR0noo/zcYEMfMBasLuan8xMnhM=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This expands the "PGO" acronym and adds additional metadata to help have
patches get directed correctly.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Bill Wendling <wcw@google.com>
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
as seen in: https://lore.kernel.org/lkml/YLVRTilQ5k5n+Vmz@archlinux-ax161/
---
 MAINTAINERS | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd7d34fcd95c..2030cd9593cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4448,6 +4448,19 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/cla
 F:	include/linux/cfi.h
 F:	kernel/cfi.c
 
+CLANG PROFILE GUIDED OPTIMIZATION SUPPORT
+M:	Sami Tolvanen <samitolvanen@google.com>
+M:	Bill Wendling <wcw@google.com>
+M:	Kees Cook <keescook@chromium.org>
+R:	Nathan Chancellor <nathan@kernel.org>
+R:	Nick Desaulniers <ndesaulniers@google.com>
+L:	clang-built-linux@googlegroups.com
+S:	Supported
+B:	https://github.com/ClangBuiltLinux/linux/issues
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/features
+F:	Documentation/dev-tools/pgo.rst
+F:	kernel/pgo/
+
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 L:	linux-kernel@vger.kernel.org
@@ -14387,15 +14400,6 @@ S:	Maintained
 F:	include/linux/personality.h
 F:	include/uapi/linux/personality.h
 
-PGO BASED KERNEL PROFILING
-M:	Sami Tolvanen <samitolvanen@google.com>
-M:	Bill Wendling <wcw@google.com>
-R:	Nathan Chancellor <nathan@kernel.org>
-R:	Nick Desaulniers <ndesaulniers@google.com>
-S:	Supported
-F:	Documentation/dev-tools/pgo.rst
-F:	kernel/pgo/
-
 PHOENIX RC FLIGHT CONTROLLER ADAPTER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 L:	linux-input@vger.kernel.org
-- 
2.25.1

