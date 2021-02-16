Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AC831D191
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBPUas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBPUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:30:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF902C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:30:04 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kr16so26175pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gthQxk7gSlQCjC+sNSEsy+ijqfi6weCIaW0qtZ9s5yE=;
        b=YHSJ7hWxJSp8kURfD1BUk7/IAf7uFonGRyxqGrgl3KVDB+bU072QqNLWt12VVUlvCt
         LlM253HQMBFNep3ilk42S0Bb1wHSJQCnRu7Q0+0FaY/FZB36WVEI1a9t6mOKz6Ccr1mY
         bTDc8jAgJ/iGWnYSaFpUivzIfKND8wk0QhxXsUyZ1rC0xHeJ2dCUVNWuBE4U5KW7ras9
         KMYFqBFYBOd/6fMry7LqkuFHUSS4FPUqQ6lGpmbdViuFbMllg12qfyVA04r4sYUM4kPi
         AAH/l9GhpNeDnyCYEeq2X6u+LLqiytbweVgijngyqvX2aUzs6dTel+p2ZvsDcscQTyiC
         A1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gthQxk7gSlQCjC+sNSEsy+ijqfi6weCIaW0qtZ9s5yE=;
        b=Z/Nq8OUM2NCenEQFkveVi0TWecQXXEhYEBCYVK07grOJlSxY2f8118rCq7pfJN0t94
         1o8OKkGuSvBl2Wmt878XB5pG50URqg9TenNnod3GTlDKMeZu1zT/nwACHjZ1vvTeWend
         fDpzvNE85LUYB4X/Me2GxTzKAYnZVX25kB3YYCK6druClWksmilIrdaXS0AK+AuneIQR
         CkHfV23ARfs5fIUJQ9xPkviAcX7NeGD8i1p+3cq89kZM9fxilASatFK9LFesDrRdrIhx
         kCbDwhN1FiSEN5lxYLzVftfKKNXtLRe07hviLO0xdJIyr5g5yivyv4BNccZPB+CLXvsP
         xKYQ==
X-Gm-Message-State: AOAM532kLYaOrSTxeVD8hRXyaK6KnOCehmY/lnve8MNsNBl7uZXLsaDN
        RHULQzVGNfuDBZ90uIniod95XA==
X-Google-Smtp-Source: ABdhPJxE0+kuEJFm3xoTFsaDV00dUz9IIHrZ9+6kkM9Ow+2lNRMi1TSMt5rVNaAtIoeVJzyXLWlTPQ==
X-Received: by 2002:a17:90a:1d44:: with SMTP id u4mr6098110pju.88.1613507404284;
        Tue, 16 Feb 2021 12:30:04 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a37sm2728pgm.79.2021.02.16.12.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 12:30:03 -0800 (PST)
Date:   Tue, 16 Feb 2021 13:30:02 -0700
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
Message-ID: <20210216203002.GA2936551@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-9-git-send-email-anshuman.khandual@arm.com>
 <CAJ9a7VgC0j4TmOYXdUVd19sQqxWOk-tsvv3r5DQzmY59ZptzDQ@mail.gmail.com>
 <20210215165606.GB2770547@xps15>
 <CAJ9a7VimBJkeFVaYmW+jTGYH9EsDbUX_Wbf5P_bTicFqsSFJkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VimBJkeFVaYmW+jTGYH9EsDbUX_Wbf5P_bTicFqsSFJkg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 05:58:37PM +0000, Mike Leach wrote:
> Hi Mathieu,
> 
> On Mon, 15 Feb 2021 at 16:56, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> > On Mon, Feb 15, 2021 at 04:27:26PM +0000, Mike Leach wrote:
> > > HI Anshuman
> > >
> > > On Wed, 27 Jan 2021 at 08:55, Anshuman Khandual
> > > <anshuman.khandual@arm.com> wrote:
> > > >
> > > > Add support for dedicated sinks that are bound to individual CPUs. (e.g,
> > > > TRBE). To allow quicker access to the sink for a given CPU bound source,
> > > > keep a percpu array of the sink devices. Also, add support for building
> > > > a path to the CPU local sink from the ETM.
> > > >
> > >
> > > Really need to tighten up the terminology here - I think what you mean
> > > is a PE architecturally defined sink - i.e. one that can be determined
> > > by reading the feature registers on the PE, rather than an ETR which
> > > cannot.
> > > However, the Coresight Base System Architecture specification does
> > > recommend a per cpu design using an ETR per CPU - now I assume that
> > > this case is not catered for in this patch?
> > >
> > > > This adds a new percpu sink type CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM.
> > > > This new sink type is exclusively available and can only work with percpu
> > > > source type device CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC.
> > > >
> > >
> > > CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC - this does not exist.
> > >
> > > >
> > > > This defines a percpu structure that accommodates a single coresight_device
> > > > which can be used to store an initialized instance from a sink driver. As
> > > > these sinks are exclusively linked and dependent on corresponding percpu
> > > > sources devices, they should also be the default sink device during a perf
> > > > session.
> > > >
> > > > Outwards device connections are scanned while establishing paths between a
> > > > source and a sink device. But such connections are not present for certain
> > > > percpu source and sink devices which are exclusively linked and dependent.
> > > > Build the path directly and skip connection scanning for such devices.
> > > >
> > > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > Cc: Mike Leach <mike.leach@linaro.org>
> > > > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > ---
> > > > Changes in V3:
> > > >
> > > > - Updated coresight_find_default_sink()
> > > >
> > > >  drivers/hwtracing/coresight/coresight-core.c | 16 ++++++++++++++--
> > > >  include/linux/coresight.h                    | 12 ++++++++++++
> > > >  2 files changed, 26 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > > > index 0062c89..4795e28 100644
> > > > --- a/drivers/hwtracing/coresight/coresight-core.c
> > > > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > > > @@ -23,6 +23,7 @@
> > > >  #include "coresight-priv.h"
> > > >
> > > >  static DEFINE_MUTEX(coresight_mutex);
> > > > +DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
> > > >
> > >
> > > If you do indeed mean the architecturally defined sinks then this
> > > could be 'csdev_pe_arch_sink' - or something similar to indicate the
> > > reliance on the PE architecture, unless per-cpu ETR topologies are
> > > also handled here.
> >
> > I would like to treat systems with one ETR per CPU the same way we do for TRBEs.
> > That way we have two distinct way of working, i.e topologies where the sink is
> > shared and 1:1 topologies.  As such moving forward with "csdev_pe_arch_sink"
> > could become misleading when 1:1 ETR topologies are supported.
> >
> > Mathieu
> >
> 
> I believe that In terms of connecting source -> sink for 1:1 ETM:ETR,
> then the existing code will already work via the normal build path and
> ports declarations. Suzukis changes in coresight-etm-perf to allow
> multiple sinks of the same type to be active for ETE:TRBE will also
> work for ETx:ETR. (at least in terms of path building - there may
> still be other issues that come into play about buffers etc).
> 
> The TRBE .dts doesn''t have any ports and is as such outside this
> framework. This patch appears to be making it detectable when
> connecting source -> sink where we have ETE:TRBE on a given CPU - as
> in the subsequent patches, the TRBE driver registers in the per cpu
> sink array.
> 
> So these changes are not really related to 1:1 specifically, but the
> detectability of PE architected sinks. There is a need for the per cpu
> array for TRBE as there is no other way of finding them - but not for
> ETR - which should work just fine without changes I think.

