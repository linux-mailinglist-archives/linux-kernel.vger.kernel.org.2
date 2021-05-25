Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C740390165
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhEYM52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhEYM51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:57:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DFCC061574;
        Tue, 25 May 2021 05:55:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so13109450pjv.1;
        Tue, 25 May 2021 05:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AetoYR95C/EM7RtotuJaX9n3+/OqeWSyJo94V9oStUQ=;
        b=omPwWY1AQITTrDd1TD1YEkJM8lG02ddk0ZyPvhYGJMxxljO4aUwPzSHlnUvJWhqb1i
         dGTXZjQMGNgH9mTHVMnbMGiFSTYWxojCIvfYCuDjpEGChcgQQVbPSntorBuoPpx+3OUz
         jxHgDo1hTCYJDYLPlXMeolZclaIdCR+sochJzAAHDgKhnJtNAVweJUsoOOH1VYFyEnfm
         kf45LMT3nxO8ybxUd9wOrDY/KXDNdGVLSXtWkie42yohQyPp2r/45SGHcAbx3CHP+1sh
         GWci7ldm7JGqJU0ypiazIkXOPXBfeUNHNW3n5tIzY/HPIaqxnVLAhiycjDwmiWS3Lb3g
         yjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AetoYR95C/EM7RtotuJaX9n3+/OqeWSyJo94V9oStUQ=;
        b=HmqvxQoOdGgopkx+MSgQhZ+mAodN4o92+60UK8ifIGuTyfibUKcIEHrzXMnAN7zhnY
         Er1eyQN50kxKMyTm2VAxaoYZPHGNtLGEQn8WGy3ss+qaxqMId3h72udNkigdlLu8Ur+o
         akFCuFPN498tmE8KdRVphvLSWe0USnXeFC6b+H5BUqxgriqPECSCLJh/gMY01tnksRxe
         z6NZzqbvRz3TMqx2hUQgoe3kA3whSUWKTNiYrsKYsQs1+rw4d+NK6Oj02NEXKPatFYCk
         jMR9SUyybz/UKvwOMuhMImU/68JN96iyPmXv/Nt7IiqRr72SnzVs8tQ8DA6+MaXIjo2I
         36xQ==
X-Gm-Message-State: AOAM530C4BsCz7WUrZkPDqjaPia1UphUkGj0yMjFfTPvP3UhzFra4BBo
        +seCsmWSKsquXz7Pi2552oFd993IvdI=
X-Google-Smtp-Source: ABdhPJz8T6QnDhgauGuIVOuQAPk1wwuuuL9v8i1sXNYRAOVS+oIHc5sM/R9uSbJowZns4F9o6Aj5ow==
X-Received: by 2002:a17:90a:6f06:: with SMTP id d6mr30463372pjk.216.1621947356957;
        Tue, 25 May 2021 05:55:56 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id s14sm14755937pfs.108.2021.05.25.05.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 05:55:56 -0700 (PDT)
Subject: Re: [PATCH v2] docs: Activate exCJK only in CJK chapters
To:     "Wu X.C." <bobwxc@email.cn>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
 <0229bc4d-b391-41b9-e900-b88089c493df@gmail.com>
 <20210525123012.GA16810@bobwxc.top>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <97234fd1-66b8-5591-1259-6e995f91835f@gmail.com>
Date:   Tue, 25 May 2021 21:55:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210525123012.GA16810@bobwxc.top>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 20:30:12 +0800, Wu X.C. wrote:
> On Tue, May 25, 2021 at 08:17:26PM +0900, Akira Yokosawa wrote:
>> Activating xeCJK in English and Italian-translation documents
>> results in sub-optimal typesetting with wide-looking apostrophes
>> and quotation marks.
>>
>> The xeCJK package provides macros for enabling and disabling its
>> effect in the middle of a document, namely \makexeCJKactive and
>> \makexeCJKinactive.
>>
>> So the goal of this change is to activate xeCJK in the relevant
>> chapters in translations.
>>
>> To do this:
>>
>>     o Define custom macros in the preamble depending on the
>>       availability of the "Noto Sans CJK" font so that those
>>       macros can be used regardless of the use of xeCJK package.
>>
>>     o Patch \sphinxtableofcontents so that xeCJK is inactivated
>>       after table of contents.
>>
>>     o Embed those custom macros in each language's index.rst file
>>       as a ".. raw:: latex" construct.
>>
>> Note: A CJK chapter needs \kerneldocCJKon in front of its chapter
>> heading, while a non-CJK chapter should have \kerneldocCJKoff
>> below its chapter heading.
>>
>> This is to make sure the CJK font is available to CJK chapter's
>> heading and ending page's footer.
>>
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> 
> Test it, worked well.
> 
> Tested-by: Wu XiangCheng <bobwxc@email.cn>

Thanks!

> 
> And one warning when am patch:
> 
>     .git/rebase-apply/patch:62: trailing whitespace.
> 	    \kerneldocCJKoff

Oops, will fix and post v3 soon, with your Tested-by: appended

> 
> 
>> I think per-directory conf.py can be tried as a follow-up
>> change after this patch is applied.
> 
> Agree, I think it's enough for this problem.
> If we need more complex customization, per-directory conf.py then worth. 
> 
>> --- a/Documentation/translations/index.rst
>> +++ b/Documentation/translations/index.rst
>> @@ -18,6 +18,10 @@ Translations
>>  Disclaimer
>>  ----------
>>  
>> +.. raw:: latex
>> +
>> +	\kerneldocCJKoff	
>> +
>>  Translation's purpose is to ease reading and understanding in languages other
>>  than English. Its aim is to help people who do not understand English or have
>>  doubts about its interpretation. Additionally, some people prefer to read
>> diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
>> index bb8fa7346939..e80a3097aa57 100644
>> --- a/Documentation/translations/it_IT/index.rst
>> +++ b/Documentation/translations/it_IT/index.rst
>> @@ -4,6 +4,10 @@
>>  Traduzione italiana
>>  ===================
>>  
>> +.. raw:: latex
>> +
>> +	\kerneldocCJKoff
>> +
>>  :manutentore: Federico Vaga <federico.vaga@vaga.pv.it>
>>  
>>  .. _it_disclaimer:
> 
> And for above two, maybe better to put "raw:: latex" block above the
> title, more beautiful, and CJKoff will be done before enter "Italiana"
> chapter.

These two are placed there intentionally.

As mentioned in the change log:

>> Note: A CJK chapter needs \kerneldocCJKon in front of its chapter
>> heading, while a non-CJK chapter should have \kerneldocCJKoff
>> below its chapter heading.
>>
>> This is to make sure the CJK font is available to CJK chapter's
>> heading and ending page's footer.

If they are put above chapter titles in the .rst files,
Chinese translation's final page's footer won't be rendered properly.

        Thanks, Akira

> 
> Thanks,
> 	Wu X.C.
> 
