Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA0339B84A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFDLw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:52:56 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46654 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhFDLwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:52:54 -0400
Received: by mail-wr1-f54.google.com with SMTP id a11so7135062wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gqK/E/daHzJM8CuLthT+YIARYT9rE2qIzkBiMsN6UF4=;
        b=nQX7MG2oaeBlc2Bp1FkXXGnUeR1qgth1oehqRq6f4gv0HU9+bnDIvFAPVy183pz0Gv
         ttryhr9yLacOWCxp0FWLd2KyfqTe8ZO5tgP1jj0YiQ2mUA+WYODwbX1DZub5cubr0K0k
         LX2L4R4UuEbLsrkRcKAm9yjiP20XGfWDKW9sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gqK/E/daHzJM8CuLthT+YIARYT9rE2qIzkBiMsN6UF4=;
        b=TdldAdnXlStwqZK64Z+6kNzAuwlmCq2tPfhl/lSP3KPjaVdz9e4EOaxs92OfYPoa7c
         f6OkEuA8yP/uvnxpEaDLG3+fal9c1l24WYWNyuQVqalKGCI0+j4oWLjGGNAaQaVuHqRu
         T+C3xN8GknDOI8bhGnY/wN6z4D8Zz57tgygd/z+8GhzP1TUrAV7a/DfMfCSLrGJyNBle
         DNCwfJJNftXQjQWdzWe3bl4yRfCd4YjB7SBWW1evU155g7B4t+Td83XZvbr8wgQgm1gY
         wpuZ9/Hpn7D99oIDoSd0zD6/HLwB36Sux66siM4/r/HAqmKCF1di+76zYSeKuaolkM7M
         x5AA==
X-Gm-Message-State: AOAM531LSU80f1/SkyfzxnZs0gW5cjgHmZdXliWR61M2UcPB4PuM0mXm
        lxXKh3tDkJFyZJlFYB+BKyI/dA==
X-Google-Smtp-Source: ABdhPJy9uxOBv9IARKhX9KvzAkDQEBQyuIVpS+mMV/wp8RNe6XTZtVCcSjm3LdjCPOa5H4lNUGbhnw==
X-Received: by 2002:a5d:5251:: with SMTP id k17mr3524943wrc.153.1622807406910;
        Fri, 04 Jun 2021 04:50:06 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:fc89])
        by smtp.gmail.com with ESMTPSA id f7sm5582670wmq.30.2021.06.04.04.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 04:50:06 -0700 (PDT)
Date:   Fri, 4 Jun 2021 12:50:05 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 3/4] printk: Userspace format indexing support
Message-ID: <YLoTbQjQzrPcLcHd@chrisdown.name>
References: <cover.1621338324.git.chris@chrisdown.name>
 <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
 <YK0ShqdTSVTYXGPF@alley>
 <YLZPJpTC6YpJwAJk@chrisdown.name>
 <YLn+IEf3iEZpEeQZ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YLn+IEf3iEZpEeQZ@alley>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>> Petr Mladek writes:
>> > Note that we do not store the value defined by pr_fmt() which
>> > is yet another automatically added prefix.
>>
>> Hmm, we do actually store pr_fmt, since it's known at compile time (or we
>> wouldn't store it at all if it was dynamic due to the __builtin_constant_p
>> check). Or are you seeing something different?
>
>I see. Well, the prefix defined by pr_fmt() becomes part of entry.fmt.
>It is _not_ stored in entry.pre_fmt which confused me.
>
>As I mentioned in the previous mail. I think about using "subsys_fmt"
>or "subsys_prefix" instead of "pre_fmt".
>
>Anyway, we should improve the comment. For example, something like:
>
>	/*
>	 * The format string used by various subsystem specific printk()
>	 * wrappers to prefix the message.
>	 *
>	 * Note that the static prefix defined by pr_fmt() macro is handled
>	 * another way. It is stored directly in the message format (@fmt).
>	 */
>	const char *subsys_fmt;

Sounds totally reasonable, will do.

>> > Is is possible to update __printk_index_emit() to do not create
>> > entries with fmt = NULL ?
>> >
>> > We should either remove the above check or add a comment
>> > explaining why it is necessary.
>>
>> The trick is unfortunately necessary for the reason described in the comment
>> above the double check:
>>
>>     /*
>>      * The compiler may not be able to eliminate the
>>      * non-constant variants of _fmt and _level, so we need
>>      * to make sure that it doesn't see any hypothetical
>>      * assignment for non-constants even though this is
>>      * already inside the __builtin_constant_p guard.
>>      */
>>
>> Happy to add another comment if it helps.
>
>I re-read the discussion about this,
>namely https://lore.kernel.org/r/3Kf896Zt9O+/Yh@chrisdown.name
>
>Frankly, the comment above ftrace_vprintk() is easier to understand
>for me. I mean:
>
>/*
> * The double __builtin_constant_p is because gcc will give us an error
> * if we try to allocate the static variable to fmt if it is not a
> * constant. Even with the outer if statement.
> */

Oh yes, that does sound more clear. I'll update it :-)

Thanks!
