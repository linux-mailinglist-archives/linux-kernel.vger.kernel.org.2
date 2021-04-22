Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A60367719
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhDVCGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:06:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:59291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhDVCGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:06:00 -0400
IronPort-SDR: pEQeo9jEtN38DDsZhqLQ00ww2HSEAkiVFDGRhxJBk9a3/AUqxI7SrsqiOwtpJVl6/mpZOUDN1f
 OMw0gzMgLdbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="216470774"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="216470774"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 19:05:15 -0700
IronPort-SDR: J7L3j1NCzA4oaG7+eKnjE8m7uBymT3gCZ7SGYKxGkbTyJ8OmUTsIX6+pHmsRhkK/qY6UVDwnEX
 9140CvtY6bNw==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="391649287"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 19:05:14 -0700
Date:   Wed, 21 Apr 2021 19:05:12 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm-list@vger.kernel.org,
        Peter Shier <pshier@google.com>
Subject: Re: [PATCH] perf/x86/kvm: Fix Broadwell Xeon stepping in
 isolation_ucodes[]
Message-ID: <20210422020512.GH1401198@tassilo.jf.intel.com>
References: <20210422001834.1748319-1-jmattson@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422001834.1748319-1-jmattson@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 05:18:34PM -0700, Jim Mattson wrote:
> The only stepping of Broadwell Xeon parts is stepping 1. Fix the
> relevant isolation_ucodes[] entry, which previously enumerated
> stepping 2.
> 
> Although the original commit was characterized as an optimization, it
> is also a workaround for a correctness issue.
> 
> If a PMI arrives between kvm's call to perf_guest_get_msrs() and the
> subsequent VM-entry, a stale value for the IA32_PEBS_ENABLE MSR may be
> restored at the next VM-exit. This is because, unbeknownst to kvm, PMI
> throttling may clear bits in the IA32_PEBS_ENABLE MSR. CPUs with "PEBS
> isolation" don't suffer from this issue, because perf_guest_get_msrs()
> doesn't report the IA32_PEBS_ENABLE value.

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi
