Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BFB33ECDF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhCQJTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229796AbhCQJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615972778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wDtR7tgXN0GWY9XTaXa4dXAdEOCAehc3gkBXn58TQJU=;
        b=L5jmj0L9bQL0WVo6FCNzkZkCjWgQ+gS7jEmP0ygb9/SAIhWOYmVZo4z94Cns4xE5SHDtnj
        Ja8Fzu+4n2Db5lRzKFv6dtm4dycIXxh1Ade6nxQIIyJmYjYG6igKyXa72oZWZsDZwkLIbs
        A0SlbUIeHw3X/h6QC3qzTpViKlJ3y58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-GAaik-TOMr6ZaUl5Ha7XGw-1; Wed, 17 Mar 2021 05:19:34 -0400
X-MC-Unique: GAaik-TOMr6ZaUl5Ha7XGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3F2E81746B;
        Wed, 17 Mar 2021 09:19:32 +0000 (UTC)
Received: from krava (unknown [10.40.194.149])
        by smtp.corp.redhat.com (Postfix) with SMTP id E88CA5C23E;
        Wed, 17 Mar 2021 09:19:30 +0000 (UTC)
Date:   Wed, 17 Mar 2021 10:19:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Message-ID: <YFHJoapj4NMSkFIh@krava>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 02:29:28PM +0900, Namhyung Kim wrote:
> Hi Song,
> 
> On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb.com> wrote:
> >
> > perf uses performance monitoring counters (PMCs) to monitor system
> > performance. The PMCs are limited hardware resources. For example,
> > Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
> >
> > Modern data center systems use these PMCs in many different ways:
> > system level monitoring, (maybe nested) container level monitoring, per
> > process monitoring, profiling (in sample mode), etc. In some cases,
> > there are more active perf_events than available hardware PMCs. To allow
> > all perf_events to have a chance to run, it is necessary to do expensive
> > time multiplexing of events.
> >
> > On the other hand, many monitoring tools count the common metrics (cycles,
> > instructions). It is a waste to have multiple tools create multiple
> > perf_events of "cycles" and occupy multiple PMCs.
> 
> Right, it'd be really helpful when the PMCs are frequently or mostly shared.
> But it'd also increase the overhead for uncontended cases as BPF programs
> need to run on every context switch.  Depending on the workload, it may
> cause a non-negligible performance impact.  So users should be aware of it.

right, let's get get some idea of how bad that actualy is

Song,
could you please get some numbers from runnning for example
'perf bench sched messaging ...' with both normal and bpf
mode perf stat? for all supported target options

thanks,
jirka

