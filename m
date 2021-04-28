Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946CA36E20E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhD1XPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbhD1XP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:15:29 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3948DC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 16:14:44 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id i3-20020a4ad3830000b02901ef20f8cae8so6967702oos.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 16:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=wJJ8QiWGv/JVmwQ5VkteCr60IW5p6zpCwSUgzllQPe8=;
        b=Xa5ecP80tPGOMiGg8GhHfpXJpzPYGQr/odIbRKQUNi89lg2BLnhXdkS4LS2tAW5VG1
         P+kgkGNesIl9xUi53nBNzYFMxnuVjjNrO+Op42nVOHMsBnDP3VHOX+MP1ZHKcgqhwy8T
         EjBGzf/zr/5owdbtGE5qDNPwD5Ww108yi7ILo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=wJJ8QiWGv/JVmwQ5VkteCr60IW5p6zpCwSUgzllQPe8=;
        b=LWeuDo1IXZw8SHGndU1WFlaQxgB3kHl5n+vZlHKhjbZJVNlMOrONV4ZInFYbqWMEWv
         gUY8tyX+b9WflxcAtIG1c2xnmZKUVJ7yqqzc22K5WdZqb7wuqDSCCScix/2pj2yb/Xs/
         AZqNghmu60jQvT3HvLJfB0rP+b80M3Pto4/thfpeziBrQM9SpyRQhmbm5azj8X13d6m3
         l8ZQ/yW/l8ID037WxDDX8l53160MeSgGrhk67FiMWB/Px6cmgQey8qxTqEE3Hk0NYyVQ
         wOZUk8wuomzffrt5t9Db/iBvTBf7Y44vIjQ5MusxOsDv5c/+XVvKLg+OEVVOdHO4DKLo
         MO+g==
X-Gm-Message-State: AOAM532XAxS3FNeGqq234ElseL8vVNrU7YnDe0r+mbN6qNILZ8kj8of0
        EmyzYJ10QCKZd+dof1TLjk+UBTUIBwGC0akOqQSoTQ==
X-Google-Smtp-Source: ABdhPJyLhOSnQUzZsMPyd30dVLpNqnzs126NXx8jqyHmnNQlRSVjO2YCNQs7vksEccC7P7NJRuOOOwVXFpGg8odvrmM=
X-Received: by 2002:a05:6820:381:: with SMTP id r1mr24770069ooj.79.1619651683707;
 Wed, 28 Apr 2021 16:14:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Apr 2021 01:14:43 +0200
MIME-Version: 1.0
In-Reply-To: <20210428101355.GB8374@localhost.localdomain>
References: <20210420215003.3510247-1-swboyd@chromium.org> <20210420215003.3510247-14-swboyd@chromium.org>
 <20210428101355.GB8374@localhost.localdomain>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 29 Apr 2021 01:14:43 +0200
Message-ID: <CAE-0n517ZDD8ySTqT2GvKv-KNf1DFP2qmaqt3Pc=-AEndLTevg@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] kdump: Use vmlinux_build_id to simplify
To:     Baoquan He <bhe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Baoquan He (2021-04-28 03:13:55)
> On 04/20/21 at 02:50pm, Stephen Boyd wrote:
> > We can use the vmlinux_build_id array here now instead of open coding
> > it. This mostly consolidates code.
> >
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Evan Green <evgreen@chromium.org>
> > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: <kexec@lists.infradead.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  include/linux/crash_core.h | 12 ++++-----
> >  kernel/crash_core.c        | 50 ++------------------------------------
> >  2 files changed, 8 insertions(+), 54 deletions(-)
> >
> > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > index 206bde8308b2..de62a722431e 100644
> > --- a/include/linux/crash_core.h
> > +++ b/include/linux/crash_core.h
> > @@ -38,8 +38,12 @@ phys_addr_t paddr_vmcoreinfo_note(void);
> >
> >  #define VMCOREINFO_OSRELEASE(value) \
> >       vmcoreinfo_append_str("OSRELEASE=%s\n", value)
> > -#define VMCOREINFO_BUILD_ID(value) \
> > -     vmcoreinfo_append_str("BUILD-ID=%s\n", value)
> > +#define VMCOREINFO_BUILD_ID()                                                \
> > +     ({                                                              \
> > +             static_assert(sizeof(vmlinux_build_id) == 20);          \
> > +             vmcoreinfo_append_str("BUILD-ID=%20phN\n", vmlinux_build_id); \
>
> Since there has been static_assert at above, can we remove the magic
> number '20'?
>
> And I checked format_decode(), didn't find which type corresponds to
> 'N', could you tell?

It is documented in Documentation/core-api/printk-formats.rst (see "Raw
buffer as a hex string") where the '20' replaces the '*' to specify a
fixed size buffer to format. We could pass the 20 as an argument instead
of encoding it in the format, but then it would still be there twice. We
could use a #define but then it would have to be passed as an argument.

I don't know of a good way to enforce in printk that the buffer is the
size that matches the format size. Maybe it shouldn't be an option to
have a size in the format string if it's a problem to put the size of
the buffer in there.

>
> Other than these, this patch looks good to me, thanks for the effort.
>

Thanks.
