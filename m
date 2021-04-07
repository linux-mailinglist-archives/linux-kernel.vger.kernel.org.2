Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6CA356FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353242AbhDGPEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:04:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:33200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353265AbhDGPD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:03:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617807827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWjtgwlc40LyIVjpijUdpIKHSVQDYdEuOTFd1/ekuL4=;
        b=tSFVehHOHj7JPE5qsRkpLw2Bf68H8A5KWPjwYNx0J7NOka/Q0GZSBLVdyplH1DpbT7+Gsz
        abYSx7yXvAVRjZ5YUi2VwxIG+kalFdhy85ch9IRDmY/3+DL9KaZHiojeN/R3YFkd6DzqK9
        ltgihM5gyMXc8g2QKEfiAe9Btm+PJpk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA0E4B166;
        Wed,  7 Apr 2021 15:03:47 +0000 (UTC)
Date:   Wed, 7 Apr 2021 17:03:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 04/12] module: Add printk format to add module build
 ID to stacktraces
Message-ID: <YG3J03GY+QqtKMlu@alley>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331030520.3816265-5-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-30 20:05:12, Stephen Boyd wrote:
> Let's make kernel stacktraces easier to identify by including the build
> ID[1] of a module if the stacktrace is printing a symbol from a module.
> This makes it simpler for developers to locate a kernel module's full
> debuginfo for a particular stacktrace. Combined with
> scripts/decode_stracktrace.sh, a developer can download the matching
> debuginfo from a debuginfod[2] server and find the exact file and line
> number for the functions plus offsets in a stacktrace that match the
> module. This is especially useful for pstore crash debugging where the
> kernel crashes are recorded in something like console-ramoops and the
> recovery kernel/modules are different or the debuginfo doesn't exist on
> the device due to space concerns (the debuginfo can be too large for
> space limited devices).
> 
> @@ -359,15 +369,17 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
>  
>  /* Look up a kernel symbol and return it in a text buffer. */
>  static int __sprint_symbol(char *buffer, unsigned long address,
> -			   int symbol_offset, int add_offset)
> +			   int symbol_offset, int add_offset, int add_buildid)
>  {
>  	char *modname;
> +	const unsigned char *buildid;
>  	const char *name;
>  	unsigned long offset, size;
>  	int len;
>  
>  	address += symbol_offset;
> -	name = kallsyms_lookup(address, &size, &offset, &modname, buffer);
> +	name = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
> +				       buffer);
>  	if (!name)
>  		return sprintf(buffer, "0x%lx", address - symbol_offset);
>  
> @@ -379,8 +391,12 @@ static int __sprint_symbol(char *buffer, unsigned long address,
>  	if (add_offset)
>  		len += sprintf(buffer + len, "+%#lx/%#lx", offset, size);

Please add something like:

	/* Keep BUILD_ID_SIZE_MAX in sync with the below used %20phN */
	BUILD_BUG_ON(BUILD_ID_SIZE_MAX != 20)

to make sure the the hard

>  
> -	if (modname)
> -		len += sprintf(buffer + len, " [%s]", modname);
> +	if (modname) {
> +		len += sprintf(buffer + len, " [%s", modname);
> +		if (IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) && add_buildid && buildid)
> +			len += sprintf(buffer + len, " %20phN", buildid);
> +		len += sprintf(buffer + len, "]");
> +	}
>  
>  	return len;
>  }

Otherwise the approach looks fine to me. The main problem is that it
does not work for me as described in the other reply ;-)

Best Regards,
Petr
