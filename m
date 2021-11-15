Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CF5452016
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357364AbhKPAsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344735AbhKOTZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:25:18 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D72C04F54C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:38:17 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id o4so36682727oia.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CZSxWmZRav92+eQHeF0kSH/09V+GvkXV5M71MLsSM+0=;
        b=R8FPcq2/Tr1Gia2TGiXrM0QYPhADBRI82AVFgYHBScfBoBYrXblU29jCixj9Rou4tE
         1mdPoyckbTXo/G/fYiQVkjVQe9D0TlJWE6ghs0sF4wtBsf8T5G4km/09PV8ih7qnxCJ6
         CqW2DuJCwnuiY/xMdKY++2V52kFYQOWVjKQilaOYxF8Gph5KNjmSpBKcS9uBWr1EPRPd
         ApdJTCdW6ofINeC3Jb0BxSrbj6wlRNMa13XlfFh/a+qJ1dHzmqcH46PsU87tPxcNqLEm
         gNvWureqsP1hXAytrX1B9dW8qJ9SF5/53t/6mdiOYm2L9kWXt5z/VPydC/Df5qOtM5oj
         4d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZSxWmZRav92+eQHeF0kSH/09V+GvkXV5M71MLsSM+0=;
        b=2d1IaTGtK4jSj6iTAjGSTSiHsKG7urD9wIOfgnULTcNA1SmQU04CbzxUpQ1SYDave5
         FPuhYwQvhdfe2sNHTS1WEx8/0VA8q3CIJRQ9fexXo5ocmKFoOaSdZHGC8xE4o0AqWLFk
         R1uwD1fzgDYGBqm3IbvDyD3cAVIScV99NoWz77ENxZ+CRDWsKKXNwnDppfj1+PvKXBv/
         iyHg7rJcOKIthCpSj5D2jbJmj0wyxZ6d5tOKaiQcW9cgWw3KgVF0d3tV1Axkcpu0kKNB
         S6KcqCCWlVOD795IST9NjGOp9QKuk0JqMeowAPu7Dj0SNfSd6znYkM093kwryotk8JWg
         Vzdg==
X-Gm-Message-State: AOAM530JKBk5PsToCReprIhdPYGBMuI0fneWeZ5b/L06UQuwmThfgxtY
        uKWjduuNXkdJtYsZhc9XdpWrVUmwIFU=
X-Google-Smtp-Source: ABdhPJyl1/OYFy81S/WRR2iB6CAZ7cVNKpIPGifvcwUl3RbTUBwn5YNNRCymr1+GXd65Gehpeld/kA==
X-Received: by 2002:a05:6808:221c:: with SMTP id bd28mr825493oib.56.1637001496365;
        Mon, 15 Nov 2021 10:38:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bk41sm2082190oib.31.2021.11.15.10.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 10:38:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net>
 <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
 <CAHk-=wis4sMKEB1EWJW-+jgc4j31S297sx7nq4a_MS92r8-HgA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.16-rc1
Message-ID: <2e041a4c-b74b-001f-eaca-3f186958e486@roeck-us.net>
Date:   Mon, 15 Nov 2021 10:38:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wis4sMKEB1EWJW-+jgc4j31S297sx7nq4a_MS92r8-HgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 10:10 AM, Linus Torvalds wrote:
> On Mon, Nov 15, 2021 at 9:07 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> parisc:allmodconfig: Lots of build failures in arch/parisc/include/asm/jump_label.h.
>> Not fixed in -next. The problem seens to be related to the thread_info changes,
>> or at least bisect points to commit 01463374c50e ("Merge tag 'cpu-to-thread_info-v5.16-rc1'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux").
> 
> I don't think they are related to the thread_info changes except very
> incidentally.
> 
>>From the errors ("expected ':' before '__stringify'") it looks like
> __stringify() isn't defined there, and I do think that header file
> should include <linux/compiler.h> to get it.
> 
> I don't actually see how that merge commit you bisected to could
> possibly matter (the diff doesn't show any header file include
> changes, or any parisc ones), but I suspect you might have bisected to
> it because we did end up having actual thread_info errors on parsic
> that weren't fixed until commit 2a2e8202c7a1 ("parisc: move CPU field
> back into thread_info").
> 
> So I suspect the parisc build problems started with thread_info issues
> at that merge commit you pinpoint, and then by commit 2a2e8202c7a1
> some other header file simplification had exposed that "no
> __stringify()" thing).
> 
> Helge - apparently from allmodconfig and others, we have:
> 
>     arch/parisc/include/asm/jump_label.h: In function 'arch_static_branch':
>     arch/parisc/include/asm/jump_label.h:18:18: error: expected ':'
> before '__stringify'
> 
> and others, which does look like just a missing header file (that was
> presumably previously implicitly included earlier, and now the
> implicit include is gone).
> 

Geert pinpointed this problem to

     due to static_branch_likely() in crypto/api.c

Commit adad556efcdd4 ("crypto: api - Fix built-in testing dependency failures")
added "#include <linux/jump_label.h>". That extra include isn't needed because
crypto/internal.h already includes it. Removing it from crypto/api.c
fixes the problem for parisc, but I don't know if that is the correct fix.
Alternatively, linux/completion.h would have to be included from crypto/api.c
before including linux/jump_label.h.

Guenter
