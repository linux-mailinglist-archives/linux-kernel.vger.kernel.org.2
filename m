Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8753940300A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346426AbhIGVAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbhIGVAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:00:05 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D28C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:58:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m4so659341ljq.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g82twVHBT3nIwib1kNATw3EUKJ53a0N5uNazF9kw1V4=;
        b=HSXE0gT8Qf6IWPV3zzXIMyBL4YFWjcmOD76oYR9y2M7iKdgH8f3CcGYRcw/d/6jDwg
         t7rKZa35VISPjjjZlybtFixfQxBmUt576kNn8j2nN3tWQfOsfN6OQhVB29iWsxtB+WUE
         Put9hy7fgU6BBlaLFM7bEenbHfnXtM39prIKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g82twVHBT3nIwib1kNATw3EUKJ53a0N5uNazF9kw1V4=;
        b=IbXcXdWGuul3RgRVf+wfhcv5H0fGqXLVupq7vtUxEcMtdI3wENqrr1w68VoFNayhJ1
         /uk/CvLuuCNqbOWeH+E2wTQcwBXWubrMUITwNuLlixRXeRGDdMoAxiYZhWPoEOKeIjzC
         7cvKY37Y1GNDS8QCu2fkt+F18bsGXCc1Q2mzqjuIZmH/W755eZVQnKgFXWadEaTGtYeJ
         dsFRUXy/q3sDMZop1nNhmzP0t0v6qHmMm2TSJOkRbdMMaXLfypGHVIzDyP5cOq34REYB
         prwArSh5JsJqK/sQf0TrDd58NZkIy+wnSgyqsUDXRYVq0OQcthlID331Hd75BUJ91msa
         StYg==
X-Gm-Message-State: AOAM530dLkcSKyu3M0zbXg1EdxX7zj5LbcaCJ1XGHQAHcryAr6H50Tn/
        DA7hV19y9LSz2NxgQEx8c6CwFnCXUFbGVtovyOE=
X-Google-Smtp-Source: ABdhPJyvtgtuYMoTnoppcSe8haZxXE2TBHynDP3syEt5ipq6125z+9rlIPyO+HwgS2/LyOGacZZjxQ==
X-Received: by 2002:a2e:990d:: with SMTP id v13mr133348lji.127.1631048335581;
        Tue, 07 Sep 2021 13:58:55 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id r12sm4711ljp.15.2021.09.07.13.58.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 13:58:54 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id y6so711215lje.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:58:54 -0700 (PDT)
X-Received: by 2002:a2e:a363:: with SMTP id i3mr153633ljn.56.1631048334025;
 Tue, 07 Sep 2021 13:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210907191139.GA18865@www.linux-watchdog.org> <20210907192514.GA18886@www.linux-watchdog.org>
In-Reply-To: <20210907192514.GA18886@www.linux-watchdog.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 13:58:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7NEnwnbrNewJLvjsMc4gAOmGb4nOMfooZUXMr627Zxg@mail.gmail.com>
Message-ID: <CAHk-=wi7NEnwnbrNewJLvjsMc4gAOmGb4nOMfooZUXMr627Zxg@mail.gmail.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v5.12 Merge window
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christine Zhu <Christine.Zhu@mediatek.com>,
        Curtis Klein <curtis.klein@hpe.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 1:46 PM Wim Van Sebroeck <wim@linux-watchdog.org> wrote:
>
> My Apologies. The subject of this e-mail is wrong again. It should have been [GIT PULL REQUEST] watchdog - v5.15 Merge window

Heh. That was fairly obvious. No problem.

My email search terms end up being just "git" and "pull", so it's not
like I end up even really looking at the version numbers except closer
to the end of the release. At that point people start sending me early
pull requests for the next merge window, and I start looking more
closely just to make sure I differentiate between "fixes for this
release" and "updates for the next merge window".

... and even then, it's usually pretty obvious from the actual
contents, and if somebody gets a version number wrong it generally
isn't all that confusing.

            Linus
