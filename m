Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9554324077
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbhBXPF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:05:57 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:28971 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhBXOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:10:47 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 11OE8GiZ010024;
        Wed, 24 Feb 2021 23:08:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 11OE8GiZ010024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614175697;
        bh=0plXlyBwS0CIS1+01uCTb+XHeEQAva1YcsxsVYVl0dc=;
        h=From:To:Cc:Subject:Date:From;
        b=D2qyEG3tkQrRyIDJXuWOjymsupzH4qoxRT8Z02u2nByMTaXC9xovFIIOIV6if8CR0
         efV5S1mgKq6mY+NorWnjH65fXjibY1qiDPYjgs7Yt0/Ya5DTYFxL7jG3EDIWsqmI1e
         XrtZJZ6gnl9p6KsBdql17YdAJ2O3JzVDz5oLVH94gGmR79/Enupu4PigTMKh6pXVzd
         8SjZiYf5oPcD92hE/5MB/Ek6XjS4lrfyEk/9faCiSofhaw1Rjs4nHStdzIw2BOpHmC
         k0waPOlX/VgsgPX6CBCh7Sy8Xp/6e5HtjbuMio2hLNyqHiKFBnFBPDgtZJkcuCRvvi
         oLd3TrLOYV4+Q==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        KP Singh <kpsingh@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH] init/Kconfig: make COMPILE_TEST depend on HAS_IOMEM
Date:   Wed, 24 Feb 2021 23:08:09 +0900
Message-Id: <20210224140809.1067582-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I read the commit log of the following two:

- bc083a64b6c0 ("init/Kconfig: make COMPILE_TEST depend on !UML")
- 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390")

Both are talking about HAS_IOMEM dependency missing in many drivers.

So, 'depends on HAS_IOMEM' seems the direct, sensible solution to me.

This does not change the behavior of UML. UML still cannot enable
COMPILE_TEST because it does not provide HAS_IOMEM.

The current dependency for S390 is too strong. Under the condition of
CONFIG_PCI=y, S390 provides HAS_IOMEM, hence can enable COMPILE_TEST.

I also removed the meaningless 'default n'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 init/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index ba8bd5256980..2ff0b5a50736 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -113,8 +113,7 @@ config INIT_ENV_ARG_LIMIT
 
 config COMPILE_TEST
 	bool "Compile also drivers which will not load"
-	depends on !UML && !S390
-	default n
+	depends on HAS_IOMEM
 	help
 	  Some drivers can be compiled on a different platform than they are
 	  intended to be run on. Despite they cannot be loaded there (or even
-- 
2.27.0

