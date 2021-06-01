Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9332A397653
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhFAPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbhFAPRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:17:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF18C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:15:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h12-20020a05600c350cb029019fae7a26cdso88861wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YtBpSDe8tMfHR08xYXWGDmOWpdyD083TsO41wEtq+J0=;
        b=IYpO+xuepDJDsUIgIr6kLZHa0X4F1sjY5pen5bmmCu4qCSyrvC/HWdnU0VdZ13JlG/
         Yy0SUJKaP+bI/aOLn6qN19Nb1U5eThKwESSKT2pT8QbXKnaPXiW5wc24U00K2QuAz3XL
         oO/06Id/gr0+zoq9ZyaAPBGrGpG6jiNLdPgVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YtBpSDe8tMfHR08xYXWGDmOWpdyD083TsO41wEtq+J0=;
        b=BzSW9BGgOLRhQXUmBDJ2SKYwZqWzZ4g8dT7u6CyKLpYZlmzneI3QPVkwHvz/+h4O57
         SwktpzffVez3nD1yD2YoMm7mdxIqhJ68miW756Fw35l777ukrjZMa6pKxh+3glMZ5Me9
         e0bL2wWvPdYfrXB7eTOo24Ggf1gY52W6Co/YFh/1hjMZWhrClri3ka2MUkksY4p17jTy
         HSMl1W35gOUrIVeWeW8TiHDzshHRJONvJrs1Nu5yFiq1WYXyW6BubtOVvTxpORP/Q3Vb
         V5J5cVIbuMiJTiJ0bvOHavV3TI+k1X4gLbiDDiwlTX86OOJHCO9HtKpVA3DA5ZR4St4z
         7bAg==
X-Gm-Message-State: AOAM533SlmORX4u8Gqfw5NMXavwg04/xNlVo79p0JxOtjRUgd+ywBR8k
        lwxqpS46sCq9jPPxwS4O4mbrjw==
X-Google-Smtp-Source: ABdhPJxOMjENB+tv3aLeUeli3tiBXZkoPwc7BviMG557fTpVuIWau8z1iWoo/6mpRdrCuB0synoMyQ==
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr26438375wmq.38.1622560551848;
        Tue, 01 Jun 2021 08:15:51 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:a819])
        by smtp.gmail.com with ESMTPSA id c64sm2938207wma.15.2021.06.01.08.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:15:51 -0700 (PDT)
Date:   Tue, 1 Jun 2021 16:15:50 +0100
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
Message-ID: <YLZPJpTC6YpJwAJk@chrisdown.name>
References: <cover.1621338324.git.chris@chrisdown.name>
 <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
 <YK0ShqdTSVTYXGPF@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YK0ShqdTSVTYXGPF@alley>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Petr,

Thanks for the feedback -- apologies for the delay in getting back.

Anything not explicitly replied to here is acked and will be fixed for v7.

Petr Mladek writes:
>Are you aware of any subsystem having some extra post_fmt, please?

Good thinking -- I just checked and I didn't find any, so I guess we can add 
that later if needed and do without it for now. :-)

>Well, the main question is whether we need to store this
>at all. Does it bring any useful information?
>
>Note that we do not store the value defined by pr_fmt() which
>is yet another automatically added prefix.

Hmm, we do actually store pr_fmt, since it's known at compile time (or we 
wouldn't store it at all if it was dynamic due to the __builtin_constant_p 
check). Or are you seeing something different?

>I would personally omit these prefixes. The most important
>information is:
>
>  + fmt: is the pattern that the system monitors would most likely
>	look for.
>
>  + level: says whether the string will appear on console that
>      shows only messages below a certain console_loglevel
>
>  + func, file, line: help to find the string in the kernel sources.
>      It is useful when investigating what has changed.
>
>For example, pre_fmt="%s %s:" used by dev_printk (4th patch)
>is not much useful.

In this case it's not super useful, but for cases where you can put something 
more useful (like "BTRFS: ...") it can make matching significantly less 
ambiguous.

Having this information means that system monitors know that they can anchor 
the matching at both ends when linking a printk format with some output, rather 
than having to look for a substring (in which case things become more difficult 
to determine).

I agree that in this particular case with dev_printk it's not incredibly 
useful, but there are certainly others we may want to have in future (like the 
btrfs case) where it would certainly help disambiguate. :-)

