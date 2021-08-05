Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC813E1359
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbhHEK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhHEK7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:59:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016F8C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 03:59:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so13794590pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=31wHV3k4OdqroTKePjUTotq6cHm90H/l7isQSu9I3mQ=;
        b=UVg0o3Dq+LIsAEv2uGRdOXFlsXHXH78Oos0ipXcwmv8NucK2/DwxeAgf+m3SlkEuZY
         4tzXbhlusZeGUcuzNcVdWF23L62eH/sIFOjHgmVs6hAmwETVFlP1lV3ws4fCe7s8nh/P
         U61wr/wDXVaSJKdyi5si93afqoO1NR9j1w03s84MVBik9lvyIigZF//ufhn3bYf7fAqI
         yF2aliJguBQ6fFvMAPzae2TsEgn8Du1jDq6cViVEtAMEJiNmOkXQqGOPVAmACUO6Xred
         +FTubQdYRPMZH3rrdOO10nolo275CtjHWDw81zL5z8b/xt4Sh/l2GJ20kIKfFXDAmZ6e
         byLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=31wHV3k4OdqroTKePjUTotq6cHm90H/l7isQSu9I3mQ=;
        b=nxCFn6YHRtMfWXLDFNeve+HnR91xZkA+WfL4dNEZVRDnDRcrMp9B2buH3+HY5G3A05
         W3MTKWJNRf0krYyu6QMnUNKEApbYPg3E2+PqZjtgCxDESn8n3yWMR9/1+T5PeJDUu7Ot
         GunKHjmwgUtOQehD0aF5t1jjNhbT4FoTPFwRAL5HThiJknigM+Sgs/rFMYHn+kHBATOi
         24as7oWEAvBhoJZxN3n7wAcumXGSfHlEgUOae01um+vgCEu9yNwIvHUxnCX48+ZtPLde
         lxC4tYZx9PQzwc8Z01Pko+cWcUU/0MEQ3+H/b+VA1p/JRar6WpY4S/eJsbrw15U4BNkb
         EeFw==
X-Gm-Message-State: AOAM531Bb0ou86EzdbvmSwKWBbTRba5xD3f54jWccmDpGKFY8sGz7rQ+
        NHBlH1BNJm9qJKl3ZRydpQgnWw==
X-Google-Smtp-Source: ABdhPJy4GX8AlScXr0EhwPw/Y1CY7MoxWD+tSDBVhOh/m82Ukd6RvOIJJU0ctRZE20HMuwXCRqcE0g==
X-Received: by 2002:a05:6a00:704:b029:39e:3043:ec64 with SMTP id 4-20020a056a000704b029039e3043ec64mr4483509pfl.68.1628161176325;
        Thu, 05 Aug 2021 03:59:36 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id y9sm7399800pgr.10.2021.08.05.03.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:59:35 -0700 (PDT)
Date:   Thu, 5 Aug 2021 18:59:26 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, acme@kernel.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        al.grant@arm.com, anshuman.khandual@arm.com, mike.leach@linaro.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/6] perf cs-etm: Create ETE decoder
Message-ID: <20210805105926.GA22454@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-6-james.clark@arm.com>
 <20210731072341.GE7437@leoy-ThinkPad-X240s>
 <654cf3ae-325b-49c9-a9d0-ebf704a83d6f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <654cf3ae-325b-49c9-a9d0-ebf704a83d6f@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 02:09:38PM +0100, James Clark wrote:

[...]

