Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC9B358B39
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhDHRUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232377AbhDHRUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617902429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6jeo6RKyoMM+BFp8BXR0dyWtTRsTbouoZgex95KJOQY=;
        b=XV2RFJu0Dv2M4pK+gJUh6LURnz2fUwf1LhZLfXRIrx5G1pvNtgxvX+FIA7UzZpqtQ9dw0D
        BSy0TxnsS6tVkeSbPT0AA1WOO1VbUlZH3kUeO7UcaZemX/W+ytZlSrZzkYjy4BMe1Lva2B
        c1CPyvVK1EClJLvTsc4+F+0FHPBa1Sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-ZGcIYKeXPiCkehacnwyJSA-1; Thu, 08 Apr 2021 13:20:25 -0400
X-MC-Unique: ZGcIYKeXPiCkehacnwyJSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8535D1B18BC0;
        Thu,  8 Apr 2021 17:20:23 +0000 (UTC)
Received: from krava (unknown [10.40.192.110])
        by smtp.corp.redhat.com (Postfix) with SMTP id D15F510013C1;
        Thu,  8 Apr 2021 17:20:21 +0000 (UTC)
Date:   Thu, 8 Apr 2021 19:20:20 +0200
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
Message-ID: <YG87VLdSrhG0xSDj@krava>
References: <20210407003601.619158-1-song@kernel.org>
 <20210407003601.619158-4-song@kernel.org>
 <YG7tU/mVxQZLNCYL@krava>
 <FA667178-09F3-48C5-891C-9E44744276C0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FA667178-09F3-48C5-891C-9E44744276C0@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 04:39:33PM +0000, Song Liu wrote:
> 
> 
> > On Apr 8, 2021, at 4:47 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Tue, Apr 06, 2021 at 05:36:01PM -0700, Song Liu wrote:
> >> Currently, to use BPF to aggregate perf event counters, the user uses
> >> --bpf-counters option. Enable "use bpf by default" events with a config
> >> option, stat.bpf-counter-events. This is limited to hardware events in
> >> evsel__hw_names.
> >> 
> >> This also enables mixed BPF event and regular event in the same sesssion.
> >> For example:
> >> 
> >>   perf config stat.bpf-counter-events=instructions
> >>   perf stat -e instructions,cs
> >> 
> > 
> > so if we are mixing events now, how about uing modifier for bpf counters,
> > instead of configuring .perfconfig list we could use:
> > 
> >  perf stat -e instructions:b,cs
> > 
> > thoughts?
> > 
> > the change below adds 'b' modifier and sets 'evsel::bpf_counter',
> > feel free to use it
> 
> I think we will need both 'b' modifier and .perfconfig configuration. 
> For systems with BPF-managed perf events running in the background, 

hum, I'm not sure I understand what that means.. you mean there
are tools that run perf stat so you don't want to change them?

> .perfconfig makes sure perf-stat sessions will share PMCs with these 
> background monitoring tools. 'b' modifier, on the other hand, is useful
> when the user knows there is opportunity to share the PMCs. 
> 
> Does this make sense? 

if there's reason for that then sure.. but let's not limit that just
on HARDWARE events only.. there are RAW events with the same demand
for this feature.. why don't we let user define any event for this?

jirka

