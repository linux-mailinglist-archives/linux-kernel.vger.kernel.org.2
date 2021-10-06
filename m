Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04744243CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbhJFRRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239279AbhJFRRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:17:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF651C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 10:15:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m14so2929643pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zBXu2PPudHr4jGx/bUfAke+K270eym5QryyQHVT40do=;
        b=B9RyGZNBvCE3FUDzTd8Uh2TgtofVdgKkU63KSe6cdjb5Q039fjbgjGbbA34g5gGYOk
         FX1qAhDSZH9F4FYTvAWiOdvjgKGvmrVEaQBaRqRKFnOeIrrPYfH5rhPR000MbxDYcNTO
         pE2zSI6ZH1HoGL4Rp1ffyW3EGn1mi+ofRaCDxOHmF0Ua3C1Xx0bIAkvgaFiMaTAFl32y
         RnCwsg0qWfl8HZLU9+CUnj8TNc6wCtbNIL8JtWESD/Lb81gAk97Cu+ZYgngyQsfSoKuJ
         4jrgfkyfqJdohRu+dmfEU6x/s7eu0Hq8ztBL1TN7OCPVcCLZqVGFtYk0JZQKnnBdffh/
         k38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zBXu2PPudHr4jGx/bUfAke+K270eym5QryyQHVT40do=;
        b=450HJ24mSsmrZXZsHsYPYQFIRQWAvxq2ysfj9HniymtrbWqPzwXZFDmdoGBtzIoq/d
         1gkBZdrp7SDttOr/HWVqyw0qN83snWQWCCHt+SkgALDMNyyG7Wq4G7fFbEQ0GtwmdzIi
         YZ+lDV2MUYFgNcVKH3CJ1/DOunW0kSppN/ZqUR3n2Nlz5R960DosS7APzHY4tOZ1fN2n
         KYFnoFHEJUgRudOWGgaedtEmlRXRh+24ebEagHDjzNT9NquQ/RwcX+WFWxvdLjMEt6d9
         aM/A1GiR/Vd4y6I+mHxuLtOxRTF5LU56LnSny4xvMPmtOhvCsD+6kQVG2KFZApzemPXo
         DS1w==
X-Gm-Message-State: AOAM533p90ZMQ/EgiRerFFuxmwFFVJS+pyuMpIFIwuIsRSDZ2SZmazjE
        vvxuc27oPeoLTqvbhJIkgCbA9A==
X-Google-Smtp-Source: ABdhPJwWcl8/bVafg9x6S6RAD8X+P5BOk98PsQyQ4b2chMdjIC2Q2I8t4ZVe0u/liE8SdpE7Hy3JzQ==
X-Received: by 2002:aa7:9287:0:b0:44c:767e:4e71 with SMTP id j7-20020aa79287000000b0044c767e4e71mr12317426pfa.76.1633540540347;
        Wed, 06 Oct 2021 10:15:40 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b14sm9339589pfo.127.2021.10.06.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 10:15:38 -0700 (PDT)
Date:   Wed, 6 Oct 2021 11:15:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 12/17] coresight: trbe: Add a helper to fetch cpudata
 from perf handle
Message-ID: <20211006171536.GA3373323@p14s>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-13-suzuki.poulose@arm.com>
 <20211004174239.GB3263478@p14s>
 <0ff450f4-ab3e-b409-5278-35cdfb883284@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ff450f4-ab3e-b409-5278-35cdfb883284@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 11:35:13PM +0100, Suzuki K Poulose wrote:
> Hi Mathieu
> 
> On 04/10/2021 18:42, Mathieu Poirier wrote:
> > On Tue, Sep 21, 2021 at 02:41:16PM +0100, Suzuki K Poulose wrote:
> > > Add a helper to get the CPU specific data for TRBE instance, from
> > > a given perf handle. This also adds extra checks to make sure that
> > > the event associated with the handle is "bound" to the CPU and is
> > > active on the TRBE.
> > > 
> > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Leo Yan <leo.yan@linaro.org>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   drivers/hwtracing/coresight/coresight-trbe.c | 12 ++++++++++--
> > >   1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> > > index 983dd5039e52..797d978f9fa7 100644
> > > --- a/drivers/hwtracing/coresight/coresight-trbe.c
> > > +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> > > @@ -268,6 +268,15 @@ static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
> > >   	return buf->nr_pages * PAGE_SIZE;
> > >   }
> > > +static inline struct trbe_cpudata *
> > > +trbe_handle_to_cpudata(struct perf_output_handle *handle)
> > > +{
> > > +	struct trbe_buf *buf = etm_perf_sink_config(handle);
> > > +
> > > +	BUG_ON(!buf || !buf->cpudata);
> > > +	return buf->cpudata;
> > > +}
> > > +
> > >   /*
> > >    * TRBE Limit Calculation
> > >    *
> > > @@ -533,8 +542,7 @@ static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *hand
> > >   {
> > >   	int ec = get_trbe_ec(trbsr);
> > >   	int bsc = get_trbe_bsc(trbsr);
> > > -	struct trbe_buf *buf = etm_perf_sink_config(handle);
> > > -	struct trbe_cpudata *cpudata = buf->cpudata;
> > > +	struct trbe_cpudata *cpudata = trbe_handle_to_cpudata(handle);
> > 
> > There is two other places where this pattern is present:  is_perf_trbe() and
> > __trbe_normal_offset().
> 
> I skipped them, as they have to get access to the "trbe_buf" anyways.
> So the step by step, made sense. But I could replace them too to make it
> transparent.
> 
> What do you think ?

Humm...  I don't think there is a right way or a wrong way here.  If we move
forward with this patchset we have two ways of getting to buf->cpudata.  One
using trbe_handle_to_cpudata() and another one as laid out in is_perf_trbe() and
__trbe_normal_offset(), each with an equal number of occurences (2 for each).

I am usually not fond of small functions like trbe_handle_to_cpudata() and to me
keeping the current heuristic in trbe_get_fault_act() would have been just fine.
I agree with the argument that trbe_handle_to_cpudata() provides more checks but
is it really worth it if they aren't done everywhere?

In short I would get rid of trbe_handle_to_cpudata() entirely and live without
the extra checks... But I'm not strongly opinionated on this either.

> 
> Suzuki
> 
> 
