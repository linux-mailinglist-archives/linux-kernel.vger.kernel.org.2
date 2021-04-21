Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F323672FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245353AbhDUS71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243307AbhDUS70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:59:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ACEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 11:58:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v13so8590404ple.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fBo9iO5p1FVQk7U2PW9ks5Ltl0+taTlaBnmT5cR6/Q=;
        b=NIeClhu9rh4JwSSGsAW+i+ttpaVuSWw5i4W5UuvB/p8yHnWiMcjQdizatRXhLw7/VU
         71iWLKJZzXGA2fAB3GnLR5XwRUUJry+8TI8rdzyemh0yzeTcwlS9EA0F/p0lue4rl+ZS
         3iC+mG2YkSpxj9nja67NFTM7JPG8XJfKk4yOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fBo9iO5p1FVQk7U2PW9ks5Ltl0+taTlaBnmT5cR6/Q=;
        b=C3S4ybZ88FYzpuFfiSes5CAmeUYfBKsrXMugMcLRguKKvaMppnHci1+RxaqCiIXNHa
         EucVGDr9jY2x0WtOkPr1lu8ND7eiThSMlYlQ1ByLq5uFCVLkxBCb5SsU99nwD1Mz+aB6
         ULW/7mbIyQpMlPGdNT1cwmCeQCH2jZoZijlfkDKCh7uF3adgGelBe8XVp+iANrjgrEfC
         QygcZDHwXSkFNy/11De6HZBvF+R7FRGC7bgicRMM1Zo0palnt2RDZc7amDx5W6LulPuV
         xxNChD3f77uBKFaoMs3d5k5DrtR3oC4fqcN5D2sO/0l/ukoGJ1TMbm2xxjbH+2cQ0pXj
         jp3w==
X-Gm-Message-State: AOAM531E0aTff0p3isEb3+L1cID81s1PvO+tKe6QJDvda9yQN6hGcfXv
        yym9JgfkcbVCr+q6YrsHD7/hxg==
X-Google-Smtp-Source: ABdhPJxLxgg4oT0dQGZJ803QmWwT7p2Pjk2IhoyyMnSqKa3HMqp15IC/XQxK/VyLChVC1WXZAQA3dQ==
X-Received: by 2002:a17:902:c209:b029:ec:7add:e183 with SMTP id 9-20020a170902c209b02900ec7adde183mr30242486pll.74.1619031532713;
        Wed, 21 Apr 2021 11:58:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a20sm72734pfi.138.2021.04.21.11.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 11:58:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools build: Fix quiet cmd indentation
Date:   Wed, 21 Apr 2021 11:58:48 -0700
Message-Id: <20210421185848.1292167-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=e08ffe10ec6022fb7b60ecf9a2a23b1d35aceb0d; i=9NRyGhY2tv3XI95ynhk/erefMCxCOdJLjVUP7jh2Qf4=; m=vK6aKHZTHCKkaa3LCNsL1CLRlcOUfmHKCyTdaCu+++I=; p=2txpJDWqaOzBYRdhrjGnZCI+jzZWgCTEs2W5udf0Hs4=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCAdecACgkQiXL039xtwCaJ8g/+M1G HVfSQg0ZrDa+xTFCym4KtZWRwarp+DjO9W6MvDAalew4vGVJxpn7AK6jdzCZH6W3+Uj+F3WQrkHoS n1L1CeOfXRNOHjow/tPIt1RWDIt9r4Khb4zAX0Qj3G51JnMU8pIJS1YYWlBJvozrmXkKwKXIPl48E WIF0za8GZNoV0CD+b8SR/oo38+EQFiKEOaPMPi+I3E7Dv79Wp6dHjddb87k4aDfRWtsmPiEsCM5uj j+S6eucCqbC8jy1sIMP5yau6QlYKclfI7ugrzsd3njeH/RkxWhw9jNfd/lraEQjZDtH6WHgpdz8oZ Ho+xRV0d7RWLf9TfZlAL4LendgBUZl1BrthM0NHTZ42dV97au5tYTT+5EtWGI/85zR7rTFmy88Ls/ AyCbU6L71GGITqWjN21ohxITmR3M2jpwuBONmUSsBTyWQAs05TQJPc/USF/pE4f0lVsJaQrew9tN+ 1Qzdy9wWOXY72gE2A3/JDowYk7th9yohVqWYMCmz9jcALd19K+8c5/BorW8Zh2vxeib0QjPPKRxb8 D9P1m2FiSczfs0GhpPTRHWWbGMBDv+G1DhYc5Dg1CLJknQYpdRt3FiWrpEHTkv+2ZBugHzWbUudwj k7Psk4WqQJLBk+Ji0u3kZ0SUamJxs7tAwEB7xWm7m5z5zWSK1YgTejPhO2FN2Qd8=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tools quiet cmd output has mismatched indentation (and extra space
character between cmd name and target name) compared to the rest of
kbuild out:

  HOSTCC  scripts/insert-sys-cert
  LD       /srv/code/tools/objtool/arch/x86/objtool-in.o
  LD       /srv/code/tools/objtool/libsubcmd-in.o
  AR       /srv/code/tools/objtool/libsubcmd.a
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  CC      scripts/mod/devicetable-offsets.s
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  LD       /srv/code/tools/objtool/objtool-in.o
  LINK     /srv/code/tools/objtool/objtool
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s

