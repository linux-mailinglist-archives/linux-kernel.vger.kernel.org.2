Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12667457A20
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 01:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhKTA3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 19:29:50 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33783 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhKTA3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 19:29:48 -0500
Received: by mail-lf1-f45.google.com with SMTP id bu18so50909992lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 16:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymsb56msPBLvOzlurRwBAn72XXkVy6dp2kfrB9BYIN8=;
        b=AKiXYO767KLAbbPI/6mvD3djIJyZr3hs7Pt5phF+V9g4n7KIgOthYT37dL1I+foF57
         OCG/RsE4a6lFHpB6J8f2YA3kFc0/dD0PuCxRPM0IpJYd4jzxZwuT3Ltw9bzo62FI0w5N
         qI6n01v9fQ6rBT/C9rkxzjPxdAlcJC+nNlM2Dko0+pVTzCkXKRjn7d/FnTFtskoyRJPE
         0Jo6XE4sikNqtRj8vaa8Yy1cTh9dOK9yXtXGKq6alpicd5cSrKWEosBwp5LXfduy9s3Y
         J+LUWYOvRD9dsP1zHtzfG2LwqDH1LS9PfSRdtl7kJGtIuh51GsnRE9m/gk7G0Eah6JJB
         izJA==
X-Gm-Message-State: AOAM533gdbvk+axNDdm9OgjIYr9y3AhimE+Z9RmQm9LdybSHGow0uVCM
        xWW4N7Oy42uon5SXUmUQl2dL+Xf+pEj5Cl3M9go=
X-Google-Smtp-Source: ABdhPJx9MIgePzH9pbh7YvcHZbtPzifNFw72OUEis+C2EfJlmWlFQCZu+jCU+RBOQ5psngmSQhdaLWbbt/bWPVOZu+8=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr36241395lfb.71.1637368004720;
 Fri, 19 Nov 2021 16:26:44 -0800 (PST)
MIME-Version: 1.0
References: <YZeYX305gA0ut9N8@kernel.org> <YZev7KClb/ud43Lc@krava>
In-Reply-To: <YZev7KClb/ud43Lc@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 19 Nov 2021 16:26:33 -0800
Message-ID: <CAM9d7chqmavCZyJDz0OHe0uGEwp7PuxhHMBZ0cx+U71VpU+1=w@mail.gmail.com>
Subject: Re: 'perf stat --bpf-counters test' failures
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 19, 2021 at 6:08 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 19, 2021 at 09:28:15AM -0300, Arnaldo Carvalho de Melo wrote:
> >
> > After I updated to fedora 35 I started seeing the errors below,
> > it may well not be related to that, maybe something on libbpf, haven't
> > investigated, have you seen this?
>
> yep, it seems the perf bench is broken so the counts won't correlated
> if I revert this one:
>   92723ea0f11d perf bench: Fix two memory leaks detected with ASan
>
> it works for me again.. it seems to break -t option

Right, it should free the ctx after the thread finishes the work.

Thanks,
Namhyung


>
> Sohaib, could you please check on that?
>
>         [root@dell-r440-01 perf]# ./perf bench sched messaging -g 1 -l 100 -t
>         # Running 'sched/messaging' benchmark:
>         RRRperf: CLIENT: ready write: Bad file descriptor
>         Rperf: SENDER: write: Bad file descriptor
