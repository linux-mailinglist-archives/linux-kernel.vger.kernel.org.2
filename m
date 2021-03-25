Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0DE349280
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhCYM5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhCYM5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:57:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 382D261974;
        Thu, 25 Mar 2021 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616677052;
        bh=3H0UEl8IFMZnTCiYxMhBs6oV9gfIvgzzMAIaxL0u45U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1AERoXCy9779LdVGqi8hJ3RLE6J1qXJcz37mjlqLcR2x5xlZEbgfqSjYhha7N7jz
         VuSr8Jc73qmNE7025HzhPQv80qz1FhbuiMz2Stf0SBE8+IWvSh+9UTTv2h6EXoMTJF
         Rmz1t0uXt7cK90w8wTRcDj1jaGb/UCE7Y9zeZQpMJd6hAxM4/BxGKbIGjCWDUy8LCW
         EAs02cTY0uK+MIgDVzkhSIGeDOnlU4zlFE54NCNXoFDDgNhoNUaUWMHXlWP/O7BDHj
         E8EeZFCKttEPYC8PToehQymNErQ+wUeRT+7OqJiskDwdn7RoC+eKO101PXWPj1iQzZ
         9ogbuLyRO/Ugw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0FACE40647; Thu, 25 Mar 2021 09:57:30 -0300 (-03)
Date:   Thu, 25 Mar 2021 09:57:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] perf/core: Share an event with multiple cgroups
Message-ID: <YFyIuZWs+GINtoTY@kernel.org>
References: <20210323162156.1340260-1-namhyung@kernel.org>
 <20210323162156.1340260-2-namhyung@kernel.org>
 <C0AF9F1F-F525-4047-AD89-F75E3FEFC215@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C0AF9F1F-F525-4047-AD89-F75E3FEFC215@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 25, 2021 at 12:55:50AM +0000, Song Liu escreveu:
> > On Mar 23, 2021, at 9:21 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > #ifdef CONFIG_SECURITY
> > @@ -780,6 +792,14 @@ struct perf_event {
> > #endif /* CONFIG_PERF_EVENTS */
> > };

> > +struct perf_cgroup_node {
> > +	struct hlist_node		node;
> > +	u64				id;
> > +	u64				count;
> > +	u64				time_enabled;
> > +	u64				time_running;
> > +	u64				padding[2];
> 
> Do we really need the padding? For cache line alignment? 

I guess so, to get it to 64 bytes, then having it as:

struct perf_cgroup_node {
	struct hlist_node		node;
	u64				id;
	u64				count;
	u64				time_enabled;
	u64				time_running;
} ____cacheline_aligned;

Seems better :-)

Testing:

[acme@five c]$ cat cacheline_aligned.c
#ifndef ____cacheline_aligned
#define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
#endif

// from ../build/v5.12.0-rc4+/include/generated/autoconf.h
#define CONFIG_X86_L1_CACHE_SHIFT 6

#define L1_CACHE_SHIFT  (CONFIG_X86_L1_CACHE_SHIFT)
#define L1_CACHE_BYTES  (1 << L1_CACHE_SHIFT)

#ifndef SMP_CACHE_BYTES
#define SMP_CACHE_BYTES L1_CACHE_BYTES
#endif

typedef long long unsigned int u64;

struct hlist_node {
	struct hlist_node *        next;                 /*     0     8 */
	struct hlist_node * *      pprev;                /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* last cacheline: 16 bytes */
};

struct perf_cgroup_node {
        struct hlist_node               node;
        u64                             id;
        u64                             count;
        u64                             time_enabled;
        u64                             time_running;
} ____cacheline_aligned foo;

[acme@five c]$ cc  -g  -c -o cacheline_aligned.o cacheline_aligned.c
[acme@five c]$ pahole cacheline_aligned.o
struct hlist_node {
	struct hlist_node *        next;                 /*     0     8 */
	struct hlist_node * *      pprev;                /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* last cacheline: 16 bytes */
};
struct perf_cgroup_node {
	struct hlist_node          node;                 /*     0    16 */
	u64                        id;                   /*    16     8 */
	u64                        count;                /*    24     8 */
	u64                        time_enabled;         /*    32     8 */
	u64                        time_running;         /*    40     8 */

	/* size: 64, cachelines: 1, members: 5 */
	/* padding: 16 */
} __attribute__((__aligned__(64)));
[acme@five c]$

- Arnaldo
