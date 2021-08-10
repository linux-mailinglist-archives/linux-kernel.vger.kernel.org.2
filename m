Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CE63DC3B8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 08:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbhGaGDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 02:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbhGaGD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 02:03:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E08FC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:03:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l19so18345066pjz.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=75Zkhg83/waZUlL0SId+YvamWoiIkDrDXEUeyRTWERc=;
        b=zzgpBEUrIKvu+dKlJJ/xrPzDeZ/TnnVtXB0yFrdxc/GyJ/YieEUpvQn0lMKTv8w4vx
         HOtrNRQeX0vDKCV8JoM6H/TIx8TmLEdoOMZpsiagdDeug/aHxsMj/Y5jIZvemcWpk7ui
         SDToqwk0ULG8/g8O5v0hW4H5LhxtrYorU9EYzW+5sMdwSjB7CS1hV3WSBDbt2uyRM+3o
         mVUd8e5b/3vBl4jhPju3hgqSOblCLwB23b3oMdME7uGJ4USctCGxEZ09DoE5JZHK9YgW
         WvCujxef4wycGeD1ajoctBruhpuTaTQi3Km+x48Vt86sZJsK9R4uNb1ZCU/D94WRK5oB
         lK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=75Zkhg83/waZUlL0SId+YvamWoiIkDrDXEUeyRTWERc=;
        b=MKsIitL5zmbWIArvDTJxRmOZDaKgxIKRPHUr64dL2pl3U6gXj5/kWaSNubwN6yxkEB
         Sa2UYYg8klbkFcRwoU+NsSLmM54S2OE2vd1fFO4BmDmsi/96vyAnwW5d/5Zz2hzioYfC
         f9IyepDk/hyGSTUnqw9DHM5YprsE5AZ+1DHUq0BlfjHXun9FFO73XlbBxlSJYMOQzE42
         LY4Kj3gPd4pV7/NIHuVcYOKpFBAGyRsonpnxVWcqNb+MkmYSe/sVNtMI0D7tN4scuZU1
         rPfKlqKez7nS/5tVKskDBWnJr1r7NWxifgaqbuVNJ3jgx42k4Twgs519Lp7FJ7tpamHj
         X8cw==
X-Gm-Message-State: AOAM531n7fxWDKCjmu7N8j2wSzgmnKmaeThZZOCjwRRTe0YAV0eHezok
        m+eLqc+eroPhKIRfKBR1lU+nGw==
X-Google-Smtp-Source: ABdhPJwtM3rMZUgyVpwQmUuEHr+HM/85JnXrXwEmH2M+PFy9jtTtvc8zkBClsULutoKg9mDieZyALQ==
X-Received: by 2002:a05:6a00:b46:b029:334:54db:af17 with SMTP id p6-20020a056a000b46b029033454dbaf17mr6188123pfo.26.1627711402944;
        Fri, 30 Jul 2021 23:03:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.43])
        by smtp.gmail.com with ESMTPSA id m8sm4296685pfo.110.2021.07.30.23.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 23:03:22 -0700 (PDT)
Date:   Sat, 31 Jul 2021 14:03:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Al Grant <al.grant@arm.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/6] perf cs-etm: Initialise architecture based on TRCIDR1
Message-ID: <20210731060312.GB7437@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-3-james.clark@arm.com>
 <CAJ9a7Viap53OgrM2e_DU4+oymFB41jspbKbvEVFQWROt7ifuXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Viap53OgrM2e_DU4+oymFB41jspbKbvEVFQWROt7ifuXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 12:10:35PM +0100, Mike Leach wrote:
> HI James
> 
> On Wed, 21 Jul 2021 at 10:07, James Clark <james.clark@arm.com> wrote:
> >
> > Currently the architecture is hard coded as ARCH_V8, but with the
> > introduction of ETE we want to pick ARCH_AA64. And this change is also
> > applicable to ETM v4.4 onwards as well.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index 30889a9d0165..5972a8afcc6b 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -126,6 +126,18 @@ static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
> >         return 0;
> >  }
> >
> > +#define TRCIDR1_TRCARCHMIN_SHIFT 4
> > +#define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
> > +#define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
> > +static enum _ocsd_arch_version cs_etm_decoder__get_arch_ver(u32 reg_idr1)
> > +{
> > +       /*
> > +        * If the ETM trace minor version is 4 or more then we can assume
> > +        * the architecture is ARCH_AA64 rather than just V8
> > +        */
> > +       return TRCIDR1_TRCARCHMIN(reg_idr1) >= 4 ? ARCH_AA64 : ARCH_V8;
> > +}
> 
> This is true for ETM4.x & ETE 1.x (arch 5.x) but not ETM 3.x
> Probably need to beef up this comment or the function name to emphasise this.

Yeah, I think it's good to change the function name.  Eventually, this
function should only be used for ETM4.x and ETE.

Another minor comment is: can we refine the arch version number, e.g.
change the OpenCSD's macro "ARCH_AA64" to "ARCH_V8R4", (or
"ARCH_V8R3_AA64"), this can give more clear clue what's the ETM version.

And a nitpick: how about to change OpenCSD macro "ARCH_V8r3" to
"ARCH_V8R3" and assign it for ETMv4.3 IPs.

Thanks,
Leo
