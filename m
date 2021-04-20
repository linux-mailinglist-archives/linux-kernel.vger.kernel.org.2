Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A925D365EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhDTRbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233245AbhDTRbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618939878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJlADHgs7Bom5f1A4SK34buquQwkXhXunioAr86hCSE=;
        b=Rz+15CtjZwFT9/QS7bKEkaSRnDUvhaXdRUdrhPvL7oKB4LrmyTG7A3BxqOTGLTLD3RLvs2
        hfnziycyE+2dgbaB2hcsmUcGoGtALpaE42E4B1g0i4hffZ4Y0WI/M4PL3ehQDeQ2pqleIU
        2wJBScwQ225UzK05nj0iP8eH9frpKpU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-RgOl3XuNP9aaBg8wVYBhQA-1; Tue, 20 Apr 2021 13:30:47 -0400
X-MC-Unique: RgOl3XuNP9aaBg8wVYBhQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B72A18189C8;
        Tue, 20 Apr 2021 17:30:45 +0000 (UTC)
Received: from krava (unknown [10.40.196.37])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0F9DC5D9C0;
        Tue, 20 Apr 2021 17:30:43 +0000 (UTC)
Date:   Tue, 20 Apr 2021 19:30:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Song Liu <song@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Message-ID: <YH8Pw4m0w6DuuEXo@krava>
References: <20210416221325.2373497-1-song@kernel.org>
 <20210416221325.2373497-4-song@kernel.org>
 <CAM9d7ciVj+d=Bgqmwu+v9mA1CGTbtr8pfXzgNKJs0Nh3BJtt8A@mail.gmail.com>
 <71CC9E29-ECBD-47DB-AE85-1477BF54C45D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71CC9E29-ECBD-47DB-AE85-1477BF54C45D@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 08:26:02PM +0000, Song Liu wrote:
> 
> 
> > On Apr 17, 2021, at 9:45 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > Hi Song,
> > 
> > On Sat, Apr 17, 2021 at 7:13 AM Song Liu <song@kernel.org> wrote:
> >> 
> >> Currently, to use BPF to aggregate perf event counters, the user uses
> >> --bpf-counters option. Enable "use bpf by default" events with a config
> >> option, stat.bpf-counter-events. Events with name in the option will use
> >> BPF.
> >> 
> >> This also enables mixed BPF event and regular event in the same sesssion.
> >> For example:
> >> 
> >>   perf config stat.bpf-counter-events=instructions
> >>   perf stat -e instructions,cs
> >> 
> >> The second command will use BPF for "instructions" but not "cs".
> >> 
> >> Signed-off-by: Song Liu <song@kernel.org>
> >> ---
> >> @@ -535,12 +549,13 @@ static int enable_counters(void)
> >>        struct evsel *evsel;
> >>        int err;
> >> 
> >> -       if (target__has_bpf(&target)) {
> >> -               evlist__for_each_entry(evsel_list, evsel) {
> >> -                       err = bpf_counter__enable(evsel);
> >> -                       if (err)
> >> -                               return err;
> >> -               }
> >> +       evlist__for_each_entry(evsel_list, evsel) {
> >> +               if (!evsel__is_bpf(evsel))
> >> +                       continue;
> >> +
> >> +               err = bpf_counter__enable(evsel);
> >> +               if (err)
> >> +                       return err;
> > 
> > I just realized it doesn't have a disable counterpart.
> 
> I guess it is not really necessary for perf-stat? It is probably good
> to have it though. How about we do it in a follow up patch?

good catch, should it at least do:
  evsel->follower_skel->bss->enabled = 0;

because then the follower goes down only with perf process, right?
still doing the counts till the end..?

also while checking on that I realized we open the counters
in separate path for this in bperf_reload_leader_program by
calling evsel__open_per_cpu.. and we're missing all the
fallback code and setup from create_perf_stat_counter

I think we should at least call create_perf_stat_counter,
and also propagate error value if it fails

jirka

> 
> [...]
> 
> >> +       if (!evsel__bpf_counter_events)
> >> +               return false;
> >> +
> >> +       ptr = strstr(evsel__bpf_counter_events, name);
> >> +       name_len = strlen(name);
> >> +
> >> +       /* check name matches a full token in evsel__bpf_counter_events */
> >> +       match = (ptr != NULL) &&
> >> +               ((ptr == evsel__bpf_counter_events) || (*(ptr - 1) == ',')) &&
> >> +               ((*(ptr + name_len) == ',') || (*(ptr + name_len) == '\0'));
> > 
> > I'm not sure we have an event name which is a substring of another.
> > Maybe it can retry if it fails to match.
> 
> We have ref-cycles and cycles. And some raw events may be substring of others?
> 
> Thanks,
> Song
> 
> [...]
> 

