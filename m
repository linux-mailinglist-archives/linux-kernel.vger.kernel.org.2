Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8933A052A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbhFHUcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:32:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37956 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234000AbhFHUcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:32:45 -0400
Received: from zn.tnic (p200300ec2f16b100e640acc4c45ae2c4.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:b100:e640:acc4:c45a:e2c4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 412561EC03F0;
        Tue,  8 Jun 2021 22:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623184251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pYTEA7ZFfdn94rXPwQz8ZqU+46Urht6x/74neWtZvZY=;
        b=WFNATtg8GZelRPM5pYMEpGNg66evBRzZeyfwjanYoBaIgAMoZMsL6pjaeou8Ge9S3kDH7Q
        1jCxB9gEX1mZ4u3rHms6QV7ziDTvEZxAOlBDyannKYU8cmJCkFkALKhFtc10nsRrs9ZyFe
        aDZ4ciXCSbFzknJqNl0kGocOmuNS2bo=
Date:   Tue, 8 Jun 2021 22:30:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morris <James.Morris@microsoft.com>
Subject: [PATCH] x86/setup: Document that Windows reserves the first MiB
Message-ID: <YL/Tc1bGkgXKRKfT@zn.tnic>
References: <YL029aQZb09G3ShY@linux.ibm.com>
 <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
 <YL1HLdmh55uGAIs/@zn.tnic>
 <YL1UucKH0GfXddZo@sashalap>
 <eaf8e14-12d6-6e3a-f5e5-8b504647eb48@namei.org>
 <MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
 <YL+368+oKRORwUzx@zn.tnic>
 <CAHk-=wh1nz4=72vk3+q5TuPwBF2HMY4SnBOZr6WSLp=s4KExSA@mail.gmail.com>
 <YL/MoOZFRwo261WG@zn.tnic>
 <CAHk-=wh7BWwNR5+z7bn1xxa1Rc1Dzo-SDnahJ2cLePmRcG8uWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh7BWwNR5+z7bn1xxa1Rc1Dzo-SDnahJ2cLePmRcG8uWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does so unconditionally too, on Intel and AMD machines, to work
around BIOS bugs, as confirmed by Microsoft folks (see Link for full
details).

Reflow the paragraph, while at it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com
---
 arch/x86/kernel/setup.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 7638ac6c3d80..85acd22f8022 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1060,17 +1060,18 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	/*
-	 * Find free memory for the real mode trampoline and place it
-	 * there.
-	 * If there is not enough free memory under 1M, on EFI-enabled
-	 * systems there will be additional attempt to reclaim the memory
-	 * for the real mode trampoline at efi_free_boot_services().
+	 * Find free memory for the real mode trampoline and place it there. If
+	 * there is not enough free memory under 1M, on EFI-enabled systems
+	 * there will be additional attempt to reclaim the memory for the real
+	 * mode trampoline at efi_free_boot_services().
 	 *
-	 * Unconditionally reserve the entire first 1M of RAM because
-	 * BIOSes are know to corrupt low memory and several
-	 * hundred kilobytes are not worth complex detection what memory gets
-	 * clobbered. Moreover, on machines with SandyBridge graphics or in
-	 * setups that use crashkernel the entire 1M is reserved anyway.
+	 * Unconditionally reserve the entire first 1M of RAM because BIOSes
+	 * are known to corrupt low memory and several hundred kilobytes are not
+	 * worth complex detection what memory gets clobbered. Windows does the
+	 * same thing for very similar reasons.
+	 *
+	 * Moreover, on machines with SandyBridge graphics or in setups that use
+	 * crashkernel the entire 1M is reserved anyway.
 	 */
 	reserve_real_mode();
 
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
