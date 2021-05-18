Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E23387991
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbhERNL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:11:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:23986 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236800AbhERNLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:11:54 -0400
IronPort-SDR: QsKqHwiD17C+2v6NXuFSsuKFemycYjPlyGdHp1GMRQn2FtPIA/rQE71OMX4L8LoX4DW2OkU1IJ
 kvzzYxw5R35Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="286239246"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="286239246"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 06:10:36 -0700
IronPort-SDR: 0n4M5yTCy0Mi+RPuN+rdMPbDVdvx5/0ujHLgkmUWUJ07AfZ69DCu4sz9Op8fa71tuCRVeKtdiH
 qIVX263MwGQw==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="466401726"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 06:10:32 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lizUT-00CxZP-Ks; Tue, 18 May 2021 16:10:29 +0300
Date:   Tue, 18 May 2021 16:10:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 1/4] string_helpers: Escape double quotes in
 escape_special
Message-ID: <YKO8xeR8q5Wdv8ZT@smile.fi.intel.com>
References: <cover.1621338324.git.chris@chrisdown.name>
 <56771f7dafd884d8d2ffcf104104a0c2522391d4.1621338324.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56771f7dafd884d8d2ffcf104104a0c2522391d4.1621338324.git.chris@chrisdown.name>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 01:00:32PM +0100, Chris Down wrote:
> From an abstract point of view, escape_special's counterpart,
> unescape_special, already handles the unescaping of blackslashed double
> quote sequences.
> 
> As a more practical example, printk indexing is an example case where
> this is already practically useful. Compare an example with
> `ESCAPE_SPECIAL | ESCAPE_SPACE`, with quotes not escaped:
> 
>     [root@ktst ~]# grep drivers/pci/pci-stub.c:69 /sys/kernel/debug/printk/index/vmlinux
>     <4> drivers/pci/pci-stub.c:69 pci_stub_init "pci-stub: invalid ID string "%s"\n"
> 
> ...and the same after this patch:
> 
>     [root@ktst ~]# grep drivers/pci/pci-stub.c:69 /sys/kernel/debug/printk/index/vmlinux
>     <4> drivers/pci/pci-stub.c:69 pci_stub_init "pci-stub: invalid ID string \"%s\"\n"
> 
> One can of course, alternatively, use ESCAPE_APPEND with a quote in
> @only, but without this patch quotes are coerced into hex or octal which
> can hurt readability quite significantly.
> 
> A new ESCAPE_QUOTE/ESCAPE_PRINTK option is also possible, but it seems
> reasonable to use the simplest strategy first, since this is already
> decoded properly.

We have only one direct user of ESCAPE_SPECIAL and there " is not used.

Indirect ones are %pE, but IIRC most of them are either debug messages or some
kind of (non-ABI) messages.

It would be nice if you can confirm this and put a note into commit message.

If the above is confirmed, feel free to add mine
Reviewed-by; Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  lib/string_helpers.c      |  4 ++++
>  lib/test-string_helpers.c | 14 +++++++-------
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 5a35c7e16e96..3806a52ce697 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -361,6 +361,9 @@ static bool escape_special(unsigned char c, char **dst, char *end)
>  	case '\e':
>  		to = 'e';
>  		break;
> +	case '"':
> +		to = '"';
> +		break;
>  	default:
>  		return false;
>  	}
> @@ -474,6 +477,7 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
>   *		'\t' - horizontal tab
>   *		'\v' - vertical tab
>   *	%ESCAPE_SPECIAL:
> + *		'\"' - double quote
>   *		'\\' - backslash
>   *		'\a' - alert (BEL)
>   *		'\e' - escape
> diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
> index 2185d71704f0..437d8e6b7cb1 100644
> --- a/lib/test-string_helpers.c
> +++ b/lib/test-string_helpers.c
> @@ -140,13 +140,13 @@ static const struct test_string_2 escape0[] __initconst = {{
>  },{
>  	.in = "\\h\\\"\a\e\\",
>  	.s1 = {{
> -		.out = "\\\\h\\\\\"\\a\\e\\\\",
> +		.out = "\\\\h\\\\\\\"\\a\\e\\\\",
>  		.flags = ESCAPE_SPECIAL,
>  	},{
> -		.out = "\\\\\\150\\\\\\042\\a\\e\\\\",
> +		.out = "\\\\\\150\\\\\\\"\\a\\e\\\\",
>  		.flags = ESCAPE_SPECIAL | ESCAPE_OCTAL,
>  	},{
> -		.out = "\\\\\\x68\\\\\\x22\\a\\e\\\\",
> +		.out = "\\\\\\x68\\\\\\\"\\a\\e\\\\",
>  		.flags = ESCAPE_SPECIAL | ESCAPE_HEX,
>  	},{
>  		/* terminator */
> @@ -157,10 +157,10 @@ static const struct test_string_2 escape0[] __initconst = {{
>  		.out = "\eb \\C\007\"\x90\\r]",
>  		.flags = ESCAPE_SPACE,
>  	},{
> -		.out = "\\eb \\\\C\\a\"\x90\r]",
> +		.out = "\\eb \\\\C\\a\\\"\x90\r]",
>  		.flags = ESCAPE_SPECIAL,
>  	},{
> -		.out = "\\eb \\\\C\\a\"\x90\\r]",
> +		.out = "\\eb \\\\C\\a\\\"\x90\\r]",
>  		.flags = ESCAPE_SPACE | ESCAPE_SPECIAL,
>  	},{
>  		.out = "\\033\\142\\040\\134\\103\\007\\042\\220\\015\\135",
> @@ -169,10 +169,10 @@ static const struct test_string_2 escape0[] __initconst = {{
>  		.out = "\\033\\142\\040\\134\\103\\007\\042\\220\\r\\135",
>  		.flags = ESCAPE_SPACE | ESCAPE_OCTAL,
>  	},{
> -		.out = "\\e\\142\\040\\\\\\103\\a\\042\\220\\015\\135",
> +		.out = "\\e\\142\\040\\\\\\103\\a\\\"\\220\\015\\135",
>  		.flags = ESCAPE_SPECIAL | ESCAPE_OCTAL,
>  	},{
> -		.out = "\\e\\142\\040\\\\\\103\\a\\042\\220\\r\\135",
> +		.out = "\\e\\142\\040\\\\\\103\\a\\\"\\220\\r\\135",
>  		.flags = ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_OCTAL,
>  	},{
>  		.out = "\eb \\C\007\"\x90\r]",
> -- 
> 2.31.1
> 

-- 
With Best Regards,
Andy Shevchenko


