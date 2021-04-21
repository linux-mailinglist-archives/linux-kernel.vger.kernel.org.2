Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2FC366E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243673AbhDUOvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243648AbhDUOvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:51:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FB9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:50:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u17so63966391ejk.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pColakFL/oD6K5w+4xc6suN1o6M2SKI7M9jsjcF6vq0=;
        b=fAbQ2AqOrYqvKXyGWn9XD5FfGB7HkD07jpWKW4+MtWRrotpDkK7HIF6Ws0AW7uxiIW
         VVnG7IElrZskcVceebo/ZYeLNkBtRln4j4h08fME/SPlnpPsgFQc+BeaNeaV8FtyFota
         ZaHkw9qHtE8HDZEtrgZ5S5YfS0LVWDv+EbgoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pColakFL/oD6K5w+4xc6suN1o6M2SKI7M9jsjcF6vq0=;
        b=XF5u0HtmPAaicT2dty2/aCTGjMIos7Z02vMTUCBYdaaSegb2LzCfmNAgFhBF3mtftH
         nM61sW8Nsvu9lU5DY/Ap+woMzxjDk3mjxN6Qlp3kXlLPlWTL4Qf4D+p0ULS3oSb8XD7/
         02KdD/XHxoUyWp3XbEdiC8Wbec0OWOq+TaS6U+FqX3N5UQJ3jCerTS+v6K/eXMmWi2BO
         lsrJB8vLZL6zlrrNbzfcOwBZXMEuNd6iDPgZXT5rQqjoS5OhlKFpwaU2DiXz9Di55WPk
         iouRJAdo3XlMF283bwkKE4sFVrNr+z0PPVk1xxRruHnW7UCLhlVtFP/vCI5+iP3gHuoZ
         wZ6A==
X-Gm-Message-State: AOAM530tSdQMRQmGznyqef6Phg7KS82crdtP0eCmsDdWj2KMO7+JmMYo
        HudPBNt2QrrySny3ShsLI7akzg==
X-Google-Smtp-Source: ABdhPJxeetNfYWARegiTKr2YDP6uJ0JGKGiWke66Vc7e3ju9fs61nRP78er07SdcYeRPUHh7yeIHxA==
X-Received: by 2002:a17:906:3f88:: with SMTP id b8mr33884788ejj.36.1619016632659;
        Wed, 21 Apr 2021 07:50:32 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id f19sm2790726ejc.54.2021.04.21.07.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 07:50:32 -0700 (PDT)
Subject: Re: [PATCH][RFC] tracing: Enable tracepoints via module parameters
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
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
 <5d191e26-bd00-c338-e366-b4855ac08053@rasmusvillemoes.dk>
 <20210421102008.411af7c5@gandalf.local.home>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <7d971eef-72bc-db32-e6a3-26e94b1b4236@rasmusvillemoes.dk>
Date:   Wed, 21 Apr 2021 16:50:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210421102008.411af7c5@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2021 16.20, Steven Rostedt wrote:
> On Wed, 21 Apr 2021 09:30:01 +0200
> Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
>> On 20/04/2021 22.32, Steven Rostedt wrote:
>>> 	/* vsnprintf() will not append null for zero-length strings */
>>> 	if (ret == 0)
>>> 		buf[0] = '\0';  
>>
>> Wrong. snprintf(buf, 16, "") will work just fine and cause a '\0' to be
>> written to buf[0]. As will snprintf(buf, 16, "%s", ""), and any other
>> case where there ends up being no characters printed.
> 
> I just cut and pasted the bpf_trace_printk() code and modified it for here.

OK, thanks for the pointer, lemme go write a patch to remove that
bogosity before it gets cargo-culted further.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/bpf_trace.c#n404
> 
>>>
>>> #define dev_dbg(dev, fmt, ...) 					\
>>> 	do {							\
>>> 		if (trace_dev_dbg_printk_enabled())		\
>>> 			__dev_dbg(dev, fmt, ##__VA_ARGS__);	\
>>> 	} while (0)
>>>
>>> Note, the "trace_dev_dbg_printk_enabled()" is a static branch, which means
>>> it is a nop when the dev_dbg_printk tracepoint is not enabled, and is a jmp
>>> to the __dev_dbg() logic when it is enabled. It's not a conditional branch.  
>>
>> dynamic_debug has been implemented in terms of static_keys for a long
>> time. And that's a per-dev_dbg invocation static key. IIUC, the above
>> would cause every single dev_dbg in the kernel to pass through the "grab
>> a raw spin lock and do the snprintf" thing even when one is just
>> interested in the dev_dbgs inside a single driver or function.
> 
> If you want to make it per device, I'm sure three's a way. Or allocate a
> per-cpu buffer for the sprintf storage, and then you only need to disable
> interrupts. And if you make the storage 4 levels deep per CPU (like
> trace_printk does), then you only need to disable preemption and not even
> interrupts.
> 
> The above wasn't a patch submission. It was a proof of concept. Everything
> you brought up can be trivially dealt with.

I don't "want" anything. I just fail to see what advantage that proof of
concept would bring over the current dev_dbg implementation.

Rasmus
