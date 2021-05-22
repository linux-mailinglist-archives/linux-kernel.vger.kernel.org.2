Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9A538D7CF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 01:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhEVXgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 19:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhEVXgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 19:36:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5CBC061574;
        Sat, 22 May 2021 16:35:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t9so4345250ply.6;
        Sat, 22 May 2021 16:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5d/AMdghvz+nBd6axuELDzHSk9xkveObVkaQMKlgVrc=;
        b=bo1ZRpK9sbdnAMH6jwdUoVwbU03+zQtIhjAfjXLWfP8bfjBL7hoprXCJUxjPgcz4kH
         3FT+cu/SYCtlAu4KMwF4C4/QpOaqeTNyD4/YyZ8Dj4MfE033VvRBdovudxhs0su8dXBw
         SL4lSDAZ3szhZNwltg71jO/23uSLEV1CvzAOHdgAw7hbqcPU+T5pd+iPw7/gUrEEmZHF
         AYdMjcLZs8g2pTlHUVvkTqJhFUs8Xp5ir5tZy+j4+G6Krn2MtNhdciLYeH0S6UCJBXLP
         T79l2j3+mlPqEJC8wYZtAzDvh2UQKeh/Nhjgae3bOmZToaSXtTrizUrLUelXrMnxY+Ze
         ncVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5d/AMdghvz+nBd6axuELDzHSk9xkveObVkaQMKlgVrc=;
        b=WAl45ENBZR3OeT6CnZDQ5019F6wqM8GIGyx24r49+c9YHscO6Z2+lozy1KHjLFuyyD
         VOLTIiI8VEBKQg2r6rNc+7ppWlLKMeS2tOBbaAhFF68RSzXPT/svE82rarBQ0Susr7+b
         uA0yajCqQiiOgRNu1jJJn8vTc0stIxNbcNEv7X4wClRBlA+ivPXp0AFzg8/SERAziY3f
         UD347SNM4VRpwuKLAcXvd/DY74+wCcsR/64QQTgFddxArNjIhyl1b4QCEtjOf1Dkblh8
         AR/IDh6zUmnZxFwiKg+49YWP/AOsYAhHRgeI1QMkq8QfEva+yfrUQg8NPCzkCH9fQKNV
         +vZw==
X-Gm-Message-State: AOAM530KjC0S0t0tSFFHDj0ykoyQMjfsZ8GdIQeHbZqwD22KRux0tV8m
        3eN6RkyjJ6Gp0q1S6Yu6ssY=
X-Google-Smtp-Source: ABdhPJxC/oj/TUiU6EdYXXBmMIMc6NRgk9DjWuu+aKXkCpqODVwX8D34UW85u+lX76rdbq9+ps6VNg==
X-Received: by 2002:a17:902:7684:b029:f4:b82b:b893 with SMTP id m4-20020a1709027684b02900f4b82bb893mr18385131pll.67.1621726513569;
        Sat, 22 May 2021 16:35:13 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 24sm7648750pgz.77.2021.05.22.16.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 16:35:13 -0700 (PDT)
Subject: Re: [PATCH] docs: Activate xeCJK only in CJK chapters
To:     "Wu X.C." <bobwxc@email.cn>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
 <20210522165606.GA25494@bobwxc.top>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <8d74d71d-4a1d-7850-006c-eacf1abf84e5@gmail.com>
Date:   Sun, 23 May 2021 08:35:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210522165606.GA25494@bobwxc.top>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2021 00:56:06 +0800, Wu X.C. wrote:
> On Sat, May 22, 2021 at 04:28:55PM +0900, Akira Yokosawa wrote:
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
>>
>>
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> ---
>=20
> Hi Akira,
>=20
> Test this patch with Noto Sans SC font, worked well.
> =E2=80=9C=E2=80=9D use right font in western language docs now.>=20
> Tested-by: Wu XiangCheng <bobwxc@email.cn>

Thank you for testing!
As Mauro has a simpler and better idea to do this, I need to do
a respin.  I'll add you in the CC list.

        Thanks, Akira

>=20
> Thanks,
> Wu X.C.
>=20

