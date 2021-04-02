Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41051352EB2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhDBRrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhDBRrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:47:41 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF7AC061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:47:39 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id f5so1258914ilr.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hlmY9ay0U3wvSCBCBDTvrY5xuHoevwZSGxKNN6WLYyo=;
        b=KEfPNYX0hxEQJ5RSJw8sTTqF6SLMJBEFqjzuZSfSkkxsb+EmcaGWoiJP4mXe6Q8LjP
         pTEjwWZP7ShClLA3I49+c7Due/puEiX4q1BohoYtKzmEQXFmFBGQv2Cy3fo64wdOM6UK
         I9b1N4VD9teUD1gjp3wMDgzPX5ke3fqOJQ2QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hlmY9ay0U3wvSCBCBDTvrY5xuHoevwZSGxKNN6WLYyo=;
        b=bPoJsn/cbI1ellJ+YmxQF5ZjlIsTBKe5i85Ge6iydqnh6Pv+82XGzY9umMCh3V93Lk
         sSZ2zg+Be3YfekY0YapIRaKPjmquUOlFZgZnvit7CssHldg+DX5PCHjBTpGyFopaVIlf
         FmAwPF09Y9zufk2RuCeMhkABWOJConJhr21/0XDlzr8F1NT0hr88TmXx9h8kksvV1ZB8
         WJbWkR3OdwjWk8NaGS418Eet+uYWnlS/IyKJG0rbOkcqPqeC/2dYdGDSrVtlYSFJsj2O
         Pct232BqZLp9DJ2rvyqOYaX/qK82uMjhBhte4pkEF24qwQHcW9UatlDUdyzWO2Hzj4/A
         K+aQ==
X-Gm-Message-State: AOAM531AHD42yD46jrcwB+9Uf2gEZYc3Wje4fHzplmuJg7GC7kUGL0S5
        FKmoIL6Wr6kB+nT668ueixvQCw==
X-Google-Smtp-Source: ABdhPJyv/h+pcdXk22+CtdU5pG4KIhATDFSYSe1a1zZ/C6DXx8EzFnEFA3dU9NXzplHZrY+Q75UKQA==
X-Received: by 2002:a92:c50c:: with SMTP id r12mr11991100ilg.52.1617385659329;
        Fri, 02 Apr 2021 10:47:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g16sm4424011ilk.22.2021.04.02.10.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 10:47:38 -0700 (PDT)
Subject: Re: [PATCH] kunit: make KUNIT_EXPECT_STREQ() quote values, don't
 print literals
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210205221808.1966010-1-dlatypov@google.com>
 <CAFd5g44PL+DrN6+0bw-oYQCjCSR-f4Y0=QZL9DsSO-3hKLsFzw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9f5df593-6584-b7d4-3b6e-ad77ee6f8760@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 11:47:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g44PL+DrN6+0bw-oYQCjCSR-f4Y0=QZL9DsSO-3hKLsFzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 3:35 AM, Brendan Higgins wrote:
> On Fri, Feb 5, 2021 at 2:18 PM Daniel Latypov <dlatypov@google.com> wrote:
>>
>> Before:
>>>   Expected str == "world", but
>>>       str == hello
>>>       "world" == world
>>
>> After:
>>>   Expected str == "world", but
>>>       str == "hello"
>> <we don't need to tell the user that "world" == "world">
>>
>> Note: like the literal ellision for integers, this doesn't handle the
>> case of
>>    KUNIT_EXPECT_STREQ(test, "hello", "world")
>> since we don't expect it to realistically happen in checked in tests.
>> (If you really wanted a test to fail, KUNIT_FAIL("msg") exists)
>>
>> In that case, you'd get:
>>>   Expected "hello" == "world", but
>> <output for next failure>
>>
>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 

Hi Daniel,

Please run checkpatch on your patches in the future. I am seeing
a few checkpatch readability type improvements that can be made.

Please make changes and send v2 with Brendan's Reviewed-by.

thanks,
-- Shuah
