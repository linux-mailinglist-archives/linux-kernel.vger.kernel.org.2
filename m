Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E9842311C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhJET7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 15:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhJET71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:59:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4773C061749;
        Tue,  5 Oct 2021 12:57:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d20002fd498dc90ccb948.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2000:2fd4:98dc:90cc:b948])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9A231EC01CE;
        Tue,  5 Oct 2021 21:57:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633463853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bSTD+YJ7AsMgF5Lwa6uxwybJxnQHhV2/XYQ6rwOH5yc=;
        b=rrKYMYVox2JWv1DVP5Rou8wB5FYDmvzrSpgMDTvVFH58Djuvwl/9wWczLQsdK1CVmm6bAb
        pBfjgPSTtSSfXvavCKW/Qw4KcyD99ltCxA4cYPDhliN+kONw2TdjmqU8cOilzM7vdKr/Yr
        k2uHE1uim0D04TSSiGrgpM67VTjMon0=
Date:   Tue, 5 Oct 2021 21:57:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] x86/Kconfig: remove reference to obsolete APB_TIMER
 config
Message-ID: <YVyuKanDJz5vaFfW@zn.tnic>
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
 <20210803113531.30720-6-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210803113531.30720-6-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 01:35:27PM +0200, Lukas Bulwahn wrote:
> Commit 1b79fc4f2bfd ("x86/apb_timer: Remove driver for deprecated
> platform") removes the definition of the config APB_TIMER in
> ./arch/x86/Kconfig, but misses to remove a reference to it in config
> X86_INTEL_MID.
> 
> Fortunately, ./scripts/checkkconfigsymbols.py warns:
> 
> APB_TIMER
> Referencing files: arch/x86/Kconfig
> 
> Remove this reference to the obsolete config.
> 
> Fixes: 1b79fc4f2bfd ("x86/apb_timer: Remove driver for deprecated platform")
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/x86/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

I've combined that and the previous one into a single patch since
they're pretty trivial:

---
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Tue, 3 Aug 2021 13:35:26 +0200
Subject: [PATCH] x86/Kconfig: Remove references to obsolete Kconfig symbols

Remove two symbols referenced in Kconfig which have been removed
previously by:

  ef3c67b6454b ("mfd: intel_msic: Remove driver for deprecated platform")
  1b79fc4f2bfd ("x86/apb_timer: Remove driver for deprecated platform")

Detected by scripts/checkkconfigsymbols.py.

  [ bp: Merge into a single patch. ]

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210803113531.30720-5-lukas.bulwahn@gmail.com
---
 arch/x86/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4e001bbbb425..b79e88ee6627 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -605,9 +605,7 @@ config X86_INTEL_MID
 	depends on X86_IO_APIC
 	select I2C
 	select DW_APB_TIMER
-	select APB_TIMER
 	select INTEL_SCU_PCI
-	select MFD_INTEL_MSIC
 	help
 	  Select to build a kernel capable of supporting Intel MID (Mobile
 	  Internet Device) platform systems which do not have the PCI legacy
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
