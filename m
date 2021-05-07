Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999C7375F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 06:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhEGEsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 00:48:51 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:37484 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhEGEsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 00:48:50 -0400
Received: by mail-lj1-f176.google.com with SMTP id b7so9926365ljr.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 21:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXC1fcI73o6sEua4GaBQ6XsOOvAmYvi06yow1Q8fqa0=;
        b=jcctccP+9PP69hUkh3HgzjCTdY9m/1I/sATY3L/AmHmdsBQ6svrBZ7cVOE17p9YuWR
         qtTc8sGnzb4Y/Ww2PD4FVJbIzo/BowJYh8V/tSDDBEKZyYlx0rH2zTm9FW0TLFuwMa6Z
         JCZ2oNFpffMwzUEWsAcEkc18nyGy3MVyggijgdwT7JgWCydSnr+gg6v/dspt442tjBIc
         7EVXgZzlbCD80uIrQ0rmhZZF5EdXqkiF6y9OOXo94qU9Ch6rKnCbtHZQ2c7/s+Ivnptu
         OmL9BkviiV8iXXUqZM4uyU5SY+2vaUR0nLBpsMnmT+xHg8vtwcNBcJQJC7g78vju+G4y
         liFg==
X-Gm-Message-State: AOAM532a7y38VWYmWPdMT0jbAb+vei6YQ6384Lru3tzqJbdo5ZWhAJcS
        G5gpWpZQ8Xq1bod/L/n07l9K0usSlGfMJan0HEw=
X-Google-Smtp-Source: ABdhPJwLEH/PXWmkUzTrYYi6mPQA/SPSGY86InP0RZkyYJpSrJMMbIytb366UDicOHHpUijmM+ZqtwbzGvdLM18dCKQ=
X-Received: by 2002:a2e:b6d2:: with SMTP id m18mr5941191ljo.233.1620362869748;
 Thu, 06 May 2021 21:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
 <CAM9d7citW_NGb0vjMM2ytp=Mbq5YNe4GEaWspEkMGf=KAm+ugw@mail.gmail.com> <9f178dde-751f-9ac9-f5a0-fd1bfba3ca32@linux.intel.com>
In-Reply-To: <9f178dde-751f-9ac9-f5a0-fd1bfba3ca32@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 6 May 2021 21:47:38 -0700
Message-ID: <CAM9d7cj_nLM2PfSpCjRGKTHdY5G641StHSRgQT-ohWOvJsKEAA@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] Introduce threaded trace streaming for basic
 perf record operation
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 5:44 AM Bayduraev, Alexey V
<alexey.v.bayduraev@linux.intel.com> wrote:
>
> Hi,
>
> On 06.05.2021 9:20, Namhyung Kim wrote:
> > Hello,
> >
> > On Tue, May 4, 2021 at 12:05 AM Alexey Bayduraev
> > <alexey.v.bayduraev@linux.intel.com> wrote:
> >>
> <SNIP>>>
> >> Basic analysis of data directories is provided in perf report mode.
> >> Raw dump and aggregated reports are available for data directories,
> >> still with no memory consumption optimizations.
> >
> > Do you have an idea how to improve it?
> >
> > I have to say again that I don't like merely adding more threads to
> > record.  Yeah, parallelizing the perf record is good, but we have to
> > think about the perf report (and others) too.
>
> There is your idea about separating tracking records and process them
> first, but these changes can be much larger than my patch and I think
> they looks like independent patch and could be introduced as extension
> of parallel data loading.
>
> I also thought and experimented with the intermediate flushing of
> the ordered queue. This is simple for per-cpu data files (sorted
> by time), but not clear for arbitrary CPU masks.
>
> I think my patch can be the first step to introduce parallel mode
> to the perf tool. It just extends perf-record (already used in our
> vtune tool) and allows to load parallel data in experimental mode.
> Next patches could optimize and extend parallel data loading.

Yeah I agree that we can change it incrementally and good to
know that you are thinking about the next step. :)

Thanks,
Namhyung
