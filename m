Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D553F513A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 21:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhHWTYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhHWTYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:24:11 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2E0C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:23:28 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x10-20020a056830408a00b004f26cead745so39253438ott.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R61EvE5T8P1BLdeG5FoKvlIWFZXYQh2fedYwtenFS5w=;
        b=Vg2yIG520LIhKpPXUI4mZ2ssujQNL8K4zT9coTZV5k2WN1GdU7pzXW90U6O9Us12z8
         BYrO98kdP4HiatoAZ+FmTSdB75kZDyY3QhSTUGrRGbHbhAWiiouMFxvdGkc8J0XFaYoU
         zroTYBKBZyw/rBnU7PmFqFyMVYt5+m5v3f8Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R61EvE5T8P1BLdeG5FoKvlIWFZXYQh2fedYwtenFS5w=;
        b=jkSANI1qP++r9Io/CK6WTusYdh9MqkdioEP+ZOGldXQm51fmJrlKofVrAx7rM3s84M
         qDP2tDLyuCurHtUUPQwj4C/VtbU6QglXi94Wrzj/cicSGPfCFN5QI7WKNaSMwQpChixC
         Qq02K8biEN5AsVIKGU0rAaXyYjtzZ1vgxDa3Zy7JigIfVR2nxw+dRGvik7uSfM8p9Xld
         A7MW38fyA08tdNE8YVD58POgDtFHTVndWDQVUfrIssvY41LSCwE4BVsS6sdl0BgA7GFz
         kzSHD/BrTdyMTT9yZp1NzQo1V2s1pR+Wp+4OweJh9LtZzDAG6PniVkXbyWZ4gcmZk9oH
         GMug==
X-Gm-Message-State: AOAM532wjejKUHTxqaWmWkUSH3Kuerq5o8hHY9rK9EW4eU8kc/FGafQW
        BHNqYFCirps3qVTU7BP7fIYL4A==
X-Google-Smtp-Source: ABdhPJwNuSRfsc4F4tzHz4U6R/cVYWBvbE+fBQ8cEX0tAwdrEbJzg6m0MWx0CR8lkaYUwuB7YwjRPA==
X-Received: by 2002:a05:6808:20e:: with SMTP id l14mr84473oie.87.1629746608138;
        Mon, 23 Aug 2021 12:23:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i27sm4117419ots.12.2021.08.23.12.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 12:23:27 -0700 (PDT)
Subject: Re: [PATCH] selftests: openat2: Fix testing failure for O_LARGEFILE
 flag
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, shuah@kernel.org,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1627475340-128057-1-git-send-email-baolin.wang@linux.alibaba.com>
 <01184d9e-477d-cbe4-c936-62b92e915911@linux.alibaba.com>
 <9411d418-567b-78f0-0e4d-30f08371c55a@linux.alibaba.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a9dc1616-61b9-c010-950c-521693c74247@linuxfoundation.org>
Date:   Mon, 23 Aug 2021 13:23:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9411d418-567b-78f0-0e4d-30f08371c55a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 8/22/21 8:40 PM, Baolin Wang wrote:
> Hi Shuah,
> 
> On 2021/7/28 20:32, Baolin Wang wrote:
>> Hi,
>>
>>> When running the openat2 test suite on ARM64 platform, we got below failure,
>>> since the definition of the O_LARGEFILE is different on ARM64. So we can
>>> set the correct O_LARGEFILE definition on ARM64 to fix this issue.
>>
>> Sorry, I forgot to copy the failure log:
>>

Please cc everybody get_maintainers.pl suggests. You are missing
key reviewers for this change.

Adding Christian Brauner and Aleksa Sarai to the thread.

>> # openat2 unexpectedly returned # 3['/lkp/benchmarks/kernel_selftests/tools/testing/selftests/openat2'] with 208000 (!= 208000)

Not sure I understand this. 208000 (!= 208000) look sthe same to me.

>> not ok 102 openat2 with incompatible flags (O_PATH | O_LARGEFILE) fails with -22 (Invalid argument)
>>
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Could you apply this patch if no objection from your side? Thanks.
> 

Ideally this define should come from an include file.

Christian, Aleksa,

Can you review this patch and let me know if this approach looks right.

>>> ---
>>>   tools/testing/selftests/openat2/openat2_test.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
>>> index d7ec1e7..1bddbe9 100644
>>> --- a/tools/testing/selftests/openat2/openat2_test.c
>>> +++ b/tools/testing/selftests/openat2/openat2_test.c
>>> @@ -22,7 +22,11 @@
>>>    * XXX: This is wrong on {mips, parisc, powerpc, sparc}.
>>>    */
>>>   #undef    O_LARGEFILE
>>> +#ifdef __aarch64__
>>> +#define    O_LARGEFILE 0x20000
>>> +#else
>>>   #define    O_LARGEFILE 0x8000
>>> +#endif
>>>   struct open_how_ext {
>>>       struct open_how inner;
>>>
> 

thanks,
-- Shuah
