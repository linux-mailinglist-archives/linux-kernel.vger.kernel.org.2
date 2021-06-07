Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6781B39E504
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhFGRPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:15:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:59311 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhFGRPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:15:10 -0400
IronPort-SDR: MZNPIt3NCCUa36VtoPaT37TrTE2NoW1r6ql7mEvrWCHCD4snguvtNeqWy7LwPZ9ucx34iYhYs0
 Rx1yYwpCZbXw==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="204479510"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="204479510"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 10:13:03 -0700
IronPort-SDR: 1oAeD0K29r2CbuCU96LJZYqgyd4nulaV92oTSx455D5i4oBr8ORmmtXYMVeawaVfpqpBW8BAii
 Ct6ykYBm2aAA==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="401748140"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 10:13:01 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lqIo7-000JPs-1T; Mon, 07 Jun 2021 20:12:59 +0300
Date:   Mon, 7 Jun 2021 20:12:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] powerpc/prom_init: Move custom isspace() to its
 own namespace
Message-ID: <YL5Tm7jZaaQ0POH5@smile.fi.intel.com>
References: <20210510144925.58195-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510144925.58195-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 05:49:25PM +0300, Andy Shevchenko wrote:
> If by some reason any of the headers will include ctype.h
> we will have a name collision. Avoid this by moving isspace()
> to the dedicate namespace.
> 
> First appearance of the code is in the commit cf68787b68a2
> ("powerpc/prom_init: Evaluate mem kernel parameter for early allocation").

Any comments on this?

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/powerpc/kernel/prom_init.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 41ed7e33d897..6845cbbc0cd4 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -701,13 +701,13 @@ static int __init prom_setprop(phandle node, const char *nodename,
>  }
>  
>  /* We can't use the standard versions because of relocation headaches. */
> -#define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
> -			 || ('a' <= (c) && (c) <= 'f') \
> -			 || ('A' <= (c) && (c) <= 'F'))
> +#define prom_isxdigit(c)	(('0' <= (c) && (c) <= '9') \
> +				 || ('a' <= (c) && (c) <= 'f') \
> +				 || ('A' <= (c) && (c) <= 'F'))
>  
> -#define isdigit(c)	('0' <= (c) && (c) <= '9')
> -#define islower(c)	('a' <= (c) && (c) <= 'z')
> -#define toupper(c)	(islower(c) ? ((c) - 'a' + 'A') : (c))
> +#define prom_isdigit(c)		('0' <= (c) && (c) <= '9')
> +#define prom_islower(c)		('a' <= (c) && (c) <= 'z')
> +#define prom_toupper(c)		(prom_islower(c) ? ((c) - 'a' + 'A') : (c))
>  
>  static unsigned long prom_strtoul(const char *cp, const char **endp)
>  {
> @@ -716,14 +716,14 @@ static unsigned long prom_strtoul(const char *cp, const char **endp)
>  	if (*cp == '0') {
>  		base = 8;
>  		cp++;
> -		if (toupper(*cp) == 'X') {
> +		if (prom_toupper(*cp) == 'X') {
>  			cp++;
>  			base = 16;
>  		}
>  	}
>  
> -	while (isxdigit(*cp) &&
> -	       (value = isdigit(*cp) ? *cp - '0' : toupper(*cp) - 'A' + 10) < base) {
> +	while (prom_isxdigit(*cp) &&
> +	       (value = prom_isdigit(*cp) ? *cp - '0' : prom_toupper(*cp) - 'A' + 10) < base) {
>  		result = result * base + value;
>  		cp++;
>  	}
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


