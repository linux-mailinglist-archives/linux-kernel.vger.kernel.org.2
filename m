Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565F230EB2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhBDDsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBDDsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:48:31 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14029C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 19:47:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gx20so989009pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 19:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lxTosy4uHVRCArCakSMPHANjiXYw+5Gg+jpL1TvuwWs=;
        b=teatPvBvE1gtUas0Geg1VbWrOQ06zF6QQMg2uh4ZkriNN6acOhyACe2qOz43vMV4e9
         K/HSsiubH5Oxi+YePkXEQWUR7OS3ohfi2pXoODGQXBJz2A3djNR+6t6lXOcuiCKgyHj9
         N2JFkSSteWlA2pMfnELR36j36+16rOf7BhtNCxXLidkUSssq56hKNDsJWe8yU38sdNBM
         6Un1G7rRTCozVY3a2+fgiPcyL2Qh+R50i+T1Gh6GMMx+t/eS2lzUUPwkZ5/juX4wfUJF
         XpUoAZqekd1aSfQeoUqRvck65zSAh+igBDAoBDAYFQY7jlde3uvkdLgeU0QieJf+SMEK
         Pabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lxTosy4uHVRCArCakSMPHANjiXYw+5Gg+jpL1TvuwWs=;
        b=JInsqayVDRUUEegugVHduv7PwrPS0mhCqk+ZyN4R6ZJLeDUABTXjd7A4gQcv06rPeu
         Seo9qUHnS560erm77JxIX1snuqomAap9zzgTjDYwq5B0Z+vBc0aVn/qK4m0rpLAITR+M
         iZ8CXNMpXDQS75DzZio7dUWmSGpjWgSxwCuigtKa/PSnO+SWrfAiN4K/V51ot6mrXU1Q
         Dl/yRZv3PPDHXkm0z2160x9tFSOGZgncFg41RPmrskEZissBswK8IUoWWLhiuis4I1c9
         /xe7qBbpLSC2hrvFqGsLJfuLXvtFzEaHjkfWV7BcVGz3DXeWwddT8/67pTKgIFAag9pb
         IITQ==
X-Gm-Message-State: AOAM530CwBoCc59x8oGRqZLcygxk/Lcq7EHhza7frI9uauCOGK499Drj
        +dN0ETFZBwwgzg8S157aoL13GA==
X-Google-Smtp-Source: ABdhPJyYqjq0wXET+c8P9dHdLXiI8pxSnGiuHxBOooXeX+K4VRxecAb6E7Uk30/522c4JNv8AOk4QA==
X-Received: by 2002:a17:90a:6407:: with SMTP id g7mr6450168pjj.56.1612410470597;
        Wed, 03 Feb 2021 19:47:50 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id e20sm4357082pgr.48.2021.02.03.19.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:47:49 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:47:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] perf cs-etm: Add helper cs_etm__get_pid_fmt()
Message-ID: <20210204034743.GE11059@leoy-ThinkPad-X240s>
References: <20210202163842.134734-1-leo.yan@linaro.org>
 <20210202163842.134734-6-leo.yan@linaro.org>
 <51a1e845-f9a4-3c6e-88a2-c105f5b5adfe@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a1e845-f9a4-3c6e-88a2-c105f5b5adfe@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 11:19:22PM +0000, Suzuki Kuruppassery Poulose wrote:
> On 2/2/21 4:38 PM, Leo Yan wrote:
> > This patch adds helper function cs_etm__get_pid_fmt(), by passing
> > parameter "traceID", it returns the PID format.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >   tools/perf/util/cs-etm.c | 43 ++++++++++++++++++++++++++++++++++++++++
> >   tools/perf/util/cs-etm.h |  1 +
> >   2 files changed, 44 insertions(+)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index a2a369e2fbb6..8194ddbd01e5 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -7,6 +7,7 @@
> >    */
> >   #include <linux/bitops.h>
> > +#include <linux/coresight-pmu.h>
> >   #include <linux/err.h>
> >   #include <linux/kernel.h>
> >   #include <linux/log2.h>
> > @@ -156,6 +157,48 @@ int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
> >   	return 0;
> >   }
> > +/*
> > + * The returned PID format is presented by two bits:
> > + *
> > + *   Bit ETM_OPT_CTXTID: CONTEXTIDR or CONTEXTIDR_EL1 is traced;
> > + *   Bit ETM_OPT_CTXTID2: CONTEXTIDR_EL2 is traced.
> > + *
> > + * It's possible that these two bits are set together, this means the tracing
> > + * contains PIDs for both CONTEXTIDR_EL1 and CONTEXTIDR_EL2.
> 
> This is a bit confusing. If both the bits are set, the session
> was run on an EL2 kernel. Thus, the PID is always in CONTEXTIDR_EL2.

Sorry for confusion.  I'd like to rephrase as:

It's possible that the two bits ETM_OPT_CTXTID and ETM_OPT_CTXTID2 are
enabled at the same time when the session runs on an EL2 kernel.  This
means the CONTEXTIDR_EL1 and CONTEXTIDR_EL2 both will be recorded in
the trace data, the tool will selectively use CONTEXTIDR_EL2 as PID.

> > + */
> > +int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
> > +{
> > +	struct int_node *inode;
> > +	u64 *metadata, val;
> > +
> > +	inode = intlist__find(traceid_list, trace_chan_id);
> > +	if (!inode)
> > +		return -EINVAL;
> > +
> > +	metadata = inode->priv;
> > +
> > +	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
> > +		val = metadata[CS_ETM_ETMCR];
> > +		/* CONTEXTIDR is traced */
> > +		if (val & BIT(ETM_OPT_CTXTID))
> > +			*pid_fmt = BIT(ETM_OPT_CTXTID);
> > +	} else {
> > +		val = metadata[CS_ETMV4_TRCCONFIGR];
> > +
> > +		*pid_fmt = 0;
> > +
> > +		/* CONTEXTIDR_EL2 is traced */
> > +		if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
> > +			*pid_fmt = BIT(ETM_OPT_CTXTID2);
> > +
> > +		/* CONTEXTIDR_EL1 is traced */
> > +		if (val & BIT(ETM4_CFG_BIT_CTXTID))
> 
> I haven't looked at how this gets used. But, Shouldn't this be :
> 
> 		else if (val & BIT(ETM4_CFG_BIT_CTXTID)) ?

Actually it's deliberately to set both bits ETM_OPT_CTXTID2 and
ETM_OPT_CTXTID if user has enable configs "contextid1" and
"contextid2".  So this is exactly the reversed flow in the
function cs_etmv4_get_config().

Thanks,
Leo
