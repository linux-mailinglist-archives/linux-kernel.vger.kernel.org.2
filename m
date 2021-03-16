Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D35233D5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhCPO2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbhCPO2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:28:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D594DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:28:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y16so10590716wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Eu7utfvQiZXNyLM62DemkiJmlhyjpiY+84CjLMbms0=;
        b=Nk42BzjcKfWfYtB19DlhUIa61QQkB0za5OWnAUttBA7V+vguqXnWWmctoGlEBw7z2d
         J2V+KQaAgpGDrYYQCzAzJxuKVvude//2bJZJux7MVF3S9+4npQ1SlWjscPY3v/Gy/WYH
         WYBCSjRogqfLdXx5OVEk9CVXGOJ6mQNeVJNKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Eu7utfvQiZXNyLM62DemkiJmlhyjpiY+84CjLMbms0=;
        b=uCMGpzONAjTdCVMiA86Jd+KZq1M7c9w1CavqaT2wxsRsL0mKoy4aagLoIQqr9IJllb
         D2CQZdHXiJu6I5WsHTjvV4/Zk/w5ipH/cJ4sQBahtweVNnMLJh/unAcWjFZMWQYSOIQM
         QChOCo1txWKkgABdm5OicuNSLT3BJyjLv0/zhntDprtR8bO+9DRcsvfx+7GuB4x1YcYW
         V3EkPbdpc9EiHCzKs7HmoVJbtKV6aOwtMG22UWjp3uhwc8XLg48TMShaGklE1/ZYTqjd
         ypcMwv0ngGTfwhvbmfEB8VbE1cpHrl4w1OcCh2GGzCA25j2bzSc7KJNisFDtXDIAhNxU
         EVFw==
X-Gm-Message-State: AOAM531PnMUXO9J+WjSGhqdrQmSFK0kkPaxFRoPG18VT4zJQINGYplmg
        9Czqrz33VhFm24kouC24QvEySg==
X-Google-Smtp-Source: ABdhPJwZ1IwNnKvwllt/aWYVqEDR52Rs9/cf7+4b1iYrPI4dH1t82w7JhbHT7tfUNQpnnbzPjNN+rg==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr5354282wrr.118.1615904893537;
        Tue, 16 Mar 2021 07:28:13 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::4:54e6])
        by smtp.gmail.com with ESMTPSA id i26sm3403758wmb.18.2021.03.16.07.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 07:28:13 -0700 (PDT)
Date:   Tue, 16 Mar 2021 14:28:12 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YFDAfPCnS204jiD5@chrisdown.name>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Villemoes writes:
>I think it's pointless renaming the symbol to _printk, with all the
>churn and reduced readability that involves (especially when reading
>assembly "why are we calling _printk and not printk here?"). There's
>nothing wrong with providing a macro wrapper by the same name
>
>#define printk(bla bla) ({ do_stuff; printk(bla bla); })
>
>Only two places would need to be updated to surround the word printk in
>parentheses to suppress macro expansion: The declaration and the
>definition of printk. I.e.
>
>int (printk)(const char *s, ...)

Hmm, I'm indifferent to either. Personally I don't like the ambiguity of having 
both a macro and function share the same name and having to think "what's the 
preprocessor context here?".

>> +extern struct pi_object __start_printk_index[];
>> +extern struct pi_object __stop_printk_index[];
>
>Do you need these declarations to be visible to the whole kernel? Can't
>they live in printk/index.c?

Yeah, this is a leftover: already noted for rescoping in v6. :-)

>> +
>> +#define pi_sec_elf_embed(_p_func, _fmt, ...)				       \
>> +	({								       \
>> +		int _p_ret;						       \
>> +									       \
>> +		if (__builtin_constant_p(_fmt)) {			       \
>> +			/*
>> +			 * The compiler may not be able to eliminate this, so
>> +			 * we need to make sure that it doesn't see any
>> +			 * hypothetical assignment for non-constants even
>> +			 * though this is already inside the
>> +			 * __builtin_constant_p guard.
>> +			 */						       \
>> +			static struct pi_object _pi			       \
>
>static const struct pi_object?
>
>> +			__section(".printk_index") = {			       \
>> +				.fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
>> +				.func = __func__,			       \
>> +				.file = __FILE__,			       \
>> +				.line = __LINE__,			       \
>> +			};						       \
>> +			_p_ret = _p_func(_pi.fmt, ##__VA_ARGS__);	       \
>
>Is the use of _pi.fmt here a trick to prevent gcc from eliding the _pi
>object, so it is seen as "used"? That seems a bit fragile, especially if
>the compiler ends up generating the same code in .text - that means gcc
>does not load the format string from the _pi object (which it
>shouldn't), but then I don't see why it (or the next version of gcc)
>couldn't realize that _pi is indeed unused.
>
>There's the __used attribute precisely for this kind of thing. Then you
>could also eliminate
>
>> +		} else							       \
>> +			_p_ret = _p_func(_fmt, ##__VA_ARGS__);		       \
>> +									       \
>
>this and the _p_ret variable
>
>> +		_p_ret;							       \
>
>and just end the ({}) with _p_func(_fmt, ##__VA_ARGS__);

Oh, this is a leftover from the early days of the patch when we used to 
explicitly store the formats in ._printk_fmts in order to avoid duplication. 
Now that we just store a pointer instead of storing the format itself, it 
probably should be fine to move to using _fmt directly and __used. Thanks, I'll 
investigate this for v6.