Adjust to match the rest of kbuild.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/build/Makefile.build     | 22 +++++++++++-----------
 tools/scripts/Makefile.include | 30 +++++++++++++++---------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index cd72016c3cfa..715092fc6a23 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -51,39 +51,39 @@ subdir-obj-y :=
 build-file := $(dir)/Build
 -include $(build-file)
 
-quiet_cmd_flex  = FLEX     $@
-quiet_cmd_bison = BISON    $@
+quiet_cmd_flex  = FLEX    $@
+quiet_cmd_bison = BISON   $@
 
 # Create directory unless it exists
-quiet_cmd_mkdir = MKDIR    $(dir $@)
+quiet_cmd_mkdir = MKDIR   $(dir $@)
       cmd_mkdir = mkdir -p $(dir $@)
      rule_mkdir = $(if $(wildcard $(dir $@)),,@$(call echo-cmd,mkdir) $(cmd_mkdir))
 
 # Compile command
-quiet_cmd_cc_o_c = CC       $@
+quiet_cmd_cc_o_c = CC      $@
       cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
 
-quiet_cmd_host_cc_o_c = HOSTCC   $@
+quiet_cmd_host_cc_o_c = HOSTCC  $@
       cmd_host_cc_o_c = $(HOSTCC) $(host_c_flags) -c -o $@ $<
 
-quiet_cmd_cxx_o_c = CXX      $@
+quiet_cmd_cxx_o_c = CXX     $@
       cmd_cxx_o_c = $(CXX) $(cxx_flags) -c -o $@ $<
 
-quiet_cmd_cpp_i_c = CPP      $@
+quiet_cmd_cpp_i_c = CPP     $@
       cmd_cpp_i_c = $(CC) $(c_flags) -E -o $@ $<
 
-quiet_cmd_cc_s_c = AS       $@
+quiet_cmd_cc_s_c = AS      $@
       cmd_cc_s_c = $(CC) $(c_flags) -S -o $@ $<
 
-quiet_cmd_gen = GEN      $@
+quiet_cmd_gen = GEN     $@
 
 # Link agregate command
 # If there's nothing to link, create empty $@ object.
-quiet_cmd_ld_multi = LD       $@
+quiet_cmd_ld_multi = LD      $@
       cmd_ld_multi = $(if $(strip $(obj-y)),\
                      $(LD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(AR) rcs $@)
 
-quiet_cmd_host_ld_multi = HOSTLD   $@
+quiet_cmd_host_ld_multi = HOSTLD  $@
       cmd_host_ld_multi = $(if $(strip $(obj-y)),\
                           $(HOSTLD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(HOSTAR) rcs $@)
 
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index a402f32a145c..f754ed798034 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -121,29 +121,29 @@ QUIET_SUBDIR1  =
 
 ifneq ($(silent),1)
   ifneq ($(V),1)
-	QUIET_CC       = @echo '  CC       '$@;
-	QUIET_CC_FPIC  = @echo '  CC FPIC  '$@;
-	QUIET_CLANG    = @echo '  CLANG    '$@;
-	QUIET_AR       = @echo '  AR       '$@;
-	QUIET_LINK     = @echo '  LINK     '$@;
-	QUIET_MKDIR    = @echo '  MKDIR    '$@;
-	QUIET_GEN      = @echo '  GEN      '$@;
+	QUIET_CC       = @echo '  CC      '$@;
+	QUIET_CC_FPIC  = @echo '  CC FPIC '$@;
+	QUIET_CLANG    = @echo '  CLANG   '$@;
+	QUIET_AR       = @echo '  AR      '$@;
+	QUIET_LINK     = @echo '  LINK    '$@;
+	QUIET_MKDIR    = @echo '  MKDIR   '$@;
+	QUIET_GEN      = @echo '  GEN     '$@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) \
-			  echo '  SUBDIR   '$$subdir; \
+			  echo '  SUBDIR  '$$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
-	QUIET_FLEX     = @echo '  FLEX     '$@;
-	QUIET_BISON    = @echo '  BISON    '$@;
-	QUIET_GENSKEL  = @echo '  GEN-SKEL '$@;
+	QUIET_FLEX     = @echo '  FLEX    '$@;
+	QUIET_BISON    = @echo '  BISON   '$@;
+	QUIET_GENSKEL  = @echo '  GENSKEL '$@;
 
 	descend = \
-		+@echo	       '  DESCEND  '$(1); \
+		+@echo	       '  DESCEND '$(1); \
 		mkdir -p $(OUTPUT)$(1) && \
 		$(MAKE) $(COMMAND_O) subdir=$(if $(subdir),$(subdir)/$(1),$(1)) $(PRINT_DIR) -C $(1) $(2)
 
-	QUIET_CLEAN    = @printf '  CLEAN    %s\n' $1;
-	QUIET_INSTALL  = @printf '  INSTALL  %s\n' $1;
-	QUIET_UNINST   = @printf '  UNINST   %s\n' $1;
+	QUIET_CLEAN    = @printf '  CLEAN   %s\n' $1;
+	QUIET_INSTALL  = @printf '  INSTALL %s\n' $1;
+	QUIET_UNINST   = @printf '  UNINST  %s\n' $1;
   endif
 endif
 
-- 
2.25.1

