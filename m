Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B22837173D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhECO5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:57:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:46980 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhECO5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:57:32 -0400
IronPort-SDR: KxQsdmD2Xnw4wMDFHhAUWP77swj1/8kOj8ZF2nFfV88aGbX6KHyuiGjTenA0wdS1ekxWWAOHww
 VRAsOckh+nIw==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="194614527"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="194614527"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 07:56:39 -0700
IronPort-SDR: RE/xa3+o+iHwkdx65ezadGIgFW85JCcG0zwz3wNxR5kLyBF+8N0Db864L+r0AY+adPMo8sJ5pN
 mL4Pr4mXBz1w==
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="428397588"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 07:56:39 -0700
Date:   Mon, 3 May 2021 07:56:37 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Set timestamp boundary for AUX area events
Message-ID: <20210503145637.GN4032392@tassilo.jf.intel.com>
References: <20210503064222.5319-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503064222.5319-1-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 09:42:22AM +0300, Adrian Hunter wrote:
> AUX area data is not processed by 'perf record' and consequently the
>  --timestamp-boundary option may result in no values for "time of first
> sample" and "time of last sample". However there are non-sample events
> that can be used instead, namely 'itrace_start' and 'aux'.
> 'itrace_start' is issued before tracing starts, and 'aux' is issued
> every time data is ready.

Hmm, what happens when some other non PT events are in the same perf record?
And those maybe run at different times than PT (e.g. due to some PT specific
filter).  Does this all work correctly then?

-Andi
