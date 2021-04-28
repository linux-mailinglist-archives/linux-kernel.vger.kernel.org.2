Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74736DBEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbhD1Pji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240328AbhD1PhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619624194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pG5pwOUgg892glFsUccSS4Ot1zsI7mcT+KpkcWM44lQ=;
        b=hOAXRjqtO9cIJrVRg3a6IR2CqimBbo+0Ev+7N/ahJHeyNnF/x74WXHRLFYT1QFQFCiMM1O
        uqTDq0YtNaPBShhmw7n84FO5cFH/rFgME/K/sSrvnvShPx61+xWc5+Vhw3rUCYDcSLVKbQ
        CS8/1cNltMxhKO3/aT0chWGYxW2T7sk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-87dSG0wVMce4GJca9IR6kw-1; Wed, 28 Apr 2021 11:36:31 -0400
X-MC-Unique: 87dSG0wVMce4GJca9IR6kw-1
Received: by mail-qt1-f199.google.com with SMTP id s4-20020ac85cc40000b02901b59d9c0986so22804323qta.19
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pG5pwOUgg892glFsUccSS4Ot1zsI7mcT+KpkcWM44lQ=;
        b=cMoIKiiUH+UIQ/vJhAznQoISQnBgzr0FORs966rb9nvYlivi1jDLBKmoCmJODsfkWn
         fpHPww7aQV0+1ydFdBDXpOdN7EqCLJljpeI4ceT51B1MpmHqp0U91NRb67IUDBZ+aS0k
         2GTaaGFfaZF/hEu9dVDD8c4GNGDDU7gH+wgjXwWHgncw/82zERZM6XOMAy1kQDJ4iAUA
         ptX2u9aYna1iI20AwAucv+0VCYC1lccyz/wFk6baWixdYxjJov2ZP2wmcSjOXKzu5zxq
         jP3aFC5jhbhBR3aE4NCEOQA0H4Id+AZ7DZWLbhg1rUocjZ6DV3jfN2U3KL2cULMZsrhN
         b2tg==
X-Gm-Message-State: AOAM531tQXHnEGo6ub/5b77kSCZ3+ImIQjrEQdX3+yPip9mp3Lz7DhVB
        hhE6nVL0qqBHbXAMyrzTkIHfYZ/J4BH/U7KnBvHjJ76hhi8q8fIjbKsLthYIjzU26MsI/8PeQi1
        QN2F56G8fKpw9TPNbBpnAPKPJ
X-Received: by 2002:a37:5f41:: with SMTP id t62mr29451308qkb.458.1619624190593;
        Wed, 28 Apr 2021 08:36:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+naGLpqAAopTlTZbQTPCAVHulsI7tDqz+zkw7UWnc7YVzu6jS0fCGmeR9jCcwK9+IV75HsA==
X-Received: by 2002:a37:5f41:: with SMTP id t62mr29451285qkb.458.1619624190406;
        Wed, 28 Apr 2021 08:36:30 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e15sm21640qkm.129.2021.04.28.08.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 08:36:29 -0700 (PDT)
Subject: Re: [PATCH] samples/landlock: fix path_list memory leak
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210427183755.2790654-1-trix@redhat.com>
 <CAKwvOdmj5YvWZZWwcq1G7JgRALwPbqwiROiedMeEbBst2sGeiQ@mail.gmail.com>
 <6108e69b-0470-cd71-e477-ba64641cbf58@digikod.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4ece80d4-16fe-1938-7eba-2046840881f6@redhat.com>
Date:   Wed, 28 Apr 2021 08:36:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6108e69b-0470-cd71-e477-ba64641cbf58@digikod.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/28/21 2:58 AM, Mickaël Salaün wrote:
> On 27/04/2021 21:13, Nick Desaulniers wrote:
>> On Tue, Apr 27, 2021 at 11:38 AM <trix@redhat.com> wrote:
>>> From: Tom Rix <trix@redhat.com>
>>>
>>> Clang static analysis reports this error
>>>
>>> sandboxer.c:134:8: warning: Potential leak of memory
>>>    pointed to by 'path_list'
>>>          ret = 0;
>>>                ^
>>> path_list is allocated in parse_path() but never freed.
>>>
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> ---
>>>   samples/landlock/sandboxer.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
>>> index 7a15910d2171..4629d011ed61 100644
>>> --- a/samples/landlock/sandboxer.c
>>> +++ b/samples/landlock/sandboxer.c
>>> @@ -134,6 +134,8 @@ static int populate_ruleset(
>>>          ret = 0;
>>>
>>>   out_free_name:
>>> +       if (path_list)
>>> +               free(path_list);
>> I don't think the conditional is even necessary? By our first `goto
>> out_free_name;`, `parse_path` has already been called/memory for
>> `path_list` has already been allocated. `parse_path` doesn't check
>> whether `malloc` has failed.
> Indeed, no need for the path_list check. In practice, this memory leak
> doesn't stay long because of the execve, but I missed this free anyway.
> Thanks!

Ok, the general problem of not checking if malloc and friends succeeds 
is a different problem.

So remove the check and keep the free ?

Tom

> Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>
>
>>>          free(env_path_name);
>>>          return ret;
>>>   }
>>> --
>>> 2.26.3
>>>
>>

