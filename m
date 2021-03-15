Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD08633C49D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbhCORiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236757AbhCORh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615829876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vmok3KpeqyTBrv1/P6iCh+p6J/Li4ldLPj4b/X81wsE=;
        b=ami8mdL5+TkdJ36ifvhFNr1+XOEwahjPxLLGb4Cn076uKIJuqkZla3o9h/hCVJAmL0lUuk
        GiLcoDW7P8vcCCeC8VuWEasKAhManXTf2wdH4/jn2ZsiIJXq1vJ72lk4foCrtZRkdn2Kea
        cEwqL/HztpjHCVLX7pe2+9eG1EuW/Tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-oQ_QXPThPteLzE3EW7FZZg-1; Mon, 15 Mar 2021 13:37:52 -0400
X-MC-Unique: oQ_QXPThPteLzE3EW7FZZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0EB4108BD10;
        Mon, 15 Mar 2021 17:37:49 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id D614F620DE;
        Mon, 15 Mar 2021 17:37:47 +0000 (UTC)
Date:   Mon, 15 Mar 2021 18:37:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 11/27] perf parse-events: Support hardware events
 inside PMU
Message-ID: <YE+balbLkG5RL7Lu@krava>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-12-yao.jin@linux.intel.com>
 <YEu9usdFl6VSnOQ7@krava>
 <c40d6187-9391-40de-aea8-7389bb369555@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40d6187-9391-40de-aea8-7389bb369555@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:28:12AM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 3/13/2021 3:15 AM, Jiri Olsa wrote:
> > On Thu, Mar 11, 2021 at 03:07:26PM +0800, Jin Yao wrote:
> > > On hybrid platform, some hardware events are only available
> > > on a specific pmu. For example, 'L1-dcache-load-misses' is only
> > > available on 'cpu_core' pmu. And even for the event which can be
> > > available on both pmus, the user also may want to just enable
> > > one event. So now following syntax is supported:
> > > 
> > > cpu_core/<hardware event>/
> > > cpu_core/<hardware cache event>/
> > > cpu_core/<pmu event>/
> > > 
> > > cpu_atom/<hardware event>/
> > > cpu_atom/<hardware cache event>/
> > > cpu_atom/<pmu event>/
> > > 
> > > It limits the event to be enabled only on a specified pmu.
> > > 
> > > The patch uses this idea, for example, if we use "cpu_core/LLC-loads/",
> > > in parse_events_add_pmu(), term->config is "LLC-loads".
> > 
> > hum, I don't understand how this doest not work even now,
> > I assume both cpu_core and cpu_atom have sysfs device directory
> > with events/ directory right?
> > 
> 
> Yes, we have cpu_core and cpu_atom directories with events.
> 
> root@ssp-pwrt-002:/sys/devices/cpu_atom/events# ls
> branch-instructions  bus-cycles    cache-references  instructions
> mem-stores  topdown-bad-spec topdown-fe-bound
> branch-misses        cache-misses  cpu-cycles        mem-loads
> ref-cycles  topdown-be-bound topdown-retiring
> 
> root@ssp-pwrt-002:/sys/devices/cpu_core/events# ls
> branch-instructions  cache-misses      instructions   mem-stores
> topdown-bad-spec topdown-fe-bound   topdown-mem-bound
> branch-misses        cache-references  mem-loads      ref-cycles
> topdown-be-bound topdown-fetch-lat  topdown-retiring
> bus-cycles           cpu-cycles        mem-loads-aux  slots
> topdown-br-mispredict topdown-heavy-ops
> 
> > and whatever is defined in events we allow in parsing syntax..
> > 
> > why can't we treat them like 2 separated pmus?
> > 
> 
> But if without this patch, it reports the error,
> 
> root@ssp-pwrt-002:~# ./perf stat -e cpu_core/cycles/ -a -vv -- sleep 1
> event syntax error: 'cpu_core/cycles/'
>                               \___ unknown term 'cycles' for pmu 'cpu_core'

yep, because there's special care for 'cycles' unfortunately,
but you should be able to run 'cpu_core/cpu-cycles/' right?

> 
> valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,name,period,percore
> 
> Initial error:
> event syntax error: 'cpu_core/cycles/'
>                               \___ unknown term 'cycles' for pmu 'cpu_core'
> 
> valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,name,period,percore
> Run 'perf list' for a list of valid events
> 
> The 'cycles' is treated as a unknown term, then it errors out.

yep, because it's not in events.. we could add special rule to
treat cycles as cpu-cycles inside pmu definition ;-)

jirka

