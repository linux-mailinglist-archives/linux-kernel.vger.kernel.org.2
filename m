Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8716837760B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 11:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhEIJhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 05:37:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhEIJhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 05:37:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E38960FD7;
        Sun,  9 May 2021 09:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620552993;
        bh=LqmsTVv8ZK74PAaCsVctbtZUcaUmDWP7Y3GcXbNaBcc=;
        h=From:To:Cc:Subject:Date:From;
        b=GnC2/y6kH3l24OCrFGC+q815RmuTgSlxqN/Gve9Y4mU4nmWZnqc5DZ8vOIQ7AOT+S
         ZV0teAsgH1oXGSpDY329hVRQVHQ8RGSyT2jD8LOF+G+NCkFL160eJBR6/R9wkLw8yb
         ltw8jZNrWIft9AQ0CbztXDBRquYZ7L6Cn5McqVVgeFKAZ7YmWe4EjmS+2/GCx3p+2K
         L3mnVqRV9HHbKytQN7DNyadGx+7pqvVxdOxKi3hTqtiaOpb31+Gx2TGTD+41sJMfpO
         3QZ0MGZ4O9+n+OTeBnFGMnTh2lLw23DTV4RTZ3/wArL7lxxc6Fz0Jdon5yVK739UIb
         GJ5yXB5h0a+hg==
From:   guoren@kernel.org
To:     jakub@redhat.com, mliska@suse.cz
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org, gcc@gcc.gnu.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] libsanitizer: Fix compile error with linux-5.12
Date:   Sun,  9 May 2021 09:35:49 +0000
Message-Id: <1620552949-20797-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

../../../../libsanitizer/sanitizer_common/sanitizer_platform_limits_posix.cpp:133:10: fatal error: linux/cyclades.h: No such file or directory
  133 | #include <linux/cyclades.h>
      |          ^~~~~~~~~~~~~~~~~~

Linux has remove the cyclades driver:
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux?h=v5.12&id=f76edd8f7ce06cdff2fe5b6b39a49644c684a161>

So there is no cyclades.h in current linux.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 .../sanitizer_common/sanitizer_platform_limits_posix.cpp      | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/libsanitizer/sanitizer_common/sanitizer_platform_limits_posix.cpp b/libsanitizer/sanitizer_common/sanitizer_platform_limits_posix.cpp
index 1427cec..025e575 100644
--- a/libsanitizer/sanitizer_common/sanitizer_platform_limits_posix.cpp
+++ b/libsanitizer/sanitizer_common/sanitizer_platform_limits_posix.cpp
@@ -131,7 +131,6 @@ typedef struct user_fpregs elf_fpregset_t;
 # include <sys/procfs.h>
 #endif
 #include <sys/user.h>
-#include <linux/cyclades.h>
 #include <linux/if_eql.h>
 #include <linux/if_plip.h>
 #include <linux/lp.h>
@@ -449,7 +448,6 @@ unsigned struct_ElfW_Phdr_sz = sizeof(Elf_Phdr);
 
 #if SANITIZER_LINUX && !SANITIZER_ANDROID
   unsigned struct_ax25_parms_struct_sz = sizeof(struct ax25_parms_struct);
-  unsigned struct_cyclades_monitor_sz = sizeof(struct cyclades_monitor);
 #if EV_VERSION > (0x010000)
   unsigned struct_input_keymap_entry_sz = sizeof(struct input_keymap_entry);
 #else
@@ -815,15 +813,6 @@ unsigned struct_ElfW_Phdr_sz = sizeof(Elf_Phdr);
 #endif // SANITIZER_LINUX
 
 #if SANITIZER_LINUX && !SANITIZER_ANDROID
-  unsigned IOCTL_CYGETDEFTHRESH = CYGETDEFTHRESH;
-  unsigned IOCTL_CYGETDEFTIMEOUT = CYGETDEFTIMEOUT;
-  unsigned IOCTL_CYGETMON = CYGETMON;
-  unsigned IOCTL_CYGETTHRESH = CYGETTHRESH;
-  unsigned IOCTL_CYGETTIMEOUT = CYGETTIMEOUT;
-  unsigned IOCTL_CYSETDEFTHRESH = CYSETDEFTHRESH;
-  unsigned IOCTL_CYSETDEFTIMEOUT = CYSETDEFTIMEOUT;
-  unsigned IOCTL_CYSETTHRESH = CYSETTHRESH;
-  unsigned IOCTL_CYSETTIMEOUT = CYSETTIMEOUT;
   unsigned IOCTL_EQL_EMANCIPATE = EQL_EMANCIPATE;
   unsigned IOCTL_EQL_ENSLAVE = EQL_ENSLAVE;
   unsigned IOCTL_EQL_GETMASTRCFG = EQL_GETMASTRCFG;
-- 
2.7.4

