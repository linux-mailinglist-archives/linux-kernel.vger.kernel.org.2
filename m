Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1383FF2D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346587AbhIBRt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhIBRtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:49:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397FFC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:48:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s11so2753194pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hNMj/GicbHDFoe73cuJ4lNnx/NF5xDyfqRaOX+0Ci3Q=;
        b=YShTlSP5CUXu2We9BopCbUcCPNZXUdTFfKWhV4htP+zKgUKw6SQWmMmr5ZjeGdFHDV
         7uX6cKtkMatsuhF8Ecl/WvB/A7iciMIXtay5u7BoeX9xnPSLAHF2p4KPtx4hX2vthj7Y
         TcY5s2WT7NRCIDuluN2GZoemDddljML2ONQgcNBtOlxmpkBw7flChnRBANjCBeFd8rZt
         9G7ebYuTa6D2TPziyfFuh4uRDZ8LkJK1PmW5S/gjUlfVAsHwXcZWpdKNC9whCUqer3S0
         vC7xc/c9xRVt08Rjn0BWf9hsGwiQpgiKRfNof18GNBLv8lwjaJYFN6SaRMAGnZ1MM3Xh
         IRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hNMj/GicbHDFoe73cuJ4lNnx/NF5xDyfqRaOX+0Ci3Q=;
        b=F2xHFrHU/cbLg4HWK5lSco+AHZW1fIZtGTYAdYb87rUOKGqODv5q9ICZTZHEwxTjoQ
         3xkRe9YxfoxiAryy8u5os/X9atBbTahsegf6oO/TnOu9doFGJzE2OgTBjQ9/Nv3a7yKj
         nLTG5uxVRXnpFZIB7ObMCW2QCsz2yfdkmjwY2cqYzKB2S1UjolCrZdyDRQq+V7AjYXgh
         ycyCv7Y+GleHDYS+vJiTB/7QYPzbrXh9BVQNsBsSH0Krioln92K1RIiu/w09B9rG7VUb
         Mve7Nl/+yDhu/JeI1SpiKTRgatL+OAuHfRPpIVZ5ZIsbcfoxNLQqqZWXlNU6TCmcCwYv
         0ZZA==
X-Gm-Message-State: AOAM533xf9MVoX7bfv+2uw5EXAGABekgHD7WdE1CPQNGoLQCTvRWylCw
        w4XdXfri1VCr829/aZFZrFyj1Q==
X-Google-Smtp-Source: ABdhPJxUFxkuiACE9bx35iXYuvJBCCP8PZUF5Ehxs+TdgCLps7x4MSNrX5ZkupyqJ2RSAO/KXxMp5Q==
X-Received: by 2002:a05:6a00:26cb:b0:408:f3b8:bdad with SMTP id p11-20020a056a0026cb00b00408f3b8bdadmr4649004pfw.48.1630604934637;
        Thu, 02 Sep 2021 10:48:54 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b17sm3470956pgl.61.2021.09.02.10.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 10:48:53 -0700 (PDT)
Date:   Thu, 2 Sep 2021 11:48:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] perf cs-etm: Show a warning for an unknown magic
 number
Message-ID: <20210902174851.GB1078000@p14s>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-10-james.clark@arm.com>
 <20210824083615.GF204566@leoy-ThinkPad-X240s>
 <YS+iOrcPTzQfmbqU@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS+iOrcPTzQfmbqU@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Sep 01, 2021 at 12:54:34PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 24, 2021 at 04:36:15PM +0800, Leo Yan escreveu:
> > On Fri, Aug 06, 2021 at 02:41:09PM +0100, James Clark wrote:
> > > Currently perf reports "Cannot allocate memory" which isn't very helpful
> > > for a potentially user facing issue. If we add a new magic number in
> > > the future, perf will be able to report unrecognised magic numbers.
> > > 
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > 
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> Applies cleanly to my tree, test building it now, holler if there is
> something that prevents it from being merged.

Have you already merged this? 

If so than let it be.  Otherwise please hold off as I'd like to take a look,
something I intend on doing next week.

Thanks,
Mathieu

> - Arnaldo
>  
> > > ---
> > >  tools/perf/util/cs-etm.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > index 788ad5a099f6..5b276bdb96a6 100644
> > > --- a/tools/perf/util/cs-etm.c
> > > +++ b/tools/perf/util/cs-etm.c
> > > @@ -2973,6 +2973,11 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> > >  
> > >  			/* ETE shares first part of metadata with ETMv4 */
> > >  			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> > > +		} else {
> > > +			ui__error("CS ETM Trace: Unrecognised magic number %#"PRIx64". File could be from a newer version of perf.\n",
> > > +				  ptr[i]);
> > > +			err = -EINVAL;
> > > +			goto err_free_metadata;
> > >  		}
> > >  
> > >  		if (!metadata[j]) {
> > > -- 
> > > 2.28.0
> > > 
> 
> -- 
> 
> - Arnaldo
