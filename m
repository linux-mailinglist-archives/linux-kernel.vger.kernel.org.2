Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33B531C0BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhBORiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhBOQ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:57:02 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AA1C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:56:10 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o38so4522216pgm.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qoAdT8nrkdFDnX4hLWloEuGlvwdQcX9uwfXAZtHlhkA=;
        b=idxh7UT/VU3EYxALIx2bdfWf5LKGJDKREDZm5+5KMnc1tL67GK9DA0kar3xsdIFGUG
         csNqCXGEE2RqIcS8P2/Mj9sk65NvJjcweHHwFgJjCnMiDUcdvhSVHSIm4FVr1gyBUTbZ
         YjAHcR+g7FTSiBpyRoOCimL+H3LH9WU6mYic7IsFeXn7bjK8oourcIC9Y2wYdfR2oRmE
         yuvr9NJLLFeBZayo3zwJAMJkCG9Swlk8eeF+R2p1PvyVh/OeaxMjgSEVzEubgviFZSYo
         IxSSnvhVRqfVA+BydvqjLze1jnj5VICkuXMnjmYheFzt1qpxGY7uUSY1L04XpQeQTRjp
         sMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qoAdT8nrkdFDnX4hLWloEuGlvwdQcX9uwfXAZtHlhkA=;
        b=REm2/tjUmFnpLASM4aXkJyJiTOQG6QsPzHySVJfjeUgcw4Vdjgl6I/chqMpaB/xjFB
         Ze5pJeWsu+4ohhsvxsVpPwHbOvRceoiQByYRkFSZK1fs0Sz9+r9/BotQsNhjq7VWrH1Z
         7Gu8jU0vcrHl1ZOIL5Q6fbOmzHjHKRDMPzGTEf9tj2r9BjMbaIElmVU1vF4Q0tDb/3s8
         m4frRA431sLWhl9bkRe/mnuK3KPWbZ/AXalcGNJUCEKC2qf2D2sgMbwmUwnEYEhbNTAc
         LAfdBtGR6FDY3UoYxufsllNpQ+dg+5Z903C85bT9daP6h06y+QVv0d1PSUUCnUj8V1ur
         zLRw==
X-Gm-Message-State: AOAM532uMmcPDa+lfZ6bExXFBWRDQQmRml28zE4RnFwetB5o/IdXq1iX
        LDHU0krh++buH4z9WWoHXPfPBA==
X-Google-Smtp-Source: ABdhPJwTOuOehOXE/u5fm4Nyo+cQN3eEpPR34Io82q1Ly8Eqq8UDwGVvhg8tFSHaH2Pg2A5McsvPrw==
X-Received: by 2002:a65:5a0a:: with SMTP id y10mr1981734pgs.221.1613408168445;
        Mon, 15 Feb 2021 08:56:08 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id o21sm17382122pjp.42.2021.02.15.08.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:56:07 -0800 (PST)
Date:   Mon, 15 Feb 2021 09:56:06 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 08/14] coresight: core: Add support for dedicated
 percpu sinks
Message-ID: <20210215165606.GB2770547@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-9-git-send-email-anshuman.khandual@arm.com>
 <CAJ9a7VgC0j4TmOYXdUVd19sQqxWOk-tsvv3r5DQzmY59ZptzDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VgC0j4TmOYXdUVd19sQqxWOk-tsvv3r5DQzmY59ZptzDQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 04:27:26PM +0000, Mike Leach wrote:
