Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F68C358BF7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhDHSNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232281AbhDHSNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:13:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B6D3610C8;
        Thu,  8 Apr 2021 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617905577;
        bh=srcP1POWJBP8EPl3rQLISqPDTr2hkWQ0RrdqLHmlAUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UJKA4y4ZjWUD7wjS+Ek2nii2ja6PIv6PzC+WASHTZRtqgAMksAdSQSe6eKSarpcGY
         9LI6D0pLiLGBxs0z3IinkULJjYQQngN9JIkIfPsUFrbBbMDapPYLCQGagxz19h+O0n
         DVwq0LXM+NFP5+2L/+OW53kXDv4dbubAIwIEHFRA=
Date:   Thu, 8 Apr 2021 20:12:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Quentin Perret <qperret@google.com>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        maennich@google.com, gprocida@google.com, kernel-team@android.com
Subject: Re: [PATCH] export: Make CRCs robust to symbol trimming
Message-ID: <YG9Hp9NLACw57vu/@kroah.com>
References: <20210408180105.2496212-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408180105.2496212-1-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 06:01:05PM +0000, Quentin Perret wrote:
> The CRC calculation done by genksyms is triggered when the parser hits
> EXPORT_SYMBOL*() macros. At this point, genksyms recursively expands the
> types, and uses that as the input for the CRC calculation. In the case
> of forward-declared structs, the type expands to 'UNKNOWN'. Next, the
> result of the expansion of each type is cached, and is re-used when/if
> the same type is seen again for another exported symbol in the file.
> 
> Unfortunately, this can cause CRC 'stability' issues when a struct
> definition becomes visible in the middle of a C file. For example, let's
> assume code with the following pattern:
> 
>     struct foo;
> 
>     int bar(struct foo *arg)
>     {
> 	/* Do work ... */
>     }
>     EXPORT_SYMBOL_GPL(bar);
> 
>     /* This contains struct foo's definition */
>     #include "foo.h"
> 
>     int baz(struct foo *arg)
>     {
> 	/* Do more work ... */
>     }
>     EXPORT_SYMBOL_GPL(baz);
> 
> Here, baz's CRC will be computed using the expansion of struct foo that
> was cached after bar's CRC calculation ('UNKOWN' here). But if
> EXPORT_SYMBOL_GPL(bar) is removed from the file (because of e.g. symbol
> trimming using CONFIG_TRIM_UNUSED_KSYMS), struct foo will be expanded
> late, during baz's CRC calculation, which now has visibility over the
> full struct definition, hence resulting in a different CRC for baz.
> 
> This can cause annoying issues for distro kernel (such as the Android
> Generic Kernel Image) which use CONFIG_UNUSED_KSYMS_WHITELIST. Indeed,
> as per the above, adding a symbol to the whitelist can change the CRC of
> symbols that are already kept exported. As such, modules built against a
> kernel with a trimmed ABI may not load against the same kernel built
> with an extended whitelist, even though they are still strictly binary
> compatible. While rebuilding the modules would obviously solve the
> issue, I believe this classifies as an odd genksyms corner case, and it
> gets in the way of kernel updates in the GKI context.
> 
> To work around the issue, make sure to keep issuing the
> __GENKSYMS_EXPORT_SYMBOL macros for all trimmed symbols, hence making
> the genksyms parsing insensitive to symbol trimming.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  include/linux/export.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 6271a5d9c988..27d848712b90 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -140,7 +140,12 @@ struct kernel_symbol {
>  #define ___cond_export_sym(sym, sec, ns, enabled)			\
>  	__cond_export_sym_##enabled(sym, sec, ns)
>  #define __cond_export_sym_1(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
> +
> +#ifdef __GENKSYMS__
> +#define __cond_export_sym_0(sym, sec, ns) __GENKSYMS_EXPORT_SYMBOL(sym)
> +#else
>  #define __cond_export_sym_0(sym, sec, ns) /* nothing */
> +#endif
>  
>  #else
>  

Anything to help make these symbol values more "stable" is good, they
drive me crazy...

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
