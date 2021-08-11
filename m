Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C9A3E9624
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhHKQit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:38:49 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:24493 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhHKQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:38:45 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 17BGbXJ0027140;
        Thu, 12 Aug 2021 01:37:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 17BGbXJ0027140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1628699854;
        bh=2Er+QKd5Ko20deRGrSXJT5qge6sZHPDP5YZQuMjEZ7w=;
        h=From:To:Cc:Subject:Date:From;
        b=Ft0nJbzedZBO2jy1hxu7A5L0tSQGzE8VEozrXX2HQdh92QLFiQBR0uxGHYH5jcf3J
         8LyqckdJgnu4WwJsUnLyPemTGfgNk9aTFABrv8mI9NPr+sOr5ET2q3Dn1s8/BWVqsZ
         bvjPfpYTkuf2cFdmhWLrK7aOF+qUhMNGIZdEGEIJUOTV1CeJolQHaIzQnQtgqrfZWx
         kTaGUaKxFpsB3+JU900omGp9esMMQVcRUhSF0oeof0YrTJo8r6MQv6yB+rUy+VJwuH
         ySUMgXq9OAdOtl++bpFjIojsNnxGLzbyy4T1f2c2w3U4P/L1KMTZDaDcXZrdAX1qYK
         n1bSvm0KP7Knw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] xtensa: remove unneeded exports
Date:   Thu, 12 Aug 2021 01:37:28 +0900
Message-Id: <20210811163731.186125-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are not used in any of subdirectories.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/xtensa/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index e9c8f064c44d..6fab7fc87579 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -17,7 +17,6 @@
 variant-y := $(patsubst "%",%,$(CONFIG_XTENSA_VARIANT_NAME))
 
 VARIANT = $(variant-y)
-export VARIANT
 
 ifneq ($(VARIANT),)
   ifdef cross_compiling
@@ -34,7 +33,6 @@ platform-$(CONFIG_XTENSA_PLATFORM_ISS)		:= iss
 platform-$(CONFIG_XTENSA_PLATFORM_XTFPGA)	:= xtfpga
 
 PLATFORM = $(platform-y)
-export PLATFORM
 
 # temporarily until string.h is fixed
 KBUILD_CFLAGS += -ffreestanding -D__linux__
-- 
2.30.2

