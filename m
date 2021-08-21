Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB523F3ABB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 15:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhHUNQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 09:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhHUNQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 09:16:20 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05080C061575;
        Sat, 21 Aug 2021 06:15:40 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id e9so7993246vst.6;
        Sat, 21 Aug 2021 06:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vfaQf0lp7sfjKT26+UEo2bDUyBDeG4IA93iti7qV08o=;
        b=kxE1xJzjdqGi3dN4a2VJcMkFf7K6IyB09P3EnHhhmTgcQg+D+rpk8o78fewBkIGibJ
         yvnaLTNbtJaP+y0Vf58FTWslBBkLhxM33LMtA3+aT+mTJJBb9L3wrElwOJToFBYzOESW
         gH7S2k6J5v/ACQrrERr8efbDQNwL7vBZtKIblX2paKnTV4ObiMq/3LYZUXvM6xArmusR
         Jjp/8uP/3/5v6zRW2lY6IRkQQPZlEhAURgFE+OJjTWgKEb3blXRPK6NoBMJz8B5qmNeL
         LlVJBt7+POWmEvMLB8mYvv0UwfycLpEvWRs92UcThmGOsapOjoa0Alg4r8Pk9ywtGjPV
         h2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vfaQf0lp7sfjKT26+UEo2bDUyBDeG4IA93iti7qV08o=;
        b=Jk0PEJ/3PLVCyXZJtCqndowAwQbjx7cVuXN2RVcLCuBhTj8jbeZpesGHr3AEo74WX1
         AccrPkkwNLh6pakAVJFJ+jyKs+0RSOHXozBTsU3mL2IsH0d02nEaRcGPvVaxqTGx1mTS
         m+2UvnS+sFQRYuufcoTiGpaYi5TFAOoqG1kQ2CNre3bXt5qkBW0cWUoEIWc9OCJR+GNG
         1V2Ekpz9m1edGxgk6hrwRSmzXLd3btKmC5jZncjy/ztu/YfmxlTDPlgti3IuhTJ39P0r
         OL/JEG68lIPavOWHwCnKcTDA2oXSk0sTDVjHDk7DvZx5Ft2IOONWXJwyBirlvvYGS18u
         hQuw==
X-Gm-Message-State: AOAM530KRa3rVz7OdJOPdn+cDe6sDTxSnkFNx/luQuj0y8JRX+rTo4yM
        XJjd/ttW3UU/EFBDyAjPel2hE49q7P7G6oUTv5WpUlfC
X-Google-Smtp-Source: ABdhPJxpBJNyVN57HzS/5gM/y47+boTSsh3DvOVdD/UxGF7W9Np8btK1rZ64ePlvBRrV5iKvZ7sT/oOmdf1umOxRmPw=
X-Received: by 2002:a05:6102:4af:: with SMTP id r15mr20282978vsa.31.1629551739588;
 Sat, 21 Aug 2021 06:15:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:55cf:0:0:0:0:0 with HTTP; Sat, 21 Aug 2021 06:15:38
 -0700 (PDT)
In-Reply-To: <87zgtbpvgq.fsf@meer.lwn.net>
References: <20210820222152.971174-1-henrybear327@gmail.com> <87zgtbpvgq.fsf@meer.lwn.net>
From:   Henry Tseng <henrybear327@gmail.com>
Date:   Sat, 21 Aug 2021 15:15:38 +0200
Message-ID: <CAA5xa-=WXZ5QqQ7FwtruOk_7+dPtcQr_FBjZ8VRNFOWfpuVFrQ@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: Update details of The Linux Kernel
 Module Programming Guide
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     jmseyas@dit.upm.es, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21, Jonathan Corbet <corbet@lwn.net> wrote:
> Chun-Hung Tseng <henrybear327@gmail.com> writes:
>
>> Recently, the content and examples of the book "The Linux Kernel Module
>> Programming Guide" are being actively maintained and added on Github[1].
>> Currently, the book is being regularly built into webpage and pdf
>> file using Github static page[2].
>>
>> [1]: https://github.com/sysprog21/lkmpg
>> [2]: https://sysprog21.github.io/lkmpg/
>>
>> Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
>> ---
>>  Documentation/process/kernel-docs.rst | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/process/kernel-docs.rst
>> b/Documentation/process/kernel-docs.rst
>> index 22d9ace5df2a..dd911cf09b55 100644
>> --- a/Documentation/process/kernel-docs.rst
>> +++ b/Documentation/process/kernel-docs.rst
>> @@ -126,15 +126,17 @@ On-line docs
>>          describes how to write user-mode utilities for communicating
>> with
>>          Card Services.
>>
>> -    * Title: **Linux Kernel Module Programming Guide**
>> +    * Title: **The Linux Kernel Module Programming Guide**
>>
>> -      :Author: Ori Pomerantz.
>> -      :URL: https://tldp.org/LDP/lkmpg/2.6/html/index.html
>> -      :Date: 2001
>> +      :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob
>> Mottram,
>> +      Jim Huang.
>> +      :URL: https://sysprog21.github.io/lkmpg/
>> +      :Date: 2021
>>        :Keywords: modules, GPL book, /proc, ioctls, system calls,
>>          interrupt handlers .
>> -      :Description: Very nice 92 pages GPL book on the topic of modules
>> -        programming. Lots of examples.
>> +      :Description: A very nice GPL book on the topic of modules
>> +        programming. Lots of examples. Currently the new version is
>> being
>> +        actively maintained at https://github.com/sysprog21/lkmpg.
>
> I have applied this, thanks.
>
> That said, this change introduced a set of build warnings:
>
>     Documentation/process/kernel-docs.rst:132: WARNING: Field list ends
> without a blank line; unexpected unindent.
>     Documentation/process/kernel-docs.rst:136: WARNING: Unexpected
> indentation.
>     Documentation/process/kernel-docs.rst:137: WARNING: Block quote ends
> without a blank line; unexpected unindent.
>
> To fix that, I had to do this:
>
> diff --git a/Documentation/process/kernel-docs.rst
> b/Documentation/process/kernel-docs.rst
> index dd911cf09b55..da9527502ef0 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -129,7 +129,7 @@ On-line docs
>      * Title: **The Linux Kernel Module Programming Guide**
>
>        :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob
> Mottram,
> -      Jim Huang.
> +        Jim Huang.
>        :URL: https://sysprog21.github.io/lkmpg/
>        :Date: 2021
>        :Keywords: modules, GPL book, /proc, ioctls, system calls,
>
> Please, be sure to test the docs build before sending patches.
>
> Thanks,
>
> jon
>

Hi Jon,

I tried to put Juan-Mariano de Goyeneche (jmseyas@dit.upm.es) in cc,
as indicated on the kernel-docs file. But the email account is not reachable
in the last few email exchanges.

Should we probably amend that part of the file, too?

Thank you!

-- 
Best wishes,
Henry
