Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0641342F9A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 21:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCTU43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 16:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCTU4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 16:56:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2059C061574;
        Sat, 20 Mar 2021 13:56:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616273765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=spUFCRG29h9RVqTvgsvEoyAUjRhPPLoLtv+oFUv0LF0=;
        b=nCwDQB/jV3yR4x0OOWDTAYdDKYZ0AardGg3IZvXQxhRR/HF39Ty9/lxv+wr3QHCQPjZTjS
        aUaxGxANNfs/DJDEw/kHwg9TwzQ/P+x/yU+4qFaxHUPtdiFcRA4Jx03Q1LN2hRDZN7KHtt
        bGjn1ziPQIBPX5S2CAzE+41lT4EuId0KW85AtOdsDP626xmzL5XRzM7NUuudowYF2y5GV7
        F/vT0fVAFJiowedePWSqzwqaEqbIlmtUln3cVIOO+USMoYfzfkzpVw0Y7R06DGE1R8J3Jr
        PBM3bwn95Z45/u5DJm0R/kGg71BFw+sYmvVXWW0xulQh34UiOxBFtTfIJp/mUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616273765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=spUFCRG29h9RVqTvgsvEoyAUjRhPPLoLtv+oFUv0LF0=;
        b=E8W6m/skpkxgBZ4Pka4xkdMkeW6S631dx0CDwBDYcrP3kPLPcSaqW2xkXgdJhRyp1x7OzQ
        SWCNCKabqcNzPFCg==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to control state component support
In-Reply-To: <20210221185637.19281-23-chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-23-chang.seok.bae@intel.com>
Date:   Sat, 20 Mar 2021 21:56:04 +0100
Message-ID: <871rc9bl3v.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21 2021 at 10:56, Chang S. Bae wrote:
> "xstate.disable=0x60000" will disable AMX on a system that has AMX compiled
> into XFEATURE_MASK_USER_ENABLED.
>
> "xstate.enable=0x60000" will enable AMX on a system that does NOT have AMX
> compiled into XFEATURE_MASK_USER_ENABLED (assuming the kernel is new enough
> to support this feature).

This makes no sense at all.

> Rename XFEATURE_MASK_USER_SUPPORTED to XFEATURE_MASK_USER_ENABLED to be
> aligned with the new parameters.
>
> While this cmdline is currently enabled only for AMX, it is intended to be
> easily enabled to be useful for future XSAVE-enabled features.

I have a hard time to map this changelog to the actual code.

> +/* All currently enabled user features */
> +#define XFEATURE_MASK_USER_ENABLED (XFEATURE_MASK_FP | \
> +				    XFEATURE_MASK_SSE | \
> +				    XFEATURE_MASK_YMM | \
> +				    XFEATURE_MASK_OPMASK | \
> +				    XFEATURE_MASK_ZMM_Hi256 | \
> +				    XFEATURE_MASK_Hi16_ZMM	 | \
> +				    XFEATURE_MASK_PKRU | \
> +				    XFEATURE_MASK_BNDREGS | \
> +				    XFEATURE_MASK_BNDCSR | \
> +				    XFEATURE_MASK_XTILE)
  
> +
> +static u64 xstate_enable;
> +static u64 xstate_disable;

This needs to be kept around forever because it's used where outside of
__init code?

>  u64 __init fpu__get_supported_xfeatures_mask(void)
>  {
> -	u64 mask = XFEATURE_MASK_USER_SUPPORTED | XFEATURE_MASK_SUPERVISOR_SUPPORTED;
> -
> -	if (!IS_ENABLED(CONFIG_X86_64))
> -		mask &= ~(XFEATURE_MASK_XTILE);
> +	u64 mask = XFEATURE_MASK_USER_ENABLED | XFEATURE_MASK_SUPERVISOR_SUPPORTED;
> +
> +	if (!IS_ENABLED(CONFIG_X86_64)) {
> +		mask  &= ~(XFEATURE_MASK_XTILE);
> +	} else if (xstate_enable || xstate_disable) {
> +		u64 custom = mask;
> +		u64 unknown;
> +
> +		custom |= xstate_enable;
> +		custom &= ~xstate_disable;
> +
> +		unknown = custom & ~mask;
> +		if (unknown) {
> +			/*
> +			 * User should fully understand the result of using undocumented
> +			 * xstate component.
> +			 */

What is to understand here? Absolutely nothing.  This has been tried to
be smuggled into the kernel ever so often and it's again in something
which claims to do something else and the changelog is silent about it.

The argument 'it allows easier testing of new features' is absolutely
not true simply because the rest of the kernel knows absolutely nothing
about the feature and stuff would go south anyway.

We won't enable features which are unknown ever. Keep that presilicon
test gunk where it belongs: In the Intel poison cabinet along with the
rest of the code which nobody ever want's to see.

> +		}
> +
> +		if ((custom & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
> +			pr_warn("x86/fpu: Error in xstate.disable. Additionally disabling 0x%x components.\n",
> +				XFEATURE_MASK_XTILE);

What?

If the user added: xstate.disable=0x60000 to the command line, then the
code above:

> +		custom &= ~xstate_disable;

has cleared XFEATURE_MASK_XTILE in custom which makes that check true,
the warning emitted and then 

> +			custom &= ~(XFEATURE_MASK_XTILE);

this part clears out XFEATURE_MASK_XTILE once more.

> +		}

What the heck.

> +/*
> + * Longest parameter of 'xstate.enable=' is 22 octal number characters with '0' prefix and
> + * an extra '\0' for termination.
> + */
> +#define MAX_XSTATE_MASK_CHARS	24
> +/*
> + * We parse xstate parameters early because fpu__init_system() is executed before
> + * parse_early_param().
> + */
> +static void __init fpu__init_parse_early_param(void)
> +{
> +	char arg[MAX_XSTATE_MASK_CHARS];
> +
> +	if (cmdline_find_option(boot_command_line, "xstate.enable", arg, sizeof(arg)) &&
> +	    !kstrtoull(arg, 0, &xstate_enable))
> +		xstate_enable &= XFEATURE_MASK_CONFIGURABLE;

This enable thing is not going to happen.

> +	if (cmdline_find_option(boot_command_line, "xstate.disable", arg, sizeof(arg)) &&
> +	    !kstrtoull(arg, 0, &xstate_disable))
> +		xstate_disable &= XFEATURE_MASK_CONFIGURABLE;
> +}
> +

This parser needs to be called for X86_32 because?

Thanks,

        tglx
