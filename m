Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A067744BCFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhKJImO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:42:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230215AbhKJImN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636533566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MmQhJhrwRd2JLMfsgCMvr+kcfhzChccHWYJKCmfHGY=;
        b=gVKmOktBOCJifEvd/VA3FSyItyc22zdSg3erLCy6vzMKu1S7g68juN7XSkewbyrWOQAgRw
        giSzC/jkqVBHnQpM3k5ld37TrQsLrqMafYkQF5lIoQuO6rhp9p6W7JPKeAkq9WupWvLmmi
        SYmhmE1qN51CaN7jEk0cx/vFxCY3KNg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-twez-TVyNA2f1nAnam7Npw-1; Wed, 10 Nov 2021 03:39:24 -0500
X-MC-Unique: twez-TVyNA2f1nAnam7Npw-1
Received: by mail-wm1-f70.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso2781924wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+MmQhJhrwRd2JLMfsgCMvr+kcfhzChccHWYJKCmfHGY=;
        b=S6VBZAqju3I+HfRVqbwDVbSAU2j5UjoqIZuVANiOCWyrDiaedAT0WyALXSa9b2WL3t
         PkPVOAh+Wmm2uVeh6xjwG9EVWW9zYdmTSQAn1WoSWAJCydweQHpQYYORUv+Fz3mq4Ksd
         VirWvZepmlUu7TPShb///57GfdaGXFb2BRKi60p9sQefzpGC4xfYRUHZ2V2nv1WE2u3f
         f94MMOkigTN58ePSJNj4ptC2982tw8uipLX28Lm6ADrFPtOE44op+wQ3vDvaMl98umCk
         8XEFKLeDDlG8fiExNn3ARmE/yLBR2onwrnYv9judCduJVrW/qjuxJzQ0P4EXohPOhODU
         nlbQ==
X-Gm-Message-State: AOAM530199qXynxeGCakXzC+T/2FIcOqx0It/kZz3wC2AYh+8JkNs+aM
        g7EfrqptjCp/nFMFVwkfE2i8TXVavG9oa8YZBp6OwOkq6yGnNqZLjcQUni+bskhUn3oFOH26qq3
        HWhhduWWJ114WV8Gu0VjpSomf
X-Received: by 2002:a1c:e912:: with SMTP id q18mr15276209wmc.121.1636533563579;
        Wed, 10 Nov 2021 00:39:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUoL4vbaRqeunbu7qMTNGSezhwFbkgP7HcNTpyTL87O2FJf2mfZrJ515gFNrEzmt5YbDmdww==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr15276195wmc.121.1636533563361;
        Wed, 10 Nov 2021 00:39:23 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t8sm6226045wmq.32.2021.11.10.00.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 00:39:22 -0800 (PST)
Date:   Wed, 10 Nov 2021 09:39:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 1/2] perf tools: Add more weak libbpf functions
Message-ID: <YYuFOD7dy3MOA1/s@krava>
References: <20211109140707.1689940-1-jolsa@kernel.org>
 <20211109140707.1689940-2-jolsa@kernel.org>
 <CAP-5=fVS2AwZ9bP4BjF9GDcZqmw5fwUZ6OGXdgMnFj3w_2OTaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVS2AwZ9bP4BjF9GDcZqmw5fwUZ6OGXdgMnFj3w_2OTaw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 10:49:53AM -0800, Ian Rogers wrote:
> On Tue, Nov 9, 2021 at 6:07 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > We hit the window where perf uses libbpf functions, that did not
> > make it to the official libbpf release yet and it's breaking perf
> > build with dynamicly linked libbpf.
> >
> > Fixing this by providing the new interface as weak functions which
> > calls the original libbpf functions. Fortunatelly the changes were
> > just renames.
> 
> Could we just provide these functions behind a libbpf version #if ?
> Weak symbols break things in subtle ways, under certain circumstances
> the weak symbol is preferred over the strong due to lazy object file
> resolution:
> https://maskray.me/blog/2021-06-20-symbol-processing#archive-processing
> This bit me last week, but in general you get away with it as the lazy
> object file will get processed in an archive exposing the strong
> symbol. With an #if you either get a linker error for 2 definitions or
> 0 definitions, and it's clear what is broken.

hum, I see 2 problems..

usinf #if works nicely for btf__raw_data because it's used directly,
but bpf_object__next_program and bpf_object__next_map are used
through macros:

   #define bpf_object__for_each_map(pos, obj)              \
        for ((pos) = bpf_object__next_map((obj), NULL); \
             (pos) != NULL;                             \
             (pos) = bpf_object__next_map((obj), (pos)))

   #define bpf_object__for_each_program(pos, obj)                  \
        for ((pos) = bpf_object__next_program((obj), NULL);     \
             (pos) != NULL;                                     \
             (pos) = bpf_object__next_program((obj), (pos)))

we would need to provide 'old version' macro as well


another issue is more disturbing.. compiling with LIBBPF_DYNAMIC=1
still seems to take the in-kernel bpf headers, because we use 

  -I$(KTREE)/tools/lib

so any include with '<bpf/...> will pick up the kernel version
and not the one in /usr/include, perhaps the order of '-I...'
could help, I need to check

jirka

> 
> In the past we had problems due to constant propagation from weak
> const variables, where #if was the solution:
> https://lore.kernel.org/lkml/20191001003623.255186-1-irogers@google.com/
> 
> There was some recent conversation on libbpf version for pahole here:
> https://lore.kernel.org/bpf/CAP-5=fUc3LtU0WYg-Py9Jf+9picaWHJdSw=sdOMA54uY3p1pdw@mail.gmail.com/T/
> https://lore.kernel.org/bpf/20211021183330.460681-1-irogers@google.com/
> 
> Thanks,
> Ian
> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/bpf-event.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > index 4d3b4cdce176..ceb96360fd12 100644
> > --- a/tools/perf/util/bpf-event.c
> > +++ b/tools/perf/util/bpf-event.c
> > @@ -33,6 +33,33 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> >         return err ? ERR_PTR(err) : btf;
> >  }
> >
> > +struct bpf_program * __weak
> > +bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
> > +{
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > +       return bpf_program__next(prev, obj);
> > +#pragma GCC diagnostic pop
> > +}
> > +
> > +struct bpf_map * __weak
> > +bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
> > +{
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > +       return bpf_map__next(prev, obj);
> > +#pragma GCC diagnostic pop
> > +}
> > +
> > +const void * __weak
> > +btf__raw_data(const struct btf *btf_ro, __u32 *size)
> > +{
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > +       return btf__get_raw_data(btf_ro, size);
> > +#pragma GCC diagnostic pop
> > +}
> > +
> >  static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
> >  {
> >         int ret = 0;
> > --
> > 2.31.1
> >
> 

