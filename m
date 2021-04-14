Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D22F35F194
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhDNKjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:39:14 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:38866 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbhDNKjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:39:00 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4E4BE92009C; Wed, 14 Apr 2021 12:38:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3F46092009B;
        Wed, 14 Apr 2021 12:38:28 +0200 (CEST)
Date:   Wed, 14 Apr 2021 12:38:28 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Disable HIGHMEM64G selection for M486SX
Message-ID: <alpine.DEB.2.21.2104141221340.44318@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a regression caused by making the 486SX a separate processor family, 
for which the HIGHMEM64G setting has not been updated and therefore has 
become exposed as a user selectable option for the M486SX configuration 
setting unlike with original M486 and all the other settings that choose 
non-PAE-enabled processors:

High Memory Support
> 1. off (NOHIGHMEM)
  2. 4GB (HIGHMEM4G)
  3. 64GB (HIGHMEM64G)
choice[1-3?]:

With the fix in place the setting is now correctly removed:

High Memory Support
> 1. off (NOHIGHMEM)
  2. 4GB (HIGHMEM4G)
choice[1-2?]:

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 87d6021b8143 ("x86/math-emu: Limit MATH_EMULATION to 486SX compatibles")
Cc: stable@vger.kernel.org # v5.5+
---
 arch/x86/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-x86-highmem64g-m486sx.diff
Index: linux-macro-ide/arch/x86/Kconfig
===================================================================
--- linux-macro-ide.orig/arch/x86/Kconfig
+++ linux-macro-ide/arch/x86/Kconfig
@@ -1406,7 +1406,7 @@ config HIGHMEM4G
 
 config HIGHMEM64G
 	bool "64GB"
-	depends on !M486 && !M586 && !M586TSC && !M586MMX && !MGEODE_LX && !MGEODEGX1 && !MCYRIXIII && !MELAN && !MWINCHIPC6 && !WINCHIP3D && !MK6
+	depends on !M486SX && !M486 && !M586 && !M586TSC && !M586MMX && !MGEODE_LX && !MGEODEGX1 && !MCYRIXIII && !MELAN && !MWINCHIPC6 && !WINCHIP3D && !MK6
 	select X86_PAE
 	help
 	  Select this if you have a 32-bit processor and more than 4
