Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0B23B4040
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFYJYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhFYJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:24:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B70C061574;
        Fri, 25 Jun 2021 02:22:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a127so7539498pfa.10;
        Fri, 25 Jun 2021 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YAnu7UbmGFWWvf2Od6m+5K4nXXnoDnqOfGGMRpLMN+Y=;
        b=qVCrM+68EuPyS/PF2y8PUDTi7cWYE63LtJoTHjGAd+R8D2lbU7MX7xIjXgF+348vfp
         aVbARNgB19w12aDYb9SiHDbSBG7A6v8TwENdow0vZPFHT+OtJWINFJv747O+tMSQxVff
         IfCsD9HIJgrmkHl6ye0MEBlK28X+Mkr7WYTQKyIMcaqlvfN2rbpvfpQo89YjmEZHV+jk
         1uXfyf9gguHVeBMLEtMZ5GKcccKOhGOsB2g+UMuBOrO+1Yu7lFy1Oy/zOUezXGzGNJM1
         T3z3HMHuJPoJvZ7L3KcJjv/d8wxb5fg9CmCJ4tsuvOwHfEgLHe+TwUAbthHJtcyzU3lc
         bOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YAnu7UbmGFWWvf2Od6m+5K4nXXnoDnqOfGGMRpLMN+Y=;
        b=L7Q2lqw//H/UL1Gj88+N5/DRdoBwXQREFAQlt/2zJ8tSmv7ILS1A/vdwkv7ZvXRwdU
         BX83dBGO16FmV+nE/YMFf1/XbUHSMbMqeUW5fL+TyllIbtmz/tTXRzUtYYYSfDIhggtB
         vZpf37KfgTVoQmTJo2jQSg5z+xGzcIvCAKCNRo+w5+sx3y9m9gwirTfktg86nRxECpbh
         3Dkhg19ZMwjHensUNxL7wkFnzcFVSWo91m7rvsdBxKVXDQdvU5ttU5uAegPhSF7nhEIQ
         eHxXPbs0RvdY8+fnEnOF1fRGEn71lmgjnJFxbEfNdsKoF7hCkSZKMk1N+0hA/WW4JstT
         WBNQ==
X-Gm-Message-State: AOAM531n3hB4HgElbo/Q3Z7a5gjNfE1Uq8K3qMhKiIZaVbsnIZQl8nc3
        iWwz+zkbbPzrysEShqiu+gcy1jawQVI=
X-Google-Smtp-Source: ABdhPJz4ufuu92PJKZ55P8S5SooymhgbUS1PhwJQKyh/+CxU7usG9yTV3+Ai3V0UUKt6nL7lAXCSVg==
X-Received: by 2002:a63:5619:: with SMTP id k25mr8944799pgb.92.1624612949641;
        Fri, 25 Jun 2021 02:22:29 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 201sm5259919pfz.125.2021.06.25.02.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 02:22:29 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] docs: pdfdocs: Improve alignment of CJK ascii-art
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        SeongJae Park <sj38.park@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
 <20210625065524.GA11219@bobwxc.top> <20210625095059.7f97fd62@coco.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <ae0a7623-7ec4-937b-4b93-8435f2e94eb9@gmail.com>
Date:   Fri, 25 Jun 2021 18:22:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625095059.7f97fd62@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 09:50:59 +0200, Mauro Carvalho Chehab wrote:
> Em Fri, 25 Jun 2021 14:55:24 +0800
> "Wu X.C." <bobwxc@email.cn> escreveu:
>=20
>> On Thu, Jun 24, 2021 at 09:06:59PM +0900, Akira Yokosawa wrote:
>>> Subject: [RFC PATCH 0/3] docs: pdfdocs: Improve alignment of CJK asci=
i-art
>>>
>>> Hi all, =20
>>
>> Hi Akira,
>>
>>>
>>> This is another attempt to improve translations' pdf output.
>>> I see there is a mismatch in the font choice for CJK documents, which=

>>> causes poor-looking ascii-art where CJK characters and Latin letters
>>> are mixed used.
>>>
>>> One of noticeable examples of such ascii-art can be found in
>>> Korean translation of memory-barriers.txt.
>>>
>>> Hence the author of Korean translation of memory-barriers.txt is
>>> in the CC list.
>>>
>>> At first, I thought the issue could be fixed by simply selecting
>>> "Noto Sans Mono CJK SC" as both of monofont and CJKmonofont.
>>> It fixed the mis-alignment in the Chinese translation, but failed
>>> in the Korean translation.
>>>
>>> It turns out that Hangul characters in "Noto Sans Mono CJK SC"
>>> are slightly narrower than Chinese and Japanese counterparts.
>>> I have no idea why the so-called "mono" font has non-uniform
>>> character widths.
>>>
>>> GNU Unifont is an alternative monospace font which covers
>>> almost all Unicode codepoints.
>>> However, due to its bitmap-font nature, the resulting document
>>> might not be acceptable to Korean readers, I guess. =20
>>
>> OK, it works.
>>
>> But I still want to say that the display effect of Unifont is really
>> not good. Unifont's lattice is too small, and only one size.
>> http://fars.ee/QA1k.jpg	    http://fars.ee/GAAv.jpg
>> Looks like computers 20 years ago, LOL :)
>>
>> It there any chance to use other fonts, like *Sarasa Mono* ?
>>                                               =E7=AD=89=E8=B7=9D=E6=9B=
=B4=E7=B4=97=E9=BB=91=E9=AB=94
>> Looks more beautifull http://fars.ee/DTT6.jpg
>> But I guess not many people installed it.

Thank you for the nice suggestion.
Yes, Hangul characters in "Sarasa Mono" have the same widths.

>=20
> Does Sarasa mono looks nice for Japanese, Chinese and Korean
> (plus latin)?

Yes, I tested "Sarasa Mono SC" and it covers all CJK fonts.
The SC variant has Simple Chinese glyph where other languages
have their own preferred glyph, but that is same in "Noto Sans
Mono SC".

Currently, there is no verbatim/literal blocks in the Japanese
translation, so I tested with only a short Japanese sentence.

I'll post a v2 which uses "Sarasa Mono SC" instead of Unifont.

>=20
> If so, I guess it shouldn't be a problem to use it, as the
> ./scripts/sphinx-pre-install can be patched to recommend
> its install.

One minor problem might be that the Sarasa font needs manual
download (and install).

        Thanks, Akira

>=20
> Thanks,
> Mauro
>=20

