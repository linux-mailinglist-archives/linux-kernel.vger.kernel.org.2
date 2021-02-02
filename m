Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7F530C82A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbhBBRn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbhBBRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:40:45 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FD1C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:40:05 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 2so10308594qvd.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCvL276XXLN76mFM3Tv50taSjKfRq7S5/IJQSJlEqAY=;
        b=SFfpqctK7Ngvylzo7AwvmzzWzBfd/cV07hD4gnD0CtE0u21zMdGu6NOI26L3kRiYgY
         ziRWyEMpi8Vf6aROCXtdqFgNJW2w1nYXo2xnoWq14jCn7QaUdO5HWcla48M0hjWdB70t
         A18vZTciBSiYEyu2xzYW6FyWNKWHpWvVHFybY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCvL276XXLN76mFM3Tv50taSjKfRq7S5/IJQSJlEqAY=;
        b=S8HwxIcPjcy3J8UvrI7t+8gBwvkjN5uwG2VI67LugkoNRVeYu8dGlmdHCmBVU4tW/w
         gkbbWKC2O9NGt7mWv9nCRQFq4Pluq1jNM5sD1gwWf1gmVR0PPf6npC4ZegPlS74pegEZ
         LtLbMUIg3As6huFgqJLwZcJgN3BHAo30MECSLLZF1DOdpO5SsRjL3yDeZeFxcm5n0yV6
         F+4GDlJPFEKPmtP8+35AVR3wnnrkNhLg7jq2SLUCZC+5ndJmOib+CckV5OtlMoHwqija
         qgMwJ5ilpClZVUUZ2YzL7GZ6V9szZnHPzLDcq4lwmbtQeAq3vLwWehdnuVqnAGkLPfgn
         HujA==
X-Gm-Message-State: AOAM532iLbde21O/rbBjKs00UrUXfgWjGDkqnXYUgfNglBZy5ePFOiws
        R7P04YcU+dRZIjjG+0KRzq/nIksqY/Fryw==
X-Google-Smtp-Source: ABdhPJxp3RSEfFtFLEi0jf7u/qQqU+FZQv7rL/MU4DWQSJW+ngr1DopXQ/+roFndPYBPSEcHsClzXw==
X-Received: by 2002:a05:6214:1110:: with SMTP id e16mr21155877qvs.62.1612287604426;
        Tue, 02 Feb 2021 09:40:04 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id t14sm17687722qkt.50.2021.02.02.09.40.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 09:40:03 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id e132so1416840ybh.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:40:03 -0800 (PST)
X-Received: by 2002:a25:da53:: with SMTP id n80mr33069915ybf.79.1612287603131;
 Tue, 02 Feb 2021 09:40:03 -0800 (PST)
MIME-Version: 1.0
References: <1612005840-4342-1-git-send-email-stephenzhangzsd@gmail.com>
 <CAD=FV=WQ7iCQFf6Qb3agM4DCt_Df3c6BwV_T6tEMMxXArbY_5A@mail.gmail.com> <CALuz2=erXGa2q_ODOpARK9yb_GQo0nOLWnP-PuBMCc+pv8Cp4Q@mail.gmail.com>
In-Reply-To: <CALuz2=erXGa2q_ODOpARK9yb_GQo0nOLWnP-PuBMCc+pv8Cp4Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Feb 2021 09:39:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xcywabh3U0=hzd8DXR2gdwLBEFsbwLof7Y6LMu+ViPNA@mail.gmail.com>
Message-ID: <CAD=FV=Xcywabh3U0=hzd8DXR2gdwLBEFsbwLof7Y6LMu+ViPNA@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: kdb_support: Fix debugging information problem
To:     Stephen Zhang <stephenzhangzsd@gmail.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 2, 2021 at 3:15 AM Stephen Zhang <stephenzhangzsd@gmail.com> wrote:
>>
>>
>> > @@ -147,11 +141,10 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
>> >
>> >         if (symtab->mod_name == NULL)
>> >                 symtab->mod_name = "kernel";
>> > -       if (KDB_DEBUG(AR))
>> > -               kdb_printf("kdbnearsym: returns %d symtab->sym_start=0x%lx, "
>> > -                  "symtab->mod_name=%px, symtab->sym_name=%px (%s)\n", ret,
>> > -                  symtab->sym_start, symtab->mod_name, symtab->sym_name,
>> > -                  symtab->sym_name);
>> > +       kdb_dbg_printf(AR, "returns %d symtab->sym_start=0x%lx, "
>> > +               "symtab->mod_name=%px, symtab->sym_name=%px (%s)\n", ret,
>> > +               symtab->sym_start, symtab->mod_name, symtab->sym_name,
>> > +               symtab->sym_name);
>>
>> This indention doesn't line up, but it didn't before.  I guess I'd let
>> Daniel say if he likes this or would prefer different wrapping /
>> indentation.
>
>
> Thanks for your patience. You told me that  the alignment for continued arguments is to
> match up with the first argument, so I was confused that the first line and the second line
> here don't follow the rule.  There are many  cases like this in  this file.

There's a saying: all rules are made to be broken.

I think the general rule is that the 2nd line of arguments should line
up with the first.  However, sometimes that forces way too much
wrapping.  If it's "too ugly" to use the general rule, then you can
fall back to some alternate rule.  Usually this alternate rule is
something like indending all subsequent lines by one tab.  The
definition of "too ugly" is left to the judgement of the person
writing / reviewing the code.  In this case maybe the general rule
would make your call need to take up 3 lines?

If I had to make a judgement call on this code, I'd say:

1. It seems to have been written before the "don't split strings" rule
was in full force.  See
<https://www.kernel.org/doc/html/v5.10/process/coding-style.html#breaking-long-lines-and-strings>
where it says "never break user-visible strings such as printk
messages because that breaks the ability to grep for them".

2. If we fix #1, we're already blowing over the 80 columns limit for
this string anyway.

3. Once we blow over the 80 columns, might as well do it for the
second line.  So then you'd end up with:

<tab>kdb_dbg_printf(AR, "returns [...] (%s)\n",
<tab><tab>       ret, symtab->sym_start, [...], symtab->sym_name);
