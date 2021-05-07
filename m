Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B438375F94
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 06:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhEGExh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 00:53:37 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:33570 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEGExg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 00:53:36 -0400
Received: by mail-lj1-f172.google.com with SMTP id s25so9958902lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 21:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMYfG+wCUME/JqxM/c81ldOkffmHkn+K2+759i6K0N8=;
        b=L6/Nyt2PgCZzXdi18Zhdh7DVdU/d53ZYJhyCygoRUsRAe80H80g3Cc46+KsbFanawS
         457UUpj0s/3LEYhV1Z+Dmun3RuE219gZz9oX0sIUrUNIFRfM4fuFSZXEVfeCVtyvEqXE
         fx+tGKcKHZcijnN1R9NK4XTXLS/IIWw7+qbV+YXWt8+JZB9uU1p8fcph0E8hECY6NsjQ
         fSCJIH/xiSniWfLfMDbYh67R0mdAHDjKWcM+ODco5h284t5VD9IQxoJ5fASN20xqPCgS
         OGQ2Y8p/LDQVzUp+0emFVXgcXChERPCS0ozPoLLZmhJZrZzRNJP57v/37iD43rAyVJX1
         Yz+Q==
X-Gm-Message-State: AOAM530jHWG2expsbTcT4J+iTbQQWAxCk1Sk8nZe7vS2yay6eNsE9uit
        0BO4Z1LekEWR41Qy8CIdKxNG+ev/rq+cW2nUpZk=
X-Google-Smtp-Source: ABdhPJxzbsKcfFxqkE80f4e6XCHZ6NtJEaJIEZsPUn/Xaue0HGb8sHbx6FHC07qZOGaPTWjgt09liWYXUCC/gVh+J6I=
X-Received: by 2002:a2e:b746:: with SMTP id k6mr6043703ljo.275.1620363155161;
 Thu, 06 May 2021 21:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
 <CAM9d7citW_NGb0vjMM2ytp=Mbq5YNe4GEaWspEkMGf=KAm+ugw@mail.gmail.com> <4926ae4f-b14b-1048-229b-0b789204c192@linux.intel.com>
In-Reply-To: <4926ae4f-b14b-1048-229b-0b789204c192@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 6 May 2021 21:52:24 -0700
Message-ID: <CAM9d7cgqgF=771ATS-_25B=kyOfhM-6g5m086gOXyLaNR+cf9g@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] Introduce threaded trace streaming for basic
 perf record operation
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Thu, May 6, 2021 at 7:17 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 5/5/2021 11:20 PM, Namhyung Kim wrote:
> >
> > Do you have an idea how to improve it?
> >
> > I have to say again that I don't like merely adding more threads to
> > record.  Yeah, parallelizing the perf record is good, but we have to
> > think about the perf report (and others) too.
>
> perf report/script can be already parallelized with --time xx/x% and a
> simple shell script that runs multiple processes. While that's a bit
> awkward for interactive use it works fine for scripting. I use it all
> the time for PT batch processing for example. The real bottleneck we
> have is really record on systems with many CPUs (which are more and more
> common), and that can only be fixed with some variant of this patch kit.

Right, spreading partial analysis to multiple processes would work
for some use cases.  I also agree that parallelizing perf record is
more important, but if there's a way to improve perf report/script
we should try that too.

Thanks,
Namhyung
