Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8B3400DC5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 04:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhIEBhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 21:37:50 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:37962 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230185AbhIEBht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 21:37:49 -0400
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 85004180F3235;
        Sun,  5 Sep 2021 01:36:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 3DBBF2448B4;
        Sun,  5 Sep 2021 01:36:42 +0000 (UTC)
Message-ID: <a109e614f82891ef6e99b0ab3535a90ccaf04181.camel@perches.com>
Subject: Re: [PATCH v2 1/2] lib: add sputchar() helper
From:   Joe Perches <joe@perches.com>
To:     Yury Norov <yury.norov@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Down <chris@chrisdown.name>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Ingo Molnar <mingo@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Date:   Sat, 04 Sep 2021 18:36:41 -0700
In-Reply-To: <20210904231020.331185-2-yury.norov@gmail.com>
References: <20210904231020.331185-1-yury.norov@gmail.com>
         <20210904231020.331185-2-yury.norov@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3DBBF2448B4
X-Spam-Status: No, score=-1.13
X-Stat-Signature: t98tkm18ypq3owe69faj3w56jk9yhahf
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+VM8n5Kky5gQP7FnH2SvXr4BaHweLyZOU=
X-HE-Tag: 1630805802-980154
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-09-04 at 16:10 -0700, Yury Norov wrote:
> There are 47 occurrences of the code snippet like this:
> 	if (buf < end)
> 	        *buf = ' ';
> 	++buf;
> 
> This patch adds a helper function sputchar() to replace opencoding.
> It adds a lot to readability, and also saves 43 bytes of text on x86.

I think this patch does little to improve readability.

Perhaps make it void and use something like

	sputchar(*buf++, end, <whateverchar>);

Though the sputchar name doesn't seems particularly intelligible.

> +static inline char *sputchar(char *buf, const char *end, char c)
> +{
> +	if (buf < end)
> +		*buf = c;
> +
> +	return buf + 1;
> +}
> +
>  /*
>   * General tracing related utility functions - trace_printk(),
>   * tracing_on/tracing_off and tracing_start()/tracing_stop
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
[]
> @@ -335,12 +335,8 @@ static bool escape_space(unsigned char c, char **dst, char *end)
>  		return false;
>  	}
> 
> -	if (out < end)
> -		*out = '\\';
> -	++out;
> -	if (out < end)
> -		*out = to;
> -	++out;
> +	out = sputchar(out, end, '\\');
> +	out = sputchar(out, end, to);

etc...


