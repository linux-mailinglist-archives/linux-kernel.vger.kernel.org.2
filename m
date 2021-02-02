Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBEB30B8A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhBBH1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhBBH1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:27:46 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47813C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 23:27:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id s24so1713206pjp.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 23:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RYs1tfw2+xOcKSsrXDrCv533l3TVPSPKDkNgXs48C7E=;
        b=amkoZ86gvsRJx4UaQSn2QErh9UxgwiM2Usp+USANDfMG9c5EbqdtFB7Wgc2ign31qR
         sx4NoUguB7UaoBrCycTNYgIvH5TDINjsSBelSz5w3xfTYUJM3aW5yAbEx39rn3R/++Gc
         ooqkdMsmPmjIsSC/hy+Aq8gSsHg9NCbj+v/ZTZ3C+d4qb3iE1KVMgTkU8MbLoHjH6nyu
         aIiP1zd1t1MsT8ls9zSrTB+hrIOzRd9TfN1tkxku2F6EIZtEZ4GE/C//CLsbV+v0Gbj6
         5kLQ39qRFXX7gB2jKivl+GfE2AS/ep+BKDYeRb3wYPScf93HH2/E9OYN5XGn8M16mM1q
         mQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RYs1tfw2+xOcKSsrXDrCv533l3TVPSPKDkNgXs48C7E=;
        b=IVY4IHJqEXfyG15iMNYK8wj51P1YxJrFfWNPADkOz8Dy8TaJZ6G3KmGFm+CKqoAsS4
         FMAzueKBF04fdNtIjjAACQniF0SSk96bioDaNMLKMgMKEdMRrP7lB6D+y19EMf6k6Mdy
         C2dFUhGOTTDOV6V3SjgwiH6sFogaqA37f9A80DmIeGXVtYeO0+2tIY+e+4LInnS1AT4Y
         qlT8Z8YBO39LOMT6xGXHsvxhMhN91XdUCFMqFfUhm97s97RCBWC4dG6714N1Vrd1GIcp
         q4yXC10lWdRfC/pWZVib8zOcCKvOvz0l3/j89Os+bymlPSPBLm4P7ZSN0ZPvkTLtLxK9
         aBrQ==
X-Gm-Message-State: AOAM533YDtkLlchtLkWtN2b19QIGhNime916FR19bbd93x5vxYU0JTKP
        h+MEZt/MDj7E0CGtI3CFdNnC4F2JMYfiaw==
X-Google-Smtp-Source: ABdhPJwFYbk/Nv5MyW/DcmMqq8sW2elO1XnafM6qQe/kIMTvSNpkJbftSt5AudaYuYRKrakoGmudNg==
X-Received: by 2002:a17:902:bd0a:b029:e0:612:ad38 with SMTP id p10-20020a170902bd0ab02900e00612ad38mr21901769pls.30.1612250824738;
        Mon, 01 Feb 2021 23:27:04 -0800 (PST)
Received: from [192.168.10.23] (124-171-107-241.dyn.iinet.net.au. [124.171.107.241])
        by smtp.gmail.com with UTF8SMTPSA id j5sm1669692pjf.47.2021.02.01.23.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 23:27:03 -0800 (PST)
Subject: Re: [PATCH v5] tracepoint: Do not fail unregistering a probe due to
 memory failure
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matt Mullins <mmullins@mmlx.us>, paulmck <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20210127170721.58bce7cc@gandalf.local.home>
 <ac000ed4-3eeb-60df-f896-c05cabb4c1c9@ozlabs.ru>
 <20210130093626.0b7b3b1b@oasis.local.home>
 <20210130094211.719f03a6@oasis.local.home>
 <13608cdc-2068-6340-6795-28944c9fe3ca@ozlabs.ru>
 <20210201121007.51c0ac59@gandalf.local.home>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8b8f5d32-d3ac-ad11-c7dc-96190eddc942@ozlabs.ru>
Date:   Tue, 2 Feb 2021 18:26:55 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210201121007.51c0ac59@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/02/2021 04:10, Steven Rostedt wrote:
> On Mon, 1 Feb 2021 12:18:34 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>>> Just curious, does the following patch fix it for v5?
>>
>>
>> Yes it does!
> 
> Thanks for verifying.
> 
>>
>>
>>>
>>> -- Steve
>>>
>>> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
>>> index 7261fa0f5e3c..cf3a6d104fdb 100644
>>> --- a/kernel/tracepoint.c
>>> +++ b/kernel/tracepoint.c
>>> @@ -306,6 +306,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>>>    			tp->unregfunc();
>>>    
>>>    		static_key_disable(&tp->key);
>>> +		tracepoint_synchronize_unregister();
>>>    		rcu_assign_pointer(tp->funcs, tp_funcs);
>>>    	} else {
>>>    		rcu_assign_pointer(tp->funcs, tp_funcs);
>>>    
> 
> OK, since it would be expensive to do a synchronization on every removal
> like that, but the tp->funcs should not be reset.
> 
> It appears that your check is still required, since the iterator has been
> added.
> 
> The quick fix is the check you gave.
> 
> But I think we could optimize this (not having to dereference the array
> twice, and do the check twice) by making the iterator part of the tp_funcs
> array, and having the rest of the array as its argument. But that can be a
> separate update.
> 
> The check you added should be a patch and marked for stable. Care to send
> it, and mark it for stable as well as:
> 
> Fixes: d25e37d89dd2f ("tracepoint: Optimize using static_call()")
> 
> Thanks!


Posted as "[PATCH kernel] tracepoint: Fix race between tracing and 
removing tracepoint", hopefully I got it right. Thanks,



-- 
Alexey
