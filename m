Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246034164D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbhIWSMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242639AbhIWSMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:12:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E42EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 11:11:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d6so19555527wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21ubOOR9VOR5U3seg3iEPN0lJ/0NLAApRhv0qLePyFk=;
        b=cr7nWdSieeJfYsF4LUWdQMsen2M61vGKUOYI6vdIkChAYDsAcQi65Cl+eJNgHpqQ5y
         WfkYaKv/uTqcmqxPhDc6cojZh1Xbut7LXToy5kCg1DS6N111yhYZr0e6ueVVdMMpIAdF
         XCgDb+la+6ABTxZ6WCsfNHeywIVMZ8A6GNY2NKHZNFCkkEAHeefc8JMIjQiEutcKg07Y
         K0NNYDQsekid89Zh2ED98au/lI32O/MWMIjvCeANleQO/hgJ7LJvaH6kxZmadW3rD3/D
         s6tsRCfsoNjl2WNzR1HwCWtu7sH+G2iXG452IlXW61HVi/V2hrEv6qkApfylUqdS5uAk
         gsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21ubOOR9VOR5U3seg3iEPN0lJ/0NLAApRhv0qLePyFk=;
        b=Z0QYEJDG0HK+yZsFcO9Po2zCH4N+/IwMu5MPAvJ8elXC2UM08iT6Xq6ML43a4WdC6U
         xi7QY+ZghdaNoLuGpZB9/AjiJibqgWyJx3V8YQF8N3+t68U9qPjj+jt75Wbx5jyIvPQE
         Pc9CkruZsM9AvDhDfti6Hgg8PCq4WsRKRD02s+spzqYVCLW1S7ncOSoc3mLVsMK2KRUl
         hgZihFZgJ1ADk/kiK0QJ+iS3+r4n6to+Hz6pljEPpYYh+2a7bKyayzXDYo6t8+qZttIo
         o46Kb+iJLXdMohPJVmjo7fufOvwXo7INq5pWolg5jJIC26LYiBMlZOC18hH/sv2TodPt
         s7aQ==
X-Gm-Message-State: AOAM531vEsS/ZUF7/BIbpRL0XTh1rDhoyzMUIlkogAem/2Fbjk5ikaWp
        US57Ch0uZcI75axNdGu9NXpEpSLlrqFKJz8fwPWIMw==
X-Google-Smtp-Source: ABdhPJxZEeBSnS2nuImQOU1Vq6424Djbg1OgtuNoQLiEHpx7fARKVFz9qnFt2jhQdAdJtrus3Xq9XpBWBTLT7kETjT4=
X-Received: by 2002:a1c:7713:: with SMTP id t19mr6090094wmi.162.1632420659610;
 Thu, 23 Sep 2021 11:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210922182541.1372400-1-elver@google.com> <CABVgOSmKTAQpMzFp6vd+t=ojTPXOT+heME210cq2NA0sMML==w@mail.gmail.com>
 <CANpmjNN1VVe682haDKFLMOoHOqSizh9y1sGAc4dZXc4WnBsCbQ@mail.gmail.com>
In-Reply-To: <CANpmjNN1VVe682haDKFLMOoHOqSizh9y1sGAc4dZXc4WnBsCbQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 24 Sep 2021 02:10:48 +0800
Message-ID: <CABVgOSk3iY7-8h=uJRNwN-UoWYxVZ1dNALzuE1MMLswKUkXfqA@mail.gmail.com>
Subject: Re: [PATCH] kfence: test: use kunit_skip() to skip tests
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 1:58 AM Marco Elver <elver@google.com> wrote:
>
> On Thu, 23 Sept 2021 at 19:39, David Gow <davidgow@google.com> wrote:
> > On Thu, Sep 23, 2021 at 2:26 AM Marco Elver <elver@google.com> wrote:
> > >
> > > Use the new kunit_skip() to skip tests if requirements were not met. It
> > > makes it easier to see in KUnit's summary if there were skipped tests.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> >
> > Thanks: I'm glad these features are proving useful. I've tested these
> > under qemu, and it works pretty well.
> >
> > Certainly from the KUnit point of view, this is:
> > Reviewed-by: David Gow <davidgow@google.com>
>
> Thanks!
>
> > (A couple of unrelated complaints about the kfence tests are that
> > TRACEPOINTS isn't selected by default, and that the manual
> > registering/unregistering of the tracepoints does break some of the
> > kunit tooling when several tests are built-in. That's something that
> > exists independently of this patch, though, and possibly requires some
> > KUnit changes to be fixed cleanly (kfence isn't the only thing to do
> > this). So not something to hold up this patch.)
>
> I think there was a reason we wanted it to "depends on TRACEPOINTS".
> If it were to select it, then if you do a CONFIG_KUNIT_ALL_TESTS=y,
> and also have KFENCE on, you'll always select tracepoints. In certain
> situations this may not be wanted. If we didn't have
> CONFIG_KUNIT_ALL_TESTS, then certainly, auto-selecting TRACEPOINTS
> would be ok.
>
> If you can live with that, we can of course switch it to do "select
> TRACEPOINTS".

That's probably more convenient for me, but I confess that my use case
is almost always wanting to run the KUnit tests, so I'm not unbiased.
:-)

>
> On a whole I err on the side of fewer auto-selected Kconfig options.

Yeah, it's perfectly sensible to do it either way. Maybe the right
option is to have a .kunitconfig file which has TRACEPOINTS enabled.

It's probably not worth doing if there's still issues with kunit_tool
parsing the results when the test is built-in, so this should probably
wait until KUnit has a way of running code on init/exit of suites as
well as individual tests within those suites. KFENCE is not the only
test suite which needs something like that (nor the only one which
does some module_init or late_initcall stuff which causes some
formatting issues with builtin tests).

Cheers,
-- David
