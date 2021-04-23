Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140C0369B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243965AbhDWUVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:21:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:1486 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243797AbhDWUVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:21:03 -0400
IronPort-SDR: f7Q3W0mylJr2Ey/B1hqwXKKRw8ZjtHkmGiexD/8k03JOp01+/QikxzJwxiEQvNNaacoraow4Z0
 CNnlyGCRkIRg==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="175613764"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="175613764"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 13:20:26 -0700
IronPort-SDR: 54r4bvCv6axoXQdodLdBnWsX+tO7jlSMCFnwdM0OO5IKfYVe1p28GCt4YRryFlPMaOhO3iVZC4
 jV0viDgksRSA==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="618069478"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 13:20:25 -0700
Date:   Fri, 23 Apr 2021 13:20:24 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET 0/5] perf report: Make --stat output more compact
Message-ID: <20210423202024.GO1401198@tassilo.jf.intel.com>
References: <20210423182813.1472902-1-namhyung@kernel.org>
 <20210423184647.GN1401198@tassilo.jf.intel.com>
 <CAM9d7ciy82RM4UDHeAXwu4p7nPSg58euNK=Kdb7E0mj06e10oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciy82RM4UDHeAXwu4p7nPSg58euNK=Kdb7E0mj06e10oQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 04:00:55AM +0900, Namhyung Kim wrote:
> Hi Andi,
> 
> On Sat, Apr 24, 2021 at 3:46 AM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > So I added --skip-empty (and --no-skip-empty automatically) to suppres
> > > the 0 output and add the event stats like below.
> >
> > I doubt we need the option for this.
> >
> > But if you change it I would add the percentages after the absolute values.
> 
> What kind of percentages are you talking about?

The percentage of that value to the total sum of all the counts.

-Andi
