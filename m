Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCF141F0FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354864AbhJAPRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354697AbhJAPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:17:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C1EC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 08:15:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v19so6761177pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l0r4netubFvOqdQPmMihaq0gB5gJKAXHwXi2ci7RWwY=;
        b=WzHm4P1jQ1kmiIBqiL7BVSNsyIvbqk3ITF8ZFoWdQsx8sXwLHwj2Fpkjjc74sf6kcj
         d1uxbaOpF1ga2DXCTlqIwZXwngBw3pZjnDm5Aay5k7aKt6apPyRymeWKex2HeoG55ykh
         +SZzCQLVtXwj0JvqT01DIJGYjQ3GcyPw6gz/g20bDRQViEGEKUhqpMI55Da5tYUZIQcV
         M5llvqrHA4xcjqpIZ3t5J4SifqUZ0RLgb87//+y+nhW0khgpqUAPITNkaQLrtajhXtxZ
         lKdCAm9tz018H5o5IQbDXFcYRmFTiesvxs0RrtlpGDd8ac9jkT74WUqkLM0M+8JH3cVx
         hmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l0r4netubFvOqdQPmMihaq0gB5gJKAXHwXi2ci7RWwY=;
        b=Cv9nIcrDluSEJb2Refs1hSs6VW5pOQXDAiissye8+krVitdfVInmtt9sD+gGs6DAO/
         ry1lKDdO2ToB5PoENcWIGUk/278QRZpo+k4jWdMwrOz9NFX8o+ugLZJ+TR2deQ5pV0eM
         mbQbc6vZMceaJu19btsWE80KdBekAMWaDf0O1xQaslrGH3ngChOOvIc2rkvWuttAsMd9
         gTosjvLKJSsgGAiUXnYYeuXtKHxFazDTkTU+EmpcZ+Jb2lTbQgIT+vE5WabVsVvVeZ4W
         QVWLT2WuMnHbHneGMMvcqQdfY5CwU5pRW94/AhOfVS5PpHmSLl5DuSQgiOFFjQYxZi3d
         Z34A==
X-Gm-Message-State: AOAM531LA+ZXy091RHwQrsQ15y5KFGaJW/RWeYaxa+mQK/YvrmrETdpZ
        CaaL4FlB9IqiL+L7o5DIOF1iFw==
X-Google-Smtp-Source: ABdhPJz75J1Di7bjteoBGclmYDhxkHtOMW/oRikQ9t9SOYZK/B89jbOXn3CPkDkAsmC1Vyw7COr+Qw==
X-Received: by 2002:a17:90a:1b2a:: with SMTP id q39mr13779510pjq.219.1633101338582;
        Fri, 01 Oct 2021 08:15:38 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g3sm6531540pgj.66.2021.10.01.08.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 08:15:37 -0700 (PDT)
Date:   Fri, 1 Oct 2021 09:15:35 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 03/17] coresight: trbe: Add a helper to calculate the
 trace generated
Message-ID: <20211001151535.GA3148492@p14s>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-4-suzuki.poulose@arm.com>
 <20210930175421.GB3047827@p14s>
 <60037d18-9d0e-68ce-2a34-aa84e7876fb8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60037d18-9d0e-68ce-2a34-aa84e7876fb8@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 09:36:24AM +0100, Suzuki K Poulose wrote:
> On 30/09/2021 18:54, Mathieu Poirier wrote:
> > Hi Suzuki,
> > 
> > On Tue, Sep 21, 2021 at 02:41:07PM +0100, Suzuki K Poulose wrote:
> > > We collect the trace from the TRBE on FILL event from IRQ context
> > > and when via update_buffer(), when the event is stopped. Let us
> > 
> > s/"and when via"/"and via"
> > 
> > > consolidate how we calculate the trace generated into a helper.
> > > 
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Cc: Leo Yan <leo.yan@linaro.org>
> > > Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   drivers/hwtracing/coresight/coresight-trbe.c | 48 ++++++++++++--------
> > >   1 file changed, 30 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> > > index 63f7edd5fd1f..063c4505a203 100644
> > > --- a/drivers/hwtracing/coresight/coresight-trbe.c
> > > +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> > > @@ -527,6 +527,30 @@ static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
> > >   	return TRBE_FAULT_ACT_SPURIOUS;
> > >   }
> > > +static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
> > > +					 struct trbe_buf *buf,
> > > +					 bool wrap)
> > 
> > Stacking
> > 
> 
> Ack
> 
> > > +{
> > > +	u64 write;
> > > +	u64 start_off, end_off;
> > > +
> > > +	/*
> > > +	 * If the TRBE has wrapped around the write pointer has
> > > +	 * wrapped and should be treated as limit.
> > > +	 */
> > > +	if (wrap)
> > > +		write = get_trbe_limit_pointer();
> > > +	else
> > > +		write = get_trbe_write_pointer();
> > > +
> > > +	end_off = write - buf->trbe_base;
> > 
> > In both arm_trbe_alloc_buffer() and trbe_handle_overflow() the base address is
> > acquired using get_trbe_base_pointer() but here it is referenced directly - any
> > reason for that?  It certainly makes reviewing this simple patch quite
> > difficult because I keep wondering if I am missing something subtle...
> 
> Very good observation. So far, we always prgrammed the TRBBASER with the
> the VA(ring_buffer[0]). And thus reading the BASER and using the
> buf->trbe_base is all fine.
> 
> But going forward, we are going to use different values for the TRBBASER
> to work around erratum. Thus to make the computation of the "offsets"
> within the ring buffer, it is always correct to use this field. I could
> move this to the patch where the work around is introduced, and put in
> a comment there.

That will be greatly appreciated.

> 
> Thanks for the review
> 
> Suzuki
> 
