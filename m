Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A716457510
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbhKSRO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhKSRO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:14:57 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B630AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:11:55 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y16so13618735ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UtAEF3RMoWxvdmenr7jJlhUUM9QJZdlurbD3JlhdrA=;
        b=TLwLw5txAQexwrNw1GXupt21MSixRkrPoci4c9arHuo6rEbq5YdRs3Dn3WlhaySF8t
         XgGVqLkwjt2jNsb/uHuHelfU+iOYnupAb20l3vZ4e1r0Iy6HuQ8x5cVvxX15kroPNNH9
         V87+AEv0RUUOXYhkc7hj5nrxdi/Z5/FSmqfqjpbDomwmYOY2IfxoYDd4KYDudmADT0Pe
         L2OcNcUAa545JhSOF1DJZEdJEbEXEG8jpFefn35Jao7qvvMkRMp/2XlxgoE1sGFjLpCO
         kXD+Ln5OokQA0ujzE3Edqkno/vQj4XMW1qnsJCqzdMzPZVW8OFQVxVyDwJL9l6vpY7Gd
         DxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UtAEF3RMoWxvdmenr7jJlhUUM9QJZdlurbD3JlhdrA=;
        b=M4/bJPnb1+RJx6mwKm9UjiyQFkyd6vImArqC4hWGzg09O6CsKnbjotZRKNZem28WyP
         R21Wl1FFEAzhScPRbaoe64Yul3o7XbV9IH0AycCcYYIvyMRC7TYjHaQe/c2rHTw6SpmV
         qqxYj6y02RZeebgbGqCnQC7kYUIEW80dwX+mTFPi+yB+pYKOnQOPyX5hZF/uX9i2nxCm
         4SRtP5uhOqrd/25O/EMKhbjKnv9cbJhinTp3AV01L+gvan0VG2u/d+NVB4XOptwZbgeX
         whe9qanLRk3MQcyoumsZIv3bJvvLy3Wkf2duvO62SbFwCPyao9VX+Jr77JaoA50rVoTU
         WqVQ==
X-Gm-Message-State: AOAM5328WRB5vMEw0XL1drC6dtc8JhroPiZVE2P+vGw7Hg5DqvUWN/06
        xOUTPwrZg81kH/8+fSA8KDrCF1b6HQJyTE1kfIDkxw==
X-Google-Smtp-Source: ABdhPJyta5sVRoXfrWoMVVk96IobRSjnNcryB8JFyy5Hg55pKd9es/dKLbW1z4SgwB0UW0rnJnJE7hfx+rDlEJy1cRg=
X-Received: by 2002:a05:6638:144f:: with SMTP id l15mr28892479jad.21.1637341914947;
 Fri, 19 Nov 2021 09:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20211118220647.2355999-1-irogers@google.com> <20211118220647.2355999-2-irogers@google.com>
 <17f31c73-052d-ef15-879a-c6a224977e8d@huawei.com>
In-Reply-To: <17f31c73-052d-ef15-879a-c6a224977e8d@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 19 Nov 2021 09:11:43 -0800
Message-ID: <CAP-5=fWh6bQ1vgzk-kK1Q0rcysXPHtbagBASgcQQ2dVgANG8Mw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf parse-events: Architecture specific leader override
To:     John Garry <john.garry@huawei.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 6:47 AM John Garry <john.garry@huawei.com> wrote:
>
> On 18/11/2021 22:06, Ian Rogers wrote:
> > Currently topdown events must appear after a slots event:
> >
> > $ perf stat -e '{slots,topdown-fe-bound}' /bin/true
> >
> >   Performance counter stats for '/bin/true':
> >
> >           3,183,090      slots
> >             986,133      topdown-fe-bound
> >
> > Reversing the events yields:
> >
> > $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
> > Error:
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-fe-bound).
> >
> > For metrics the order of events is determined by iterating over a
> > hashmap, and so slots isn't guaranteed to be first which can yield this
> > error.
> >
> > Change the set_leader in parse-events, called when a group is closed, so
> > that rather than always making the first event the leader, if the slots
> > event exists then it is made the leader. It is then moved to the head of
> > the evlist otherwise it won't be opened in the correct order.
> >
> > The result is:
> >
> > $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
>
> Just curious - does this just affect topdown events? I think x86 is the
> only arch which has them.

The change is specific to x86 as the weak symbol override only happens
on x86. For x86 it only applies if the cpu/slots/ event exists. In the
future it may be used for more than just this - Kajol Jain mentioned a
similar problem for powerpc:
https://lore.kernel.org/lkml/6d1fcb97-223d-7d8e-b5cb-0f10dbc62880@linux.ibm.com/

Thanks,
Ian

> Thanks,
> John
