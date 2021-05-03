Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADFC3718F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhECQMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 12:12:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:8027 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhECQMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:12:30 -0400
IronPort-SDR: xxxxGNak+jXBeRGIpAsUbIXSrOLD+66IbBlygtSz7kvg07XRh/HOiX8jsiNRYtR+WrWKlIG3G9
 qHokUWo9QSwg==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="177309170"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="177309170"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 09:11:32 -0700
IronPort-SDR: MRr6RAn0sRrfcata57+uSIRXTIEQTYpmLf8KRdcZfSDTqVs3dnZbjjJ1J0XxtmFp5wl4iAcvPa
 CNrWFpHIQQjg==
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="462637585"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 09:11:32 -0700
Date:   Mon, 3 May 2021 09:11:31 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Set timestamp boundary for AUX area events
Message-ID: <20210503161131.GO4032392@tassilo.jf.intel.com>
References: <20210503064222.5319-1-adrian.hunter@intel.com>
 <20210503145637.GN4032392@tassilo.jf.intel.com>
 <fecadda6-b708-f7c8-ca9a-3521f168727e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fecadda6-b708-f7c8-ca9a-3521f168727e@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 06:06:38PM +0300, Adrian Hunter wrote:
> On 3/05/21 5:56 pm, Andi Kleen wrote:
> > On Mon, May 03, 2021 at 09:42:22AM +0300, Adrian Hunter wrote:
> >> AUX area data is not processed by 'perf record' and consequently the
> >>  --timestamp-boundary option may result in no values for "time of first
> >> sample" and "time of last sample". However there are non-sample events
> >> that can be used instead, namely 'itrace_start' and 'aux'.
> 
> "instead" -> "as well"
> 
> >> 'itrace_start' is issued before tracing starts, and 'aux' is issued
> >> every time data is ready.
> > 
> > Hmm, what happens when some other non PT events are in the same perf record?
> 
> The sample timestamps are still processed, so the lowest sample timestamp or
> 'itrace_start' timestamp or 'aux' timestamp is the start.  Similarly for the end.
> 
> > And those maybe run at different times than PT (e.g. due to some PT specific
> > filter).  Does this all work correctly then?
> 
> The broadest range is used

Ok makes sense.

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi

