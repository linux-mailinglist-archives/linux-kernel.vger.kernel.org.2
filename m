Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEFD4186B8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 08:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhIZGfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 02:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhIZGfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 02:35:04 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D609C061570;
        Sat, 25 Sep 2021 23:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=waCOeT4+Z0Ug7ewSDQv+n5+FK5owylBFTxfyHY08lGY=; b=bvXvLlGHr5uTg2W4Dfol7Cewsk
        0KWITElrJ6bWouKm4EhseHCiHhJ6mWIFkOAcreG9HMkGjxJ+jZni34ZhnYGnV9fWSl2eEcEv23HaL
        fUgT6Kz4Ns9xrbDlgAV/ePMGyV/uYzleA8J31udHOwx+F251NIRF1Qi3nEwv67gdA3REq7GIWjn6D
        w8j4Q7YHqQkJgkBHFAeFnIsSoVThJoplt27LuSXyu/aFppHHfdrkhbWj+2DNaWxSNljHzsLFFV1Xy
        dV9qDgH2ocB01G2ywYaMo5YoeahUT0R3DbXQORc3f/zg6Wc1U/b1Dry+OeMSVq+DWbP+hzU67Ozxi
        ZbLdJDRw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUNj4-0005xW-W1; Sun, 26 Sep 2021 06:33:27 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-ia64@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Chris Down <chris@chrisdown.name>
Subject: [PATCH] ia64: don't do IA64_CMPXCHG_DEBUG without CONFIG_PRINTK
Date:   Sat, 25 Sep 2021 23:33:25 -0700
Message-Id: <20210926063325.13581-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PRINTK is not set, the CMPXCHG_BUGCHECK() macro calls
_printk(), but _printk() is a static inline function, not available
as an extern.
Since the purpose of the macro is to print the BUGCHECK info,
make this config option depend on PRINTK.

Fixes multiple occurrences of this build error:

../include/linux/printk.h:208:5: error: static declaration of '_printk' follows non-static declaration
  208 | int _printk(const char *s, ...)
      |     ^~~~~~~
In file included from ../arch/ia64/include/asm/cmpxchg.h:5,
../arch/ia64/include/uapi/asm/cmpxchg.h:146:28: note: previous declaration of '_printk' with type 'int(const char *, ...)'
  146 |                 extern int _printk(const char *fmt, ...);

Fixes: 337015573718 ("printk: Userspace format indexing support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-ia64@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Chris Down <chris@chrisdown.name>
---
 arch/ia64/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210917.orig/arch/ia64/Kconfig.debug
+++ linux-next-20210917/arch/ia64/Kconfig.debug
@@ -39,7 +39,7 @@ config DISABLE_VHPT
 
 config IA64_DEBUG_CMPXCHG
 	bool "Turn on compare-and-exchange bug checking (slow!)"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && PRINTK
 	help
 	  Selecting this option turns on bug checking for the IA-64
 	  compare-and-exchange instructions.  This is slow!  Itaniums
