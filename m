Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734003C23B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 14:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhGIMyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 08:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhGIMyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:54:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 953F36138C;
        Fri,  9 Jul 2021 12:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625835095;
        bh=GU1jhgi5wPMaeA8R0nZaTzda3Y0S9v6LWbgT7i4/SkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjqy5QkSAmty9r6mK5N/qGFwzTEXpvsWspiQDskLAm925ierVP2EdCW3fd3T1g9HL
         h1TMykjV2FsFLFVVxe/RvYmHcxfF+QL6L0dl2SNtPUlvgw208lBftym/8+aE1pT6kS
         gcvLCQUU3VbSlfDBQAXHt/9DpSOdRmoh9L++Fqb25jf+Ezmqb28Sao5n5SKoyfebwa
         C0HoWqZPzrYTee7JVVNiQst/ROpASpVlD3orXw+5f9cQSy0VDJqOsw/T1FWQX+hJBj
         F9BGRwaCKJ+y2lMu4j0zIxRrkkjtJX/stblKO5pEFylgryAXfwxcgejdgJyRkuq/a6
         sRppPiz6iJaDA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D9E5E40B1A; Fri,  9 Jul 2021 09:51:31 -0300 (-03)
Date:   Fri, 9 Jul 2021 09:51:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     "Liang, Kan" <kan.liang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yao Jin <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf record: Add a dummy event for a hybrid system
Message-ID: <YOhGU0PZPSVb1s0n@kernel.org>
References: <1625760212-18441-1-git-send-email-kan.liang@intel.com>
 <CAM9d7cgGmAsa1wCQJM_FfhiG9+ULqAdCTyqw4wSqbnNSzvrdWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgGmAsa1wCQJM_FfhiG9+ULqAdCTyqw4wSqbnNSzvrdWQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 08, 2021 at 10:32:13PM -0700, Namhyung Kim escreveu:
> On Thu, Jul 8, 2021 at 9:05 AM <kan.liang@intel.com> wrote:
> >
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > Some symbols may not be resolved if a user only monitor one type of PMU.
> >
> >  $ sudo perf record -e cpu_atom/branch-instructions/ ./big_small_workload
> >  $ sudo perf report –stdio
> >  # Overhead  Command    Shared Object      Symbol
> >  # ........  .........  .................
> >  # ......................................
> >  #
> >     28.02%  perf-exec  [unknown]          [.] 0x0000000000401cf6
> >     11.32%  perf-exec  [unknown]          [.] 0x0000000000401d04
> >     10.90%  perf-exec  [unknown]          [.] 0x0000000000401d11
> >     10.61%  perf-exec  [unknown]          [.] 0x0000000000401cfc
> >
> > To parse symbols, the side-band events, e.g., COMM, which are generated
> > by the kernel are required. To decide whether to generate the side-band
> > event, the kernel relies on the event_filter_match() to filter the
> > unrelated events. On a hybrid system, the event_filter_match() further
> > checks the CPU mask of the current enabled PMU. If an event is collected
> > on the CPU which doesn't have an enabled PMU, it's treated as an
> > unrelated event.
> >
> > The "big_small_workload" is created in a big core, but runs on a small
> > core. The side-band events are filtered, because the user only monitors
> > the PMU of the small core. The big core PMU is not enabled.
> >
> > For a hybrid system, a dummy event is required to generate the complete
> > side-band events.
> >
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

