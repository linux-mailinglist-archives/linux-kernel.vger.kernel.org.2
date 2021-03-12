Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21379338201
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 01:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhCLAB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 19:01:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:58712 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhCLABG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 19:01:06 -0500
IronPort-SDR: mujmVT32dxpEXr6yKJnk755ujQACcVUb1Ekg8A2eQwqGwY5T8+offAyhuiUUWgDjZXSYds6Cxx
 YWIiWkWWJnQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="208588355"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="208588355"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 16:01:01 -0800
IronPort-SDR: xJSMY90mQMvQrcPIAb1rgQ5L7D/hEi7OSWYSUb7b8Vw6TEJWDQFds2RDXJ+o6IZ6fpkqHg3uuP
 kjnzW+f91mTQ==
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="370717624"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 16:01:00 -0800
Date:   Thu, 11 Mar 2021 16:00:59 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
Message-ID: <20210312000059.GM203350@tassilo.jf.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
 <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
 <01176076-049b-0129-4865-8c49cd002060@linux.intel.com>
 <20210311195832.GK4746@worktop.programming.kicks-ass.net>
 <400dbd6e-389c-899d-6d11-14b5a8f8f90e@linux.intel.com>
 <20210311204742.GM4746@worktop.programming.kicks-ass.net>
 <a606211b5b454ef5b658858e0cb361f0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a606211b5b454ef5b658858e0cb361f0@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you want a uarch name, that might be the name of the core
> (.... something-cove ... I can't keep track of the names of all the

GoldenCove for Sapphire Rapids/AlderLake.

But keep in mind that they're still different. Kind of like a different
distro with different patches and configuration from the same base kernel
release.

-Andi
