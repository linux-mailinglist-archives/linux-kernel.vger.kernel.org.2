Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B797236BEB8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 07:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhD0FGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 01:06:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:47491 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhD0FGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 01:06:12 -0400
IronPort-SDR: ZHINgRvIvUPrryatzBmaWFqxGDwyHIO+0FmKI+Hb1DFIIUtYUi6qD0gqKLotydNbW/dJd5wgpQ
 W5sQZdI+LhbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="183931154"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="183931154"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 22:05:29 -0700
IronPort-SDR: uWKj6QalGfNM4aCZHWccoR+y5vQYHoGqCJIP/auoV3Chbfb201zdFkqVtO8JXGfnLJDTOpLnXH
 rK8MZr/ZFCHA==
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="465360526"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 22:05:29 -0700
Date:   Mon, 26 Apr 2021 22:05:27 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET v2 0/6] perf report: Make --stat output more compact
Message-ID: <20210427050527.GC1401198@tassilo.jf.intel.com>
References: <20210427013717.1651674-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427013717.1651674-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 06:37:11PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This patchset changes the output of perf report --stat.
> 
> Changes from v1)
>  * fix build error in TUI  (Jiri)
>  * print percentage of each event  (Andi)

Looks all good to me.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

