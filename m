Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6A45D552
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhKYHV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353367AbhKYHTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:19:16 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DE1C061761
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:16:05 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so8102969otk.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Q5EhbqpeXowwDK0bUK5avmicbNdhuUZQON4VKkJTMQ=;
        b=GzRzqrIBzWGcvP1Auwp1VXRcp4X8VC1mu+jSXH07xcJQeusu5bqWLVLXJwn6Ddm7Y+
         ySt17kNB2JcMxmjfVRJmHKKNo1AZS4/AJ+qPafMBP020Xy0Zfnm4gy08vhfX5CYWEqat
         wK2imHXkPB2La3jed1lOojxxsOMJspL2YW1i9+KvC/BxoyGjne6yBHBa982lSsibyzhb
         vu6vx7hUnWsgaw1D1KIRMn/oGuCDd0SWhFbRgZAHiIY7IL+yv1CKKTKixmhTMQCcU9ut
         cERYwLjexgIgCfbKfS6h3hBYALUHq1hGfSrqSbvco8a3aZ6EsMnC3Qe8yuXGOXZsLjde
         A1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Q5EhbqpeXowwDK0bUK5avmicbNdhuUZQON4VKkJTMQ=;
        b=YBz40t63wck4outrpTSOI4G9bxKW7AaPKb6Y3CEO7NXxMGS2cUh1eC1go+Cttbp9O1
         992qyG+vZv+t1OoQt0nTVJQlrEN6q8M/HiD15YsgZ2EOJlxjVghYRvSKRNjcQFrIR5E9
         g0WdbvnTmmaKIL4rYaB/MCphNY2BPhJ4MbGmYz3Beylraedxw4g27Pm1S6jVZuXI0rPS
         MWuuG89dQbXeJlPQQhAnpSRTN30PAo0k9XucD/OSzFnjsMX7OXmTgXipTz70lHj6fLEx
         g6jNHqPJSHUonRjGBbEbATK3p67qvVMOhr+X+GfIV+9Dznakr3Cgu4hV6JkqUuraRTaG
         nY0Q==
X-Gm-Message-State: AOAM531CKQda4syI36Kck4XZpYs5r2GW6IGpAVV3HCneC9pAtO4el0Ff
        axkmXtmNwEIsi2Z2tXkVAXPtGRoZjR0UG3h995FF7A==
X-Google-Smtp-Source: ABdhPJzktIh4+dq3UQufJIs6YMgj/PNxm7+EyCyGeCajzNTglQ0v/PYqTM1bKWwC8ZzM6ZCMeoLzuGDBUulDS5SISjM=
X-Received: by 2002:a05:6830:2425:: with SMTP id k5mr19508104ots.319.1637824564135;
 Wed, 24 Nov 2021 23:16:04 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2111241839590.16505@cbobk.fhfr.pm> <CANpmjNOHN7SWu-pKGr9EBb3=in2AWiGmqNb6sYwhebGtRk+1uQ@mail.gmail.com>
In-Reply-To: <CANpmjNOHN7SWu-pKGr9EBb3=in2AWiGmqNb6sYwhebGtRk+1uQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 25 Nov 2021 08:15:52 +0100
Message-ID: <CACT4Y+aZ_qtMXYiWgLmEgpceookbwUAtKq33rspc+XJNQg4y9A@mail.gmail.com>
Subject: Re: [PATCH] kasan: distinguish kasan report from generic BUG()
To:     Marco Elver <elver@google.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jslaby@suse.cz
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 19:06, Marco Elver <elver@google.com> wrote:
>
> On Wed, 24 Nov 2021 at 18:41, Jiri Kosina <jikos@kernel.org> wrote:
> >
> > From: Jiri Kosina <jkosina@suse.cz>
> >
> > The typical KASAN report always begins with
> >
> >         BUG: KASAN: ....
> >
> > in kernel log. That 'BUG:' prefix creates a false impression that it's an
> > actual BUG() codepath being executed, and as such things like
> > 'panic_on_oops' etc. would work on it as expected; but that's obviously
> > not the case.
> >
> > Switch the order of prefixes to make this distinction clear and avoid
> > confusion.
> >
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>
> I'm afraid writing "KASAN: BUG: " doesn't really tell me this is a
> non-BUG() vs. "BUG: KASAN". Using this ordering ambiguity to try and
> resolve human confusion just adds more confusion.
>
> The bigger problem is a whole bunch of testing tools rely on the
> existing order, which has been like this for years -- changing it now
> just adds unnecessary churn. For example syzkaller, which looks for
> "BUG: <tool>: report".
>
> Changing the order would have to teach all kinds of testing tools to
> look for different strings. The same format is also used by other
> dynamic analysis tools, such as KCSAN, and KFENCE, for the simple
> reason that it's an established format and testing tools don't need to
> be taught new tricks.

Yes, lots of kernel testing systems may be looking just for "BUG:" and
start missing KASAN bugs. Or they may be doing more special things
when they see the current "BUG: KASAN:".

> Granted, there is a subtle inconsistency wrt. panic_on_oops, in that
> the debugging tools do use panic_on_warn instead, since their
> reporting behaviour is more like a WARN. But I'd also not want to
> prefix them with "WARNING" either, since all reports are serious bugs
> and shouldn't be ignored. KASAN has more fine-grained control on when
> to panic, see Documentation/dev-tools/kasan.rst.
>
> If the problem is potentially confusing people, I think the better
> solution is to simply document all kernel error reports and their
> panic-behaviour (and flags affecting panic-behaviour) in a central
> place in Documentation/.
>
> Thanks,
> -- Marco
