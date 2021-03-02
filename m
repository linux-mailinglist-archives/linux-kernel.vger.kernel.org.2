Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A8232A6D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575869AbhCBPxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1447402AbhCBN3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614691696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=umQPMaBIIn1ud59t64umNutBCq3ImvcIOTQnYrwtg1o=;
        b=hj5HMfFvJBvmNZ0Me9nuO/eMqfZvAF2rIcW+neB5MK+e6oopM+2G4aSvLGSW/M/ND14myb
        z3LOTM9FGV1SaiLWqvdCeiIe1VEQJ69tGNvlpnSEscSCtr7reEEWc5wpXCe/Yh/dpopQcG
        4hJmZplhgaTOqgB0YrUMRObNc5GYO0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-p7RefSDkMEKd_fewATVYNQ-1; Tue, 02 Mar 2021 08:03:10 -0500
X-MC-Unique: p7RefSDkMEKd_fewATVYNQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 933DF835E22;
        Tue,  2 Mar 2021 13:03:08 +0000 (UTC)
Received: from krava (unknown [10.40.195.211])
        by smtp.corp.redhat.com (Postfix) with SMTP id DD7EF10013C1;
        Tue,  2 Mar 2021 13:03:05 +0000 (UTC)
Date:   Tue, 2 Mar 2021 14:03:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 04/11] perf test: Fix cpu and thread map leaks in
 sw_clock_freq test
Message-ID: <YD43iUvSodTurUfG@krava>
References: <20210301140409.184570-1-namhyung@kernel.org>
 <20210301140409.184570-5-namhyung@kernel.org>
 <YD0jR7ENbD7u01Zq@krava>
 <CAM9d7cgNpEzaPYin=PUw9+WCecbUCQaNXAsMFOXnLBHcK8xotw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgNpEzaPYin=PUw9+WCecbUCQaNXAsMFOXnLBHcK8xotw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 10:50:15AM +0900, Namhyung Kim wrote:

SNIP

> > >               err = -ENOMEM;
> > >               pr_debug("Not enough memory to create thread/cpu maps\n");
> > > -             goto out_free_maps;
> > > +             goto out_delete_evlist;
> > >       }
> > >
> > >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> > >
> > > -     cpus    = NULL;
> > > -     threads = NULL;
> >
> > hum, so IIUC we added these and the other you remove in your patches long time ago,
> > because there was no refcounting at that time, right?
> 
> It seems my original patch just set the maps directly.
> 
>   bc96b361cbf9 perf tests: Add a test case for checking sw clock event frequency
> 
> And after that Adrian changed it to use the set_maps() helper.
> 
>   c5e6bd2ed3e8 perf tests: Fix software clock events test setting maps

ok, and after that there's this one:
  a55e56637613 perf evlist: Reference count the cpu and thread maps at set_maps()

forcing the get calls when storing cpus and threads

for the patchset

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> It seems we already had the refcounting at the moment.  And then the libperf
> renaming happened later.
> 
> Thanks,
> Namhyung
> 

