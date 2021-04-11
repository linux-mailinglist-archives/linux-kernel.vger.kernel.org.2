Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A44135B1D9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 07:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhDKFyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 01:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKFyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 01:54:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2A6C06138B;
        Sat, 10 Apr 2021 22:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=SaNBURFA0COj7csdi3RrmkJ1pw97mCX9cbVvlM/9+g8=; b=bIe+F5I1L6nn9iWW8iQEFhxYaD
        Fuz75mOt8HRpbB44011Fsk4+wkhJ4o7BoEXeCszj2O0XcaBRL/yo1+ifZmveaYVSbyh0Wa/1NI5ZH
        Un+n+36mLmLB1ZM4pYIAqbZv6m09IqwRO/kAlp8RzzGkqziFMmn78lcDKr8R7TBLZmuZblGjoDLcs
        azM/+se24lDreM45gtgDRmHwOWe8zUJ683RZ2NPAJvypulwofA3jdzOVzlqxcvcwQM2yHC2oCK1Pa
        3burDeVZtLCsJ/GJPltB8yTrovcsTBT4HJ/eW2iTPHCBYUARpolw7SOQKX5zaFQ3NdVvxurcPD5fE
        0PJmb5jg==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVT2T-002cUV-HL; Sun, 11 Apr 2021 05:53:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH RESEND] csky: change a Kconfig symbol name to fix e1000 build error
Date:   Sat, 10 Apr 2021 22:53:35 -0700
Message-Id: <20210411055335.7111-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

e1000's #define of CONFIG_RAM_BASE conflicts with a Kconfig symbol in
arch/csky/Kconfig.
The symbol in e1000 has been around longer, so change arch/csky/
to use DRAM_BASE instead of RAM_BASE to remove the conflict.
(although e1000 is also a 2-line change)

Now build-tested.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: Guo Ren <guoren@linux.alibaba.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Acked-by: Guo Ren <guoren@kernel.org>
---
Andrew, please merge.

v2: Add Acked-by: Guo Ren
    Has now been build-tested.

IMO "CONFIG_" namespace should belong to Kconfig files, not
individual drivers, but e1000 isn't the only driver that uses
CONFIG_ symbols.

 arch/csky/Kconfig            |    2 +-
 arch/csky/include/asm/page.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210409.orig/arch/csky/include/asm/page.h
+++ linux-next-20210409/arch/csky/include/asm/page.h
@@ -28,7 +28,7 @@
 #define SSEG_SIZE	0x20000000
 #define LOWMEM_LIMIT	(SSEG_SIZE * 2)
 
-#define PHYS_OFFSET_OFFSET (CONFIG_RAM_BASE & (SSEG_SIZE - 1))
+#define PHYS_OFFSET_OFFSET (CONFIG_DRAM_BASE & (SSEG_SIZE - 1))
 
 #ifndef __ASSEMBLY__
 
--- linux-next-20210409.orig/arch/csky/Kconfig
+++ linux-next-20210409/arch/csky/Kconfig
@@ -314,7 +314,7 @@ config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	default "11"
 
-config RAM_BASE
+config DRAM_BASE
 	hex "DRAM start addr (the same with memory-section in dts)"
 	default 0x0
 