>
>> +} __packed;
>> +
>> +#define __printk_index_emit(_fmt, _level, _pre_fmt, _post_fmt)		       \
>> +	({								       \
>> +		if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
>> +			/*
>> +			 * The compiler may not be able to eliminate the
>> +			 * non-constant variants of _fmt and _level, so we need
>> +			 * to make sure that it doesn't see any hypothetical
>> +			 * assignment for non-constants even though this is
>> +			 * already inside the __builtin_constant_p guard.
>> +			 */						       \
>> +			static const struct pi_entry _entry		       \
>> +			__used = {		       \
>> +				.fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
>> +				.func = __func__,			       \
>> +				.file = __FILE__,			       \
>> +				.line = __LINE__,			       \
>> +				.level = __builtin_constant_p(_level) ? (_level) : NULL, \
>> +				.pre_fmt = _pre_fmt,			       \
>
>Should this also be?
>
>	.pre_fmt = __builtin_constant_p(_pre_fmt) ? _pre_fmt : NULL
>

Hmm, if pre_fmt for a subsystem isn't known at compile time, it's an error on 
the developer's end -- otherwise things can't be stored anyway and there's no 
point.

>> + * pre and post must be known at compile time, or compilation will fail (since
>> + * this is a mistake). If fmt or level is not known at compile time, no index
>> + * entry will be made (since this can legitimately happen).
>
>How is this achieved, please?
>
>__printk_index_emit() creates the entry when the following check is true:
>
>       if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level))
>
>It checks neither _pre_fmt nor _post_fmt.

Maybe my phrasing wasn't clear, but compilation would fail in that case because 
`.pre_fmt = _pre_fmt` will be a non-constant static initialiser, no?

>> +	if (!entry->fmt)
>> +		return 0;
>
>Is this just a paranoid check or is it a valid case?

It happens only for the following printk:

	arch/x86/mm/fault.c:534 show_fault_oops "BUG: kernel NULL pointer dereference, address: %px\n"

I must confess, I'm not entirely sure why, although it's ironic/interesting 
that it happens on _the_ NULL-related deref printk...

>Is is possible to update __printk_index_emit() to do not create
>entries with fmt = NULL ?
>
>We should either remove the above check or add a comment
>explaining why it is necessary.

The trick is unfortunately necessary for the reason described in the comment 
above the double check:

     /*
      * The compiler may not be able to eliminate the
      * non-constant variants of _fmt and _level, so we need
      * to make sure that it doesn't see any hypothetical
      * assignment for non-constants even though this is
      * already inside the __builtin_constant_p guard.
      */

Happy to add another comment if it helps.
>
>
>> +
>> +	if (entry->level)
>> +		printk_parse_prefix(entry->level, &level, &flags);
>> +	else
>> +		prefix_len = printk_parse_prefix(entry->fmt, &level, &flags);
>
>This is missing:
>
>	if (level == LOGLEVEL_DEFAULT)
>		level = default_message_loglevel;
>
>Without it, it produces lines with loglevel <-1>, for example:
>
><-1> init/do_mounts.c:457 mount_block_root "\n"
><-1> init/do_mounts.c:456 mount_block_root " %s"
><-1> init/do_mounts.c:454 mount_block_root "No filesystem could mount root, tried: "

Hmm, from the perspective of someone building this printk-checking 
infrastructure, I want -1 here instead of dynamically changing the output to 
default_message_loglevel, because default_message_loglevel may not be the same 
across systems. For example, having "-1" allows people to know these will come 
out at whatever the default message loglevel is, rather than necessarily being 
always at (say) level 4 or whatever it happens to be set at on the running 
system.

Without that, it's also not possible to compare entries across systems or 
across time, because the default loglevel may dynamically change at runtime, 
and it's not possible to disambiguate "will always be KERN_X" from "happens to 
be KERN_X" on this system.

And if someone really does want to know what value it will be right now, they 
can just look at /proc/sys/kernel/printk and change it out as desired.

>> +
>> +	seq_printf(s, "<%d%s> %s:%d %s \"",
>> +			level, flags & LOG_CONT ? ",c" : "", entry->file,
>> +			entry->line, entry->func);
>
>It produces the following for continuous lines:
>
><-1,c> arch/x86/events/core.c:2101 init_hw_perf_events "%s PMU driver.\n"
><-1,c> arch/x86/events/core.c:2091 init_hw_perf_events "no PMU driver, software events only.\n"
>
>But we should print the loglevel only when explicitly defined.
>So I would do it the following way:
>
>	if (flags & LOG_CONT) {
>		if (level == LOGLEVEL_DEFAULT)
>			seq_printf(s, "<c>");
>		else
>			seq_printf(s, "<%d,c>", level);
>	} else {
>		if (level == LOGLEVEL_DEFAULT)
>			level = default_message_loglevel;
>		seq_printf(s, "<%d>", level);
>	}
>
>	seq_printf(s, " %s:%d %s \"", entry->file, entry->line, entry->func);

Ah yes, that's a decent point, since we don't treat this as meaning 
LOGLEVEL_DEFAULT. I'll have a think about how to make it better for v7.

>I am really happy with the progress. The remaining problems are mostly
>with the support for the subsystem-specific printk() callers that was
>added in this revision.

That's great! I really appreciate your time and your diligent review, you've 
definitely helped improve this patchset for the better :-)

Thanks,

Chris
