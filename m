Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1FB37683C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhEGPrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhEGPre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:47:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C806C061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 08:46:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so5160218wmn.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDSU3NyJoM3TtAqkaOuxI+xXnlW2O+Y5nyMcEDmyIII=;
        b=VWcK243zBHE3fWspx93g1gW0jEYLon7Z/Nl3nhrux7Ec49y7Kvp2q/JilCCY296Yon
         U2ae3jMKwt+v4+fBLHu+brhc/wzRdeHwqY5ZuvKxDraa80ksEnaNnbYpcWJpkniRwcBC
         n0Q8zAei4osbO5QP7z7KnqjtYN0hx33s3gIx0Oc7DezgXKbYvLH7JaeRrOTmBstvfD1C
         JS5vnZvhTomexGMN3PwizYWp591mtjrhCKPMT+b5aMMHO0fXPvomKGfQS007GPG21Ex3
         oje0OdZojAWNpUmf0YBaVX0aoquiWfN4dpSYo5ywIiiJ7w6UDqDIQBpDUdZoywkUJd8H
         VNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDSU3NyJoM3TtAqkaOuxI+xXnlW2O+Y5nyMcEDmyIII=;
        b=iEt30gKItDRzTqkmZ93Zz8WUj7foPlHq7984I+WZQL7HXMoy7lLfDAHpLtlpNsWZGJ
         L5JAguw8vRHo9F+tzfiNNsJL8c8OFZOEjdF8CecVBvq9or0yHE7nGftPicECx9bMVPtx
         LMW5rM2E6S0RrVLcDRbf4Z+PkUXL9QwvBlc7dBgopSuGLeEw55USYEe/UiXnvlzO4+o5
         fULH/ChHV4fAEkbOngfCf5sTAPNbbuzu96LLXn0fEAHYNeB9AM/UrtK/JIuvI3B/d9PP
         iaXFtZ1oJPrfpoh+Frg/HsY8iYyXQ1xZQQ2+Ae/EYOt6e5kwfEuitgJ8yQvW/talLe2S
         2sfw==
X-Gm-Message-State: AOAM53302/z1WXZx98S+I192YZJh1rf5Ywb0qZ08EERxp52iLe8zbdxQ
        tRvjQCBu2bNgjaEP+433Scsri+YbuwtY9wpqj+qlGA==
X-Google-Smtp-Source: ABdhPJzBJUihs1zaPpJGx1LNi2iFlYZvMYXnh2trzLY/iUEkQdrt67lkQR3hPtEv8K7xCbTJ5TsX27xrN3KqtINmACE=
X-Received: by 2002:a1c:cc0b:: with SMTP id h11mr21941857wmb.87.1620402392768;
 Fri, 07 May 2021 08:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210506225640.1461000-1-irogers@google.com> <4f9a4f20-82ac-dd68-4aee-b560396755f2@huawei.com>
In-Reply-To: <4f9a4f20-82ac-dd68-4aee-b560396755f2@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 7 May 2021 08:46:19 -0700
Message-ID: <CAP-5=fUGRU+vi5NfYLBV9dXgZcG0WY45srsi3Q75T7pPLBLnMQ@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Silence warning for ArchStd files
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 2:00 AM John Garry <john.garry@huawei.com> wrote:
>
> On 06/05/2021 23:56, Ian Rogers wrote:
> > json files in the level 1 directory are used for ArchStd events (see
> > preprocess_arch_std_files), as such they shouldn't be warned about.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/pmu-events/jevents.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > index ed4f0bd72e5a..7422b0ea8790 100644
> > --- a/tools/perf/pmu-events/jevents.c
> > +++ b/tools/perf/pmu-events/jevents.c
> > @@ -1123,8 +1123,10 @@ static int process_one_file(const char *fpath, const struct stat *sb,
> >                       mapfile = strdup(fpath);
> >                       return 0;
> >               }
> > -
> > -             pr_info("%s: Ignoring file %s\n", prog, fpath);
> > +             if (is_json_file(bname))
> > +                     pr_debug("%s: ArchStd json is preprocessed %s\n", prog, fpath)
> We could get more elaborate and add the same first debug print in
> process_one_file() to preprocess_arch_std_file() to give the allusion
> that they are preprocessed, and change the logic not print that for arch
> std files (in process_one_file()). But not sure it's worth it.
>
> Or else we could also just omit any print here for archstd files here.

I thought about just dropping the print in the json case but then a
comment would be nice, the pr_debug is a comment and is somewhat
intention revealing. If you think it is overkill then it is ok to
change.

Thanks,
Ian

> But I suppose what you are doing is ok...
>
> Thanks,
> John
>
> > +             else
> > +                     pr_info("%s: Ignoring file %s\n", prog, fpath);
> >               return 0;
> >       }
> >
> >
>
