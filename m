Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A5369A13
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbhDWSpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbhDWSpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:45:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7972BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:44:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b9so2346668iod.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cm6jLlRDy8NJ9WNJqXeloxZ7Seg5EuJb1rniVA+QOCU=;
        b=gLxyef1BrpRGgdozW2M00a0/hjEEqwEf025qp2A2Q+EU4Oxmx7EQhhL1NaAn+VAIOR
         4czb3uw00fjdQNEr2octD8MvQnRb9SV0nf2J5vUqIgBLLsFui+vgpjDPEpgxjbJhzT9+
         ZfPXS4prxQUGzsY1xrwHBO3TsVEC9tksa457U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cm6jLlRDy8NJ9WNJqXeloxZ7Seg5EuJb1rniVA+QOCU=;
        b=gHEme3DfMqNoiug4CLX/NFbHZmuLVU5T1fqKF/SHm/zRsWjTCgaDylm9eib8uBZtOT
         CegVxcE5fLIbiV0qiq3/oOJaWMNH+CiKogQbwo4r5gNvIBdB2U3koJkLeYUaDxdPpoTU
         c67msOtyx0zh5SM1dWYZSQsGIsSfl+LpB+08DorGq9dWYC5Vt1lmsRZ5TrMRYETaDsNl
         o4arz+dTLfRuVh8k+22UKUJbYp1a0rtdJymbc7bdc+6D4TYKyZAmZftBtiOt80MKEqO7
         EO/7ODsk0IcSTW68iEpgYXVFuhmb3mb8VeMlS+RymR2jdihIpkX9SksEgKnXTpxCzqCX
         JaMA==
X-Gm-Message-State: AOAM5301Wg37genT4kslWdr+0qGKSe920Xtx8HETyacf3BcdcGE33bF+
        aEy47JAx+lZEmsYhu5+lBTBNMQ==
X-Google-Smtp-Source: ABdhPJxJJqOeK8j4EUjuZ6KQ+bofdC8dZm4O/vQtO++7XTYvAki4MYOpo4pkFBNOhBEUkmuqamgDwQ==
X-Received: by 2002:a05:6638:68b:: with SMTP id i11mr4891886jab.90.1619203462948;
        Fri, 23 Apr 2021 11:44:22 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f18sm2935004ile.40.2021.04.23.11.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 11:44:22 -0700 (PDT)
Subject: Re: [PATCH v3] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210414085406.1842-1-mail@anirudhrb.com>
 <20210414125540.GJ4332@42.do-not-panic.com>
 <1e12bb24-9bb8-dad7-d852-02173ce41b6a@linuxfoundation.org>
 <20210423184033.GQ4332@42.do-not-panic.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ade1c69b-8b6e-d2da-9ae6-61c796116c11@linuxfoundation.org>
Date:   Fri, 23 Apr 2021 12:44:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210423184033.GQ4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/21 12:40 PM, Luis Chamberlain wrote:
> On Wed, Apr 14, 2021 at 09:26:55AM -0600, Shuah Khan wrote:
>> On 4/14/21 6:55 AM, Luis Chamberlain wrote:
>>> In either case I documented well *why* we do these error checks
>>> before sending a code to userspace on fw_sysfs_wait_timeout() since
>>> otherwise it would be easy to regress that code, so please also
>>> document that as I did.
>>>
>>> I'll re-iterate again also:
>>>
>>> 	Shuah's commit 0542ad88fbdd81bb ("firmware loader: Fix
>>> 	_request_firmware_load() return val for fw load abort") also wanted to
>>> 	distinguish the timeout vs -ENOMEM, but for some reason in the timeout
>>> 	case -EAGAIN was being sent back to userspace. I am no longer sure if
>>> 	that is a good idea, but since we started doing that at some point I
>>> 	guess we want to keep that behaviour.
>>>
>>> Shuah, can you think of any reason to retain -EAGAIN other than you
>>> introduced it here? If there's no real good reason I think it can
>>> simplify the error handling here. But, we *would* change what we do
>>> to userspace... and for that reason we may have to live with it.
>>>
>>
>> As I recall the reason for this patch was to be able to differentiate
>> between timing out vs no memory case when driver was attempting to
>> load firmware. I wish I added why to the change log.
>>
>> The code seems to have changed a lot since my commit. I will take a look
>> at the closely and let you know if this is still necessary late on
>> today.
> 
> Shuah, *poke*
> 
Luis,

I responded to you a week ago. Let me resend the message.

thanks,
-- Shuah

