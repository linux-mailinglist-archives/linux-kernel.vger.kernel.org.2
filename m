Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD28327D79
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhCALp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:45:27 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:38443 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhCALpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:45:18 -0500
Received: by mail-lf1-f52.google.com with SMTP id m22so24990314lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 03:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zy394OIiEXrcyVa4GVnex3pNThpnw15z5YQ9o7yOnc8=;
        b=UCJRCVkNQ9gVIF9xLzi1saLEkQ4QiV2I8u9eU9/jsjg1RBe8gwZhqyTPSmi0ucDwa+
         KicvKWWSkktmNKw+hUln+plxoLL8sxjlwgudnpjorSPjZhAOR62kL0a3xGWTmfgmTB53
         TmUn9mO8UOIeQ8lck2bsFqVETRL5PRDckhROq/rvGEkw7xLg8tmcIoSiilWCmupefkeF
         pReBt1yaL5N1tlwQf/h/5MqybPNchLs6jHSaIu+0OiieGvgAhAFLhEhHmANzdH9avZX0
         9ljv4ZjmtJpu/rwS4VKzX5QAqZn6MLMn5uyW7jGj2ozFP8MC4jhv7DkM6RFHXvsIbpHr
         MvKw==
X-Gm-Message-State: AOAM533pGv0iFyei/tohJ83Fp/0IuJJew4OKu9QRQIiBukT4FU9eLhrM
        vIAKWvQ/zezx0ExoyaRGl6CGQtR3HreGRGLTGlU=
X-Google-Smtp-Source: ABdhPJxih07mReQ8KuSzuWNRov92va7Zy7QruMKOPxqmaYqHC0wcs76kCzl49usWQoLu8jafjp5tZH5DLNHQjmcRyJs=
X-Received: by 2002:a05:6512:21a3:: with SMTP id c3mr8926653lft.635.1614599075795;
 Mon, 01 Mar 2021 03:44:35 -0800 (PST)
MIME-Version: 1.0
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
 <ad205903-41a6-5041-f4f3-6f57d83cbd3a@linux.intel.com> <20201120104942.GF94830@google.com>
 <64b0859f-aad3-43fa-4e4c-81614d0c75e4@linux.intel.com>
In-Reply-To: <64b0859f-aad3-43fa-4e4c-81614d0c75e4@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 1 Mar 2021 20:44:24 +0900
Message-ID: <CAM9d7chw-i7Vx+eOPDAdyh2MPQpW=t9ueGFqUH=UcyfsNi7dUg@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] perf record: init data file at mmap buffer object
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Alexei Budankov <abudankov@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 1, 2021 at 8:16 PM Bayduraev, Alexey V
<alexey.v.bayduraev@linux.intel.com> wrote:
>
> Hi,
>
> On 20.11.2020 13:49, Namhyung Kim wrote:
> > On Mon, Nov 16, 2020 at 03:19:41PM +0300, Alexey Budankov wrote:
>
> <SNIP>
>
> >>
> >> @@ -1400,8 +1417,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
> >>      /*
> >>       * Mark the round finished in case we wrote
> >>       * at least one event.
> >> +     *
> >> +     * No need for round events in directory mode,
> >> +     * because per-cpu maps and files have data
> >> +     * sorted by kernel.
> >
> > But it's not just for single cpu since task can migrate so we need to
> > look at other cpu's data too.  Thus we use the ordered events queue
> > and round events help to determine when to flush the data.  Without
> > the round events, it'd consume huge amount of memory during report.
> >
> > If we separate tracking records and process them first, we should be
> > able to process samples immediately without sorting them in the
> > ordered event queue.  This will save both cpu cycles and memory
> > footprint significantly IMHO.
> >
> > Thanks,
> > Namhyung
> >
>
> As far as I understand, to split tracing records (FORK/MMAP/COMM) into
> a separate file, we need to implement a runtime trace decoder on the
> perf-record side to recognize such tracing records coming from the kernel.
> Is that what you mean?

No, I meant separating the mmap buffers so that the record process
can save the data without decoding.

>
> IMHO this can be tricky to implement and adds some overhead that can lead
> to possible data loss. Do you have any other ideas how to optimize memory
> consumption on perf-report side without a runtime trace decoder?
> Maybe "round events" would somehow help in directory mode?
>
> BTW In our tool we use another approach: two-pass trace file loading.
> The first loads tracing records, the second loads samples.

Yeah, something like that.  With the separated data, we can do it
more efficiently IMHO.

Thanks,
Namhyung
