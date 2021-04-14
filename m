Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC6D35FCDF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhDNUyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhDNUyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:54:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A30D61179
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 20:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618433629;
        bh=29EHUhjzIrsu9S9WT6ZbMpXUN6PrspEKBQXQhwjItis=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KcxWGSASyG+jv1awQVl2Ij8cGl6rYUGUxoubR8iIXA5bS850ZxPDd30919EQwW0oT
         aXM+wWplgBhrbtJW0L+27SDIjG6oUw4Kk9zyPTFDhi1zEaCf82hl/OkLRcINUT1OY3
         N8W/Y8k9bs64IpXZDsTCUKW+wnGTcidtKtzzsjvnA2DGKVnXSAn5BP1/a2jyTRiuqt
         K31R78kulDC2Oy/HPNL0pMY7cg7Nvxd+JfAOgZAclABoVKuvWudN4hUWEZm7UTjipp
         zYiMyoz1X/Ghpr+6hauSksVmQitGf7VUnl1z5GUr9eh9uR3dk7pNtKAVHCg4D1qkm/
         MriZZyCB4FHBg==
Received: by mail-ed1-f51.google.com with SMTP id h10so25308373edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:53:49 -0700 (PDT)
X-Gm-Message-State: AOAM532iwSo94c3fkKnSxNO6eRKSyEAVTMDMBekg0sFLqwJAviN+BCJD
        jAzq6JtXF7sCsKhQrWPtHVoeCY/xKM7pdHAjMA==
X-Google-Smtp-Source: ABdhPJyufEB6F9JqzdPSmBO4JR1mPFbi9Mq9JvcH0ReY77nTTwoXmEjxUbNKYPQqgeDdt456pSIJ4MxCaHTdNhGTsGI=
X-Received: by 2002:aa7:cd83:: with SMTP id x3mr97305edv.373.1618433627682;
 Wed, 14 Apr 2021 13:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210414195758.4078803-1-robh@kernel.org> <CAM9d7chWROPAg3T_gd+T6N+94pWawKtggyegCGo0nXzKF+F7+g@mail.gmail.com>
In-Reply-To: <CAM9d7chWROPAg3T_gd+T6N+94pWawKtggyegCGo0nXzKF+F7+g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Apr 2021 15:53:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKuk53i0Lf=3sMOjieSNZo3Rqh+-Uhbd0n3qn=rpRKfLQ@mail.gmail.com>
Message-ID: <CAL_JsqKuk53i0Lf=3sMOjieSNZo3Rqh+-Uhbd0n3qn=rpRKfLQ@mail.gmail.com>
Subject: Re: [PATCH] libperf: xyarray: Add bounds checks to xyarray__entry()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 3:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Thu, Apr 15, 2021 at 4:58 AM Rob Herring <robh@kernel.org> wrote:
> >
> > xyarray__entry() is missing any bounds checking yet often the x and y
> > parameters come from external callers. Add bounds checks and an
> > unchecked __xyarray__entry().
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  tools/lib/perf/include/internal/xyarray.h | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/perf/include/internal/xyarray.h b/tools/lib/perf/include/internal/xyarray.h
> > index 51e35d6c8ec4..f0896c00b494 100644
> > --- a/tools/lib/perf/include/internal/xyarray.h
> > +++ b/tools/lib/perf/include/internal/xyarray.h
> > @@ -18,11 +18,18 @@ struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
> >  void xyarray__delete(struct xyarray *xy);
> >  void xyarray__reset(struct xyarray *xy);
> >
> > -static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
> > +static inline void *__xyarray__entry(struct xyarray *xy, int x, int y)
> >  {
> >         return &xy->contents[x * xy->row_size + y * xy->entry_size];
> >  }
> >
> > +static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
> > +{
> > +       if (x >= xy->max_x || y >= xy->max_y)
> > +               return NULL;
>
> Maybe better to check negatives as well.

max_x and max_y are size_t and unsigned, so x and y will be promoted
to unsigned and the check will still work.

It's probably better to change the args to size_t though. And perhaps
on xyarray__new(), xyarray__max_y(), and xyarray__max_x() as well.

Rob
