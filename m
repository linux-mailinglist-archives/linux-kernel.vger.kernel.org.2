Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2DA35F4A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhDNNQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:16:15 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:42935 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhDNNP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:15:57 -0400
Received: by mail-lf1-f41.google.com with SMTP id z13so16088470lfd.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 06:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nt3k4mbFo142KstLtJv6u8jBsVUi0xHVK//4WN7nd5c=;
        b=Npvj/IpRzIEsc0ODe1VC+FLsxOkOOr3gwjR683BY1jHfw3K4pfBE0ccKxhW1cOU1um
         pTPpumLXe9y7ve5BMOM5366kTHojaMYdQecy9umfe3Tlq7JY16IQoT5CxmcC8g/oxDma
         etGIFaUChiFa5omFXcBhctP3B42PdRrH0/KaTVQ3YVo3P7CaknRCY/6j4ZoDY0jnlHAq
         ZxNoVwoGPNLA9/5pYPshzsOXdyBNc+7oeTw3zyqq3isQ7h5sktBh7rnWP2GvxnFJo/in
         iofoYNUeB3uhmfMysMDWboaGkjvqfH4pyADcHiuOb1BZZc8DqXX8mz672zHVBu2S7GK3
         14PQ==
X-Gm-Message-State: AOAM532GZUoVTNNX85VZdq3EIhK2ruz8xAGQi5EJAbCYqvaZp5mV9DPC
        njAp33rkrhUjnXwTWjN3vPyrDlkWVGal9Tbzgb8=
X-Google-Smtp-Source: ABdhPJxJ1MVU2SHcgqMSyT/DjfCachH22OYdor0PcYg2GDFnD3y2A4k50e2V5b6lyQxy/+B2S8Fy1oUoFDgfFV43SsU=
X-Received: by 2002:a05:6512:234e:: with SMTP id p14mr5247904lfu.112.1618406134824;
 Wed, 14 Apr 2021 06:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210319123527.173883-1-yangjihong1@huawei.com>
 <33ba152e-b8ef-3057-744a-51cb8c478ff2@huawei.com> <CAM9d7cjT-Q8RBprzG=hwdxrgVpzf3RwECuJ1UvbQYpQ47migbg@mail.gmail.com>
 <YF3OXfzl7FEV50Ir@kernel.org> <27703989-e510-c964-2af7-ef0a5611f8cf@huawei.com>
 <CAM9d7chhFnYyUv++RzJRXomHq0vZN2LrbCAOBPg67MDeg6saOw@mail.gmail.com>
 <555b7a2d-13c8-e840-e62b-cf0ad7d084a9@huawei.com> <12d269ad-80f9-3893-f3c4-d12fcdbfecda@huawei.com>
 <YHbexV5LtJWMqJra@kernel.org>
In-Reply-To: <YHbexV5LtJWMqJra@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 14 Apr 2021 22:15:23 +0900
Message-ID: <CAM9d7cij0sqfG_Z5uq52kx30G9iCj48mqb3fhQ-KVrf2qDFHvQ@mail.gmail.com>
Subject: Re: [PATCH v7] perf annotate: Fix sample events lost in stdio mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Yao Jin <yao.jin@linux.intel.com>, gustavoars@kernel.org,
        mliska@suse.cz, linux-kernel <linux-kernel@vger.kernel.org>,
        zhangjinhao2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Apr 14, 2021 at 9:23 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Apr 12, 2021 at 03:22:29PM +0800, Yang Jihong escreveu:
> > On 2021/3/31 10:18, Yang Jihong wrote:
> > > On 2021/3/30 15:26, Namhyung Kim wrote:
> > > > On Sat, Mar 27, 2021 at 11:16 AM Yang Jihong <yangjihong1@huawei.com> wrote:
> > > > > On 2021/3/26 20:06, Arnaldo Carvalho de Melo wrote:
> > > > > > So it seems to be working, what am I missing? Is this strictly non
> > > > > > group related?
>
> > > > > Yes, it is non group related.
> > > > > This problem occurs only when different events need to be recorded at
> > > > > the same time, i.e.:
> > > > > perf record -e branch-misses -e branch-instructions -a sleep 1
>
> > > > > The output results of perf script and perf annotate do not match.
> > > > > Some events are not output in perf annotate.
>
> > > > Yeah I think it's related to sort keys.  The code works with a single
> > > > hist_entry for each event and symbol.  But the default sort key
> > > > creates multiple entries for different threads and it causes the
> > > > confusion.
>
> > > Yes, After revome zfree from hists__find_annotations, the output of perf
> > > annotate is repeated, which is related to sort keys.
>
> > > The original problem is that notes->src may correspond to multiple
> > > sample events. Therefore, we cannot simply zfree notes->src to avoid
> > > repeated output.
>
> > > Arnaldo, is there any problem with this patch? :)
>
> > PING :)
> > Is there any problem with this patch that needs to be modified?
>
> I continue having a feeling this is kinda a bandaid, i.e. avoid the
> problem, and since we have a way to work this when using a group, I fail
> to see why it couldn't work when not grouping events.

When we use a group, there's a single iteration only for the leader event.
But if not, it'll iterate the hist entries twice (for two events).
Each iteration
used to have multiple entries for the same symbol (due to the sort key),
so it marked the symbol (by freeing notes->src) to skip the same symbol
during the iteration.

However as the first iteration freed sym->notes->src, then the second
(or later) event cannot see the annotation for the deleted symbols
for that event even if it has some samples.

>
> But since I have no time to dive into this and Namhyung is ok with it,
> I'll merge it now.

Thanks,
Namhyung
