Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAA0340557
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhCRMRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230338AbhCRMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616069806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vq6TJORDviWML7cL/LpE4+T1mOz5XRMlb9bFqYnLKCI=;
        b=QF2Kz9iJ9Y4bpNoA2n+v15sgCWJRmVNMZEwQniBt5hRPUBbjOimR2htsbIe8wQ+yU1TNyn
        QSye+q3F4j/MeuKvyiBbrnUkCDG7ger6swtt/DIaUX6reAdPhNeq42DK5gVcnic7C8wUZW
        zQ60DMzVZCacD0A3En3jp/WPF0BboSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-aTJI2VyLNJuXf9TJ7ImevQ-1; Thu, 18 Mar 2021 08:16:42 -0400
X-MC-Unique: aTJI2VyLNJuXf9TJ7ImevQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B397D107B768;
        Thu, 18 Mar 2021 12:16:40 +0000 (UTC)
Received: from krava (unknown [10.40.194.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id A750610016FC;
        Thu, 18 Mar 2021 12:16:38 +0000 (UTC)
Date:   Thu, 18 Mar 2021 13:16:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 11/27] perf parse-events: Support hardware events
 inside PMU
Message-ID: <YFNEpRILOTwh3svv@krava>
References: <20210311070742.9318-12-yao.jin@linux.intel.com>
 <YEu9usdFl6VSnOQ7@krava>
 <c40d6187-9391-40de-aea8-7389bb369555@linux.intel.com>
 <YE+balbLkG5RL7Lu@krava>
 <fd88f214-f0a4-87bc-ef52-ee750ca13a8d@linux.intel.com>
 <YFC615nTdUR/aLw5@krava>
 <65624432-2752-8381-d299-9b48ec508406@linux.intel.com>
 <YFHUo1I8cYf502qJ@krava>
 <b0ec8d05-acbc-3021-2e74-684d119de2db@linux.intel.com>
 <YFIHVQPG3TEeiOpP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFIHVQPG3TEeiOpP@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:42:45AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 17, 2021 at 08:17:52PM +0800, Jin, Yao escreveu:
> > Hi Jiri,
> > 
> > On 3/17/2021 6:06 PM, Jiri Olsa wrote:
> > > On Wed, Mar 17, 2021 at 10:12:03AM +0800, Jin, Yao wrote:
> > > > 
> > > > 
> > > > On 3/16/2021 10:04 PM, Jiri Olsa wrote:
> > > > > On Tue, Mar 16, 2021 at 09:49:42AM +0800, Jin, Yao wrote:
> > > > > 
> > > > > SNIP
> > > > > 
> > > > > > 
> > > > > >    Performance counter stats for 'system wide':
> > > > > > 
> > > > > >          136,655,302      cpu_core/branch-instructions/
> > > > > > 
> > > > > >          1.003171561 seconds time elapsed
> > > > > > 
> > > > > > So we need special rules for both cycles and branches.
> > > > > > 
> > > > > > The worse thing is, we also need to process the hardware cache events.
> > > > > > 
> > > > > > # ./perf stat -e cpu_core/LLC-loads/
> > > > > > event syntax error: 'cpu_core/LLC-loads/'
> > > > > >                                 \___ unknown term 'LLC-loads' for pmu 'cpu_core'
> > > > > > 
> > > > > > valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,name,period,percore
> > > > > > 
> > > > > > Initial error:
> > > > > > event syntax error: 'cpu_core/LLC-loads/'
> > > > > >                                 \___ unknown term 'LLC-loads' for pmu 'cpu_core'
> > > > > > 
> > > > > > If we use special rules for establishing all event mapping, that looks too much. :(
> > > > > 
> > > > > hmmm but wait, currently we do not support events like this:
> > > > > 
> > > > >     'cpu/cycles/'
> > > > >     'cpu/branches/'
> > > > > 
> > > > > the pmu style accepts only 'events' or 'format' terms within //
> > > > > 
> > > > > we made hw events like 'cycles','instructions','branches' special
> > > > > to be used without the pmu
> > > > > 
> > > > > so why do we need to support cpu_code/cycles/ ?
> 
> > > > Actually we have to support pmu style event for hybrid platform.
> 
> > > > User may want to enable the events from specified pmus and also with flexible grouping.
> 
> > > > For example,
> 
> > > > perf stat -e '{cpu_core/cycles/,cpu_core/instructions/}' -e '{cpu_atom/cycles/,cpu_atom/instructions/}'
> 
> > > > This usage is common and reasonable. So I think we may need to support pmu style events.
> 
> > > sure, but we don't support 'cpu/cycles/' but we support 'cpu/cpu-cycles/'
> > > why do you insist on supporting cpu_core/cycles/ ?
> 
> > 
> > I'm OK to only support 'cpu_core/cpu-cycles/' or 'cpu_atom/cpu-cycles/'. But
> > what would we do for cache event?
> > 
> > 'perf stat -e LLC-loads' is OK, but 'perf stat -e cpu/LLC-loads/' is not supported currently.
> > 
> > For hybrid platform, user may only want to enable the LLC-loads on core CPUs
> > or on atom CPUs. That's reasonable. While if we don't support the pmu style
> > event, how to satisfy this requirement?
> > 
> > If we can support the pmu style event, we can also use the same way for
> > cpu_core/cycles/. At least it's not a bad thing, right? :)
> 
> While we're discussing, do we really want to use the "core" and "atom"
> terms here? I thought cpu/cycles/ would be ok for the main (Big) CPU and
> that we should come up with some short name for the "litle" CPUs.
> 
> Won't we have the same situation with ARM where we want to know the
> number of cycles spent on a BIG core and also on a little one?
> 
> Perhaps 'cycles' should mean all cycles, and then we use 'big/cycles/' and
> 'little/cycles/'?

do arm servers already export multiple pmus like this?
I did not notice

it'd be definitely great to have some unite way for this,
so far we have the hybrid pmu detection and support in
hw events like cycles/instructions.. which should be easy
to follow on arm

there's also support to have these events on specific pmu
pmu/cycles/ , which I still need to check on

jirka

