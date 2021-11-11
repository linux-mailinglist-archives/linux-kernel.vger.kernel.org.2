Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2AB44D252
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhKKHRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:17:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhKKHRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636614898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O9nDE4nBev+ucNKzlFhtTKh11mMo8Dfth3UvWqU7P7E=;
        b=Ky0lbPqQw87zK9Soi0GeTEZOAwUehVCiEmU+865U5ybO61+59sI+yQ/9/2F31S6DXmtQZV
        kkZmPrQ02D+reSPK9GMMa2xIl/Ds87X5kuuRtoW4xTkqWQRruo425OAshMD/0tQQVcAd/A
        el/cbefu9xk7HSqhtgjeUsjs8FcVYnE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-vIGUvUTFOgSnqqc8Ob2pPQ-1; Thu, 11 Nov 2021 02:14:56 -0500
X-MC-Unique: vIGUvUTFOgSnqqc8Ob2pPQ-1
Received: by mail-wr1-f70.google.com with SMTP id h13-20020adfa4cd000000b001883fd029e8so826848wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 23:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O9nDE4nBev+ucNKzlFhtTKh11mMo8Dfth3UvWqU7P7E=;
        b=I9hHO+4o4JqyJl1HG+ujS8KzYtOXGTUjs2TkeBSAzqQz9X3WPdkv4HL6MUIv4GWasa
         vBt3lsy10VD+dDrzIJbqTYjto/BdBnegh2IHw/J9eCGfwWris3sp3THNjftQWuNE/cGT
         rLb17eQ/pghDNAGkgxvZRiVT2mOttL0ebu+xqdJlXrsesyfsX/EDSWtAfnHvsXvSur+0
         pYBtBD9FZdZlFg30TL1IVK7khuvmRld0gb4ChUr0+VdaZi99N7pG0zijGsTAlip+42PI
         zgUnTCtrin2aahC2gHJKtXwGxbjPvHXp4LLagGGpChl5H8EYvOS4Vj8m1bF6OMQNvsuH
         Om6A==
X-Gm-Message-State: AOAM531MQV2c2FB4CJHL9CU9V5eFT08tF9PTW6Elh/0/nkJ4YbsEzzGR
        qURIr8BT1tmfPRm2GC39ncRAzduiVm/grMWLQILxCa6sGQ69R4uO8pPLZdGDt9B1Yj93weA9VSe
        XmPLaoaPFEHAJnUmK/PyPnUa5
X-Received: by 2002:adf:ce8b:: with SMTP id r11mr6408376wrn.294.1636614895521;
        Wed, 10 Nov 2021 23:14:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymrUVNsXqaRU9fHLE0kW6mRFTMT4IrqZvzzqE20e0UE0m5/xQesFwmXV2wx392nroFHgCxlA==
X-Received: by 2002:adf:ce8b:: with SMTP id r11mr6408355wrn.294.1636614895321;
        Wed, 10 Nov 2021 23:14:55 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l5sm8129982wms.16.2021.11.10.23.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 23:14:55 -0800 (PST)
Date:   Thu, 11 Nov 2021 08:14:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 1/2] perf tools: Add more weak libbpf functions
Message-ID: <YYzC7YCumGVA09UM@krava>
References: <20211109140707.1689940-1-jolsa@kernel.org>
 <20211109140707.1689940-2-jolsa@kernel.org>
 <CAP-5=fVS2AwZ9bP4BjF9GDcZqmw5fwUZ6OGXdgMnFj3w_2OTaw@mail.gmail.com>
 <CAEf4BzYXD57UDMW_scUdHUs=jgmR6f1-pt5JROwr5LYTh1vejw@mail.gmail.com>
 <YYuGu+bhjSs3syGl@krava>
 <CAEf4Bza+wxyRgTRN_vXL7SGqSBaBG5tWmwhyH6b7o3tsEjyauw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza+wxyRgTRN_vXL7SGqSBaBG5tWmwhyH6b7o3tsEjyauw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 02:37:53PM -0800, Andrii Nakryiko wrote:
