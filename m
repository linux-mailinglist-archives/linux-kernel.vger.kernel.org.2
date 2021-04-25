Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5E136A881
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhDYRHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 13:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230329AbhDYRHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 13:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619370416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BvfeTp6yZ6CIXdQ26CACIQwp+00PPjzpkltjROWSVI=;
        b=NbFjHczf+4m9wcM7h6wBQK/oyNCsPEw2RZGzaELnRe6oTH0LoKg/tG+aYvnXZEzFyIQksQ
        xx8gd86CW59aIMvT1fCfxTJnjpJs4xAVJj+MGwlbbX1e9pGM/sokrnYqOJZCcK3OTzNeep
        UGJgLJMOYI++DRl/EMpyeKEy2TSzDqg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-KTs8uPWaNJqLtWDRnmIooQ-1; Sun, 25 Apr 2021 13:06:55 -0400
X-MC-Unique: KTs8uPWaNJqLtWDRnmIooQ-1
Received: by mail-qv1-f72.google.com with SMTP id z17-20020a0cf0110000b029019a84330150so21815140qvk.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 10:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/BvfeTp6yZ6CIXdQ26CACIQwp+00PPjzpkltjROWSVI=;
        b=rVHDdLx3Gwp4LTnYLtwMbj3BYz3PLSoPvj3e3rNpXR6RZYDpbI0neOxN42WiS6Ez7N
         faYJtlFxeNBzRkMbD8r+B0B+O2qlwxFRZr8g+aKQmd2TAjMGA6cXq7sDY+VFF4CZnEC3
         9z7eRoBH1e96JYsT18UChOcFro0W5pTyt1ziuAWKDJfoFKRMWmQ4CQPsXZql5/ef2dl5
         /CJ4iUbSogh/T6Czo858mOgjRYnNU62V7AWyCZQT2JWWuUooq4txstnRyhRnQUEaRDwO
         G/nzbyZ8F/bUv0secCTtogKW9v1G8t9ri3dQiMqzqvSRRsaL8MNIqua7kakeTsrqEE3a
         nDvg==
X-Gm-Message-State: AOAM532Dq7b+A/ZYgx9WPAB6A0wGXEcenGoCmefk3JfYJpotgZ/KuVWj
        Pu/d8Hp/s7CY12jJ1rtWrKZRChDFrqemIe/JhJ5IionjyFAyxb+CRP8KAtTrIwPzmcDetbB4+jn
        a0XCXgtkWFGNBIiG5Iu1lqJQ3hQFijKDWgQT2kT4Jc2W3y3pvXryznErNApZmNuwogUr5iXbZ
X-Received: by 2002:a37:8906:: with SMTP id l6mr14146012qkd.198.1619370414195;
        Sun, 25 Apr 2021 10:06:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJeHEikpel1/pwAToajBFkduGyrKBOVR5hI78bDqLJQLn588zDlV2EG9JDGp4kUacHeNUAwQ==
X-Received: by 2002:a37:8906:: with SMTP id l6mr14145980qkd.198.1619370413947;
        Sun, 25 Apr 2021 10:06:53 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id r1sm9004442qtt.3.2021.04.25.10.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Apr 2021 10:06:53 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [GIT PULL] locking/urgent for v5.12
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <YIU4005K55S20FU1@zn.tnic>
 <CAHk-=whhCWi_aOvY9AfAz4fRMU53hO7n+w9hU6Wuk4RuHpK31Q@mail.gmail.com>
 <CAHk-=wi2NEfJmgZbqHL43a2rsWuc7Oyb5kfiz9x8z+S-juL7-w@mail.gmail.com>
Message-ID: <9017e7b9-cd6e-caa1-b8ba-8d85f4a5d87e@redhat.com>
Date:   Sun, 25 Apr 2021 13:06:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi2NEfJmgZbqHL43a2rsWuc7Oyb5kfiz9x8z+S-juL7-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/21 12:39 PM, Linus Torvalds wrote:
> Oh, and replying to myself only because I spazzed out and pressed
> "send" before I had filled out the full participants line.
>
> Sorry for the duplicate message quoted in full below.
>
>                   Linus
>
> On Sun, Apr 25, 2021 at 9:37 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> [ Side note: this is cc'd to x86-ml, even though x86 is the _one_
>> architecture that was guaranteed to be not at all affected by the
>> actual locking bug, since a locked op is always ordered on x86. ]
>>
>> On Sun, Apr 25, 2021 at 2:39 AM Borislav Petkov <bp@suse.de> wrote:
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.12
>>>
>>> - Fix ordering in the queued writer lock's slowpath.
>> So I'm looking at that change, because the code is confusing.
>>
>> Why did it add that "cnts" variable? We know it must have the value
>> _QW_WAITING, since that's what the atomic_cond_read_relaxed() waits
>> for.
>>
>> I'm assuming it's because of the switch to try_cmpxchg by PeterZ?

Yes, try_cmpxchg() requires a variable to hold the new value as well as 
a place to return the actual value before the cmpxchg(). It is just the 
way try_cmpxchg() works.


>>
>> HOWEVER.
>>
>> That actually just makes the code even MORE unreadable.
>>
>> That code was odd and hard to read even before, but now it's
>> positively confusing.
>>
>> New confusion:
>>   - Why is the truly non-critical cmpxchg using "try_cmpxhg()", when
>>     the _first_ cmpxchg - above the loop - is not?
At least for x86, try_cmpxchg() seems to produce a slight better 
assembly code than the regular cmpxchg(). I guess that may be one of the 
reason Peter changed it to use try_cmpxchg(). Another reason that I can 
think of is to make the code fit in one line instead of splitting it up 
into two lines like the original version from Ali.
>>
>> Pre-existing confusion:
>>   - Why is the code using "atomic_add()" to set a bit?
>>
>> Yeah, yeah, neither of these are *bugs*, but Christ is that code hard
>> to read. The "use add to set a bit" is valid because of the spinlock
>> serialization (ie only one add can ever happen), and the
>> cmpxchg-vs-try_cmpxchg confusion isn't buggy, it's just really really
>> confusing that that same function is using two different - but
>> equivalent - cmpxchg things on the same variable literally a couple of
>> lines apart.
As you have said, the spinlock serialization makes sure that only 1 
writer is allowed to do that. I agree that using atomic_or() looks 
better in this case. Both of them are equivalent in this particular case.
>>
>> I've pulled this, but can we please
>>
>>   - make *both* of the cmpxchg's use "try_cmpxchg()" (and thus that
>>     "cnts" variable)?
Yes, we can certainly change the other cmpxchg() to try_cmpxchg().
>>
>>   - add a comment about _why_ it's doing "atomic_add()" instead of the
>>     much more logical "atomic_or()", and about how the spinlock serializes
>>     it
>>
>> I'm assuming the "atomic_add()" is simply because many more
>> architectures have that as an actual intrinsic atomic. I understand.
>> But it's really really not obvious from the code.
>>
I will post a patch to make the suggested change to qrwlock.c.

Cheers,
Longman