> >> -static enum _ocsd_arch_version cs_etm_decoder__get_arch_ver(u32 reg_idr1)
> >> +static enum _ocsd_arch_version cs_etm_decoder__get_arch_ver(u32 reg_idr1, u32 reg_devarch)
> >>  {
> >> +	/* ETE has to be v9 so set arch version to v8.3+ (ARCH__AA64) */
> >> +	if (cs_etm__is_ete(reg_devarch))
> >> +		return ARCH_AA64;
> >> +
> > 
> > Based on values used in below change, I think we can unify the ETM
> > versio number like:
> > 
> >   ARCH_V8R3 : REVISION, bits[19:16] is 0x3
> >   ARCH_V8R4 : REVISION, bits[19:16] is 0x4
> >   ARCH_V8R5 : REVISION, bits[19:16] is 0x5
> 
> Do you mean make this change in OpenCSD? At the moment it understands these
> values so I'm not sure if the extra ones would be useful:

Yes.  As Mike said, these new macros will cause big changes in OpenCSD,
so I don't have strong opinion to add more macros for tracer versions.

> >> +struct cs_ete_trace_params {
> >> +	struct cs_etmv4_trace_params base_params;
> >> +	u32 reg_devarch;
> > 
> > As we have said, can we directly support ETMv4.5, so that it can
> > smoothly support ETE features?  If so, we don't need to add a new
> > structure "cs_ete_trace_params" at here.
> > 
> 
> I think with the new magic number change this is more likely to stay,
> what are your thoughts?

Agreed.  Just wander if need to define the struct cs_ete_trace_params
as below?

  struct cs_ete_trace_params {
          u32 reg_idr0;
          u32 reg_idr1;
          u32 reg_idr2;
          u32 reg_idr8;
          u32 reg_configr;
          u32 reg_traceidr;
          u32 reg_devarch;
  }

> >> +
> >> +#define TRCDEVARCH_ARCHPART_SHIFT 0
> >> +#define TRCDEVARCH_ARCHPART_MASK  GENMASK(11, 0)
> >> +#define TRCDEVARCH_ARCHPART(x)    (((x) & TRCDEVARCH_ARCHPART_MASK) >> TRCDEVARCH_ARCHPART_SHIFT)
> >> +
> >> +#define TRCDEVARCH_ARCHVER_SHIFT 12
> >> +#define TRCDEVARCH_ARCHVER_MASK  GENMASK(15, 12)
> >> +#define TRCDEVARCH_ARCHVER(x)    (((x) & TRCDEVARCH_ARCHVER_MASK) >> TRCDEVARCH_ARCHVER_SHIFT)
> >> +
> >> +bool cs_etm__is_ete(u32 trcdevarch)
> >> +{
> >> +	/*
> >> +	 * ETE if ARCHVER is 5 (ARCHVER is 4 for ETM) and ARCHPART is 0xA13.
> >> +	 * See ETM_DEVARCH_ETE_ARCH in coresight-etm4x.h
> >> +	 */
> >> +	return TRCDEVARCH_ARCHVER(trcdevarch) == 5 && TRCDEVARCH_ARCHPART(trcdevarch) == 0xA13;
> > 
> > I think this is incorrect.
> > 
> > Here should check the bit field "REVISION, bits[19:16]".  If it's
> > field value is >= 5, then we can say it supports ETE.  I checked the
> > spec for ETMv4.4 and ETMv4.6, both use the same values for the
> > Bits[15:12] = 0x4, so the architecture ID is same for ETMv4.x IPs.
> > 
> 
> I tried to copy this as closely as possible from the ETE driver. See in coresight-etm4x.h
> 
> 	#define ETM_DEVARCH_ETE_ARCH						\
> 		(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETE | ETM_DEVARCH_PRESENT) 
> 
> Where ETM_DEVARCH_ARCHID_ETE is ARCHVER == 5 and ARCHPART == 0xA13. I didn't check 
> ETM_DEVARCH_ARCHITECT_ARM because I thought that wouldn't be necessary. If we want to make
> the change do detect >= 5 then I think this should be made in the driver first. @Suzuki,
> what do you think?

The tracer has two fields:

- ARCHID bits[15:12]
- REVISION, bits[19:16]

For ETE its ARCHID[15:12] is 0x5 and ETMv4.x's ARCHID[15:12] is 0x4.
So checking ARCHID[15:12] is the right way to distinguish if the
tracer is ETE and creates corresponding decoder for it.

When reviewed this patch I assumed we also need to create ETE decoder
if ETMv4.x has supported packet extension.  As Mike confirmed, all
ETMv4.x tracers keep to use existed way to create decoder; so it's not
necessary to check REVISION bit field.

So please ignore my this comment.

Thanks,
Leo
