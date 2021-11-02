Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB444254C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 02:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhKBBre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 21:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBBrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 21:47:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DD9C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 18:44:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d21so251712lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 18:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duOB7+tuy/fIbs+x89Qef01G/0/mhGdiCSXIKCosuiE=;
        b=CEYfTaXj7mM+KsFYrGnS2X4f4jNV7hBM4bTqPygnci63h5amA5+mzE5YMD/KA8FQBC
         LEejzFQERXjannlALBLu/LxaPxtfKq3hCyXOwu6Q3i5O1MnuIoA4lWujuRPuj/5/qrAt
         nryzEsDcKU4Bv6a67WkZ324PfTbC4ctEldJLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duOB7+tuy/fIbs+x89Qef01G/0/mhGdiCSXIKCosuiE=;
        b=yZBuxsfPZtKDIhV2U9M9E03eRwChFP3/YHqGpSpwZJqRMUaRlcREA7/7ojAYqZ1nXd
         ot8/83yBAsXkf22yhOkdLb96YeClEfMl7TT5s7mg/fzrGnqPdWBhNVV0XPI2Y3BP0YkK
         zsXPzpfpWPfRLDYbGlo1exAjjQsOi/X3BZnPGYYxlJE0qrKNm3vh/38zLp6euBlBRRPA
         QZve7b5NPXlm65okYjcWF0Vk0wFZ/68UfKm5YTbn3qUzXsI9avXQyEgICEPen9BgV92S
         83MXckul+9j+Ks0Boj8hi0qA3+Pdge0l9HZ0TbJMhzH3IJ+gukChUteX3aaDBlT3u4Su
         mitw==
X-Gm-Message-State: AOAM5318a/74nKonxj/vZvhzYY4oC0JT1xcGTRmqvAdyOKJBiAACMtuz
        IehsHKn409Mh5eUyWer40RS5RkiePjwy2h4m
X-Google-Smtp-Source: ABdhPJzSm1w5U0DysjBNu6b8lTP6vMqP2npr8bza48CjokqwXy19SQoLZJXd01hBqtnLl8j/VXmUZg==
X-Received: by 2002:a05:6512:2104:: with SMTP id q4mr9298781lfr.159.1635817497116;
        Mon, 01 Nov 2021 18:44:57 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id o5sm1543148lft.278.2021.11.01.18.44.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 18:44:56 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id e2so32235538ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 18:44:56 -0700 (PDT)
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr36138283ljk.191.1635817495823;
 Mon, 01 Nov 2021 18:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
 <20211101002346.GA304515@roeck-us.net> <CAMuHMdWBgGvt8q9suk6tysgga7sJ4v74eJHHO=ifg2Rc3S9A9Q@mail.gmail.com>
 <89a3686d-1ef6-4677-5d9f-f5e15a77c50e@roeck-us.net>
In-Reply-To: <89a3686d-1ef6-4677-5d9f-f5e15a77c50e@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 18:44:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZgzKMw7AkahZH-iCxJLAadS_nrzVJiCqrsFWfg7n_Xw@mail.gmail.com>
Message-ID: <CAHk-=wiZgzKMw7AkahZH-iCxJLAadS_nrzVJiCqrsFWfg7n_Xw@mail.gmail.com>
Subject: Re: Linux 5.15
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 6:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Replacing "strlen(UTS_RELEASE)" with "sizeof(UTS_RELEASE) - 1" seems to do
> the trick, at least with gcc 11.2 and v5.15. I just wonder if that would be
> acceptable. Any idea ?

Looks sane to me.

I don't understand why gcc complains about that thing in the first
place, much less why it only happens on m68k, but whatever...

The other - and perhaps better - option would be to just uninline
memcpy_and_pad() entirely, move it to lib/string.c, and only have the
declaration in <linux/string.h>.

Because the only reason to have it as an inline function is when the
compiler can statically optimize a call site: but it's really not a
performance-critical function to begin with, and clearly the compiler
instead just *breaks* rather than optimize that call-site.

               Linus
