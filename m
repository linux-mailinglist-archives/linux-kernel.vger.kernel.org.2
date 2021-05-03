Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162CB372013
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhECTBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhECTBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:01:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4872961153;
        Mon,  3 May 2021 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620068425;
        bh=7e742zsoPr1tYdh6ay1S632cp/o0IVi8RKQ+w0cqQ30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIx0igrWplWAdJWc+zHHHZHbG/BZy+8aw5Ao+zV8wxJGp4+anPpIA/fYHOo9zZaqQ
         AS51u2l0hHg8ryQ0rL8pnmEN5vNAx/KPQvFCOmFhPGP96bKjcdNfeXJ82WAjIPenHa
         YLmfBgx1DH/oN8QlU5tBmjIO1nMukAPI0MiFMmdaLvt47PEdLbx3LK8x/0XheecCdQ
         prH2UHMJkH45O/PWXSylxMyZQo+YIaXTT8u1RxXYmPU0QnqnkYHOvfvtBi3P9axBaT
         60txUXzeGrTZvcf7sXOPUfiAk0vEK2tlCq0hGp32eX44pePC9CnstCexRDezeSUEPZ
         iPtAoNtshFPNw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3D4D141084; Mon,  3 May 2021 16:00:22 -0300 (-03)
Date:   Mon, 3 May 2021 16:00:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Set timestamp boundary for AUX area events
Message-ID: <YJBIRoRZ9WKvELQc@kernel.org>
References: <20210503064222.5319-1-adrian.hunter@intel.com>
 <20210503145637.GN4032392@tassilo.jf.intel.com>
 <fecadda6-b708-f7c8-ca9a-3521f168727e@intel.com>
 <20210503161131.GO4032392@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503161131.GO4032392@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 03, 2021 at 09:11:31AM -0700, Andi Kleen escreveu:
> On Mon, May 03, 2021 at 06:06:38PM +0300, Adrian Hunter wrote:
> > On 3/05/21 5:56 pm, Andi Kleen wrote:
> > > On Mon, May 03, 2021 at 09:42:22AM +0300, Adrian Hunter wrote:
> > >> AUX area data is not processed by 'perf record' and consequently the
> > >>  --timestamp-boundary option may result in no values for "time of first
> > >> sample" and "time of last sample". However there are non-sample events
> > >> that can be used instead, namely 'itrace_start' and 'aux'.
> > 
> > "instead" -> "as well"
> > 
> > >> 'itrace_start' is issued before tracing starts, and 'aux' is issued
> > >> every time data is ready.
> > > 
> > > Hmm, what happens when some other non PT events are in the same perf record?
> > 
> > The sample timestamps are still processed, so the lowest sample timestamp or
> > 'itrace_start' timestamp or 'aux' timestamp is the start.  Similarly for the end.
> > 
> > > And those maybe run at different times than PT (e.g. due to some PT specific
> > > filter).  Does this all work correctly then?
> > 
> > The broadest range is used
> 
> Ok makes sense.
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo

