Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C910A338F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhCLNxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhCLNxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:53:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7158DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:53:22 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l12so4858326wry.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=44NBGE+fl1Zm0cdVSdCq7sQwx/0XO+dQhuxsPFQ1ZbM=;
        b=ObCYdx9ohlFlUJJgCc6zgnywLGYol9Nhrz+zAlDuu4YH3HJf2kyghljSslegvnZrm1
         Tp8zJn4ZKcwMwxt0wRsu1mJk4mPUroPlZCMlazkdxZjYX8Wtj7v4JFUNWNTCiuPrk08d
         1Ymegxs75FhAJC5fmj9BqjvjCj/jAv3X13tGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=44NBGE+fl1Zm0cdVSdCq7sQwx/0XO+dQhuxsPFQ1ZbM=;
        b=GHpsXHxc9vntLERE7iDWpyAeILHAa5PTbuevyA7UJURzBTbyWXwMuST9ZMtfXFYUZQ
         U8PGgQdiMgnNutrjYjUSOdl/qYcmHZMwrzuTUpHGRmEerhvmA8iIG9/O7P8fvCPF/zFq
         7ZEenuBvwyAX2L3Icxx6te10PQBPtZsqRSpzCfJJaAwwa0ELqOJGHGpsdDrOuHT17NCL
         FJVnsgGPTAXC1sYP0l3WCaaHkEiSKQs2rjY65gtlX/Rzw6J6F1FxUrhDBTRQbX3SXl9h
         9sB2BZnPA7SyK+shDMCsefnqUVGNYX4l5zkNPTHsQsyDfmAG4AMKyRsG6CE+4m6GZdgU
         hJZQ==
X-Gm-Message-State: AOAM532AV2uIPbCLK7+TWGkasq3fbo9wiKP1KldeWAVHiq1LMb1xUfal
        +1w8VONEJRUAvyabEi+FC/qatQETmcuygvgh
X-Google-Smtp-Source: ABdhPJz8LabWyUkSpV+ooLxLj9tLoCUPNhAn7JNwXGmV15CVm7Zyz9OqB/+WtNmkV6d6UNSmPIuz/w==
X-Received: by 2002:a5d:6602:: with SMTP id n2mr14315039wru.262.1615557201142;
        Fri, 12 Mar 2021 05:53:21 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:f568])
        by smtp.gmail.com with ESMTPSA id 13sm1639765wmw.5.2021.03.12.05.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 05:53:20 -0800 (PST)
Date:   Fri, 12 Mar 2021 13:53:20 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YEtyUM07gsqR6ltG@chrisdown.name>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <YEtNKMF3KH1kUDxY@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YEtNKMF3KH1kUDxY@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ack to all unmentioned suggestions. :-)

Petr Mladek writes:
>> +	  changed or no longer present.
>> +
>> +	  There is no additional runtime cost to printk with this enabled.
>> +
>>  #
>>  # Architectures with an unreliable sched_clock() should select this:
>>  #
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 1e5aad812310..44df2913a046 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -1064,6 +1064,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>>  	blocking_notifier_call_chain(&module_notify_list,
>>  				     MODULE_STATE_GOING, mod);
>>  	klp_module_going(mod);
>> +	pi_sec_remove(mod);
>
>Is there any particular reason why this is not done via the module
>notifier, please?
>
>Other subsystems hardcode their callbacks here only when they
>require some special ordering that could not be achieved by
>the notifiers.
>
>The hardcoded callbacks complicate the error paths in
>the module loader code.

Oh! That's exactly what I feel as well, but I mistakenly thought that's what 
you were asking for in the feedback for v4. Turns out I misread your statement 
about storing the pointer to `struct module` (hence my message last time 
querying whether it was sensible or not) as being about not using the module 
notifier. Mea culpa.

>> +static void *pi_next(struct seq_file *s, void *v, loff_t *pos)
>> +{
>> +	const struct pi_sec *ps = s->file->f_inode->i_private;
>> +	struct pi_object *pi = NULL;
>
>Please, call the variables by the content and not by prefix.
>A variable called "pi" might include anything used by "pi" API.
>
>[...]
>
>Please, try to put more effort into creating the function and
>variable names. I know that I am probably too picky about it.
>But you seem to be the other extreme.
>
>Inconsistent, ambiguous, or meaningless names might make even few
>lines of code hard to follow. It makes it write-only.
>It is hard to review and maintain.

Hmm, I'd even say that I agree with this statement, but as I understand it a 
`pi` variable always means pi_object, and `ps` always means pi_sec. I'm not 
immediately seeing it as meaningless or ambiguous (although maybe your concern 
was more abstractly aesthetic with overlapping the `pi_` prefix?).

The "content" here is pretty abstract, so I'm not quite sure what your 
suggestion for naming them based on content is. Maybe (assuming it doesn't just 
disappear, which it seems it will) a pi_sec named sec, and the pi_object named 
fmt_index? I don't feel strongly that this is more clear though, so maybe you 
mean something else?
