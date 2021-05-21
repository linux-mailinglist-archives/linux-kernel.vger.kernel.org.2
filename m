Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3968F38C770
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhEUNFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhEUNFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:05:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8D7C061574;
        Fri, 21 May 2021 06:04:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ot16so8998455pjb.3;
        Fri, 21 May 2021 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KazFp94vGYmH79BEM/aZY06cbYtJj9Pb42I1kTX5ais=;
        b=A1vN4FGQLVWObKaTYn4XZNkCnS0cW7/YlaWSyX7nhnMjI8f+poG6AzkoHKcytcHMm2
         efBoGGct11QNH6W0lWdNqGUkrEo27SFpR10Ou5o050AzxqPjUh1J58d7Gh+q3OJfaoIk
         b9TmXmMf9ca7kgAYauSPZGdmpGypj9DQ1vnzozi/Q7T9I6W5qagZGGRwpIofpR6X4cnI
         yUXzLF0FK6WFUGK4DMWN2RaKXUUlg6sVYIIX9UUpDsEWNrlLvIxalP3Qvd8GgRrIE64G
         u6pQ2Mv28VsV/SbYshLS/dCo6ne5frT40pIbpbp/MiXijwFR05VwgXMaWg2/a7V5X8/i
         DlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KazFp94vGYmH79BEM/aZY06cbYtJj9Pb42I1kTX5ais=;
        b=BLnxtatWezAUQjT8pVpBO3kD7OqXMRVzeA2J0QOVoF2vxpGYffUTAnRz6Metr9fbyB
         qZ/XUezGDqXBqMRhC7swFM1Czr3td8ChlDTMCRycTJbyzuFiDY4bZMTNXO+YYsHVgyoY
         en78naDu7k/pUwPHX8yHRg6Tj49zgLNKUwsLwhO4BAyw/nTDin0HL3eG6er9Xsw9ujB5
         rnIWGyxoU97Rn4iSpDsVXYBva6GVvJn0qSYpd6TqZ1qesEb+JDPsyQnWmT1G+c52kiUF
         ZcNEdg10dfzyyz0vr0qOi6rJLRFyNQR/afmpOPQo/uv09Zl1lNURgYAeXhBLgbqEsGOJ
         8ziQ==
X-Gm-Message-State: AOAM530lCqT/7PeA+y8IedBk1XoZhciNgBYHSAmBSPg3vlOGFNdz4dwb
        hgF54Xu+XNY2Nfl4KoMoBi7iOLBkhhs=
X-Google-Smtp-Source: ABdhPJz/m8bP3ZeWer2qhsavubfZnJpDs1oXVTSQNN2C3kjXoTxbrt6W01I+O9baCBGJyu+Lk/35CQ==
X-Received: by 2002:a17:902:9b83:b029:ef:4dd5:beab with SMTP id y3-20020a1709029b83b02900ef4dd5beabmr11851112plp.76.1621602255851;
        Fri, 21 May 2021 06:04:15 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y64sm4246179pfy.204.2021.05.21.06.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 06:04:15 -0700 (PDT)
Subject: Re: [PATCH] docs: sphinx-pre-install: Reword warning on installing
 cjk font
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c5652bb4-0bb0-9efa-2b80-a79793a8efa8@gmail.com>
 <20210521095442.33957ff3@coco.lan>
 <0c33f48f-150d-caa9-d18b-f1267f679f26@gmail.com>
 <20210521141952.2c575cbe@coco.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <12a4169e-5c50-b6c3-64df-37a9d05199b3@gmail.com>
Date:   Fri, 21 May 2021 22:04:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210521141952.2c575cbe@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 14:19:52 +0200, Mauro Carvalho Chehab wrote:
> Em Fri, 21 May 2021 18:00:00 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> Hi Mauro,
>>
>> On Fri, 21 May 2021 09:54:42 +0200, Mauro Carvalho Chehab wrote:
>>> HI Akira,
>>>
>>> Em Fri, 21 May 2021 16:14:19 +0900
>>> Akira Yokosawa <akiyks@gmail.com> escreveu:
>>>   
>>>> Installing a ckj font as recommended by the warning message causes
>>>> generated latex code to have:
>>>>
>>>> 	% This is needed for translations
>>>> 	\usepackage{xeCJK}
>>>> 	\setCJKmainfont{Noto Sans CJK SC}
>>>>
>>>> in its preamble even for an English document.  
>>>
>>> Yes. The same LaTeX configuration is applied to all documents.
>>>
>>> While the standard Sphinx logic allows just one conf.py, there's
>>> a logic on Linux that allows a per-directory configuration.
>>> Perhaps it would be possible to set the font just for translations.
>>>
>>> Yet, this can't be easily done per-translation - Italian
>>> translation for instance doesn't need CJK fonts.  
>>
>> Yes, the Italian part looks ugly with xeCJK.
>>
>>>   
>>>> The package "xeCJK" changes wide characters' appearance including
>>>> apostrophe (single quote) and double quotes, and it changes line-break
>>>> behavior with regard to the boundary of narrow and wide characters.
>>>>
>>>> This greatly degrades readability of English PDFs typeset by xelatex.  
>>>
>>> Hmm... could you give an example where it looks ugly?
>>>
>>> At least on the documents I use to check the PDF output, I was unable
>>> to see any big issue.  
>>
>> Appended are screenshots from RCU.pdf built with and without xeCJK.
>>
>> They are built on Ubuntu Bionic based container with sphinx 2.4.4.
>>
>> I think you can see the difference of how apostrophes are rendered.
>> Line-break points are also affected by the widths of apostrophes.
>>
>> Can you spot the difference?
> 
> Ok, now I understand what you're meaning. We need to double check
> what's wrong there, as it doesn't make much sense to have a
> "`  " character instead of "`" on those places, nor to change
> the word's hyphenation logic.

No, I'm afraid you don't get the point yet.

The point is, just commenting out the lines:

 	% This is needed for translations
% 	\usepackage{xeCJK}
% 	\setCJKmainfont{Noto Sans CJK SC}

, xelatex renders both UTF8 and ASCII apostrophe characters in the
same way.

On the contrary, with xeCJK, UTF and ASCII code are handled
differently.
The reason is that in CJK typesetting, line breaks are permitted almost
anywhere in the text, with a few exceptions specific to each language.

So, sphinx is doing nothing wrong when it converts ASCII apostrophe in
.rst into the UTF8 in latex code.

Enabling xeCJK in English document is the very wrong thing to do in the
first place.

I hope I have made my point clear enough.

        Thanks, Akira

> 
>>
>> BTW, on current docs-next, wich the CJK font installed, "make pdfdocs"
>> stops while building s390.pdf.
> 
> That's weird.
> 
>> I needed to manually run "make latexdocs", then run
>> "latexmk -xelatex RCU.tex" under Documentation/output/latex/ to get
>> RCU.pdf.
> 
> Well, you can pass some options to latexmk when building a
> pdf via an environment var (LATEXMKOPTS), like (untested):
> 
> 	LATEXMKOPTS="-interaction=nonstopmode" make pdfdocs.
> 
> or change it to interactive mode, in order to show what part
> of the s390.tex is causing the issue.
> 
> Thanks,
> Mauro
> 
