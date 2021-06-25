Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCD83B4305
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFYMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFYMUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:20:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCE8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:17:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u11so10337174wrw.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=il4obK32BNlPUQO4EYk4oKTvh3VuPextYiN7OykUKTM=;
        b=Bfwh9XXb3FlWnqQ76fDT3NkbRL64XyP7vb58oAqMmsdoilDmMkq6/bmMz50hrVia7L
         eUIY8WQLV2R10S3fxh5O5KS+xHI+0UUONY7Or/8rcoMR1G1c7M0P2wvncdbL3ZZxD5l4
         MKOpDAHXGAV5k+ay8CZbgMzUFjRRu52RgME+t3w6KbA9xmACeyMNrCK9Wt6dUQLn4ozn
         ziwzi6ctz+N8lN7oHVyqIya5ME/uyh1cLNvE2g8MeI4HlbBSQp7BQXKyVZ4Uo+HngFyv
         I98uK4EfCDs87kQYxP5QVPLV4BTtGW542b4jWCn5y2JUZwqjGAYmbNJxV55zKpUxyFvx
         zf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=il4obK32BNlPUQO4EYk4oKTvh3VuPextYiN7OykUKTM=;
        b=PaL2zNjjBeGraNr9qhGc7fB9+hLAnbz4EVOrM/OmI1fkTCziwiNVZKWyzVyjoMs9hF
         k7eG2NKN7y9oZBPuX+KE4ZVSps6+NvS9/Cidhbnxu/0T7fbJN+k4fk1MaMMW8SEmpQWG
         +2X8rsCGrtcwTwKsm2INuYjtgtl00jh2Db7iplaCq+kQz+UFd1jTR5gaoN0qqR+KC1p/
         v7BQ8ClrX7Yz6+K7GnHPeuXlXmV1jWBmX+rFAFC418A39L/momwDabb0C/wUpuMrtr5u
         ZOMQo7T6cfNROuG+AvFhTwtgaa9jH1/GU1yDfaatpYgIHiBtePYM17RAat8CF9IvF7fJ
         WCyQ==
X-Gm-Message-State: AOAM530tktL3BrGAfJdxgIsVKxhf9jegsM1nr5AHS/Phk+4vBr8oi/nh
        Gp5sQM7ydcQnbv7NjTRbOV+5WA==
X-Google-Smtp-Source: ABdhPJyckGyNcTJi4QCms7i9xFRIBfoifykomGAU9wL2iymSb9oJB/BSvh/FlN/5sxVeaH/O+7k04g==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr10558230wrr.11.1624623465397;
        Fri, 25 Jun 2021 05:17:45 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id y14sm6345621wrq.66.2021.06.25.05.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 05:17:45 -0700 (PDT)
Subject: Re: [PATCH] printk: Add CONFIG_CONSOLE_LOGLEVEL_PANIC
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210622143350.1105701-1-dima@arista.com>
 <YNWeIks8NC1i2w96@alley>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <8e7dae6f-e67c-b961-4986-883e1db0c566@arista.com>
Date:   Fri, 25 Jun 2021 13:17:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNWeIks8NC1i2w96@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr, thanks for looking into this,

On 6/25/21 10:13 AM, Petr Mladek wrote:
> On Tue 2021-06-22 15:33:50, Dmitry Safonov wrote:
[..]
>> @@ -76,8 +76,8 @@ static inline void console_silent(void)
>>  
>>  static inline void console_verbose(void)
>>  {
>> -	if (console_loglevel)
>> -		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
>> +	if (console_loglevel && (CONFIG_CONSOLE_LOGLEVEL_PANIC > 0))
>> +		console_loglevel = CONFIG_CONSOLE_LOGLEVEL_PANIC;
> 
> console_verbose() is called also in some other situations.
> For example, check_hung_task(), oops_begin(), debug_locks_ff().
> These do not always lead to panic.>
> At minimum, the name is misleading. It should be something
> like CONFIG_CONSOLE_LOGLEVEL_VERBOSE.
>
> But the question is whether we really want to limit the loglevel
> also in the non-panic scenarios. IMHO, it is a bad idea.
>
> A better solution would be to introduce console_verbose_panic()
> and use it only when it is really going to panic. The function
> should also use the lower value only when crash dump is really
> successfully enabled.

Hmm, check_hung_task() calls it only if it's going to panic().
debug_locks_off() AFAICS is called only when there is something bad with
either lockdep itself or locks: they may get freed
[print_freed_lock_bug()] or lock is held on return to userspace
[lockdep_sys_exit()] and so on - when lockdep has to turn off. Arguably,
the situations are somewhat close to panic.
MCE calls it also just before panic.

So, the only left is oops_begin().
I'm not sure what to do about it.
What do you think, should console_verbose() be called only under
panic_on_oops? Or should there be console_unverbose() to return the
loglevel in oops_end()? [that seems quite a bit ugly, considering that
there're already places that temporary save loglevel and adding another
one is ugh]

Renaming console_verbose() to console_verbose_on_panic() or something
sounds good to me - I didn't do it only to keep the patch short.

>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 678c13967580..0c12cafd9d8b 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -61,6 +61,19 @@ config CONSOLE_LOGLEVEL_QUIET
>>  	  will be used as the loglevel. IOW passing "quiet" will be the
>>  	  equivalent of passing "loglevel=<CONSOLE_LOGLEVEL_QUIET>"
>>  
>> +config CONSOLE_LOGLEVEL_PANIC
>> +	int "panic console loglevel (1-15)"
> 
> The range is 1-15 here.
> 
>> +	range 0 15
> 
> But it is 0-15 here. If you use "range 1 15" you should not need the
> check (CONFIG_CONSOLE_LOGLEVEL_PANIC > 0) in the code.
> 
>> +	default "15"
>> +	help
>> +	  loglevel to use in kernel panic or oopses.
>> +
>> +	  Usually in order to provide more debug information on console upon
>> +	  panic, one wants to see everything being printed (loglevel = 15).
>> +	  With an exception to setups with low baudrate on serial console,
>> +	  keeping this value high is a good choice.
>> +	  0 value is to keep the loglevel during panic/oops unchanged.
> 
> The trick with 0 value just makes things more complicated. The default
> "15" does the same job and should be good enough. The hard-coded
> default is good enough for the other CONSOLE_LOGLEVEL_* settings.

Well, "0" is kinda reverse to "15" - it doesn't change loglevel at all.
Actually, the origin purpose of the patch is to have "0" :-)
I thought 0-15 would be better than just off or on to MOTORMOUTH.

Now, looking at it again, I think what may be even better:

: if (console_loglevel && (CONFIG_CONSOLE_LOGLEVEL_PANIC >
console_loglevel))
:       console_loglevel = CONFIG_CONSOLE_LOGLEVEL_PANIC;

that way I can get rid of "0".
What do you think?

Thanks,
          Dmitry
