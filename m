Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDAA3AB7A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhFQPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhFQPkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:40:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43452C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:37:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w21so4648987edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YT85gP+YFDJ5ychGyvNL82kun+NGGvSQi4A8qTsyAT8=;
        b=d2GK9t3nL2nAfTcf7lqXjd31fD7Hz5xzxIAJtdTuGMg15qEOCzDgflXnVUQN8grvuM
         EeDaBMTzUJ5xRvELBxH/CNS4pCSwowu44jiHt3qIjmlgS1IMEZ8ZQIhPGE+4zoWIiZC3
         gnXozEqWX4Im4+7CVdSM9IFtkfATJIFunDZyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YT85gP+YFDJ5ychGyvNL82kun+NGGvSQi4A8qTsyAT8=;
        b=g/hGd6C9FuE+UUf9JlACE6HZYBVgrLPdGpgyqdZnrE0sl301fp0jvF1C9d7RRGPfZc
         F5wWGusyUYpQP0cEE2xH41oEWK81QvOKH+6J0Dqg6/VI8g3VH0Yct+WJWgcV+dpp5kme
         MIB5LHH6Pm4pIs3ZtHkpPWLyXXfmHF51TDdCgyDImnxANOa8NvaF2r29AxlCXS6twG1Y
         M+swumA3hHJtMiT3YeXJt4nuhEfJNDVdwexQz6PoxSj5qbK1dfQlk74vGfT0df16RlL+
         xNjMqtVu73R8wkk7zOcaTYvwhlLCPw8K9E1wRFztWYCEamGZPf1yasUKc24TyI3wPAph
         2rLg==
X-Gm-Message-State: AOAM5313v8kL6cz3/who0svI/BsU/2fPdLz1r87Fkqm7g7+Eig1WPJcy
        TtkLgUvaJ2rGeCHTtwQJeMPcdw==
X-Google-Smtp-Source: ABdhPJx5RzRT+L7RIRvsl9usmDDDf/qtiyT+vCzmybNW0ErUVakZubdtURjpJlM3bBjtB8KFQFyMAA==
X-Received: by 2002:aa7:c705:: with SMTP id i5mr7526454edq.222.1623944272883;
        Thu, 17 Jun 2021 08:37:52 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id j24sm4538603edv.48.2021.06.17.08.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 08:37:52 -0700 (PDT)
Subject: Re: Linux 5.13-rc6 regression to 5.12.x: kernel OOM and panic during
 kernel boot in low memory Xen VM's (256MB assigned memory).
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sander Eikelenboom <linux@eikelenboom.it>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <ee8bf04c-6e55-1d9b-7bdb-25e6108e8e1e@eikelenboom.it>
 <CAHk-=wjgg67NMBNG99naEQ1cM0mXBBzdhCJaYFH-kC+mLK+J2g@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9108c22e-3521-9e24-6124-7776d947b788@rasmusvillemoes.dk>
Date:   Thu, 17 Jun 2021 17:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjgg67NMBNG99naEQ1cM0mXBBzdhCJaYFH-kC+mLK+J2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2021 17.01, Linus Torvalds wrote:
> On Thu, Jun 17, 2021 at 2:26 AM Sander Eikelenboom <linux@eikelenboom.it> wrote:
>>
>> I just tried to upgrade and test the linux kernel going from the 5.12 kernel series to 5.13-rc6 on my homeserver with Xen, but ran in some trouble.
>>
>> Some VM's boot fine (with more than 256MB memory assigned), but the smaller (memory wise) PVH ones crash during kernel boot due to OOM.
>> Booting VM's with 5.12(.9) kernel still works fine, also when dom0 is running 5.13-rc6 (but it has more memory assigned, so that is not unexpected).
> 
> Adding Rasmus to the cc, because this looks kind of like the async
> roofs population thing that caused some other oom issues too.

Yes, that looks like the same issue.

> Rasmus? Original report here:
> 
>    https://lore.kernel.org/lkml/ee8bf04c-6e55-1d9b-7bdb-25e6108e8e1e@eikelenboom.it/
> 
> I do find it odd that we'd be running out of memory so early..

Indeed. It would be nice to know if these also reproduce with
initramfs_async=0 on the command line.

But what is even more curious is that in the other report
(https://lore.kernel.org/lkml/20210607144419.GA23706@xsang-OptiPlex-9020/),
it seemed to trigger with _more_ memory - though I may be misreading
what Oliver was telling me:

> please be noted that we use 'vmalloc=512M' for both parent and this
commit.
> since it's ok on parent but oom on this commit, we want to send this
report
> to show the potential problem of the commit on some cases.
>
> we also tested by changing to use 'vmalloc=128M', it will succeed.

Those tests were done in a VM with 16G memory, and then he also wrote

> we also tried to follow exactly above steps to test on
> some local machine (8G memory), but cannot reproduce.

Are there some special rules for what memory pools PID1 versus the
kworker threads can dip into?


Side note: I also had a ppc64 report with different symptoms (the
initramfs was corrupted), but that turned out to also reproduce with
e7cb072eb98 reverted, so that is likely unrelated. But just FTR that
thread is here:
https://lore.kernel.org/lkml/CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com/

Rasmus