> HI Anshuman
> 
> On Wed, 27 Jan 2021 at 08:55, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> >
> > Add support for dedicated sinks that are bound to individual CPUs. (e.g,
> > TRBE). To allow quicker access to the sink for a given CPU bound source,
> > keep a percpu array of the sink devices. Also, add support for building
> > a path to the CPU local sink from the ETM.
> >
> 
> Really need to tighten up the terminology here - I think what you mean
> is a PE architecturally defined sink - i.e. one that can be determined
> by reading the feature registers on the PE, rather than an ETR which
> cannot.
> However, the Coresight Base System Architecture specification does
> recommend a per cpu design using an ETR per CPU - now I assume that
> this case is not catered for in this patch?
> 
> > This adds a new percpu sink type CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM.
> > This new sink type is exclusively available and can only work with percpu
> > source type device CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC.
> >
> 
> CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC - this does not exist.
> 
> >
> > This defines a percpu structure that accommodates a single coresight_device
> > which can be used to store an initialized instance from a sink driver. As
> > these sinks are exclusively linked and dependent on corresponding percpu
> > sources devices, they should also be the default sink device during a perf
> > session.
> >
> > Outwards device connections are scanned while establishing paths between a
> > source and a sink device. But such connections are not present for certain
> > percpu source and sink devices which are exclusively linked and dependent.
> > Build the path directly and skip connection scanning for such devices.
> >
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > Changes in V3:
> >
> > - Updated coresight_find_default_sink()
> >
> >  drivers/hwtracing/coresight/coresight-core.c | 16 ++++++++++++++--
> >  include/linux/coresight.h                    | 12 ++++++++++++
> >  2 files changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index 0062c89..4795e28 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -23,6 +23,7 @@
> >  #include "coresight-priv.h"
> >
> >  static DEFINE_MUTEX(coresight_mutex);
> > +DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
> >
> 
> If you do indeed mean the architecturally defined sinks then this
> could be 'csdev_pe_arch_sink' - or something similar to indicate the
> reliance on the PE architecture, unless per-cpu ETR topologies are
> also handled here.

I would like to treat systems with one ETR per CPU the same way we do for TRBEs.
That way we have two distinct way of working, i.e topologies where the sink is
shared and 1:1 topologies.  As such moving forward with "csdev_pe_arch_sink"
could become misleading when 1:1 ETR topologies are supported.

Mathieu

> 
> >  /**
> >   * struct coresight_node - elements of a path, from source to sink
> > @@ -784,6 +785,13 @@ static int _coresight_build_path(struct coresight_device *csdev,
> >         if (csdev == sink)
> >                 goto out;
> >
> > +       if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
> > +           sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
> > +               _coresight_build_path(sink, sink, path);
> > +               found = true;
> > +               goto out;
> > +       }
> > +
> >         /* Not a sink - recursively explore each port found on this element */
> >         for (i = 0; i < csdev->pdata->nr_outport; i++) {
> >                 struct coresight_device *child_dev;
> > @@ -999,8 +1007,12 @@ coresight_find_default_sink(struct coresight_device *csdev)
> >         int depth = 0;
> >
> >         /* look for a default sink if we have not found for this device */
> > -       if (!csdev->def_sink)
> > -               csdev->def_sink = coresight_find_sink(csdev, &depth);
> > +       if (!csdev->def_sink) {
> > +               if (coresight_is_percpu_source(csdev))
> > +                       csdev->def_sink = per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
> > +               if (!csdev->def_sink)
> > +                       csdev->def_sink = coresight_find_sink(csdev, &depth);
> > +       }
> >         return csdev->def_sink;
> >  }
> >
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 976ec26..bc3a5ca 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -50,6 +50,7 @@ enum coresight_dev_subtype_sink {
> >         CORESIGHT_DEV_SUBTYPE_SINK_PORT,
> >         CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
> >         CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
> > +       CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM,
> 
> If this is needed then could it not be ..._SINK_SYSMEM_PROC - to be
> consistent with ..._SOURCE_PROC?
> 
> >  };
> >
> >  enum coresight_dev_subtype_link {
> > @@ -428,6 +429,17 @@ static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 o
> >                 csa->write(val, offset, false, true);
> >  }
> >
> > +static inline bool coresight_is_percpu_source(struct coresight_device *csdev)
> 
> All cpu sources are per cpu - that is ETMv3, ETMv4, PTM, ETE - this
> might be better as simply coresight_is_cpu_source() as all the
> aforementioned types will return true.
> 
> > +{
> > +       return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
> > +              csdev->subtype.source_subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
> > +}
> > +
> > +static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
> > +{
> > +       return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SINK) &&
> > +              csdev->subtype.sink_subtype == CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
> > +}
> >  #else  /* !CONFIG_64BIT */
> >
> >  static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> > --
> > 2.7.4
> >
> 
> Regards
> 
> Mike
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
