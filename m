Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF6F3E963C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhHKQmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:42:37 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:29574 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhHKQmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:42:24 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 17BGfJMe000861;
        Thu, 12 Aug 2021 01:41:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 17BGfJMe000861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1628700079;
        bh=Rbj4LRb3BCdM0qtfZP8nAj3m5NMYkLYyA0Fn1DSu1qs=;
        h=From:To:Cc:Subject:Date:From;
        b=JSjLsq6vTZ2Ep+n4dFIsMUW/5qW6jwH9HzUPLs7pTfofVJAgLud1OtyFiPndf/qOg
         i0N/ApsF96BSvU+CJPZoUr+yqfhxkKGIJEM6wbicq33+JhHlmjmcJOs1ZiNdaaS9Gd
         6K+fqwrymStYFezQ43qHTma2PpCvSY68Lj49m/ec6yKys5vzUWkGv51soDuqx6aQ6s
         uuVxXnY3vyqxUzJji2P7F2dnDRqoBV6dYhPHlsIB5CZ78RmJ/GzRMBzgFOZ31kpvzG
         DzLuw442JLR0xAgPsExgXmmdu6ruTlUJfcIBZRUuymgvC0O3t6nAPPFoWRVAFSE3cn
         D5/VTW2o5sSZA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: move core-y in arch/parisc/Makefile to arch/parisc/Kbuild
Date:   Thu, 12 Aug 2021 01:41:16 +0900
Message-Id: <20210811164116.186844-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use obj-y to clean up Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/Kbuild   | 1 +
 arch/parisc/Makefile | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/parisc/Kbuild b/arch/parisc/Kbuild
index a4e40e534e6a..3c068b700a81 100644
--- a/arch/parisc/Kbuild
+++ b/arch/parisc/Kbuild
@@ -1 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-y	+= mm/ kernel/ math-emu/
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index aed8ea29268b..6c27940eff03 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -111,9 +111,6 @@ KBUILD_CFLAGS	+= $(cflags-y)
 LIBGCC		:= $(shell $(CC) -print-libgcc-file-name)
 export LIBGCC
 
-kernel-y			:= mm/ kernel/ math-emu/
-
-core-y	+= $(addprefix arch/parisc/, $(kernel-y))
 libs-y	+= arch/parisc/lib/ $(LIBGCC)
 
 boot	:= arch/parisc/boot
-- 
2.30.2

