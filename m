Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B923A3463
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhFJUBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFJUBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:01:15 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4449161359;
        Thu, 10 Jun 2021 19:59:17 +0000 (UTC)
Date:   Thu, 10 Jun 2021 15:59:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-users@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, eranian@google.com,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC PATCH] libtraceevent: Increase libtraceevent logging when
 verbose
Message-ID: <20210610155915.20a252d3@oasis.local.home>
In-Reply-To: <YMJjMPDKo2IdCC6G@krava>
References: <20210610060643.595673-1-irogers@google.com>
        <20210610103927.44462e35@oasis.local.home>
        <YMJjMPDKo2IdCC6G@krava>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 21:08:32 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> Michael did the libtraceevent detection and dynamic linking support:
>   https://lore.kernel.org/linux-perf-users/20210428092023.4009-1-mpetlan@redhat.com/
> 
> I think we should have that in Fedora/RHEL rpms already, or it's on the way.
> 
> The detection code could be change to contain things we need.

Or it can also be changed to export the version too?

LIBTRACEEVENT_VERSION = $(shell pkg-config --modversion libtraceevent | perl -e '$ver=<>; @v=split /,/,$ver; printf "%d\n", $v[0] * 255 * 255 | $v[1] * 255 | $v[2];')

-DLIBTRACEFS_VERSION=$(LIBTRACEEVENT_VERSION)

Then in C have:

#define VERSION(a,b,c) ((a)*255*255|(b)*255|(c))

#if LIBTRACEEVENT_VERSION >= VERSION(1,2,3)

To test if the libtraceevent feature is available?

-- Steve
