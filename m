Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E7936BC47
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 01:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbhDZXnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 19:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbhDZXnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:43:00 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E89EC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 16:42:17 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso48990569otv.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=rABt3tcBwh2XInWLEly6iJ6gJ5SfldgUQGQTM9kHuxw=;
        b=C38KK+gKaqQ1I0W4asX+n3E9S4FujSL6FsuyShgIa96VKgIKlRYu9WJncqyF0rT08Y
         EfTCOpK0WvdocQ2bHXQE2ZcoYNjJ0HSt4/sLmn4+T9HOKxYii3zgYwQgay+MtvCtmr09
         r3E78n8WHv9RTqvDW4JLY5RcsmG0mdZqg1GFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=rABt3tcBwh2XInWLEly6iJ6gJ5SfldgUQGQTM9kHuxw=;
        b=NhKFmgB1/YPuCoWKMDGXxTdkgifmDdcXkAIX9pbXyn2w749ehL/kwqIgZg2kjj0UZt
         jaTfDXHI+rXFOSp8Y1hy1gtZ/2XXddDyNyMP8RUn2DRg6gztmq5XAqVEqWopZksYDQ0I
         O5Lr5YVmFCa1IoPJfaBSzr98UxKCWAz6em4xUmbQgdEx57315u1DbONU1Hk3n3XgfdmB
         Pvb5P8wV/x8O/Qn53sdXepSQ6JwRI6+k30E7nL03goXYc/MFmlqExhxiyIj1mRYiJg16
         H3Uk+0PcvIPUrUnd7mh5uOkt3L+1rnrB0z124wffMLhpziH0LxjCsLk6kgyb+dei77YZ
         LXwA==
X-Gm-Message-State: AOAM531Ajm8sTplL5dIp0wZDwqTft0BFuUyOlu1dHe/KyyULUv/8DdBR
        JVMBwZERyOOc1JgXvgz2e7Oauw4QDtZDGMbAHDp4Xg==
X-Google-Smtp-Source: ABdhPJzhbVQr/cxzBwUXNgmJFIHkEi3C1tG3WUuIq0sbL8zZj9hc2x+BfnXKSs+VbtNBw+U4iJ0p4zCaMTppjLXeYRE=
X-Received: by 2002:a9d:222a:: with SMTP id o39mr13079949ota.246.1619480536586;
 Mon, 26 Apr 2021 16:42:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Apr 2021 16:42:16 -0700
MIME-Version: 1.0
In-Reply-To: <YILKpQ2KsBXCoHlG@smile.fi.intel.com>
References: <20210420215003.3510247-1-swboyd@chromium.org> <20210420215003.3510247-6-swboyd@chromium.org>
 <YIARTVqnN8t/FA/P@smile.fi.intel.com> <161913520061.46595.8469966711677906076@swboyd.mtv.corp.google.com>
 <YILKpQ2KsBXCoHlG@smile.fi.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 26 Apr 2021 16:42:16 -0700
Message-ID: <CAE-0n52Aq+hOXCJkDXBgNjVG=kP3yVMsc5czyi3R8SU=X362ug@mail.gmail.com>
Subject: Re: [PATCH v5 05/13] module: Add printk formats to add module build
 ID to stacktraces
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2021-04-23 06:24:53)
> On Thu, Apr 22, 2021 at 04:46:40PM -0700, Stephen Boyd wrote:
> > Quoting Andy Shevchenko (2021-04-21 04:49:33)
> > > On Tue, Apr 20, 2021 at 02:49:55PM -0700, Stephen Boyd wrote:
>
> ...
>
> > > > Example:
> > >
> > > Please, shrink the example to leave only meaningful lines.
> > >
> > > Why, e.g., do we need to see register dump, is it somehow different?
> >
> > Can you format it how you would like to see it? Should it be a unified
> > diff? I agree it would help to see "what changed" but also don't know
> > what you want so opted to provide more information, not less. I was
> > worried about the questions like "do you change other parts of a splat?"
> > so I just put the whole thing there.
>
>
> Before:
>  ...line X...
>  ...
>  ...line Y...
>
> After:
>  ...line X'...
>  ...
>  ...line Y'...
>
> Three lines of example per each paragraph, in each of them the middle one is
> simply [...].

Ok got it. Thanks for clarifying.

>
> ...
>
> > > > +#ifdef CONFIG_STACKTRACE_BUILD_ID
> > > > +     /* Module build ID */
> > > > +     unsigned char build_id[BUILD_ID_SIZE_MAX];
> > >
> > > Is it really string of characters? Perhaps u8 will be more explicit.
> >
> > I'm just matching the build ID API that uses unsigned char. If you want
> > u8 then we should update more places. I could do that in a followup
> > patch, but this one is already sorta big.
>
> Unsigned char here is confusing. I would prefer a prerequisite patch to fix
> other places first.
>

Does anyone else want this to happen first? Andrew? I'm inclined to fix
this in a followup. As I said before, this would make this an even
bigger patch series which I'd like to avoid.
