Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0F1356D5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344356AbhDGNe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbhDGNeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:34:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D01C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:34:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r9so5177365ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vDUwuylMSr1p1egrzfXRzNG099y7Eed6Or0fAEsvKCQ=;
        b=LtgPaaonNNQMSIoZlawOawV0mxA9TDZPXNqlhX51QLfqd5ArIwap8xrVoblByK6NWB
         vyifvRY2F1kuQMuvqBdcAqC6wUZmZWyhWQYz8+pmEy0ctl2JYrsv3i4vHlF0IlanjKIn
         qhQTdw1Se38tnbvw+8oEaaleXs/S3NTe42vfF0+Hq6kAg5gOosmRsw5kVwxETiWYmEmz
         BTi6qaabwxGdmAjBxN2TL0XUT5UawZXLD7jXXqnLqkwtY45ZhzCHcJSz7dENEQNvw7h4
         Sk/n2EqszSsLXZlBfad+CG7ICzQPpXOCzbRVxdc0PkCtJ79G4ellWXaUqH9+Vn7K/JEt
         vp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vDUwuylMSr1p1egrzfXRzNG099y7Eed6Or0fAEsvKCQ=;
        b=MprsGmZa0T3GlN1MH3h1/xFHAO9ABEGHflvrUwaUU3+aWTleSHjJIPrGQ1iaEY4T/B
         X2w03GmxnGfRD7+5A50hHEyLX3KCT+HYDW4EJnPua+j94UGyohTMoGf/nnIybXYlD1+h
         I5w3J6vgwrTquRxAn4z4JmnqVu60VRLyW2gsWIDrvByThx5W1wOyYq2sbaKw4+cAd3PV
         Q/j+4hf4Nv/mSEIjyCxC3o1JZv7lL2tAS0ebtyTqy/Ao4Kq1JsFKHg0TWT1o8wgkD2xL
         npHH3YOCz5YUaLjNmLDUV1BPSfRViJ0aqs7gDhG/D9Rx27QlynRDGAuzWsJqg4dB1pcq
         k2Lw==
X-Gm-Message-State: AOAM532Mw9d4i+WTIvP/NNcpB3qDEaXRVJersNIbS7bwbi2C0/vJZjJT
        a6x1z6zOgr3zjHfSvPeoCtU=
X-Google-Smtp-Source: ABdhPJwezZfm8hhIsdQiRShili47FGXBhTKNC2TWW/LSV90FHHW4Rx7SxjaupD6OQQX3JlwGrWTnYw==
X-Received: by 2002:a17:906:29d4:: with SMTP id y20mr3792013eje.461.1617802453544;
        Wed, 07 Apr 2021 06:34:13 -0700 (PDT)
Received: from [192.168.0.109] ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id m1sm9213522ejl.35.2021.04.07.06.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 06:34:13 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] tracing: Unify the logic for function tracing
 options
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
References: <20210329130533.199507-1-y.karadz@gmail.com>
 <20210329130533.199507-5-y.karadz@gmail.com>
 <20210405181525.0d4a724e@gandalf.local.home>
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Message-ID: <3eb21018-d10d-6f05-cd91-e514d260f924@gmail.com>
Date:   Wed, 7 Apr 2021 16:34:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210405181525.0d4a724e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Hi Steven,

On 6.04.21 г. 1:15, Steven Rostedt wrote:
>>   
>> @@ -235,30 +248,31 @@ static struct tracer function_trace;
>>   static int
>>   func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
>>   {
>> -	switch (bit) {
>> -	case TRACE_FUNC_OPT_STACK:
>> -		/* do nothing if already set */
>> -		if (!!set == !!(func_flags.val & TRACE_FUNC_OPT_STACK))
>> -			break;
>> +	ftrace_func_t func;
>> +	u32 new_flags_val;
> Nit, but the variable should just be "new_flags", which is consistent with
> old_flags. In the kernel we don't need to the variable names to be so
> verbose.
> 
>>   
>> -		/* We can change this flag when not running. */
>> -		if (tr->current_trace != &function_trace)
>> -			break;
>> +	/* Do nothing if already set. */
>> +	if (!!set == !!(func_flags.val & bit))
>> +		return 0;
>>   
>> -		unregister_ftrace_function(tr->ops);
>> +	/* We can change this flag only when not running. */
>> +	if (tr->current_trace != &function_trace)
>> +		return 0;
>>   
>> -		if (set) {
>> -			tr->ops->func = function_stack_trace_call;
>> -			register_ftrace_function(tr->ops);
>> -		} else {
>> -			tr->ops->func = function_trace_call;
>> -			register_ftrace_function(tr->ops);
>> -		}
>> +	new_flags_val = (func_flags.val & ~(1UL << (bit - 1)));
>> +	new_flags_val |= (set << (bit - 1));
> bit is already the mask, no need to shift it, nor there's no reason for the
> extra set of parenthesis. And the above can be done in one line.
> 
> 	new_flags = (func_flags.val & ~bit) | (set ? bit : 0);
> 

OK, I totally misinterpreted the meaning of the "bit" argument of the 
function. I did not realized it is a mask. I was thinking the argument 
gives only the number of the bit that changes (like 5 for the 5-th bit 
inside the mask).

Thanks!
Yordan


