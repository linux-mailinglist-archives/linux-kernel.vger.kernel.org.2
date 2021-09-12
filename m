Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2117407B59
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 05:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhILDB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 23:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhILDBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 23:01:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47F8F610A3;
        Sun, 12 Sep 2021 03:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631415642;
        bh=pS9HZVlPvtn7Q5XlT8PPFoLDREqGK4O9HDm8FSSaPHI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZseE5TN+4AdVYOkod9V9le8TintjIIwojHczkYeZH0PEcDEvgElQ9/la7eJKc46Gq
         cyNQfBvmxqTrdKiJuqxzwFysdwbtEzXUJRPp2V50MREwyZVovUFf7u9Rhte3HvwAK4
         DlY5aKEXoMsQkJwt3pPMpYMExhgEZ3YfuhCtDJW3MOLlZ1mdH0rxd6GOYUHLQjCCDT
         DTxK+5l58OiX6Gm4CTc/PTbe0WPAtk3liQoxbuG5TOlmb1J270XvXCyUDn91z8fNm4
         /aI85Vx7U/T04StSEey2OWheuCh9tm0W2/O7lS8ILcEmjGKRgoXbrcSIHk8lvWzirZ
         RUjTwyrNlWvkQ==
Received: by mail-ot1-f45.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso8208584ots.5;
        Sat, 11 Sep 2021 20:00:42 -0700 (PDT)
X-Gm-Message-State: AOAM531ANEGDWsOYADxBXtURqA2M6orwNbiXMupVNau5v0xiK3GQfUL5
        9fC7bMb7wso4WmefIw8t9NSpKhN0HxPYXbBm3Jw=
X-Google-Smtp-Source: ABdhPJz/0eZ6wzPUVUTrKtioPZwMEYnNDLoIX9jJxNXCjS/fmtAEESV3jW7ry58dQCKy6SgQoM4mkifLd2TA2Es48/A=
X-Received: by 2002:a9d:36d:: with SMTP id 100mr4366711otv.237.1631415636724;
 Sat, 11 Sep 2021 20:00:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:74d:0:0:0:0:0 with HTTP; Sat, 11 Sep 2021 20:00:36 -0700 (PDT)
In-Reply-To: <51815fbe3e864a0177445b9b17d018a42d603e21.camel@gmx.de>
References: <425df999d02a62af13da8e77dbed0f2be750cda8.camel@gmx.de> <51815fbe3e864a0177445b9b17d018a42d603e21.camel@gmx.de>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 12 Sep 2021 12:00:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8ihs-DmE234edRCoCo9FVPRwiiyKGgVz+rrt0hHE=K7g@mail.gmail.com>
Message-ID: <CAKYAXd8ihs-DmE234edRCoCo9FVPRwiiyKGgVz+rrt0hHE=K7g@mail.gmail.com>
Subject: Re: ksmbd,transport_rdma.c: Don't include rwlock.h directly
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021-09-12 11:23 GMT+09:00, Mike Galbraith <efault@gmx.de>:
> typing hard.. Thag forget type [patch]
I will apply this patch, Thanks for your patch!
>
> On Sun, 2021-09-12 at 04:19 +0200, Mike Galbraith wrote:
>>
>> rwlock.h specifically asks to not be included directly.
>>
>> In fact, the proper spinlock.h include isn't needed either,
>> it comes with the huge pile that kthread.h ends up pulling
>> in, so just drop it entirely.
>>
>> Signed-off-by: Mike Galbraith <efault@gmx.de>
>> ---
>>  fs/ksmbd/transport_rdma.c |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> --- a/fs/ksmbd/transport_rdma.c
>> +++ b/fs/ksmbd/transport_rdma.c
>> @@ -20,7 +20,6 @@
>>  #define SUBMOD_NAME    "smb_direct"
>>
>>  #include <linux/kthread.h>
>> -#include <linux/rwlock.h>
>>  #include <linux/list.h>
>>  #include <linux/mempool.h>
>>  #include <linux/highmem.h>
>>
>
>
