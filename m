Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6E83DDE2F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 19:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhHBRDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 13:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhHBRDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 13:03:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BC6C061760
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 10:03:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so32606239pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 10:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ZboOedxV5HocqOHed9R2rRbrksyFeYlZ+bzi9mMGLY=;
        b=LxqcaZ5ls/BOk7qlIHclYJaTgBc2zgv0mf+NcRmW6VNMuOkd3+mRfSMmBy3x3DmtJ/
         hEPoMS+w5jwfrazMQS9fnffRSiC0ySFHteH86CjbojEfmv66jO5Er9mCohSihq/6J5de
         YzOwaTt1q40A2OKERsE7PGWVOBkk1qYHboQDXcFotsSfi+QBnm4QWsF2gCwI5SV5t4xQ
         qRkPRiISU58yhasSB3FT/dUvBzp27Fm/4bhX9nG06REZGvWsZdjtnG/iUXmqSS2/jw1l
         ClKrnmyp4qtHbS5AjfsFX60e/N/CmcR3S0LUce+QxyP1frI0B2Qb+EhkooN/y/uytWph
         iw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ZboOedxV5HocqOHed9R2rRbrksyFeYlZ+bzi9mMGLY=;
        b=ltuxtgcHEIUYPpFUIrAJ/8LCG+rDtdlnAbc+aCQ0tZNxKjS1eWM3jjpD2qc7Fg04Tc
         oXb/uOSTDbaoZpg7qQZqyq+9KYmgF39jA4IgG7bkt3t/SJd2S87K0khihvCtGh92IfvD
         Eg1adLuGcCdfjHunN/y+KI/xu3bjnchwbSt18wsGyXnpkfJIU5cpgx1SkHpkzmA0GLlE
         u3w38uEGvStxSyei964KiumBbkIHaJI4XtRaNQB79CXy2T+VP3+ywJdPi7eELxABkJoU
         FaPLYB/PmuMsRgySQQeSmKlSissbMg/MZ/Yxe4+aawAUY4rJUO+hmmxcse4e8CS43Niy
         iLzQ==
X-Gm-Message-State: AOAM5307NhEtFSzL/6DQrZXBLgdibDd4o7tWeEClEDN1qBOyrba7UYLI
        UrGbQVo2jQbMsrSJJLgicmzCEelSHnakzw==
X-Google-Smtp-Source: ABdhPJzuVMYUebwEDSBI4cgcoZX8B3pB36R84r8+jtf5HlnloTUgZf6D9ns/m8VfbywUtVzecbWQog==
X-Received: by 2002:a17:902:6904:b029:fb:42b6:e952 with SMTP id j4-20020a1709026904b02900fb42b6e952mr14857532plk.16.1627923790701;
        Mon, 02 Aug 2021 10:03:10 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t12sm544131pgo.56.2021.08.02.10.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 10:03:09 -0700 (PDT)
Date:   Mon, 2 Aug 2021 11:03:07 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 6/6] perf cs-etm: Add warnings for missing DSOs
Message-ID: <20210802170307.GA3050918@p14s>
References: <20210729155805.2830-1-james.clark@arm.com>
 <20210729155805.2830-7-james.clark@arm.com>
 <YQgGjlWtbaNApkp6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQgGjlWtbaNApkp6@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 11:51:58AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 29, 2021 at 04:58:05PM +0100, James Clark escreveu:
> > Currently decode will silently fail if no binary data is available for
> > the decode. This is made worse if only partial data is available because
> > the decode will appear to work, but any trace from that missing DSO will
> > silently not be generated.
> > 
> > Add a UI popup once if there is any data missing, and then warn in the
> > bottom left for each individual DSO that's missing.
> 
> Looks ok to me (the last 3 patches in this series, the rest I applied
> already), can I get some Acked-by/Reviewed-by from the CoreSight people?
>

I have a substantial backlog of patches to go through and I will be away for the
next two weeks.  As such it will be some time before I get to review this set.

Regards,
Mathieu

> Thanks,
> 
> - Arnaldo
>  
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/util/cs-etm.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 32ad92d3e454..e6851260d059 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -746,8 +746,16 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
> >  
> >  	len = dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
> >  
> > -	if (len <= 0)
> > +	if (len <= 0) {
> > +		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' to export data from the traced system.\n");
> > +		if (!al.map->dso->auxtrace_warned) {
> > +			pr_err("CS ETM Trace: Debug data not found for address %#"PRIx64" in %s\n",
> > +				    address,
> > +				    al.map->dso->long_name ? al.map->dso->long_name : "Unknown");
> > +			al.map->dso->auxtrace_warned = true;
> > +		}
> >  		return 0;
> > +	}
> >  
> >  	return len;
> >  }
> > -- 
> > 2.28.0
> > 
> 
> -- 
> 
> - Arnaldo
