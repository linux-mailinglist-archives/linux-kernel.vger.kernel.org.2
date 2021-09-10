Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30EC407371
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 00:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhIJWj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 18:39:56 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:45945 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhIJWjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 18:39:53 -0400
Received: by mail-lf1-f53.google.com with SMTP id f18so7000289lfk.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hO7tt7JFJNw/BA9XIANLBqKyXIbkzwwiROuGeANkVQ=;
        b=aeErx1G8GQ7iPYVtomn6TP4ucgCPkZwu4ymZiPaqPRbXnS8BW8C9iaOgTT9If1WItO
         iCifAECgEY7fAuxmqb7bFO1NcbCtFJFcIv6alXQnee8LxRxaBIY49w+/iD8/Bds3mlRu
         sSd1gGaxmpwd1CR/wGa/x3/M156BdtCebkVYBZ3CZOEfas0Jum+S6h3A8tfJMGgNWtWD
         lGEwIHQkq9PSkFMm/FSwYUii06/F9zA+/NjOUpZaRyMkKbgQhaoYdChJWERsWQt07+ZB
         3VpXwYvcONoi/4hUpRykLBHkqZ6JsC+dTQK3pMnj6F+IDi78CaV4xn4xpvIREq+43x1d
         4mtw==
X-Gm-Message-State: AOAM533h1FaORjniBj3Q0lyn4LIvDTf4i087ZA2x6GVb6dBUadTWJHeQ
        r05Cyqc9cRIlcGktjRba9HE5uZ56naqxclaYfHX0DCne
X-Google-Smtp-Source: ABdhPJz176fIA+cNCzGr7q5i58Tv2FDhytJc3WbFR5rc25wbNpWXtUbfnKUuurnDfzETd7+jmSaGzsxsGMh3ODZnS6A=
X-Received: by 2002:a05:6512:1286:: with SMTP id u6mr5862275lfs.528.1631313520797;
 Fri, 10 Sep 2021 15:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210910164150.1028294-1-namhyung@kernel.org> <YTu07uPsA2/uxvRs@krava>
In-Reply-To: <YTu07uPsA2/uxvRs@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 10 Sep 2021 15:38:29 -0700
Message-ID: <CAM9d7chp-B3i0KURk5ptKZsQOE-UJ=jwfAtvADEg-PObNysFAQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Allow build-id with trailing zeros
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Fri, Sep 10, 2021 at 12:41 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Sep 10, 2021 at 09:41:50AM -0700, Namhyung Kim wrote:
> > Current perf saves a build-id with size but old versions assumes the
> > size of 20.  In case the build-id is less than 20 (like for MD5), it'd
> > fill the rest with 0s.
> >
> > I saw a problem when old version of perf record saved binary in the
> > build-id cache and new version of perf reads the data.  The symbols
> > should be read from the build-id cache (as the path no longer has the
> > same binary) but it failed due to mismatch in the build-id.
> >
> >   symsrc__init: build id mismatch for /home/namhyung/.debug/.build-id/53/e4c2f42a4c61a2d632d92a72afa08f00000000/elf.
> >
> > The build-id event in the data has 20 byte build-ids, but it saw a
> > different size (16) when it reads the build-id of the elf file in the
> > build-id cache.
> >
> >   $ readelf -n ~/.debug/.build-id/53/e4c2f42a4c61a2d632d92a72afa08f00000000/elf
> >
> >   Displaying notes found in: .note.gnu.build-id
> >     Owner                Data size    Description
> >     GNU                  0x00000010   NT_GNU_BUILD_ID (unique build ID bitstring)
> >       Build ID: 53e4c2f42a4c61a2d632d92a72afa08f
> >
> > Let's fix this by allowing trailing zeros if the size is different.
> >
> > Fixes: 39be8d0115b3 ("perf tools: Pass build_id object to dso__build_id_equal()")
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/dso.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index ee15db2be2f4..0c0dd877d4e9 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -1349,6 +1349,18 @@ void dso__set_build_id(struct dso *dso, struct build_id *bid)
> >
> >  bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
> >  {
> > +     static const char zeros[BUILD_ID_SIZE];
> > +
> > +     if (dso->bid.size > bid->size && dso->bid.size == BUILD_ID_SIZE) {
> > +             /*
> > +              * For the backward compatibility, it allows a build-id has
> > +              * trailing zeros.
> > +              */
> > +             return !memcmp(dso->bid.data, bid->data, bid->size) &&
> > +                     !memcmp(&dso->bid.data[bid->size], zeros,
> > +                             dso->bid.size - bid->size);
>
> we now have memchr_inv in tools, so you could use:
>   memchr_inv(&dso->bid.data[bid->size], 0, dso->bid.size - bid->size);
>
> and save 20 bytes in bss ;-) other than that, nice catch
>
> Acked-by: Jiri Olsa <jolsa@redhat.com>

right, will update!

Thanks,
Namhyung
