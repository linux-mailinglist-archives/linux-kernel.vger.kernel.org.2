Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0C03B4BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 04:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFZCe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 22:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFZCe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 22:34:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EADC061574;
        Fri, 25 Jun 2021 19:32:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f10so5684099plg.0;
        Fri, 25 Jun 2021 19:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZguJBm7Ta8v5rmyq9vcmT0p9z/70jaqs5v+8tFBCC0w=;
        b=RMkDBj7HJ7fRxNyucm2kOo9eHGixwr1iziXt6EBDgrmXVmdEtXr5iaZAoJsdJHG8+c
         4XUcs7t+WIhHBegyAwCG89rm0NM2FeZthckQ4qZ6V3ACbxFU/4KU1DEq0ZjVWJAdtNCh
         IbFMOyZNH2VBsAhgPTdDQolZuPeLRfhkNdlX4Hh4TmRe49BARRoDK66B9wjCc6mcbt+/
         lawRyqAZdRey/ogRl7Qz6HhlvJ41f+LLziZEd7Sd26650LTz5ydxGa4vfoNWi9WBbEEe
         yaWvHf6wkWtEXXP8Ukk98olwtv4kAhkNHd2bw7SlZDoeW/vT6Tg5Fl0kou/aIwZwFIYK
         plkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZguJBm7Ta8v5rmyq9vcmT0p9z/70jaqs5v+8tFBCC0w=;
        b=bc3+LGko9epKmj84mOdq8bvLjdt4vLshsxbgpzqNayHZNwWn64Mq9Ou4x3X0AtX4/L
         1lGagi46YV8Ap5Gq+iqpxRWT002n1Nm/yQ1TJ/bqspe+sejeXEgoeiz1CCG5m0vVsmAr
         dUg5yikpS0f6Skn3QUQyzUIK94jj6IzdWVl3aanQhi+cocM/CYhYXV7Evhfztdh2+6NX
         BM0chSvA0uDEKqS7P3L7s2TcxfvY/wxVa4DjoVHrgqjiqHfz+FOtANfrHW0E+vXExveC
         TbCN1i2QFx21rKkeHZrk+aUzPiJEi9IYbbm6Js8gKxU6KakesDK/u/emds4n6KiBD5yZ
         DBtQ==
X-Gm-Message-State: AOAM530fpZ4xd4+dcp7OM63Ae+JdgqAXnZd1zwCrUTLWSMzd6Q9biJcX
        RkbTHpLGC3vHNzzLXm4u4CM=
X-Google-Smtp-Source: ABdhPJyvO4oOozSsX2gbNhMQN+t5UfASsRZAzIqt3v74HVCIYkpUjls8fbYJkPEDwnBcv/4Yn1Kaeg==
X-Received: by 2002:a17:902:6b42:b029:11d:a147:bb7b with SMTP id g2-20020a1709026b42b029011da147bb7bmr11997765plt.9.1624674752896;
        Fri, 25 Jun 2021 19:32:32 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id a25sm6773878pff.54.2021.06.25.19.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 19:32:32 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] docs: pdfdocs: Improve alignment of CJK ascii-art
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "Wu X.C." <bobwxc@email.cn>, Jonathan Corbet <corbet@lwn.net>,
        SeongJae Park <sj38.park@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
 <20210625065524.GA11219@bobwxc.top> <20210625095059.7f97fd62@coco.lan>
 <ae0a7623-7ec4-937b-4b93-8435f2e94eb9@gmail.com>
 <20210625122423.4435c5e9@coco.lan>
 <b6ea891e-b6f3-318a-1b40-268f436c6860@gmail.com>
 <20210625201113.337b3ecd@coco.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <0cfd8dfb-b304-4073-973c-930a93d19a17@gmail.com>
Date:   Sat, 26 Jun 2021 11:32:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625201113.337b3ecd@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 20:11:13 +0200, Mauro Carvalho Chehab wrote:
> Em Fri, 25 Jun 2021 20:32:47 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> On Fri, 25 Jun 2021 12:24:23 +0200, Mauro Carvalho Chehab wrote:
>>> Em Fri, 25 Jun 2021 18:22:26 +0900
>>> Akira Yokosawa <akiyks@gmail.com> escreveu:
>>>   
>>>> On Fri, 25 Jun 2021 09:50:59 +0200, Mauro Carvalho Chehab wrote:  
>> [...]
>>>>
>>>> One minor problem might be that the Sarasa font needs manual
>>>> download (and install).
>>>>
>>>>         Thanks, Akira  
>>>
>>> If this is not yet packaged as part of texlive packages
>>> on distros, this won't be a minor issue, as we'll need
>>> to find procedures and test it for all distros supported
>>> by the script.  
>>
>> Existence of "Sarasa Mono SC" can be checked by the command:
>>
>>     fc-list | grep "Sarasa Mono SC," | grep "style=Regular" | wc -l
>>
>> If the result is *not* "0", you have the font somewhere in your
>> fontconfig path.
>>
>> I think this is portable across distros.
>> Wouldn't this suffice for sphinx-pre-install?
> 
> No. The sphinx-pre-install tool generate a list of commands
> needed to install the pre-reqs on a given distro.
> 
> For instance, if you run on opensuse without texlive, it would
> print:
> 
> 
> 	# ./scripts/sphinx-pre-install 
> 	Detected OS: openSUSE Tumbleweed 20210515.
> 	Sphinx version: 3.5.4
> 
> 	Warning: better to also install "latexmk".
> ...
> 	Warning: better to also install "xelatex".
> 	You should run:
> 
> 	sudo zypper install --no-recommends texlive-latexmk-bin texlive-amscls texlive-amsfonts texlive-amsmath texlive-anyfontsize texlive-babel-english texlive-capt-of texlive-caption texlive-cmap texlive-colortbl texlive-courier texlive-dvips texlive-ec texlive-eqparbox texlive-euenc texlive-fancybox texlive-fancyvrb texlive-float texlive-fncychap texlive-framed texlive-helvetic texlive-luatex85 texlive-makeindex texlive-mdwtools texlive-metafont texlive-metapost texlive-multirow texlive-needspace texlive-oberdiek texlive-palatino texlive-parskip texlive-polyglossia texlive-preview texlive-psnfss texlive-tabulary texlive-threeparttable texlive-times texlive-titlesec texlive-tools texlive-ucs texlive-upquote texlive-wrapfig texlive-zapfchan texlive-zapfding texlive-xetex-bin
> 
> The same command, when executed on a different distro will
> print a different set of packages and commands.

I see...

So let's forget Unifont and "Sarasa Mono" for the time being.

By adding some custom configuration of fontconfig, "Noto Sans Mono
CJK SC" can be made an alias of "Sarasa Mono", "Unifont", or whatever
alternative font one wants to try.

An alternative *true* monospace font is just a nice-to-have for
those who concern PDF of Korean translation, and as I have said
earlier, it has another major issue of white spaces being ignored
by xeCJK.

I'll do a v2 along this line.

        Thanks, Akira

> 
> Thanks,
> Mauro
> 
