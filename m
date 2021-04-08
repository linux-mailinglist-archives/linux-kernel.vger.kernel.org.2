Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6663358B9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhDHRpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231716AbhDHRpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617903930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qaldQ34QiZ3fYC/5jSRzjV1lYgZBFeP+Ygyt9qxwRfM=;
        b=B87ZkRF1KRK/8p6Q5Bau31AjNPkCLRlKXpofpt1WN797AIDG8pH59tiVi3EtOE9a3GmsGa
        C35du51TFbtIBdFBxpoREWsg6Hhj8S8mqBW22G6ojqLBIoUhRpu6Jsy+n++1oFJKQlDUhr
        av46wP7YYnqIZnKVohCtIiL/V2vBr58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-wEBkN1aUOv-7UK9JT3sgOg-1; Thu, 08 Apr 2021 13:45:26 -0400
X-MC-Unique: wEBkN1aUOv-7UK9JT3sgOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 013DA368C3;
        Thu,  8 Apr 2021 17:45:25 +0000 (UTC)
Received: from krava (unknown [10.40.192.110])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4B55618B4B;
        Thu,  8 Apr 2021 17:45:23 +0000 (UTC)
Date:   Thu, 8 Apr 2021 19:45:22 +0200
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
Message-ID: <YG9BMss16qFOjhos@krava>
References: <20210407003601.619158-1-song@kernel.org>
 <20210407003601.619158-4-song@kernel.org>
 <YG7tU/mVxQZLNCYL@krava>
 <FA667178-09F3-48C5-891C-9E44744276C0@fb.com>
 <YG87VLdSrhG0xSDj@krava>
 <0106D99A-5CBB-4CC4-B6F5-1B795E9B8274@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0106D99A-5CBB-4CC4-B6F5-1B795E9B8274@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 05:28:10PM +0000, Song Liu wrote:
> 
> 
> > On Apr 8, 2021, at 10:20 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Thu, Apr 08, 2021 at 04:39:33PM +0000, Song Liu wrote:
> >> 
> >> 
> >>> On Apr 8, 2021, at 4:47 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> >>> 
> >>> On Tue, Apr 06, 2021 at 05:36:01PM -0700, Song Liu wrote:
> >>>> Currently, to use BPF to aggregate perf event counters, the user uses
> >>>> --bpf-counters option. Enable "use bpf by default" events with a config
> >>>> option, stat.bpf-counter-events. This is limited to hardware events in
> >>>> evsel__hw_names.
> >>>> 
> >>>> This also enables mixed BPF event and regular event in the same sesssion.
> >>>> For example:
> >>>> 
> >>>>  perf config stat.bpf-counter-events=instructions
> >>>>  perf stat -e instructions,cs
> >>>> 
> >>> 
> >>> so if we are mixing events now, how about uing modifier for bpf counters,
> >>> instead of configuring .perfconfig list we could use:
> >>> 
> >>> perf stat -e instructions:b,cs
> >>> 
> >>> thoughts?
> >>> 
> >>> the change below adds 'b' modifier and sets 'evsel::bpf_counter',
> >>> feel free to use it
> >> 
> >> I think we will need both 'b' modifier and .perfconfig configuration. 
> >> For systems with BPF-managed perf events running in the background, 
> > 
> > hum, I'm not sure I understand what that means.. you mean there
> > are tools that run perf stat so you don't want to change them?
> 
> We have tools that do perf_event_open(). I will change them to use 
> BPF managed perf events for "cycles" and "instructions". Since these 
> tools are running 24/7, perf-stat on the system should use BPF managed
> "cycles" and "instructions" by default. 

well if you are already changing the tools why not change them to add
modifier.. but I don't mind adding that .perfconfig stuff if you need
that

> 
> > 
> >> .perfconfig makes sure perf-stat sessions will share PMCs with these 
> >> background monitoring tools. 'b' modifier, on the other hand, is useful
> >> when the user knows there is opportunity to share the PMCs. 
> >> 
> >> Does this make sense? 
> > 
> > if there's reason for that then sure.. but let's not limit that just
> > on HARDWARE events only.. there are RAW events with the same demand
> > for this feature.. why don't we let user define any event for this?
> 
> I haven't found a good way to config RAW events. I guess RAW events 
> could use 'b' modifier? 

any event uing the pmu notation like cpu/instructions/

we can allow any event to be BPF-managed, right? IIUC we don't care,
the code will work with any event

jirka

