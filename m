Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35923A04EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhFHUDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:03:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33794 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234833AbhFHUDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:03:49 -0400
Received: from zn.tnic (p200300ec2f16b100e640acc4c45ae2c4.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:b100:e640:acc4:c45a:e2c4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E2771EC03F0;
        Tue,  8 Jun 2021 22:01:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623182514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=po2LgWMZnX8goRzJmDW/0dlxb0eSuDZDRmohq89k3KM=;
        b=PYMTnzq0mXyTXTFZtvyiSeXFxdGKt1tb0cdF5VAGOtoruMBIc5if76S1lM4/oCOMn4JTaE
        U+EVlNph1Y3OU0RKdVNYMPYdXb/V+MJ5M59Bzm/sa6uQkVqL2gsV8OOi0QrygRqwKhx+9c
        FcSbuHlG7b8ijyirg2bBEM4ynFyb+X0=
Date:   Tue, 8 Jun 2021 22:01:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morris <James.Morris@microsoft.com>
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc5
Message-ID: <YL/MoOZFRwo261WG@zn.tnic>
References: <YLx/iA8xeRzwhXJn@zn.tnic>
 <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
 <YL029aQZb09G3ShY@linux.ibm.com>
 <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
 <YL1HLdmh55uGAIs/@zn.tnic>
 <YL1UucKH0GfXddZo@sashalap>
 <eaf8e14-12d6-6e3a-f5e5-8b504647eb48@namei.org>
 <MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
 <YL+368+oKRORwUzx@zn.tnic>
 <CAHk-=wh1nz4=72vk3+q5TuPwBF2HMY4SnBOZr6WSLp=s4KExSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh1nz4=72vk3+q5TuPwBF2HMY4SnBOZr6WSLp=s4KExSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 12:22:50PM -0700, Linus Torvalds wrote:
> On Tue, Jun 8, 2021 at 11:33 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > Linus, maybe we should at least give it a try and see whether someone
> > complains and revert, potentially...?
> 
> I already merged the change that did that.

Oh yeah, I meant: let's leave it in and try it and only revert if there's
trouble.

> It might be worth adding a comment about the verified Windows behavior
> here, but I think otherwise we're all done.

How's that (comment re-flowed):

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1e720626069a..b58cdc70f86b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1084,17 +1084,18 @@ void __init setup_arch(char **cmdline_p)
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
 

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
