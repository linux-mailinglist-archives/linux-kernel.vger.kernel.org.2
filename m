Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A73030F73C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbhBDQHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:07:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:2815 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237709AbhBDQFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:05:15 -0500
IronPort-SDR: 5YyjVe+a0W1Gv/PZNsp/ioUQwdf2LUgNBykqZYtDGHzVe0Z53qdUANcTPyOaVdphc32kIaYy5n
 vBzYO91rqIYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="245339446"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="245339446"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 08:04:31 -0800
IronPort-SDR: jFu/b9xE0nNDZadsgL3rNRAQkJYq5wt30uuBlG9f+S7rZIwAGMoYvrkatYzGhhPE2ghOZdQBjM
 eJCXA8r6StaQ==
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="415415716"
Received: from clai1-mobl.ccr.corp.intel.com ([10.249.171.226])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 08:04:27 -0800
Message-ID: <45cbb7f18765cf7365e5eaa1358727201fc1f4bf.camel@intel.com>
Subject: Re: [PATCH 3/3] perf/x86/rapl: Fix psys-energy event on Intel SPR
 platform
From:   Zhang Rui <rui.zhang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
Date:   Fri, 05 Feb 2021 00:04:25 +0800
In-Reply-To: <YBq3csfKeH7PaK39@hirez.programming.kicks-ass.net>
References: <20210115092208.20866-1-rui.zhang@intel.com>
         <20210115092208.20866-3-rui.zhang@intel.com>
         <YALhAmTgMHxEgeG4@hirez.programming.kicks-ass.net>
         <70b71922e7f84234be70c7104969331f@intel.com>
         <03e5815f89d749a18b47bdf986181f1f@intel.com>
         <YBq3csfKeH7PaK39@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

On Wed, 2021-02-03 at 15:47 +0100, Peter Zijlstra wrote:
> FWIW, your email is malformed, please wrap at 78 chars.
> 
> On Mon, Jan 25, 2021 at 06:11:14AM +0000, Zhang, Rui wrote:
> > In short, the current code does not allow RAPL energy counter to
> > return 0. And all the work I do is to allow Psys energy counter to
> > return 0.
> 
> Ok.
> 
> > In this way, the Psys event is "valid" on all CPUs, so we don't
> > need
> > to handle the master thing.
> 
> So RAPL is mapped to DIEs, and IIRC we can have multiple DIEs per
> Package. But the master thing is a Package.
> 
> Is this all moot because SPR has one DIE per Package?

Oh, right.
This is not a problem on SPR because it is a single-die
platform.

>  Because if it
> would have more, there's be more interesting problems I suppose.

Agreed.

thanks,
rui