> On Wed, Nov 10, 2021 at 12:45 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Nov 09, 2021 at 03:33:04PM -0800, Andrii Nakryiko wrote:
> > > On Tue, Nov 9, 2021 at 10:50 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Tue, Nov 9, 2021 at 6:07 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >
> > > > > We hit the window where perf uses libbpf functions, that did not
> > > > > make it to the official libbpf release yet and it's breaking perf
> > > > > build with dynamicly linked libbpf.
> > > > >
> > > > > Fixing this by providing the new interface as weak functions which
> > > > > calls the original libbpf functions. Fortunatelly the changes were
> > > > > just renames.
> > > >
> > > > Could we just provide these functions behind a libbpf version #if ?
> > > > Weak symbols break things in subtle ways, under certain circumstances
> > > > the weak symbol is preferred over the strong due to lazy object file
> > > > resolution:
> > > > https://maskray.me/blog/2021-06-20-symbol-processing#archive-processing
> > > > This bit me last week, but in general you get away with it as the lazy
> > > > object file will get processed in an archive exposing the strong
> > > > symbol. With an #if you either get a linker error for 2 definitions or
> > > > 0 definitions, and it's clear what is broken.
> > > >
> > > > In the past we had problems due to constant propagation from weak
> > > > const variables, where #if was the solution:
> > > > https://lore.kernel.org/lkml/20191001003623.255186-1-irogers@google.com/
> > > >
> > > > There was some recent conversation on libbpf version for pahole here:
> > > > https://lore.kernel.org/bpf/CAP-5=fUc3LtU0WYg-Py9Jf+9picaWHJdSw=sdOMA54uY3p1pdw@mail.gmail.com/T/
> > > > https://lore.kernel.org/bpf/20211021183330.460681-1-irogers@google.com/
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  tools/perf/util/bpf-event.c | 27 +++++++++++++++++++++++++++
> > > > >  1 file changed, 27 insertions(+)
> > > > >
> > > > > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > > > > index 4d3b4cdce176..ceb96360fd12 100644
> > > > > --- a/tools/perf/util/bpf-event.c
> > > > > +++ b/tools/perf/util/bpf-event.c
> > > > > @@ -33,6 +33,33 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> > > > >         return err ? ERR_PTR(err) : btf;
> > > > >  }
> > > > >
> > > > > +struct bpf_program * __weak
> > > > > +bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
> > > > > +{
> > > > > +#pragma GCC diagnostic push
> > > > > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > > > +       return bpf_program__next(prev, obj);
> > > > > +#pragma GCC diagnostic pop
> > > > > +}
> > > > > +
> > > > > +struct bpf_map * __weak
> > > > > +bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
> > > > > +{
> > > > > +#pragma GCC diagnostic push
> > > > > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > > > +       return bpf_map__next(prev, obj);
> > > > > +#pragma GCC diagnostic pop
> > > > > +}
> > > > > +
> > > > > +const void * __weak
> > > > > +btf__raw_data(const struct btf *btf_ro, __u32 *size)
> > > > > +{
> > > > > +#pragma GCC diagnostic push
> > > > > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > > > +       return btf__get_raw_data(btf_ro, size);
> > >
> > > you can still use old variants for the time being, if you want. Were
> > > new APIs used accidentally? Libbpf maintains a guarantee that if some
> > > API is deprecated in favor of the new one, there will be at least one
> > > full libbpf release where both APIs are available and not marked as
> > > deprecated.
> >
> > we could use old api instead of btf__raw_data, we could just revert
> > the perf change
> >
> > but bpf_object__next_program and bpf_object__next_map are used through
> > macros like bpf_object__for_each_map or bpf_object__for_each_program,
> > so we'd need to define 'old versions' of them
> 
> There is nothing magical about bpf_object__for_each_map(). If it's
> causing problems, just implement your own iteration logic. You'll be

ok

> suffering like this because you are trying to support both shared
> library mode and static library mode with libbpf. I'm sorry for your
> pain, but you are trying to compile against the latest unreleased
> headers, yet work properly with older released libbpf shared library.
> It's painful and you know what I think about using shared libraries,
> right?

you are not a fan.. ;-)

thanks,
jirka

