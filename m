Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0643E358C21
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhDHSZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232281AbhDHSZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617906293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1eQfTPkZ8gOBPhONXMaUCSV6dCKvGRBi1RI+Qu0DNhI=;
        b=QSN5WO2Uqi8BFCTgXZtYMtdlT6Z5FK4yfJSy6LFVw2rqVa1CE3pQCR0prOgsJp1mRyB63W
        OiKiHSgp+LHqKLCnst0srofdIkIddYcxH4syUElzkeUBM8YLKwzg0gOp8obFlyyRszfSGg
        tQV2ebdza47Oq4yWohMao0M6ft3Qrh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-cmXH5ge7MT-1mAuEU06rFA-1; Thu, 08 Apr 2021 14:24:51 -0400
X-MC-Unique: cmXH5ge7MT-1mAuEU06rFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2670C8030A0;
        Thu,  8 Apr 2021 18:24:50 +0000 (UTC)
Received: from krava (unknown [10.40.192.110])
        by smtp.corp.redhat.com (Postfix) with SMTP id 64D4660864;
        Thu,  8 Apr 2021 18:24:48 +0000 (UTC)
Date:   Thu, 8 Apr 2021 20:24:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v2 3/3] perf-stat: introduce config
 stat.bpf-counter-events
Message-ID: <YG9Kb9izJhQlth3X@krava>
References: <20210407003601.619158-1-song@kernel.org>
 <20210407003601.619158-4-song@kernel.org>
 <YG7tU/mVxQZLNCYL@krava>
 <FA667178-09F3-48C5-891C-9E44744276C0@fb.com>
 <YG87VLdSrhG0xSDj@krava>
 <0106D99A-5CBB-4CC4-B6F5-1B795E9B8274@fb.com>
 <YG9BMss16qFOjhos@krava>
 <FDBEC7CA-7F74-4494-93B3-7E5758E5DED9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FDBEC7CA-7F74-4494-93B3-7E5758E5DED9@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 06:08:20PM +0000, Song Liu wrote:
> 
> 
> > On Apr 8, 2021, at 10:45 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Thu, Apr 08, 2021 at 05:28:10PM +0000, Song Liu wrote:
> >> 
> >> 
> >>> On Apr 8, 2021, at 10:20 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> >>> 
> >>> On Thu, Apr 08, 2021 at 04:39:33PM +0000, Song Liu wrote:
> >>>> 
> >>>> 
> >>>>> On Apr 8, 2021, at 4:47 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> >>>>> 
> >>>>> On Tue, Apr 06, 2021 at 05:36:01PM -0700, Song Liu wrote:
> >>>>>> Currently, to use BPF to aggregate perf event counters, the user uses
> >>>>>> --bpf-counters option. Enable "use bpf by default" events with a config
> >>>>>> option, stat.bpf-counter-events. This is limited to hardware events in
> >>>>>> evsel__hw_names.
> >>>>>> 
> >>>>>> This also enables mixed BPF event and regular event in the same sesssion.
> >>>>>> For example:
> >>>>>> 
> >>>>>> perf config stat.bpf-counter-events=instructions
> >>>>>> perf stat -e instructions,cs
> >>>>>> 
> >>>>> 
> >>>>> so if we are mixing events now, how about uing modifier for bpf counters,
> >>>>> instead of configuring .perfconfig list we could use:
> >>>>> 
> >>>>> perf stat -e instructions:b,cs
> >>>>> 
> >>>>> thoughts?
> >>>>> 
> >>>>> the change below adds 'b' modifier and sets 'evsel::bpf_counter',
> >>>>> feel free to use it
> >>>> 
> >>>> I think we will need both 'b' modifier and .perfconfig configuration. 
> >>>> For systems with BPF-managed perf events running in the background, 
> >>> 
> >>> hum, I'm not sure I understand what that means.. you mean there
> >>> are tools that run perf stat so you don't want to change them?
> >> 
> >> We have tools that do perf_event_open(). I will change them to use 
> >> BPF managed perf events for "cycles" and "instructions". Since these 
> >> tools are running 24/7, perf-stat on the system should use BPF managed
> >> "cycles" and "instructions" by default. 
> > 
> > well if you are already changing the tools why not change them to add
> > modifier.. but I don't mind adding that .perfconfig stuff if you need
> > that
> 
> The tools I mentioned here don't use perf-stat, they just use 
> perf_event_open() and read the perf events fds. We want a config to make

just curious, how those tools use perf_event_open?

> "cycles" to use BPF by default, so that when the user (not these tools)
> runs perf-stat, it will share PMCs with those events by default. 

I'm sorry but I still don't see the usecase.. if you need to change both tools,
you can change them to use bpf-managed event, why bother with the list?

> > 
> >> 
> >>> 
> >>>> .perfconfig makes sure perf-stat sessions will share PMCs with these 
> >>>> background monitoring tools. 'b' modifier, on the other hand, is useful
> >>>> when the user knows there is opportunity to share the PMCs. 
> >>>> 
> >>>> Does this make sense? 
> >>> 
> >>> if there's reason for that then sure.. but let's not limit that just
> >>> on HARDWARE events only.. there are RAW events with the same demand
> >>> for this feature.. why don't we let user define any event for this?
> >> 
> >> I haven't found a good way to config RAW events. I guess RAW events 
> >> could use 'b' modifier? 
> > any event uing the pmu notation like cpu/instructions/
> 
> Can we do something like "perf config stat.bpf-counter-events=cpu/*" means 
> all "cpu/xx" events use BPF by default?

I think there's misundestanding, all I'm saying is that IIUC you check
events stat.bpf-counter-events to be HARDWARE type, which I don't think
is necessary and we can allow any event in there

jirka

