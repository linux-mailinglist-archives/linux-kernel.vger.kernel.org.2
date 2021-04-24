Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9225836A11D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 14:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhDXMYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 08:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231799AbhDXMYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 08:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619267008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHvp0OcZq0sBkrjLYAKxEf8MZPhojvIv7Wl5Pm/lV2g=;
        b=dbVbNKWBNscmAc+trqKQB6FGeYufs7XfkBNvUrxaRS6eZb0EkV5Oeri5JTt7nuj2TZdl0C
        FwJYgpEpoeGZxPp5SaCz+GXR2rDWpXKHt/WhCcDGE0+K9icLtDT9rTWRFayi9qbIKJGxye
        XpqP33rzdYDSedIAN5y+TJ6d4AsJsTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-5vt4abhqP62awmm18NEoxg-1; Sat, 24 Apr 2021 08:23:24 -0400
X-MC-Unique: 5vt4abhqP62awmm18NEoxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36FB5343A2;
        Sat, 24 Apr 2021 12:23:23 +0000 (UTC)
Received: from krava (unknown [10.40.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1C5919C46;
        Sat, 24 Apr 2021 12:23:20 +0000 (UTC)
Date:   Sat, 24 Apr 2021 14:23:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET 0/5] perf report: Make --stat output more compact
Message-ID: <YIQNtxTku/JihU+s@krava>
References: <20210423182813.1472902-1-namhyung@kernel.org>
 <20210423184647.GN1401198@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210423184647.GN1401198@tassilo.jf.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 11:46:47AM -0700, Andi Kleen wrote:
> > So I added --skip-empty (and --no-skip-empty automatically) to suppres
> > the 0 output and add the event stats like below.
> 
> I doubt we need the option for this.

I agree this could be default, but I'm getting compilation fail:

  CC       ui/browsers/hists.o
ui/browsers/hists.c: In function ‘hist_browser__handle_hotkey’:
ui/browsers/hists.c:699:29: error: ‘struct hists_stats’ has no member named ‘nr_lost_warned’
  699 |       (browser->hists->stats.nr_lost_warned !=
      |                             ^
ui/browsers/hists.c:700:28: error: ‘struct hists_stats’ has no member named ‘nr_events’
  700 |       browser->hists->stats.nr_events[PERF_RECORD_LOST])) {
      |                            ^
ui/browsers/hists.c:701:25: error: ‘struct hists_stats’ has no member named ‘nr_lost_warned’
  701 |    browser->hists->stats.nr_lost_warned =
      |                         ^
ui/browsers/hists.c:702:26: error: ‘struct hists_stats’ has no member named ‘nr_events’
  702 |     browser->hists->stats.nr_events[PERF_RECORD_LOST];
      |                          ^
ui/browsers/hists.c: In function ‘perf_evsel_menu__write’:
ui/browsers/hists.c:3419:40: error: ‘struct hists_stats’ has no member named ‘nr_events’
 3419 |  unsigned long nr_events = hists->stats.nr_events[PERF_RECORD_SAMPLE];
      |                                        ^
ui/browsers/hists.c:3435:33: error: ‘struct hists_stats’ has no member named ‘nr_events’
 3435 |    nr_events += pos_hists->stats.nr_events[PERF_RECORD_SAMPLE];
      |                                 ^
ui/browsers/hists.c:3444:26: error: ‘struct hists_stats’ has no member named ‘nr_events’
 3444 |  nr_events = hists->stats.nr_events[PERF_RECORD_LOST];
      |                          ^
ui/browsers/hists.c: In function ‘block_hists_browser__title’:
ui/browsers/hists.c:3650:41: error: ‘struct hists_stats’ has no member named ‘nr_events’
 3650 |  unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
      |                                         ^

jirka


> 
> But if you change it I would add the percentages after the absolute values.
> 
> -Andi
> 

