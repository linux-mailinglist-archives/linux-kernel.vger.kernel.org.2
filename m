Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92AC34216D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCSQBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhCSQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:01:12 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FB9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:01:12 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id v17so6623747iot.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y3s18FhryfxEWVXaNvd6oql/kHGXKeDhfxDm+RozLBw=;
        b=EIZuKECoeqJa24PxNYdPGQj7RGiKQiRW+0rCbkIQvliDueZf2ob2e6bcllciz66Tll
         sm217SivzO3XpkuMMXLJNpN9UU7b6kXgXZHxxvyA4/kUEajbQUwZJRVQQ/RZLE2oELdr
         4gGkJvSuFDjmkE9Vgshyg8rWnU5nbSKtZRyAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y3s18FhryfxEWVXaNvd6oql/kHGXKeDhfxDm+RozLBw=;
        b=Wn0vB3+7LJsc4l7vDQhVkWboAmfwh5OPPft5K+D3IwBQWeCnVLer+aZBfpr0XA+KhY
         jS9HCVgW7rklIr8HZA0tuFh9DmuZ7G1MgrcQStizXEdiKKUynNmDx80fwboQnIydnHiD
         6GZlUrEFTjhuOUlccl1059IWQL7Q/TGebu7DFI61r29J3qmHun4eNaK5mhS12djf27MP
         RI1oVOa0iGWchjM74SKANGPNPEu/qqI43mrvAQhi4519I8WWeJvnX9r4xzyUwyV84w2d
         nLAMk3cUSiEgLb92f4LBB2Is1gxv/nO6Yd4fFKnyypRwrMJK9LJPzk4840qN06feGZvD
         6omw==
X-Gm-Message-State: AOAM533NvTVg6SXMZtJ+mlmWS+yTHzWxujkpw0PMNI8T00f7A0+ytIPo
        ZkEv6QC93rJ50SLR5f/NycZG3Wn5bTkcHA==
X-Google-Smtp-Source: ABdhPJxghl3QKA1uGtzNwCt34Y1pZSlqKbMSMFCP5FRMyxRO6SQAs0Da7CujXYIEkuwVBWOyamWMHA==
X-Received: by 2002:a05:6638:329e:: with SMTP id f30mr1957449jav.121.1616169671615;
        Fri, 19 Mar 2021 09:01:11 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id q8sm1231478ilv.55.2021.03.19.09.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:01:10 -0700 (PDT)
Subject: Re: [PATCH net-next 3/4] net: ipa: introduce ipa_assert()
To:     Leon Romanovsky <leon@kernel.org>, Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210319042923.1584593-1-elder@linaro.org>
 <20210319042923.1584593-4-elder@linaro.org> <YFQurZjWYaolHGvR@unreal>
 <edb7ab60-f0e2-8fc4-ca73-9614bb547ab5@linaro.org> <YFTD/TZ2tFX/X3dD@unreal>
From:   Alex Elder <elder@ieee.org>
Message-ID: <5b5d3f17-e647-ca1c-1ec0-fdc2396fa168@ieee.org>
Date:   Fri, 19 Mar 2021 11:01:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFTD/TZ2tFX/X3dD@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 10:32 AM, Leon Romanovsky wrote:
>>>> +/* Verify the expression yields true, and fail at build time if possible */
>>>> +#define ipa_assert(dev, expr) \
>>>> +	do { \
>>>> +		if (__builtin_constant_p(expr)) \
>>>> +			compiletime_assert(expr, __ipa_failure_msg(expr)); \
>>>> +		else \
>>>> +			__ipa_assert_runtime(dev, expr); \
>>>> +	} while (0)
>>>> +
>>>> +/* Report an error if the given expression evaluates to false at runtime */
>>>> +#define ipa_assert_always(dev, expr) \
>>>> +	do { \
>>>> +		if (unlikely(!(expr))) { \
>>>> +			struct device *__dev = (dev); \
>>>> +			\
>>>> +			if (__dev) \
>>>> +				dev_err(__dev, __ipa_failure_msg(expr)); \
>>>> +			else  \
>>>> +				pr_err(__ipa_failure_msg(expr)); \
>>>> +		} \
>>>> +	} while (0)
>>> It will be much better for everyone if you don't obfuscate existing
>>> kernel primitives and don't hide constant vs. dynamic expressions.
>> I don't agree with this characterization.
>>
>> Yes, there is some complexity in this one source file, where
>> ipa_assert() is defined.  But as a result, callers are simple
>> one-line statements (similar to WARN_ON()).
> It is not complexity but being explicit vs. implicit. The coding
> style that has explicit flows will be always better than implicit
> one. By adding your custom assert, you are hiding the flows and
> makes unclear what can be evaluated at compilation and what can't.
Assertions like this are a tool.  They aid readability
by communicating conditions that can be assumed to hold
at the time code is executed.  They are *not* part of
the normal code function.  They are optional, and code
*must* operate correctly even if all assertions are
removed.

Whether a condition that is asserted can be determined
at compile time or build time is irrelevant.  But as
an optimization, if it can be checked at compile time,
I want to do that, so we can catch the problem as early
as possible.

I understand your point about separating compile-time
versus runtime code.  I mean, it's a piece of really
understanding what's going on when your code is
executing.  But what I'm trying to do here is more
like a "functional comment," i.e., a comment about
the state of things that can be optionally verified.
I find them to be concise and useful:
	assert(count <= MAX_COUNT);
versus
	/* Caller must ensure count is in range */

We might just disagree on this, and that's OK.  I'm
interested to hear whether others think.

					-Alex
