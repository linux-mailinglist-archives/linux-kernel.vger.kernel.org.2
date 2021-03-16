Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23FB33DE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 21:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbhCPUC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 16:02:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:30147 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233365AbhCPUCY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:02:24 -0400
IronPort-SDR: mAL3/3DHLQLyM4Ax9ZcXk07ub4wHBR6QPMUIQKGYo+yhk8UXk6HePZT3xDxPTfcwCSN8WrFVdO
 wmfgjRReqp6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="188685489"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="188685489"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 13:02:22 -0700
IronPort-SDR: 7q8GXH0Cb8r7fPgcGsMxprm8FTLZVst1P+yIdCqiAzW7QHFtakMXUH/dX1F7c5SKOdGXgsiAOb
 U6aF9zoUrRMw==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="405652944"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 13:02:22 -0700
Date:   Tue, 16 Mar 2021 13:02:20 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Align CSV output for summary mode
Message-ID: <20210316200220.GS203350@tassilo.jf.intel.com>
References: <20210316072900.1739-1-yao.jin@linux.intel.com>
 <YFCtfXlaKbIeEMwk@krava>
 <20210316163421.GQ203350@tassilo.jf.intel.com>
 <YFEBaVNDokSVW/34@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFEBaVNDokSVW/34@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 04:05:13PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 16, 2021 at 09:34:21AM -0700, Andi Kleen escreveu:
> > > looks ok, but maybe make the option more related to CVS, like:
> > > 
> > >   --x-summary, --cvs-summary  ...? 
> > 
> > Actually I don't think it should be a new option. I doubt
> > anyone could parse the previous mess. So just make it default
> > with -x
> 
> In these cases I always fear that people are already parsing that mess
> by considering the summary lines to be the ones not starting with
> spaces, and now we go on and change it to be "better" by prefixing it
> with "summary" and... break existing scripts.

I think it was just one version or so?

FWIW perf has broken CSV output several times, I added workarounds
to toplev every time. Having a broken version for a short time
shouldn't be too bad.

I actually had a workaround for this one, but it can parse either way.

> 
> Can we do this with a new option?
> 
> I.e. like --cvs-summary?

If you do it I would add an option for the old broken format
--i-want-broken-csv. But not  require the option forever
just to get sane output.

Or maybe only a perf config option.

-Andi
