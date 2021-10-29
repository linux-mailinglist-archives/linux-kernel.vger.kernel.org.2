Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA89A43FB6F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhJ2Lgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 07:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231942AbhJ2Lgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:36:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32D0F61166;
        Fri, 29 Oct 2021 11:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635507247;
        bh=zklhndCE8vUwFiObARuJ15ZvqswT4LJwk/JZJaWF/Uk=;
        h=From:To:Cc:Subject:Date:From;
        b=JmkgnCNIHdwyvDqdsVhEQ0NpbfRITV04X29RG2Inv2o3nviWLPyw1tY2SHcpanefC
         2DAd0XYdaVGywn+3uaD7K4YhlGPEnSklccnkVlzrQZ2tAtsG65T4vFbF8YBoImXxkU
         YQZokiiKpo4rL18ZvXvWLszSWwT+SnjUhnqVbQpU1aq7g/bAxRUHEuIPfU33U18Sg5
         pSAUv7hq5JQPeLXuEfJT3PkO+YFQ+OWFLF0vXKYpuc/0CGyHKhfgZvJmhpxb4YnSbc
         PTE0oaQHoUc4lVbcj0vgIujwe+A1IF2C24Jy/zQE1IDJ1zZGKwSpAPj1W4mc99eqhR
         rwidY8cZOc1NQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jan Kara <jack@suse.cz>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] samples: fanotify: add CC_CAN_LINK dependency
Date:   Fri, 29 Oct 2021 13:33:35 +0200
Message-Id: <20211029113403.848239-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When using a cross tools that only works for kernels, the
newn sample can end up with a link failure such as:

/usr/bin/ld: unrecognised emulation mode: aarch64linux
Supported emulations: elf_x86_64 elf32_x86_64 elf_i386 elf_iamcu elf_l1om elf_k1om i386pep i386pe
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make[5]: *** [/git/arm-soc/scripts/Makefile.userprogs:28: samples/fanotify/fs-monitor] Error 1

Add a Kconfig dependency, similar to the one we use for
other samples.

Fixes: 5451093081db ("samples: Add fs error monitoring example")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 samples/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 147a16dafaf8..83f12c1e9ca6 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -122,7 +122,7 @@ config SAMPLE_CONNECTOR
 
 config SAMPLE_FANOTIFY_ERROR
 	bool "Build fanotify error monitoring sample"
-	depends on FANOTIFY
+	depends on CC_CAN_LINK && FANOTIFY
 	help
 	  When enabled, this builds an example code that uses the
 	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
-- 
2.29.2

