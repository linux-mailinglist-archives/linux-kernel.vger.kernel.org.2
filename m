Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621443C77AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 22:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhGMUOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 16:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhGMUOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:14:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF71CC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:11:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m2so277328wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KdpYSs0f+vMAEUJqNmRmwCkH0V9W8+HtZzvw6bbCa+I=;
        b=k5WkYTvCj0FQMv9jZauqIc46KrlQQNrl3wpe6Whc63rWv8AJ3V4SxO3ehkOu6wch3B
         09g/wnjlvPbTV68x2HDyQWCCgNfuGMLwqcFpiDzW9v+ILMThW+ec1kO8jgNe27U+VTdv
         jqnIiBywJcL66DWC2/DYbmjMikOYqt2gZ8bBB2jsBtlK/jKjzueALQpfQoVDbVuffu1c
         B6glRW7b5R/nAh39MLb2KdRZ+NCc/v7Znq4eP1tP9dlNZ9trhOJGaWVR5LNutWbKWQnX
         VWQj30rbsdwTOAu3e2ZIHc3SEbuGdS2UZVXuK1Sy9QV2XPN/9kcNUp+v4FV2SNt2frAW
         ioWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KdpYSs0f+vMAEUJqNmRmwCkH0V9W8+HtZzvw6bbCa+I=;
        b=MI4rd6z6sXuuQWHmfuNb7RAeTu4whAxPbZ2Jf+qTJbFyrES+t48RLF1hwYLi/xxrg3
         6cdjyLgf9zv04PRSQ4FKg8XMhZtvpidtR0LHuRjqiE5B2kqqwQavYS8AuxdtkrYDdCBB
         efpJ8gTMbipNCLI0uIQn4ypUra3v/OCau7pZFywX0sb3Mls3O5Gr9wUJIhv7T/w0WpYa
         iF3D/7C/+Q9+8i8ZTc35aqgFwDxNQwOUvAXov1KsUhV98bELYy/oXm33etx/Tl1TZS4p
         iC5MvNzdvLbl+RAJ/4s+y0GL4cOJuo0kEuHeNZ0xQF52Zfyxme/0V3DxfM3y2NkQ/IOK
         5bcw==
X-Gm-Message-State: AOAM533H+EnfP2v1R2SH8r+RNlRbW2uZgfMeB2CBW4G4DQb/nZXg8KDQ
        vdcoiWh+TEoS0Y3LHkpyl4c20NPYMjQAv2tySWDGTQ==
X-Google-Smtp-Source: ABdhPJzaGaZJmOs0rALsIWpGR4NsOw9Wf+57y5TLStQtjMKUZYnpUkqZ93Asq5o5h68To4EdRn18s2UKaUM4H+m1t38=
X-Received: by 2002:a05:6000:10c3:: with SMTP id b3mr7983318wrx.271.1626207106444;
 Tue, 13 Jul 2021 13:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210712234949.917788-1-namhyung@kernel.org>
In-Reply-To: <20210712234949.917788-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jul 2021 13:11:34 -0700
Message-ID: <CAP-5=fWG35oH+LdpkwoNrWaTDg9bZKxZoyH_vLbhYQnK8gd0RQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix build with libpfm
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 4:49 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It missed to update the parse_libpfm_events_option() to use a new
> helper function to set the event group leader.
>
>   $ make LIBPFM4=3D1
>   ...
>     CC      util/pfm.o
>   util/pfm.c: In function =E2=80=98parse_libpfm_events_option=E2=80=99:
>   util/pfm.c:103:9: error: =E2=80=98struct evsel=E2=80=99 has no member n=
amed =E2=80=98leader=E2=80=99
>     103 |    evsel->leader =3D grp_leader;
>         |         ^~
>   make[4]: *** [tools/build/Makefile.build:96: util/pfm.o] Error 1
>
> Fixes: fba7c86601e2 ("libperf: Move 'leader' from tools/perf to perf_evse=
l::leader")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/pfm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> index dd9ed56e0504..756295dedccc 100644
> --- a/tools/perf/util/pfm.c
> +++ b/tools/perf/util/pfm.c
> @@ -99,7 +99,7 @@ int parse_libpfm_events_option(const struct option *opt=
, const char *str,
>                         grp_leader =3D evsel;
>
>                 if (grp_evt > -1) {
> -                       evsel->leader =3D grp_leader;
> +                       evsel__set_leader(evsel, grp_leader);
>                         grp_leader->core.nr_members++;
>                         grp_evt++;
>                 }
> --
> 2.32.0.93.g670b81a890-goog
>
