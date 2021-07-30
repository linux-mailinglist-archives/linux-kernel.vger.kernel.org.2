Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB53DBF3B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 21:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhG3Tsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 15:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhG3Tr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:47:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDB3C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 12:47:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so22354436pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fVdK+4JXg1aEU6XfRh+cT+ODjMWEeNcMZB7CqecVmNQ=;
        b=HYVita9b1C5beEoeXprjo4vFurQEJTSI122jNUYTouv7+uhU3kZRWfDvekYorQcIlX
         VMJj2O1A+65NqfjmjZsXIRJ5SbV3HWAp+iR5bIut2A6nO2wlHsFSVHWGvvAPB3uhoRlB
         CNvFOapwu3pxj9SoDqqxVkAGYfA6WVK6qLZVEvYeXIPd2rhYAmL0IamDDCgvIfRaDcyR
         zxUFHP7w7sXGib73VVY5yyFOqpwyhhyIRj58iuiRNTSE/L3bCpy57250dFYQ+OMq1qKX
         Lcon3B4KeC3pTGg4PaiHZyvxEnr2VLuG5n0Wi8n73I/58IdmktC45hdXj9eRgedtHcyP
         hUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fVdK+4JXg1aEU6XfRh+cT+ODjMWEeNcMZB7CqecVmNQ=;
        b=Ijv9IZVX4Y6xKnAKs9tkwGzxPNojO/EowX1aUrYyEv919DmVAMO0A08TyWReX2JQp1
         qIvW4sE8RnDAxSSQIklqPGZAadjglwe8yn2d5TjTV+iSLAJAIBedXFyBIJWnH94B4i7q
         gTI4xjDlEkvHA7v1RWW/kcVeUcTkLx9/xnbyR0cAkLDUcbfic+0YSZvdbxsbRdmvYvkL
         YSQtUX7ESWm6vbIbk9csNByS5okEI0mThOLiKijGEsCgbCxo27z8o+MPY0luS/abBWxc
         4n5b3HgdhJqJRt5lrhxamJBTNn+tP5bS2WBP1RFcnz5ZNE226zOwX6I3R67AOCtzAn3W
         +cjw==
X-Gm-Message-State: AOAM532jjxlz1OlH7ajCCQwvZp5SU9/ZoxTvpbdutUvgAFdQBKOEAdaX
        UESO950gWMK6o0wmUxMMt1KwFA==
X-Google-Smtp-Source: ABdhPJzyPmaZrPaLUVXnl5we9tv+oas4aGybiyjrzCiyaLLDZGutjPcXPcmdDXmepzlsX+7HyDoFIQ==
X-Received: by 2002:a62:8f86:0:b029:32e:33d7:998b with SMTP id n128-20020a628f860000b029032e33d7998bmr4618356pfd.64.1627674444190;
        Fri, 30 Jul 2021 12:47:24 -0700 (PDT)
Received: from sspatil2.c.googlers.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id k4sm3703778pgh.9.2021.07.30.12.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 12:47:22 -0700 (PDT)
Subject: Re: [PATCH 1/1] fs: pipe: wakeup readers everytime new data written
 is to pipe
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20210729222635.2937453-1-sspatil@android.com>
 <20210729222635.2937453-2-sspatil@android.com>
 <CAHk-=wh-DWvsFykwAy6uwyv24nasJ39d7SHT+15x+xEXBtSm_Q@mail.gmail.com>
 <cee514d6-8551-8838-6d61-098d04e226ca@android.com>
 <CAHk-=wjStQurUzSAPVajL6Rj=CaPuSSgwaMO=0FJzFvSD66ACw@mail.gmail.com>
From:   Sandeep Patil <sspatil@android.com>
Message-ID: <b1688f32-cb0e-04e1-3c91-aa8cddbcf41d@android.com>
Date:   Fri, 30 Jul 2021 19:47:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjStQurUzSAPVajL6Rj=CaPuSSgwaMO=0FJzFvSD66ACw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 7:23 PM, Linus Torvalds wrote:
> On Fri, Jul 30, 2021 at 12:11 PM Sandeep Patil <sspatil@android.com> wrote:
>>
>> Yes, your patch fixes all apps on Android I can test that include this
>> library.
> 
> Ok, thanks for checking.
> 
>> fwiw, the library seems to have been fixed. However, I am not sure
>> how long it will be for all apps to take that update :(.
> 
> I wonder if I could make the wakeup logic do this only for the epollet case.

aren't we supposed to wakeup on each write in level-triggered (default) 
case though?

> 
> I'll have to think about it, but maybe I'll just apply that simple
> patch. I dislike the pointless wakeups, and as long as the only case I
> knew of was only a test of broken behavior, it was fine. But now that
> you've reported actual application breakage, this is in the "real
> regression" category, and so I'll fix it one way or the other.
> 
> And on the other hand I also have a slight preference towards your
> patch simply because you did the work of finding this out, so you
> should get the credit.

Ha, I can't really claim credit here. This was also reported to us
in Android that triggered the search. Plus, now that I see your thread 
with Michael Kerrisk, he was way ahead of us in finding this out.

> 
> I'll mull it over a bit more, but whatever I'll do I'll do before rc4
> and mark it for stable.

Thanks, I was actually going to suggest taking your patch cause it also 
  makes changes in pipe_read(). I am not sure if there are apps that do 
EPOLLET | EPOLLOUT (can't think of a reason why).

- ssp

> 
> Thanks for testing,
> 
>                   Linus
> 

