Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F2325B10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 01:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBZAzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 19:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhBZAzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:55:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F89C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:54:31 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v15so6996426wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mznw0q/o6F77ZdV7NW3FQKr8jKaQdl70sw2gop94YIQ=;
        b=MvLwuDf3Xq6i4Hu2CZH6hiHOdy9N1wQMLj+AcHMUhPfaSYIFNkcDjIKoSV5GpFfos9
         r7zj+SIIma8/YEoxFIu+qzHiar7IllZnCuTv/UB49UnTXuoDLzjRzPYfQUgY0gtR0Ptv
         pGH9IXm5qAfTkwPakItl8PDVwW8F20qxYQiFQbmXqHbePbVSJMNXciNkqX620gvubbj7
         hi+cMeON11lBnN9TRJ6MGj6tiXdIE63uVJ9ab6iZj9UNRhFN8YxgO4WPWj82zoBBv5NB
         BBnqErSqaReG9jUVntb+fHpJpn5wV6DZjZ6sDkU2G+qzjyJ/yrxrNvgVT2EIRveHczwB
         C5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mznw0q/o6F77ZdV7NW3FQKr8jKaQdl70sw2gop94YIQ=;
        b=uRLIWj60X0DY66ki4dJwkK0fB+7qtQ2NqTVk41Q7SMO2BJROkPr5JLYOsMDM7ssgJN
         CH4bARvYuPXA0c3gQIdUhAoPfDOo2GbZAcMKcvUPxMvj3LLgdE8yN4Ie7Lk2kG2fbOni
         Ro+qTQPUPFrgslyjnTNXBQI/KJcy/lQo3vI8EVycjGQtsqj2uqD6l3jOWETxVzvqk0nY
         toH3RaPsaYn9m6S54GcoWwQ+Raw3cjsSwwesKNnlNxfsSKnzluXhYYmxZl8CroWiI6gi
         6ywYmm/AlfGL/ORR6+WL7psBVvIBH6EqrFmfom6JLWadgU0fkzHgZES1nPNTQfbMVBrJ
         Atqw==
X-Gm-Message-State: AOAM532yjWcVUrFBjw4jtxHr2ZegK3YjRmS0N6BlTqAm/TkF18ONKaA4
        +Q8HrjuBIRtb5Q59JyWNA2Dv2ZN2YniTq2wrvqA=
X-Google-Smtp-Source: ABdhPJxBGvwoD3GeosEc4AyoF9PMS7E4QsCHJ1birt0fOJnE6XBga4/DgEzT1yhIR97vBYx/9Pp5YOz1AA3TPh7+PzI=
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr544044wrx.166.1614300870274;
 Thu, 25 Feb 2021 16:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20210225062530.25334-1-liuyun01@kylinos.cn> <YDfMHgxExyVCtm4c@krava>
In-Reply-To: <YDfMHgxExyVCtm4c@krava>
From:   JackieLiu <jackieliu2113@gmail.com>
Date:   Fri, 26 Feb 2021 08:54:19 +0800
Message-ID: <CAPV7t-01J1zyL4bGP5VHQKvmF22erQBeZdRbzcm2qGX30tqBew@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools: perf_event_paranoid and kptr_restrict may
 crash on 'perf top'
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks jirka, I will check again, and I saw another crash after this
patch, so I  need to debug again.

BR, Jackie Liu

Jiri Olsa <jolsa@redhat.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8826=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:11=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Feb 25, 2021 at 02:25:30PM +0800, Jackie Liu wrote:
> > After install the libelf-dev package and compiling perf, kptr_restrict=
=3D2
> > and perf_event_paranoid=3D3 will cause perf top to crash, because the
> > value of /proc/kallsyms cannot be obtained, which leads to
> > info->jited_ksyms =3D=3D NULL. In order to solve this problem, Add a
> > judgment before use.
> >
> > Suggested-by: Jiri Olsa <jolsa@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > ---
> >  tools/perf/util/bpf-event.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > index 57d58c81a5f8..b1ce2d189d37 100644
> > --- a/tools/perf/util/bpf-event.c
> > +++ b/tools/perf/util/bpf-event.c
> > @@ -225,6 +225,11 @@ static int perf_event__synthesize_one_bpf_prog(str=
uct perf_session *session,
> >               perf_env__fetch_btf(env, info->btf_id, btf);
> >       }
> >
> > +     if (!info->jited_ksyms) {
> > +             err =3D -1;
> > +             goto out;
> > +     }
> > +
>
> I think this check should be moved above, right after line:
>
>         info =3D &info_linear->info;
>
> so we don't do those extra btf checks
>
> thanks,
> jirka
>
> >       /* Synthesize PERF_RECORD_KSYMBOL */
> >       for (i =3D 0; i < sub_prog_cnt; i++) {
> >               __u32 *prog_lens =3D (__u32 *)(uintptr_t)(info->jited_fun=
c_lens);
> > --
> > 2.25.1
> >
>