I thought about this further after reading the above...  ETRs have ports, they
are present in the DTS and are already supported.  There is no point in trying
to handle them the same way TRBEs are handled in this set.  We can look at the
(potential) advantage of doing so at a later time if the need arises but not in
this set.

Thanks,
Mathieu

> 
> Regards
> 
> Mike
> 
> 
> > >
> > > >  /**
> > > >   * struct coresight_node - elements of a path, from source to sink
> > > > @@ -784,6 +785,13 @@ static int _coresight_build_path(struct coresight_device *csdev,
> > > >         if (csdev == sink)
> > > >                 goto out;
> > > >
> > > > +       if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
> > > > +           sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
> > > > +               _coresight_build_path(sink, sink, path);
> > > > +               found = true;
> > > > +               goto out;
> > > > +       }
> > > > +
> > > >         /* Not a sink - recursively explore each port found on this element */
> > > >         for (i = 0; i < csdev->pdata->nr_outport; i++) {
> > > >                 struct coresight_device *child_dev;
> > > > @@ -999,8 +1007,12 @@ coresight_find_default_sink(struct coresight_device *csdev)
> > > >         int depth = 0;
> > > >
> > > >         /* look for a default sink if we have not found for this device */
> > > > -       if (!csdev->def_sink)
> > > > -               csdev->def_sink = coresight_find_sink(csdev, &depth);
> > > > +       if (!csdev->def_sink) {
> > > > +               if (coresight_is_percpu_source(csdev))
> > > > +                       csdev->def_sink = per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
> > > > +               if (!csdev->def_sink)
> > > > +                       csdev->def_sink = coresight_find_sink(csdev, &depth);
> > > > +       }
> > > >         return csdev->def_sink;
> > > >  }
> > > >
> > > > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > > > index 976ec26..bc3a5ca 100644
> > > > --- a/include/linux/coresight.h
> > > > +++ b/include/linux/coresight.h
> > > > @@ -50,6 +50,7 @@ enum coresight_dev_subtype_sink {
> > > >         CORESIGHT_DEV_SUBTYPE_SINK_PORT,
> > > >         CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
> > > >         CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
> > > > +       CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM,
> > >
> > > If this is needed then could it not be ..._SINK_SYSMEM_PROC - to be
> > > consistent with ..._SOURCE_PROC?
> > >
> > > >  };
> > > >
> > > >  enum coresight_dev_subtype_link {
> > > > @@ -428,6 +429,17 @@ static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 o
> > > >                 csa->write(val, offset, false, true);
> > > >  }
> > > >
> > > > +static inline bool coresight_is_percpu_source(struct coresight_device *csdev)
> > >
> > > All cpu sources are per cpu - that is ETMv3, ETMv4, PTM, ETE - this
> > > might be better as simply coresight_is_cpu_source() as all the
> > > aforementioned types will return true.
> > >
> > > > +{
> > > > +       return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
> > > > +              csdev->subtype.source_subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
> > > > +}
> > > > +
> > > > +static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
> > > > +{
> > > > +       return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SINK) &&
> > > > +              csdev->subtype.sink_subtype == CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
> > > > +}
> > > >  #else  /* !CONFIG_64BIT */
> > > >
> > > >  static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> > > > --
> > > > 2.7.4
> > > >
> > >
> > > Regards
> > >
> > > Mike
> > > --
> > > Mike Leach
> > > Principal Engineer, ARM Ltd.
> > > Manchester Design Centre. UK
> 
> 
> 
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
