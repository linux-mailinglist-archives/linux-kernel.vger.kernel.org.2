Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37393F8E27
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbhHZSus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243373AbhHZSuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:50:46 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D42C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:49:58 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b7so5037487iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7RVi0xq01CWNWufmobfxfogmS5uOuV8P3fshSQwxbB8=;
        b=ckfAwHli4znfUylvCi3Qe/6NR65vbI2VAcnuiRLbbQYADkn4xWHdIEtfZ/FcFyjR1H
         Hq7b12TwHNXi2xYbWkXHwdaHPZjUWOwNITLiZ8QSk783kAbQF8VIRU1H8dE2g7NWeuNt
         dH50l5ngA/GHZkBnf46O7e9tZjqfqJ7K5BVkU9EE1aKAQWSQXuMtMfvwev2dJyvMgRJI
         NT+qIytM6bx6OTgpmvcJzNVPGY2TdC0pN24ojOcXnKwa0My8vMt+lgSfM+/1KDFk2UBr
         9g5ypH0PzCyV6QL4qLcUwXT8pRRsi2QmHa63Ku7XDGjvW/H90arxWZkYmZOA9wv2IEOZ
         DrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RVi0xq01CWNWufmobfxfogmS5uOuV8P3fshSQwxbB8=;
        b=KJpMf4ZJaPHFwm06x/XDtC7eovQX7cC/BUhVvHPsBWkL/lSfLcxFdN8ZPfDuOlQSlW
         UfP/ufR//Ga3Lnc6eBPLAxezSuOW9CKADEH0OqokP9VEuKWG9vVAPediXxKqkRzV+2Cl
         WHx+oaZow9QIEsRUX1l+4bBU1Ec7QobSBTDgeJaoWKSfMa9ctSocXtHKkJLq7ioWaNNu
         3/C++yqtwhSF4zHjzmOpaQpCR4yDcCZk4jvxAw9T/53OQMY5AgFj/eAcNt5qPI9xixf8
         zUMHnX51TTKlcX2qZGbRn7hkrCQJm3BIHPNCEVscF0RlHoxZTYz2guV1oBRN/84mFELX
         qPAA==
X-Gm-Message-State: AOAM533topsZ9Cppe/a6Uu1x//qU+Rs53CEG3aS6XpsU9HeWR2slG5AU
        +Jxz/hMvcyf9SICrleJv0162B3VKoxyGtOz+hRwEEQ==
X-Google-Smtp-Source: ABdhPJwGbCC1XoYLtk1S/CPsklRnFcXwZMjD42jFcx4CV3PWfgPIdI9fdFw5R8DoLVjWIWI2/iIe8x2ZtxkssOlq58Y=
X-Received: by 2002:a05:6638:38aa:: with SMTP id b42mr4702797jav.6.1630003797721;
 Thu, 26 Aug 2021 11:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210826001635.285752-1-irogers@google.com> <ad17ba1f-34d8-fa5e-72fc-e05107fe2822@linux.ibm.com>
In-Reply-To: <ad17ba1f-34d8-fa5e-72fc-e05107fe2822@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 26 Aug 2021 11:49:43 -0700
Message-ID: <CAP-5=fVvZMyQdFm2u28VeK9QKspe2t1PoM9AB3_c--8Rgk4U+g@mail.gmail.com>
Subject: Re: [PATCH] perf bpf: Fix memory leak during synthesis.
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 1:02 AM kajoljain <kjain@linux.ibm.com> wrote:
>
>
>
> On 8/26/21 5:46 AM, Ian Rogers wrote:
> > BTF needs to be freed with btf_free.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/bpf-event.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > index cdecda1ddd36..d193104db7f7 100644
> > --- a/tools/perf/util/bpf-event.c
> > +++ b/tools/perf/util/bpf-event.c
> > @@ -296,7 +296,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
> >
> >  out:
> >       free(info_linear);
> > -     free(btf);
> > +     btf__free(btf);
>
> Hi Ian,
>    Patch looks good to me. I can see in one more place we are using free(btf) in the
> same file. Can you correct that as well.

Done. Also found 1 more in annotate :-)
https://lore.kernel.org/lkml/20210826184833.408563-1-irogers@google.com/T/#u

Thanks,
Ian

> Thanks,
> Kajol Jain
>
> >       return err ? -1 : 0;
> >  }
> >
> >
