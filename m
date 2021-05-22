Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB63038D7C2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 01:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhEVXXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 19:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhEVXXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 19:23:10 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28862C061574;
        Sat, 22 May 2021 16:21:44 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id j12so17246134pgh.7;
        Sat, 22 May 2021 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UZUgAfQG09nzgaNT4bquHKxvVYQl+/q8c6+ebXr3LM0=;
        b=DPRmeXsijRUjcD/4rGNFdCr2+NmFXQJdgToQjAauX0OAqs0tgF1fLY6YkKUMDJXxUO
         iNnZVFoCrZuveD1mQRm/OendTSfMkWwOraKY8DIcgbx4J2fityuNnI53ljCyBprd5l3V
         MBvfj3/qNujiSeSiLQbYJYWrg8Bf+HlE9QPDstQHM+91LvDo4rLMbR9Ab2fv7kpJf/PI
         +xax/4Wdx7kPRURnawYwrouEdPY7+hqH/2JsP4c9rCdU7HQt60FHWKAu5CNIYZ0fywII
         oREvnHE5LxSZQeegy+INvMx/R1yh4LeDD8Aog8FyUix9uRlk0g4CTODByd1L/7yMAuQo
         dvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UZUgAfQG09nzgaNT4bquHKxvVYQl+/q8c6+ebXr3LM0=;
        b=mDDFAYiutgEKhnUNUZdhZzrmjrS91qX3bxUT/lcXJzb5Gh7kjQwQkgeuUm7IzPxCA1
         3pvx0HPmfyAp3Cw4yAYUiQGFHDErSEv2wY9sScHo7nEUvFYwqS5za9hwTpBVya4z/6ZO
         NGffU63AWIQyTK4SN0j7gAnlcvTz0vcBUnLd8ZSXbS2xtivhrV0YSzRw1tLxriH+9eza
         f4z+RgNzk0kz+EXwy8W9PaK62WU4PLoOnZYNhi7VxFAskahnk2Mzy92hvx1zYAhwq8bf
         /YqC3+SnkArNf0s5ISvtC7Q+TnXeV3YuzYi2iFJGLc54XstkR9sOJnLqgHijwRihnBb3
         21bg==
X-Gm-Message-State: AOAM531uf89D+swcjpCMi30/5z6/8yWkjq7dz1y9TpChrurWgbEM90cO
        wjjgQfZcRBt/CYQ5oULpdqc=
X-Google-Smtp-Source: ABdhPJwbAdTebXVKdtddNMbfCZSPaHtMZ+8pU/Hq6Ouxnk0cnJQxxKzNXLyfwO6UQ3ViVQvSzTec2g==
X-Received: by 2002:a05:6a00:2394:b029:2e0:a27:ba26 with SMTP id f20-20020a056a002394b02902e00a27ba26mr17190265pfc.63.1621725704227;
        Sat, 22 May 2021 16:21:44 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id o24sm7804591pgl.55.2021.05.22.16.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 16:21:43 -0700 (PDT)
Subject: Re: [PATCH] docs: Activate xeCJK only in CJK chapters
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
 <20210522201439.156bded8@coco.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <1bb6a68a-70cb-3f3a-462b-5ad124d0253e@gmail.com>
Date:   Sun, 23 May 2021 08:21:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210522201439.156bded8@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021 20:14:39 +0200, Mauro Carvalho Chehab wrote:
> Em Sat, 22 May 2021 16:28:55 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> Activating xeCJK in English or Italian-translation documents
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
>>       macros can be embedded in translations.tex after the fact.
>>       By default, xeCJK is inactive.
>>
>>     o Add a script retouch-translations.sh to embed the on/off
>>       macros in translations.tex where necessary.
>>       The patterns in the script are ad-hoc by nature, and will
>>       need updates when the chapter organization changes.
>>
>>     o Invoke the script at the final step of target "latexdocs".
> 
> Interesting solution, but there are probably an easy/better
> way of doing something similar to it.
> 
> There is an extension called:
> 
> 	Documentation/sphinx/load_config.py
> 
> Which allows using a per-document conf.py file. While it can also be
> used to have a "nitpick" version where extra warnings are enabled,
> the main usage were to have separated PDF documents. 
> 
> We ended finding a better solution, so most conf.py got removed
> on this patch: 9fc3a18a942f ("docs: remove extra conf.py files").
> 
> Anyway, perhaps we could simply add a Documentation/translations/conf.py
> that would add the CJK font only there.

Ah, that sounds like the way to go!

But I have no idea how I can load that extra conf.py for translations.

Simply putting the following as Documentation/translations/conf.py
doesn't work.

----
# -*- coding: utf-8; mode: python -*-

# translations have Asian characters
# which are only displayed if xeCJK is used

cjk_cmd = check_output(['fc-list', '--format="%{family[0]}\n"']).decode('utf-8', 'ignore')
if cjk_cmd.find("Noto Sans CJK SC") >= 0:
    print ("translations: enabling CJK for LaTeX builder")
    latex_elements['preamble']  += '''
	% This is needed for translations
        \\usepackage{xeCJK}
        \\setCJKmainfont{Noto Sans CJK SC}
     '''
----

What am I missing?

Note: I'm not good at python.

       Thanks, Akira
> 
> Even better, we could even improve it in a way that each translation
> would generate a separated book, and then use CJK only for the
> non-Latin translations.
> 
> Regards,
> Mauro
> 
