Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C159382445
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhEQG1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:27:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:28204 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhEQG1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:27:34 -0400
IronPort-SDR: HrrIJ5xOVLCyqw9arMfMhmtfcbcHLP2CKrkt+A42AGgyrNMdao6U8dzw90OfBC4y7XGwPNu66y
 /kJxGjRIxk0Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="200445076"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="200445076"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 23:26:18 -0700
IronPort-SDR: GKJ3gEEOt7aDNlLU/7l33fpdt46tZPW0TzR/TUpBQ0I9USmY64iExb2NnPsbAaInIrumEEZmUi
 7fOrFSQ/bO+g==
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="543599351"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 23:26:16 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1liWhh-00Cg2E-8B; Mon, 17 May 2021 09:26:13 +0300
Date:   Mon, 17 May 2021 09:26:13 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] printf: fix errname.c list
Message-ID: <YKIMhfhNE/6cMTIg@smile.fi.intel.com>
References: <20210514213456.745039-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514213456.745039-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 11:34:50PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On most architectures, gcc -Wextra warns about the list of error
> numbers containing both EDEADLK and EDEADLOCK:
> 
> lib/errname.c:15:67: warning: initialized field overwritten [-Woverride-init]
>    15 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
>       |                                                                   ^~~
> lib/errname.c:172:2: note: in expansion of macro 'E'
>   172 |  E(EDEADLK), /* EDEADLOCK */
>       |  ^
> 
> On parisc, a similar error happens with -ECANCELLED, which is an
> alias for ECANCELED.
> 
> Make the EDEADLK printing conditional on the number being distinct
> from EDEADLOCK, and remove the -ECANCELLED bit completely as it
> can never be hit.
> 
> To ensure these are correct, add static_assert lines that verify
> all the remaining aliases are in fact identical to the canonical
> name.

Looks good to me, thanks for fixing this.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 57f5677e535b ("printf: add support for printing symbolic error names")
> Cc: Petr Mladek <pmladek@suse.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/errname.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/errname.c b/lib/errname.c
> index 05cbf731545f..6c5c0aa4de75 100644
> --- a/lib/errname.c
> +++ b/lib/errname.c
> @@ -21,6 +21,7 @@ static const char *names_0[] = {
>  	E(EADDRNOTAVAIL),
>  	E(EADV),
>  	E(EAFNOSUPPORT),
> +	E(EAGAIN), /* EWOULDBLOCK */
>  	E(EALREADY),
>  	E(EBADE),
>  	E(EBADF),
> @@ -38,8 +39,12 @@ static const char *names_0[] = {
>  	E(ECHRNG),
>  	E(ECOMM),
>  	E(ECONNABORTED),
> +	E(ECONNREFUSED), /* EREFUSED */
>  	E(ECONNRESET),
> +	E(EDEADLK), /* EDEADLOCK */
> +#if EDEADLK != EDEADLOCK /* mips, sparc, powerpc */
>  	E(EDEADLOCK),
> +#endif
>  	E(EDESTADDRREQ),
>  	E(EDOM),
>  	E(EDOTDOT),
> @@ -166,14 +171,17 @@ static const char *names_0[] = {
>  	E(EUSERS),
>  	E(EXDEV),
>  	E(EXFULL),
> -
> -	E(ECANCELED), /* ECANCELLED */
> -	E(EAGAIN), /* EWOULDBLOCK */
> -	E(ECONNREFUSED), /* EREFUSED */
> -	E(EDEADLK), /* EDEADLOCK */
>  };
>  #undef E
>  
> +#ifdef EREFUSED /* parisc */
> +static_assert(EREFUSED == ECONNREFUSED);
> +#endif
> +#ifdef ECANCELLED /* parisc */
> +static_assert(ECANCELLED == ECANCELED);
> +#endif
> +static_assert(EAGAIN == EWOULDBLOCK); /* everywhere */
> +
>  #define E(err) [err - 512 + BUILD_BUG_ON_ZERO(err < 512 || err > 550)] = "-" #err
>  static const char *names_512[] = {
>  	E(ERESTARTSYS),
> -- 
> 2.29.2
> 

-- 
With Best Regards,
Andy Shevchenko


