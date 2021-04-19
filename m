Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070B43648AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbhDSQ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSQ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:59:06 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B73C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 09:58:36 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id v6so8290119oiv.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FgaZOWwxCgbBr8FV3M4A5B8r9XqZOZTqmUgzyfoA1fs=;
        b=JKYpV6aVoUfBcP0DtNgR2LMxzzmo7snB0v00NENmC1ubAJ+5bcPkWEIehJUCf3V/Uu
         qmdzhEgWKcBPFn61R6fuUhEWeBC43sIqXzKK6RBgggcwxu6T6os8V3Gk7PUVItEU0phj
         7xu0K43EEohZ93TnJy7pDldmj/xRvjEJHiJWMCxaXnbNPwJ0hllbnsRBbxN0NSGR/yDv
         s42MdZiel7TJm2BTepOkWKOJavnMQaS7q9/+oTbO5vq9b408zHcCAyZJs0un1sCXQAZs
         NqgcIMprf2fj3sdtyAZ7bIKX68KA9QvWJoHaPfcb8KGBkfVeU0rsL6GmMPIZWcULrv4E
         l3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FgaZOWwxCgbBr8FV3M4A5B8r9XqZOZTqmUgzyfoA1fs=;
        b=NodSygeiQ93O5sx3RiaPsq6pZYqsH3TNLLz0Mhe3r+0I5WuRaMO4tPyx3y3kOCh/Qn
         IxUbvWnZNLbXuqQ8x3lg8RVXkRp+2uGKPNZKmb20CdQIPLwAzmyHttlJssaaMy/eUdHP
         l4ZeLDPtXXFYXmXtcUWPTXlie0P8FofJ75PIEKDRsPXnHNtcXbEmQLGuT9oqeuN0Znjr
         OAvPW3qDIe4O9cUiETe+ZF0CIEKaHaQyQ0aIC/oU+0fNncklQD0Q0PdvfjSLx6uo5UXi
         YZ+8xVtXfOnvms7qXVaOxTv88aTfQAjg9G9v0mjkd4Oen4tML/wm9suqqwhwQc1dYczQ
         Z6Mg==
X-Gm-Message-State: AOAM533hAjZVfNHL8IRyjTj+uamU5hQy1NGyeZQ6vJM+IdxiOsWS+3U/
        7OZTreulrrgX0pqVfQDRu/C1HM4sWvoJ0l+QPKuaHA==
X-Google-Smtp-Source: ABdhPJwbP4UlnjeTZRe1BOf4jiW5ncoxnVFIFgqdWoXRNBXNPgn0G6P55obzgyUNPOR2YRre1j0cEFH1dJPxoNEH/og=
X-Received: by 2002:a54:4482:: with SMTP id v2mr13818oiv.75.1618851516169;
 Mon, 19 Apr 2021 09:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210415130356.15885-1-andriy.shevchenko@linux.intel.com> <CAHp75VcVBELiTk3C79jHUtxG5xBDoa-wpFYPPXiTUfV-J0PqRQ@mail.gmail.com>
In-Reply-To: <CAHp75VcVBELiTk3C79jHUtxG5xBDoa-wpFYPPXiTUfV-J0PqRQ@mail.gmail.com>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Mon, 19 Apr 2021 09:58:25 -0700
Message-ID: <CAPgEAj5yc_RKt5t=Wt5nBzXFSN0ztPbC=6HXXivmxcH1QMi66w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: core: Show pin numbers for the
 controllers with base = 0
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 3:04 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Apr 15, 2021 at 4:07 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The commit f1b206cf7c57 ("pinctrl: core: print gpio in pins debugfs file")
> > enabled GPIO pin number and label in debugfs for pin controller. However,
> > it limited that feature to the chips where the base is a positive number. This,
> > in particular, excluded chips where base is 0 for the historical or backward
> > compatibility reasons. Refactor the code to include the latter as well.
>
> Linus, since we got one more week, can you consider applying this one
> and the other one against kernel doc for the final release?

Thank you for the reminder.  I will test today.

-Drew
