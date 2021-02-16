Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11031C756
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 09:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhBPI0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 03:26:47 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:39986 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhBPIYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:24:18 -0500
Received: by mail-lj1-f177.google.com with SMTP id g11so10754928ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 00:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K09L2ppL2qD1A0Be3qQdcGbeQRk+ta5oa+rnKfp/wak=;
        b=tsrNDL3mxvAslUcBXSf5mmUktJszs85IlBA2HlCTSZmySBvPLSMlvYEVvmc6GviAmT
         Jw3dYWU2wjvNM4j0Ijxo1UV3jsG9Z96XYVcahvRVcpdFuAxgrPbQ6+z4sAWhv6iPqnAF
         /nKEqm5ss0MD+FRWBGgDe6h2gI/4HicHls3LA/1Qd+qJIV3ApL+z6VlSJHTr3RZG1T4l
         mlXg85uIppSfVSVTG6hdXne/O0EcEl2rsyOHdNqyd74VEsGJzgPNU2y8EfJuMdrU5zI9
         MCKRq1hCuoeo+wJu9Xxjt0s7snwpH/ae+JGuRm8KyflRwVRCRbbyMzd9GuPS+1SNmWGv
         JIYg==
X-Gm-Message-State: AOAM5303ixSYb6uletYJpX5jD4zCZ/TwSr909Yj3Kn7zyh93V+GgG6dz
        W2OPpcIhrboZE/AvhQ1tTJR5VBz5UNMtNBtCOgY=
X-Google-Smtp-Source: ABdhPJzfnOdCQ1vxGpDiGN+xCIWMazgRkFTQ/4a7ceYHSDmk/iRvci3NKC95EqzhEwF+Ex1bdOIpnAIv2k3SFWqokqk=
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr11494892ljm.166.1613463810341;
 Tue, 16 Feb 2021 00:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20210212090318.1522292-1-nakamura.shun@jp.fujitsu.com>
 <20210212090318.1522292-3-nakamura.shun@jp.fujitsu.com> <YCpqVuneU+wWtmMC@krava>
In-Reply-To: <YCpqVuneU+wWtmMC@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 16 Feb 2021 17:23:18 +0900
Message-ID: <CAM9d7cg7Znpwo8RKAibkmuMVoinGFa9C4WGJsUnfb728wdG-Ag@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] perf tools: Add lexical definition of event name
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 9:34 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Feb 12, 2021 at 06:03:17PM +0900, Shunsuke Nakamura wrote:
> > Add the lexical definition of event name so that the numbers are recognizable.
> >
> > A64FX defines an event name that starts with a number.
> >  - 0inst_commit
> >  - 1inst_commit
> >  - 2inst_commit
> >  - 3inst_commit
> >  - 4inst_commit
> >
> > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> > ---
> >  tools/perf/util/parse-events.l | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> > index 0b36285a9435..33f627187415 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -205,7 +205,7 @@ bpf_source        [^,{}]+\.c[a-zA-Z0-9._]*
> >  num_dec              [0-9]+
> >  num_hex              0x[a-fA-F0-9]+
> >  num_raw_hex  [a-fA-F0-9]+
> > -name         [a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
> > +name         [a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]]*
>
> I can't see anything broken because of this change,
> also numbers are defined few lines before so we should
> be fine

But this change makes the syntax ambiguous with numbers
and names. I don't think it's a good idea.

Is it possible to change the event names not having numbers
at the beginning like inst_commit0, inst_commit1 and so on?

Thanks,
Namhyung
