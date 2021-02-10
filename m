Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF3131632C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBJKGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:06:33 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:33872 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhBJKDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:03:00 -0500
Received: by mail-lj1-f178.google.com with SMTP id r23so2044735ljh.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyOc8UZclGkkqMx3r2c0BfRAQrI7zkn3IXNIIgsvPl4=;
        b=b3fXErRSHRFwRtTvAxnEdvAhWwQNY4XFojXEDNgzjS+c24tMhZFRvsCZKyBmEw4nGn
         hPoIII616FSux4800wEoFVEnQ9eRPeFMYNAMTYh+RsFHxtkHyxJO2jgnuekzrRp/tGh2
         9mtOe+leBfkKEGkJmnlv++WCvWQpvL5xFe9bCsmij3CXGN7ZevyzQvB+sD/HJ1A6ucWO
         xMf6gKV5ZUEJ50Xd1fydj6AejkniPzeIszHeYDnH0oOPd/cr6NXWNAgyWYgAonzgDtvf
         VVZj7fz4uMknlkQMK0jfmUoOQynCS1HnBAjQVlcU5EFVHfcyiCjbPkx/cGxW0Pfws/Ak
         OzaQ==
X-Gm-Message-State: AOAM531GNSeqhKAK7Nis6KL7kW9EauRZG9rnIm61VtjeK3EhC892725e
        ZR57EObnY3AGRr5uxjsB3yYneMOGvlx2Th9696Q=
X-Google-Smtp-Source: ABdhPJxs6Pq2Bl5MIq+f1bDWxubMTwz3u8OzCLlnbA0k16071n8dq86HxMqMom+cGXSW3cddQ2eiF7xI4S9IboF3WjY=
X-Received: by 2002:a2e:5016:: with SMTP id e22mr1478551ljb.166.1612951338429;
 Wed, 10 Feb 2021 02:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20210203135830.38568-1-alexander.antonov@linux.intel.com>
 <20210203135830.38568-2-alexander.antonov@linux.intel.com>
 <CAM9d7ciCGd+mkLOyJciB4Oe6XEoFyKx_=zhnK1SDnDM3=0M5NQ@mail.gmail.com> <b3cb656f-a57b-544a-67eb-3d25e85dc6b0@linux.intel.com>
In-Reply-To: <b3cb656f-a57b-544a-67eb-3d25e85dc6b0@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 10 Feb 2021 19:02:06 +0900
Message-ID: <CAM9d7ci6EmCLDxb3mYobsgndy5oA0vbEKztMuQUHE_O=KDSTeQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] perf stat: Add AGGR_PCIE_PORT mode
To:     Alexander Antonov <alexander.antonov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 8:31 PM Alexander Antonov
<alexander.antonov@linux.intel.com> wrote:
>
> On 2/4/2021 3:07 PM, Namhyung Kim wrote:
> > Hello,
> >
> > On Wed, Feb 3, 2021 at 10:58 PM Alexander Antonov
> > <alexander.antonov@linux.intel.com> wrote:
> >> Adding AGGR_PCIE_PORT mode to be able to distinguish aggr_mode
> >> for root ports in following patches.
> > I'm not sure adding the AGGR_PCIE_PORT is the right way.
> > In my understanding, the aggr mode is to specify how we aggregate
> > counter values of a single event from different cpus.  But this seems
> > to aggregate counter values from different events.  Also the new
> > mode is basically the same as AGGR_GLOBAL.
> >
> > As you will add stat_config.iostat_run to distinguish the iostat
> > command, probably we just want to use the global aggr mode
> > (and it's the default!) and get rid of the AGGR_PCIE_PORT.
> >
> > Thoughts?
> >
> > Thanks,
> > Namhyung
> Hello Namhyung,
>
> Actually, you are right. We aggregate counter values from different
> events of a
> single IIO stack (PCIe root port) to calculate metrics for this IO stack.
> But the reason is to prevent using of '-e' and '-M' options in 'iostat' mode
> because it can be a reason for the mess in the output that can confuse
> users.
>
> There is an idea to use your suggestion for this part:
>
> status = iostat_prepare(...);
> if (status < 0)
>          goto out;
> if (status == IOSTAT_LIST)
>          iostat_list(...);
> else
>          ...
>
> So, we can check if evlist is empty inside iostat_prepare(). If not, print
> a warning, for example, "The -e and -M options are not supported. All chosen
> events/metrics will be dropped". Then we can free of evlist by using
> evlist__delete(), create new one by using evlist__new() and fill the evlist.
>
> In this case the body of iostat_prepare() function would be:
>
> iostat_prepare()
> {
>      If (!is_evlist_empty) {
>          pr_warning();
>          evlist__delete();
>          evlist__new()
>      }
>
>      iostat_event_group();
> }
>
> It will allow to get rid of the AGGR_PCIE_PORT.
> What do you think?

LGTM :)

Thanks,
Namhyung
