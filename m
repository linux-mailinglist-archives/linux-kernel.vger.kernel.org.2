Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D1F34E5CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhC3Kvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:51:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:49494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231370AbhC3Kv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:51:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617101486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j0lrK2HLvgqtjwQNyAR8wDQpb72WULjjxhR0tTcwAR4=;
        b=u2Zs7iXhTEI+aqxEpzy0q1lBVzxNz9X3Li9OgAGWgdzg2mmzDI5n+Kx2DRW+SvW3UvkeiO
        I/pkw4LJYO8B3rgwUyTVMS607hHB5snXldDbj3JfR7MUV91kpHu2dQm6sn0UzTPxqFQtRe
        XTI6K85LKK0XFCK8IupQFbH6/VMj2Vk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5964B148;
        Tue, 30 Mar 2021 10:51:26 +0000 (UTC)
Date:   Tue, 30 Mar 2021 12:51:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 04/12] module: Add printk format to add module build
 ID to stacktraces
Message-ID: <YGMCrlUAlcxdlt06@alley>
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <20210324020443.1815557-5-swboyd@chromium.org>
 <6dfb8ca2-20f3-e58a-ad6b-db6a6472afe0@rasmusvillemoes.dk>
 <161661308874.3012082.15483899786731677633@swboyd.mtv.corp.google.com>
 <2785cae4-20be-85b5-7838-9a6dbd2baf72@rasmusvillemoes.dk>
 <161662492346.3012082.17886011577458863951@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161662492346.3012082.17886011577458863951@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-24 15:28:43, Stephen Boyd wrote:
> Quoting Rasmus Villemoes (2021-03-24 15:21:34)
> > On 24/03/2021 20.11, Stephen Boyd wrote:
> > > Quoting Rasmus Villemoes (2021-03-24 02:57:13)
> > 
> > >>
> > >> Is there any reason you didn't just make b an optional flag that could
> > >> be specified with or without R? I suppose the parsing is more difficult
> > >> with several orthogonal flags (see escaped_string()), but it's a little
> > >> easier to understand. Dunno, it's not like we're gonna think of 10 other
> > >> things that could be printed for a symbol, so perhaps it's fine.
> > >>
> > > 
> > > I think I follow. So %pSb or %pSRb? If it's easier to understand then
> > > sure. I was trying to avoid checking another character beyond fmt[1] but
> > > it should be fine if fmt[1] is already 'R'.
> 
> I'm inclined to use %pSb and %pSRb. The code looks to simpler and I
> suppose we can worry about different ordering/combination problems if it
> comes to it.
>
> ---8<---
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 41ddc353ebb8..0e94cba5ba20 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -968,6 +968,8 @@ char *symbol_string(char *buf, char *end, void *ptr,
>  #ifdef CONFIG_KALLSYMS
>         if (*fmt == 'B')
>                 sprint_backtrace(sym, value);
> +       else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
> +               sprint_symbol_stacktrace(sym, value);
>         else if (*fmt != 's')
>                 sprint_symbol(sym, value);
>         else

I prefer the extra "b" flag as well. It helps me to understand and
memorize[*] the meaning.

[*] at least short-time memorize ;-)

Best Regards,
Petr
