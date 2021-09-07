Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B2A402F57
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346257AbhIGUDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346086AbhIGUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:03:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB60C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:01:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m28so85765lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1IwmgSAwR+HkLZDJ9goDsuJSjvCpVb6ST440oKCFYGM=;
        b=ZNkgXB5wGRgWIsBjd+W8AGXvXd3i4LkxXT2dOGEv3DJ0gJyqOzHeOZAeYiBcaP+SC/
         jLy+lrfh8BB1pHPiSKH7W/3VLJsFwjBvMW3Ugx9mwqRVyimt4KEyUGgvOtFJ/0w0WRKa
         bwAYvq7W/Zqfe3r3Y2NM3DNrGEZAiFpoZVFLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1IwmgSAwR+HkLZDJ9goDsuJSjvCpVb6ST440oKCFYGM=;
        b=EVlKnlPp9rlZRHvB0IFSblMjced2kGtXGnAGXGPTBPc5CUpUyA6CYVuTJSDBPiwnuQ
         yDrWOxNeTbeTjAk6HLyLj+lPS86NTPBoRqpwTDbSlXQiCnrBVttgiMvEip9c1Dhu76Ka
         VbeJogQCgzPGOXNIXy5vpeXTIMl7WX2K2ijdqFrusK6QmDmtPRyvZC3MG5yFfMxKerkQ
         NQJJrVd2tWp6QWCg9pFPHpA3lEVkTBsozSokJnVTElkmNSy+3WSpbr4kM9SrCZpn+e1A
         KrtxsIsP9SQO8ql/+hTdG6+m/y0Ib0acs7oHUqMN4b69TNhotUUjNVwbiliAPqTpm+3F
         rU4Q==
X-Gm-Message-State: AOAM531jw5tetM+nUW3MzlpcN1stuGXfCRsqman7HfrwJ21tNDEMJeBy
        cCWJVyk3GEe8Hj6hfsS1+O4OVZKN+2rxViGXzCQ=
X-Google-Smtp-Source: ABdhPJyK5rgVd9mVauqKbG5eUYEUJkr4CqwRe9xxli1VMrqRGrUfWLoPes4RVTl4ebsMSAHjelvw/A==
X-Received: by 2002:a05:6512:3053:: with SMTP id b19mr78711lfb.439.1631044915071;
        Tue, 07 Sep 2021 13:01:55 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d8sm1092618lfm.67.2021.09.07.13.01.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 13:01:54 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id k13so114851lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:01:53 -0700 (PDT)
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr102231lfu.280.1631044913265;
 Tue, 07 Sep 2021 13:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210907083613.31268-1-brgl@bgdev.pl> <CAHk-=wgQBgkut6zXTbZN45AtJmSceXwDw6Y60ZmwrPkOL__A8g@mail.gmail.com>
 <163104361220.4526.774832613459764535.pr-tracker-bot@kernel.org>
 <CAHk-=wgAi8jHOFuk8iqXsL4Aekst996HGeN18aKQhXd-qu2dcQ@mail.gmail.com> <20210907195647.jutizso7o2r4mddj@meerkat.local>
In-Reply-To: <20210907195647.jutizso7o2r4mddj@meerkat.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 13:01:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFkW3XGD+Ejv_mxTaPxh+tpRTCP+zufrWnNEiMm9PPEQ@mail.gmail.com>
Message-ID: <CAHk-=wiFkW3XGD+Ejv_mxTaPxh+tpRTCP+zufrWnNEiMm9PPEQ@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: updates for v5.15
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     pr-tracker-bot@kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 12:56 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Failure is always an option. Let me poke at the logs and see what happened
> here.

I was spooked by how it actually sent the email just after I had done
the merge, but before I had pushed it out.

[ https://www.youtube.com/watch?v=-b5aW08ivHU plays ]

               Linus
