Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D8E3ACC85
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhFRNpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233904AbhFRNp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624023798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gNZOYxvHRh8WAbiF0tOQgle1Sg6oiAk/FOL9PrzSRM=;
        b=Gl1W5TEbPphPbjyDl1Yp/1vjpdOXpZXiR9aV2SLgW3dGuZ++D4GYq4+2uMoK17xjjZoGIg
        nPhTwv5PuZDEPMLkLseCAn34FRWgdV/gr1FVM7FQgvAmdxmFP1zleb7n1q7d3LzLy3Ugwf
        qJ+54Y9CrPxbtZ4fFEQ3ylhMXWB43ko=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-WE6if4M7N0KJfopdqQ42qw-1; Fri, 18 Jun 2021 09:43:17 -0400
X-MC-Unique: WE6if4M7N0KJfopdqQ42qw-1
Received: by mail-oi1-f197.google.com with SMTP id l123-20020acad4810000b02901f1fb44dca7so4859087oig.15
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/gNZOYxvHRh8WAbiF0tOQgle1Sg6oiAk/FOL9PrzSRM=;
        b=JyFdJbPpm/QLGwQ6N80CtVZ+3Zq1Urb2nUu53nH364UDYfGaLFkMwjWfSSOic2d1iw
         RFJFm0o56DVwcMnc9quWLmAxopRrnxa9sy88ZJjR5DFOB1wDDf6uyGJ0W8Ygql9BfTW8
         ucswi3zZ+ZoTuAGv/TsG2+mB8U3hL+ig0YHH3S/7t5W8e/hrd9eKOyrLqALRfbHudcR5
         vZ7GI8D8PDscGs5FnQiWAhlW3zAnmHaHe++YfJaeOe6r8ilghMIhxDORZUo+Lh+TCN38
         lbA5JlSAiaL4CjZx/hNbBfk/KIavJ1nkacIbRGV1NvrmuIgabMqgvstV4FYIx69dFzWy
         OcNw==
X-Gm-Message-State: AOAM532ssFJ4dNUZCFUUG+Fhasc73VcHdYfuzzVBZ5N4DOcCFWnOGgWi
        eB1CYNLs+u/LHApjHpwkQTD/uZZvOdZvE/r7TfcA7M6JEXxnKhaQCipNL6aB6h409ReWxWkbC4b
        q0Cq0zjc4xGQYzvjPFoJ9wDo34gRJxHcciFBymcvM9/6ABXLevVSFRuezvaPEJErsh+rVZ+A=
X-Received: by 2002:aca:ac02:: with SMTP id v2mr15154530oie.154.1624023796493;
        Fri, 18 Jun 2021 06:43:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziRuflZC5sU6xUXnHTciiKmLsXNlfJiyZE+R44W4RRLT5GaeC5ScAnNM3vfwinOxZJbgTjdA==
X-Received: by 2002:aca:ac02:: with SMTP id v2mr15154517oie.154.1624023796250;
        Fri, 18 Jun 2021 06:43:16 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w11sm1786875oov.19.2021.06.18.06.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 06:43:15 -0700 (PDT)
Subject: Re: [PATCH 1/1] bug: mark generic BUG() as unreachable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210617214328.3501174-1-trix@redhat.com>
 <20210617214328.3501174-3-trix@redhat.com>
 <CAK8P3a14uKvDZ4OevR5z2+AJervkepDcPjGWwstTo5antbQyXA@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <312e5b85-bfa5-e7f1-c1f7-a13a5d2583b8@redhat.com>
Date:   Fri, 18 Jun 2021 06:43:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a14uKvDZ4OevR5z2+AJervkepDcPjGWwstTo5antbQyXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/18/21 1:20 AM, Arnd Bergmann wrote:
> On Thu, Jun 17, 2021 at 11:44 PM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> This spurious error is reported for powerpc64, CONFIG_BUG=n
>>
>> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
>> index f152b9bb916fc..b250e06d7de26 100644
>> --- a/include/asm-generic/bug.h
>> +++ b/include/asm-generic/bug.h
>> @@ -177,7 +177,10 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>>
>>   #else /* !CONFIG_BUG */
>>   #ifndef HAVE_ARCH_BUG
>> -#define BUG() do {} while (1)
>> +#define BUG() do {                                             \
>> +               do {} while (1);                                \
>> +               unreachable();                                  \
>> +       } while (0)
>>   #endif
> Please let's not go back to this version, we had good reasons to use
> the infinite loop,
> mostly to avoid undefined behavior that would lead to the compiler producing
> completely random output in code paths that lead to a BUG() statement. Those
> do cause other kinds of warnings from objtool and from other compilers.
>
> The obvious workaround here would be to add a return statement locally, but
> it may also help to figure out what exactly triggers the warning, as I don't see
> it in my randconfig builds and it may be that there is a bug elsewhere.
>
> I've tried a simple reproducer on https://godbolt.org/z/341P949bG that did not
> show this warning in any of the compilers I tried. Can you try to narrow down
> the exact compiler versions and commmand line options that produce the
> warning? https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ has
> most of the supported gcc versions in case you need those.

Please follow the link in the cover letter to the original issue 
reported for fs/afs/dir + gcc ppc64 9.x / 10.3.1

Adding the return was the first, rejected solution.

Tom

>
>        Arnd
>

