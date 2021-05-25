Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FD438F6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhEYAH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhEYAH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621901157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/RCpsvhdAmo8XkdMfl////N8HN4L7zQ9oYjhXGDEJI=;
        b=C1Q+YcftN5xMx0cd1FvYuoWJxWy6QlNT5Z2Oh6C90pB4Oi1J+FnKILfIEM/p/lJt9AX7+3
        683kHu5J7RyMcauAkcjxYAgcX0jzizqk90ty7oEQm2qvZM8pfvLzBR3cO5AqdLlvYiWELq
        9LwyUsDIPRVSc7KEkhyWMWM9HzMvTe8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-rhIqCuvrONee_uA5plPzKw-1; Mon, 24 May 2021 20:05:53 -0400
X-MC-Unique: rhIqCuvrONee_uA5plPzKw-1
Received: by mail-qv1-f69.google.com with SMTP id x2-20020a0cda020000b02901edb4c412fdso28834479qvj.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=B/RCpsvhdAmo8XkdMfl////N8HN4L7zQ9oYjhXGDEJI=;
        b=J2nUR01XVltXZ07awlmwXoszl24yVAwNMZAKy3mn31/90hE47ThBHWgNe4ysio3WHA
         Cb0O4zKboOSrH3cTDeLPm2QtI8icNzwi+ciX+Q6sZ6BgaWCdD6SkgjM/xHRBZ1S9ZB/S
         HNSW9NuLPEgDOP7fQz6Yyo6u5yJksSp+f4zQLSKZ0iiZykQGRrIGOgEowOC8JUuGI/Mk
         fbCzKFazj3avRWsUiTCgY6E2rlbU43Bw8/oJhAfvB81YfdthXUVKB2MQb1eBFqhvVphN
         R1+Cfi6wBRATdnX+EaLWQQVJXFYzEQTFw4MAq9thCcNS7iSLu2RrSB4/QnFwORFnzOJ/
         TmBg==
X-Gm-Message-State: AOAM5322MsRrGZS15msAU63eXos6Cx0Uoj3WGcl7YTpIv/WZ2sizfYeA
        mxeZYU/cRrBRmSZ/3DoKdsRTY8cGq8YJTYZQ1GfIw9TGfRmelQJ8ANx1p8NAcWG1iQZGwepDNCp
        kvUHm0ql7eGpb7My+7gFrUhn1
X-Received: by 2002:aed:2081:: with SMTP id 1mr29723295qtb.24.1621901152979;
        Mon, 24 May 2021 17:05:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdUpLzIITFhbxIU4Fu2+b4um4Nuas4Se66mdWSq5b1sCmRY5O2h3KIeO57Y1YgD3sUwjpg8Q==
X-Received: by 2002:aed:2081:: with SMTP id 1mr29723270qtb.24.1621901152735;
        Mon, 24 May 2021 17:05:52 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 7sm11856944qkd.20.2021.05.24.17.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 17:05:52 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] LOCKDEP: use depends on LOCKDEP_SUPPORT instead of $ARCH
 list
To:     Randy Dunlap <rdunlap@infradead.org>,
        Waiman Long <llong@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
References: <20210517034430.9569-1-rdunlap@infradead.org>
 <YKIXBpxyvhzdb1uv@gmail.com>
 <1284b997-b9da-769f-2d36-4d4232c7df88@redhat.com>
 <bfb11ab2-d606-b96e-1979-3bcc3c3adc96@infradead.org>
 <8a4ee5be-ad5c-ca06-dd1a-aa13ccc94906@redhat.com>
 <c8698ce3-4995-efd6-9d1d-095dcac70dc2@infradead.org>
 <09243238-94ba-caca-441e-3fdac0154822@infradead.org>
Message-ID: <3a0fb04c-c640-25db-7e7a-fbdd3b4defb5@redhat.com>
Date:   Mon, 24 May 2021 20:05:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <09243238-94ba-caca-441e-3fdac0154822@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 5:41 PM, Randy Dunlap wrote:
> On 5/24/21 2:31 PM, Randy Dunlap wrote:
>> On 5/24/21 2:04 PM, Waiman Long wrote:
>>
>>> Is it possible to just get rid of the 2nd depends-on statement?
>>>
>>> The 2nd depends-on line was introduced by commit 7d37cb2c912d ("lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTER"):
>> and I should have looked at that history too. Thanks.
>>
>> Yes, I agree, we can just delete that line...
>>
>> I'll send a v2 and copy the author of commit 7d37cb2c912d as well.
> Hm, as I review that commit, I have to wonder if the previous 'select'
> was correct (if we disregard the Kconfig warning).  If so, then
> FRAME_POINTER is still wanted/needed for some arch-es.
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2779c29d9981..417c3d3e521b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1363,7 +1363,7 @@ config LOCKDEP
>          bool
>          depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>          select STACKTRACE
> -       select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86 <<<<<<<<<<<
>
AFAICS, enabling FRAME_POINTER is a debugging aid as it enable more 
precise stacktrace. However, not all archs want to enable FRAME_POINTER 
because of LOCKDEP. Now you are just letting users decide if they want 
FRAME_POINTER or not. Maybe you can modify the help text to mention that.

Cheers,
Longman

