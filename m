Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC3A4187DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 11:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhIZJM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 05:12:27 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:57461 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229687AbhIZJM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 05:12:26 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1mUQBL-001bVp-ID; Sun, 26 Sep 2021 11:10:47 +0200
Received: from p57bd97e9.dip0.t-ipconnect.de ([87.189.151.233] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1mUQBL-0041Cw-BF; Sun, 26 Sep 2021 11:10:47 +0200
Message-ID: <6ee982ca-6b99-da23-ec60-97ca2c317bd5@physik.fu-berlin.de>
Date:   Sun, 26 Sep 2021 11:10:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] ia64: don't do IA64_CMPXCHG_DEBUG without CONFIG_PRINTK
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-ia64@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Chris Down <chris@chrisdown.name>
References: <20210926063325.13581-1-rdunlap@infradead.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <20210926063325.13581-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.151.233
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy!

On 9/26/21 08:33, Randy Dunlap wrote:
> When CONFIG_PRINTK is not set, the CMPXCHG_BUGCHECK() macro calls
> _printk(), but _printk() is a static inline function, not available
> as an extern.
> Since the purpose of the macro is to print the BUGCHECK info,
> make this config option depend on PRINTK.
> 
> Fixes multiple occurrences of this build error:
> 
> ../include/linux/printk.h:208:5: error: static declaration of '_printk' follows non-static declaration
>   208 | int _printk(const char *s, ...)
>       |     ^~~~~~~
> In file included from ../arch/ia64/include/asm/cmpxchg.h:5,
> ../arch/ia64/include/uapi/asm/cmpxchg.h:146:28: note: previous declaration of '_printk' with type 'int(const char *, ...)'
>   146 |                 extern int _printk(const char *fmt, ...);
> 
> Fixes: 337015573718 ("printk: Userspace format indexing support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-ia64@vger.kernel.org
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Chris Down <chris@chrisdown.name>
> ---
>  arch/ia64/Kconfig.debug |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210917.orig/arch/ia64/Kconfig.debug
> +++ linux-next-20210917/arch/ia64/Kconfig.debug
> @@ -39,7 +39,7 @@ config DISABLE_VHPT
>  
>  config IA64_DEBUG_CMPXCHG
>  	bool "Turn on compare-and-exchange bug checking (slow!)"
> -	depends on DEBUG_KERNEL
> +	depends on DEBUG_KERNEL && PRINTK
>  	help
>  	  Selecting this option turns on bug checking for the IA-64
>  	  compare-and-exchange instructions.  This is slow!  Itaniums

We currently don't have a maintainer for ia64 - although I would be willing to pick
up the job - so your patch would have to go through someone else's tree.

I can boot test the patch on my RX2660 in the mean time.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

