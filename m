Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A33366640
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhDUHal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbhDUHai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:30:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E50C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:30:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id mh2so40477601ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E4ga0kUQDipV+76IyXH9bxWrSDV1mVVxwF6nH3XCypU=;
        b=hqz9XCw9Gvje2n+BrB1uvPweejm+du4yKq9tLNXtSPcK56i7ukU+g4t5FxlC6CBAyv
         frdlkPX4qw6RYDUHxKHJPuzar3I7IMrGC04UM4+0QCWvr7ZMIsHhS6dYMdPYjDMra/Gb
         fIpFwLKeDheVkiRjv/jkQjcp74Kg58vZzg8zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E4ga0kUQDipV+76IyXH9bxWrSDV1mVVxwF6nH3XCypU=;
        b=MnMS54B0gK4dYBUjwYcNW1jtGeSu1JO19mQ+jI85euzZ3KC9773UxrLZ8VuuyndAfJ
         OLu9949oXLlfrSQzcYOw0coZwX0HUa9rYtwanaWTVVPQwexj0yTIXZ0KwjhU8uouAX/P
         sq8S5QnPo/naFbnl6QpxVaiNbpO3k2N4B+6z1fPBIF+SpRBnIINjIRyQp05lMwG6u3+U
         Ua2+2TRYu8bLeO25jzl48WLzXYsSN7NkDw5cNPKnUMekWgJPF6YB+ztKto7FqTwpF05q
         cYePlIGYXvOVoFmY4aPmevmZ1GM8pGASF8a1RSlJehO9io6onych4y/LpxHHHMD1X7CR
         E2sQ==
X-Gm-Message-State: AOAM530d8dlHQXJJ4gmXrNAWjNcwEW1SYmCG9XTpLzxHJnoJZUqaVQP7
        ULnsHCyU1/RGb4qCSXOO6TTOvQ==
X-Google-Smtp-Source: ABdhPJxuBrmzm2U/hCLm72cL/6lrkhwbzOSLcmJGLUDR19oOoYj4Gup+DJA3RUKycLv+CTaUG0LJZA==
X-Received: by 2002:a17:907:2151:: with SMTP id rk17mr31239516ejb.203.1618990202834;
        Wed, 21 Apr 2021 00:30:02 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id mm8sm1452032ejb.28.2021.04.21.00.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:30:02 -0700 (PDT)
Subject: Re: [PATCH][RFC] tracing: Enable tracepoints via module parameters
To:     Steven Rostedt <rostedt@goodmis.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@elte.hu" <mingo@elte.hu>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "yuanhan.liu@linux.intel.com" <yuanhan.liu@linux.intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
References: <1299622684.20306.77.camel@gandalf.stny.rr.com>
 <877hc64klm.fsf@rustcorp.com.au> <20130813111442.632f3421@gandalf.local.home>
 <87siybk8yl.fsf@rustcorp.com.au> <20130814233228.778f25d0@gandalf.local.home>
 <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com>
 <20210419181111.5eb582e8@gandalf.local.home>
 <CAPcyv4gw7KoL8U66LLx_DVAE+5Jguz7tb3Rax-bdTz4BrpwhvQ@mail.gmail.com>
 <20210420085532.4062b15e@gandalf.local.home>
 <CAPcyv4gHHPdCYPzLeNzX0KMoNrOf8H0N5PBiWam0wF+WhV-Jpg@mail.gmail.com>
 <20210420163243.45293c9a@gandalf.local.home>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <5d191e26-bd00-c338-e366-b4855ac08053@rasmusvillemoes.dk>
Date:   Wed, 21 Apr 2021 09:30:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420163243.45293c9a@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2021 22.32, Steven Rostedt wrote:
> On Tue, 20 Apr 2021 12:54:39 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
>> On Tue, Apr 20, 2021 at 5:55 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>>
>>>> The dev_dbg() filter language is attractive, it's too bad  
>>>
>>> Not sure what you mean by that. What filter language. Tracepoints do have a
>>> pretty good filtering too.  
>>

> But you can add your own trace point, and even make it generic. That's what
> bpf did for their bpf_trace_printk. You could convert dev_dbg() into a
> tracepoint!
> 
> 
> static __printf(2, 3) int __dev_dbg(const struct device *dev, char *fmt, ...)
> {
> 	static char buf[DEV_DEBUG_PRINTK_SIZE];
> 	unsigned long flags;
> 	va_list ap;
> 	int ret;
> 
> 	raw_spin_lock_irqsave(&dev_dbg_printk_lock, flags);
> 	va_start(ap, fmt);
> 	ret = vsnprintf(buf, sizeof(buf), fmt, ap);
> 	va_end(ap);
> 	/* vsnprintf() will not append null for zero-length strings */
> 	if (ret == 0)
> 		buf[0] = '\0';

Wrong. snprintf(buf, 16, "") will work just fine and cause a '\0' to be
written to buf[0]. As will snprintf(buf, 16, "%s", ""), and any other
case where there ends up being no characters printed.

The only case where snprintf does not guarantee nul-termination is when
the _buffer size_ is 0, in which case vsnprintf obviously cannot and
must not write anything at all (that's used for the "how much do I need
to allocate" situation).

> 
> #define dev_dbg(dev, fmt, ...) 					\
> 	do {							\
> 		if (trace_dev_dbg_printk_enabled())		\
> 			__dev_dbg(dev, fmt, ##__VA_ARGS__);	\
> 	} while (0)
> 
> Note, the "trace_dev_dbg_printk_enabled()" is a static branch, which means
> it is a nop when the dev_dbg_printk tracepoint is not enabled, and is a jmp
> to the __dev_dbg() logic when it is enabled. It's not a conditional branch.

dynamic_debug has been implemented in terms of static_keys for a long
time. And that's a per-dev_dbg invocation static key. IIUC, the above
would cause every single dev_dbg in the kernel to pass through the "grab
a raw spin lock and do the snprintf" thing even when one is just
interested in the dev_dbgs inside a single driver or function.

Rasmus
