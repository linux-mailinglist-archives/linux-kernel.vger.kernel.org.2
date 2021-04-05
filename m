Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6718835489D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 00:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242787AbhDEW3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 18:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbhDEW3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 18:29:31 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0AAC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 15:29:22 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id v70so13062686qkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RwkgDCMjAFVJZLleFiMJUr9vgTjXkXjMnykXo/QokeM=;
        b=QVB6sBSLuPtIgw1bBIx0B9ARKghOSsS+doviRxtNnR1cQ8ar7A+zCkCYFw8rx00tK7
         XAAXnVfpMUQxINBXwIQcQV0/ibBpFCGlK9Klb04uVLDcgWRi/czgk1aia/6CotCMNwM6
         rM+nWAHw07J/BTdEG3NK13U9zjdkeOwt5KW5nWd8H3zKefwnGPRuxIj9ZST3vjVVQz3c
         WW8jzB+hYbGwZDZj5Ja7SCaPeVLmjLATPyOJ9IF9r1n2POvu3c34mvAn8Iqux0+UHD1g
         pf4tPtqh76KFD2rcRXESPzcDjysiZWq2iJ1kufBJAGdpQMl2YSftl2LWVJ8qhliVlPNK
         UWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RwkgDCMjAFVJZLleFiMJUr9vgTjXkXjMnykXo/QokeM=;
        b=pL/b3uiHnMcu5TvBhLcQM3K06FHzBGaNAK4/Z5IuuuI+CPMGHwFOrDv2jeGsl9ySQ0
         mUDjUjw6etX1n6AjWMiPzuqHx9UHK19dmfVZapDUkkV/OnKj/Z8ckwzK4+Uoof7l5Juk
         VoU9xOdVLOOnAhHISNQy6rh8cHSQJuCXGyR1OsAoN7nfrry+y4BU9u0pjcFz34AvNpPf
         HNeKQCP7+y0z28Nc2Q/qfgWRgcHtFTU6o+tw6AabXsAHB4B+HSk4Sncqr46ff6YtI6Qt
         ENd7zlFVK7m70tKzlGHFS3AnmHIMSybHaYXHTZhi9gEWoe3UEvOx/aoJNF4vmNHqXob4
         pqgg==
X-Gm-Message-State: AOAM530t86AHfYOJvTxxK3kwIWKurBv5UqZz/DQA14aVaUr6PxsNv87i
        nVny3BUGh7qiR0n7ji9fpSxCF1zAC54=
X-Google-Smtp-Source: ABdhPJwqilHOfodqTf996DCBzX879+tEW/OsTyV1wsHvJBOSJm1EAhS4e403GVZxczMS+Yme7n5siQ==
X-Received: by 2002:ae9:df46:: with SMTP id t67mr26461636qkf.269.1617661762116;
        Mon, 05 Apr 2021 15:29:22 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id k26sm10564139qkg.120.2021.04.05.15.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 15:29:21 -0700 (PDT)
Subject: Re: Linux 5.12-rc6
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=whK9=wafv+cSLCGqFGPBbgp67Dut3jKCnWB--8y7Lxonw@mail.gmail.com>
 <20210405171011.GA72391@roeck-us.net>
 <CAHk-=wjG=y+sXAaW=L5369Sd0pjZ_iJEKiuUGCuR6QqQQYk0ug@mail.gmail.com>
 <39c15fa7-2dfd-ed21-4882-049560e6e032@roeck-us.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <82843e8f-2129-118b-fa74-d7126727ed63@gmail.com>
Date:   Mon, 5 Apr 2021 17:29:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <39c15fa7-2dfd-ed21-4882-049560e6e032@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Rob, so that he will be in the loop.

-Frank

On 4/5/21 12:28 PM, Guenter Roeck wrote:
> On 4/5/21 10:14 AM, Linus Torvalds wrote:
>> On Mon, Apr 5, 2021 at 10:10 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> No change in test results since last week [..]
>>
>> Let's ping Frank for the alignment issue.  If that promised patch
>> isn't timely (and trivial), I really think that removing the alignment
>> check is by now the way forward for that libftd failure.
>>
> 
> Frank sent a patch with a fix/workaround yesterday, and I added my
> Tested-by: an hour or so ago.
> 
> https://lore.kernel.org/patchwork/patch/1407418/
> 
> Hmm, my reply isn't there (yet). I'll monitor and resend if needed.
> 
> Thanks,
> Guenter
> 

