Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF264473C8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 17:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbhKGQbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 11:31:04 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:53246 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbhKGQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 11:31:03 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 1A7GQh1E020834;
        Mon, 8 Nov 2021 01:26:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 1A7GQh1E020834
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1636302405;
        bh=95y4b+YUJWNBzDqMVnCdZ8PrZpY1+cjKzj0CIJk+uXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ttO9uhKoYmNgChd3CCaWg5CvFHR+/nyuB6Gw5rj/CdgSRzoqfQyKzFyU6cQ0EFWm2
         nU8dTxeAUd2xyHq3caF4uHtYIEU4xIux9bSnyVlMQhiXAgfWT8bAyBoN/HDsQB/wqC
         gXuFI5IXn78B2OLLXGPtAmsbGacG3HR5M5qELSwzJhYt7pQf8xN8pdHH5GthLdyQ0E
         IxYS13Ka6G6LsvhYIN7wNZfhE8NpsvP4APnFafEfRoEH/Utm5dxvSf93LXw15Z92BD
         KYKsPmUb6ClDAB6yqXOI2BdoihzpPFUF8K8S0HzjmZkggJdhhen705Y0+cah9fx4X2
         sB5IVYwTKD1Sg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/purgatory: remove -nostdlib compiler flag
Date:   Mon,  8 Nov 2021 01:26:41 +0900
Message-Id: <20211107162641.324688-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107162641.324688-1-masahiroy@kernel.org>
References: <20211107162641.324688-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -nostdlib option requests the compiler to not use the standard
system startup files or libraries when linking. It is effective only
when $(CC) is used as a linker driver.

$(LD) is directly used for linking purgatory.{ro,chk} here, hence
-nostdlib is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 95ea17a9d20c..ae53d54d7959 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -16,7 +16,7 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
-PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib
+PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
 LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
 LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
 targets += purgatory.ro purgatory.chk
-- 
2.30.2

