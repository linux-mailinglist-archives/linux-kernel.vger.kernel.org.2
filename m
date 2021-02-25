Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2BF325137
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 15:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhBYOFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:05:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhBYOFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:05:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F026464F10;
        Thu, 25 Feb 2021 14:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614261865;
        bh=ZzbiSO0LdphYU9+gCAqnHrrBWjpkRFL5HzaqbcKijYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ajwGja5mim9LQAOngcHGPFoYR/V0G1HRZdQ8UywAL2SZcAagocp47a/U8UbtT6uJz
         SKEdR8zhLSmwNjFLAebeKLtzmRBq0MacIteXK2QHwEXDbejskT2HAnozZ9I/b/G7DO
         mnHoX2cKReMMx6sIigZwGO+cIp8nE3bjxumR8HoDGK45WNzORNp6E98N8m3H/j+mXM
         pbnseAzBHRQBcz7KVSluoYSRk82nxabkwq2CWGpHY8wt7ZbJLldWLXJADbpF8G68h5
         daiF7AdsGff4sya4oMOdLxGaqvtlnFsKRe3P5zK8mM92btDshSc8ZgEHGjAiU6tpK4
         SE+jSDXO0EpDQ==
Date:   Thu, 25 Feb 2021 14:04:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Max Uvarov <muvarov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: cpufeatures: Fix handling of CONFIG_CMDLINE
 for idreg overrides
Message-ID: <20210225140419.GB13297@willie-the-truck>
References: <20210225125921.13147-1-will@kernel.org>
 <20210225125921.13147-2-will@kernel.org>
 <87zgzsz217.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgzsz217.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 01:53:56PM +0000, Marc Zyngier wrote:
> On Thu, 25 Feb 2021 12:59:20 +0000,
> Will Deacon <will@kernel.org> wrote:
> > 
> > The built-in kernel commandline (CONFIG_CMDLINE) can be configured in
> > three different ways:
> > 
> >   1. CMDLINE_FORCE: Use CONFIG_CMDLINE instead of any bootloader args
> >   2. CMDLINE_EXTEND: Append the bootloader args to CONFIG_CMDLINE
> >   3. CMDLINE_FROM_BOOTLOADER: Only use CONFIG_CMDLINE if there aren't
> >      any bootloader args.
> > 
> > The early cmdline parsing to detect idreg overrides gets (2) and (3)
> > slightly wrong: in the case of (2) the bootloader args are parsed first
> > and in the case of (3) the CMDLINE is always parsed.
> > 
> > Fix these issues by moving the bootargs parsing out into a helper
> > function and following the same logic as that used by the EFI stub.
> > 
> > Cc: Marc Zyngier <maz@kernel.org>
> > Fixes: 33200303553d ("arm64: cpufeature: Add an early command-line cpufeature override facility")
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/kernel/idreg-override.c | 44 +++++++++++++++++-------------
> >  1 file changed, 25 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> > index dffb16682330..cc071712c6f9 100644
> > --- a/arch/arm64/kernel/idreg-override.c
> > +++ b/arch/arm64/kernel/idreg-override.c
> > @@ -163,33 +163,39 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
> >  	} while (1);
> >  }
> >  
> > -static __init void parse_cmdline(void)
> > +static __init const u8 *get_bootargs_cmdline(void)
> >  {
> > -	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
> > -		const u8 *prop;
> > -		void *fdt;
> > -		int node;
> > +	const u8 *prop;
> > +	void *fdt;
> > +	int node;
> >  
> > -		fdt = get_early_fdt_ptr();
> > -		if (!fdt)
> > -			goto out;
> > +	fdt = get_early_fdt_ptr();
> > +	if (!fdt)
> > +		return NULL;
> >  
> > -		node = fdt_path_offset(fdt, "/chosen");
> > -		if (node < 0)
> > -			goto out;
> > +	node = fdt_path_offset(fdt, "/chosen");
> > +	if (node < 0)
> > +		return NULL;
> >  
> > -		prop = fdt_getprop(fdt, node, "bootargs", NULL);
> > -		if (!prop)
> > -			goto out;
> > +	prop = fdt_getprop(fdt, node, "bootargs", NULL);
> > +	if (!prop)
> > +		return NULL;
> >  
> > -		__parse_cmdline(prop, true);
> > +	return strlen(prop) ? prop : NULL;
> > +}
> >  
> > -		if (!IS_ENABLED(CONFIG_CMDLINE_EXTEND))
> > -			return;
> > +static __init void parse_cmdline(void)
> > +{
> > +	const u8 *prop = get_bootargs_cmdline();
> > +
> > +	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
> > +	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
> > +	    !prop) {
> 
> The logic hurts, but I think I grok it now. The last term is actually
> a reduction of
> 
> 	(IS_ENABLED(CONFIG_CMDLINE_FROM_BOOTLOADER) && !prop)
> 
> and we know for sure that if none of the other two terms are true,
> then CMDLINE_FROM_BOOTLOADER *must* be enabled.

Yes, with one gotcha: when CONFIG_CMDLINE is "", I don't think any of the
CONFIG_CMDLINE_* are set, but the behaviour ends up being the same as
CMDLINE_FROM_BOOTLOADER.

> 
> > +		__parse_cmdline(CONFIG_CMDLINE, true);
> >  	}
> >  
> > -out:
> > -	__parse_cmdline(CONFIG_CMDLINE, true);
> > +	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && prop)
> > +		__parse_cmdline(prop, true);
> >  }
> >  
> >  /* Keep checkers quiet */
> 
> I don't think we need to backport anything to stable for the nokaslr
> handling, do we?

No, I don't think so. There isn't a "kaslr" or "nonokaslr", so the ordering
doesn't matter afaict.

> Reviewed-by: Marc Zyngier <maz@kernel.org>

Cheers!

Will
