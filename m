Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5BC31C111
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBOR7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhBOR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:59:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BC9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:58:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 7so10059870wrz.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhhKdBuhEEookMaS37LIoVT3IsjzKnUX0O3XiL1iwho=;
        b=HKsT81xm45z0VFhcKM7uKe0ncwcP7vvV6z1QSf2rZM549u3Ge78ouOC7LvqS+ggACf
         Ey64BZ8tnhRRKlX2zJMLfRzp7Ul7EUI7CIE79kdGG8D+lGHYnfaCsbWTgZl70/W+plbW
         hjv3odtj3Z8FfDm1MUiPHYO3hC68RygmPvWJQhkd/wmk//CjLj8L4BdpI87aItqhbeqd
         QYaJdhUEEdgD50Rk0Tbwd5LJm8P3q7F/JptaQxa+IsjoLodJzNI2T44JXbgt45DgUmrc
         a/O7guSCZysKR3qG+KGdy8ZjHlqTTX1b7zc8ZOw0qI7gPUSjkDFD2dgQvPeixO1HGE7n
         KMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhhKdBuhEEookMaS37LIoVT3IsjzKnUX0O3XiL1iwho=;
        b=hL6r+6CKiDa+g0aM4/OGmqEDZJhKhosntsWO6wkye/ECtT/wyWZlCgr++Pb7CQqX6n
         I+AjvYKpMJ6Y+fPxIhDRTEC92ixZIEmN8vj89AUtGiEFkifY7mivAa2I9Mv9RSv2OUeT
         c/+VTNTbO2lp+pPJssPNUBgrXd40L52OvcIkarqHpOwwTGZDH+e0VLdd3bD1QLiozEt0
         xzGbRI/UNlSeMDRmSeoEgZ7SNwU3eYEP4JCLw73AjhNJcXrh5Vh6Rjb+x00uK+0uUbBv
         Og71RWXGaVgYmHZsJKC2gl155PQzJIY19oABXJhUSSbWHw/uM4rJJCFdo+tcu/0Zsq3p
         hCAQ==
X-Gm-Message-State: AOAM533iP3yEs4ojcQeXc+1d7OfwoNISyQvfU8wkzZngwThx4Pc0DjIN
        r0ck59+M4lTF3wj1/0fu46R4l5At7ZnDmORys2dSVA==
X-Google-Smtp-Source: ABdhPJyZVBm2X17EAUK7vktTfVAOik/5/hH5Dvmda0dph+Y3QZK6QBh4KmTcGdvX2vIlh0oA6sIbgrpwZ0wJ3UdqttM=
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr10404593wrs.176.1613411928666;
 Mon, 15 Feb 2021 09:58:48 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-9-git-send-email-anshuman.khandual@arm.com>
 <CAJ9a7VgC0j4TmOYXdUVd19sQqxWOk-tsvv3r5DQzmY59ZptzDQ@mail.gmail.com> <20210215165606.GB2770547@xps15>
In-Reply-To: <20210215165606.GB2770547@xps15>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 15 Feb 2021 17:58:37 +0000
Message-ID: <CAJ9a7VimBJkeFVaYmW+jTGYH9EsDbUX_Wbf5P_bTicFqsSFJkg@mail.gmail.com>
Subject: Re: [PATCH V3 08/14] coresight: core: Add support for dedicated
 percpu sinks
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Mon, 15 Feb 2021 at 16:56, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Mon, Feb 15, 2021 at 04:27:26PM +0000, Mike Leach wrote:
> > HI Anshuman
> >
> > On Wed, 27 Jan 2021 at 08:55, Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> > >
> > > Add support for dedicated sinks that are bound to individual CPUs. (e.g,
> > > TRBE). To allow quicker access to the sink for a given CPU bound source,
> > > keep a percpu array of the sink devices. Also, add support for building
> > > a path to the CPU local sink from the ETM.
> > >
> >
> > Really need to tighten up the terminology here - I think what you mean
> > is a PE architecturally defined sink - i.e. one that can be determined
> > by reading the feature registers on the PE, rather than an ETR which
> > cannot.
> > However, the Coresight Base System Architecture specification does
> > recommend a per cpu design using an ETR per CPU - now I assume that
> > this case is not catered for in this patch?
> >
> > > This adds a new percpu sink type CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM.
> > > This new sink type is exclusively available and can only work with percpu
> > > source type device CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC.
> > >
> >
> > CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC - this does not exist.
> >
> > >
> > > This defines a percpu structure that accommodates a single coresight_device
> > > which can be used to store an initialized instance from a sink driver. As
> > > these sinks are exclusively linked and dependent on corresponding percpu
> > > sources devices, they should also be the default sink device during a perf
> > > session.
> > >
> > > Outwards device connections are scanned while establishing paths between a
> > > source and a sink device. But such connections are not present for certain
> > > percpu source and sink devices which are exclusively linked and dependent.
> > > Build the path directly and skip connection scanning for such devices.
> > >
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > ---
> > > Changes in V3:
> > >
> > > - Updated coresight_find_default_sink()
> > >
> > >  drivers/hwtracing/coresight/coresight-core.c | 16 ++++++++++++++--
> > >  include/linux/coresight.h                    | 12 ++++++++++++
> > >  2 files changed, 26 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > > index 0062c89..4795e28 100644
> > > --- a/drivers/hwtracing/coresight/coresight-core.c
> > > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > > @@ -23,6 +23,7 @@
> > >  #include "coresight-priv.h"
> > >
> > >  static DEFINE_MUTEX(coresight_mutex);
> > > +DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
> > >
> >
> > If you do indeed mean the architecturally defined sinks then this
> > could be 'csdev_pe_arch_sink' - or something similar to indicate the
> > reliance on the PE architecture, unless per-cpu ETR topologies are
> > also handled here.
>
> I would like to treat systems with one ETR per CPU the same way we do for TRBEs.
> That way we have two distinct way of working, i.e topologies where the sink is
> shared and 1:1 topologies.  As such moving forward with "csdev_pe_arch_sink"
> could become misleading when 1:1 ETR topologies are supported.
>
> Mathieu
>

I believe that In terms of connecting source -> sink for 1:1 ETM:ETR,
then the existing code will already work via the normal build path and
ports declarations. Suzukis changes in coresight-etm-perf to allow
multiple sinks of the same type to be active for ETE:TRBE will also
work for ETx:ETR. (at least in terms of path building - there may
still be other issues that come into play about buffers etc).

The TRBE .dts doesn''t have any ports and is as such outside this
framework. This patch appears to be making it detectable when
connecting source -> sink where we have ETE:TRBE on a given CPU - as
in the subsequent patches, the TRBE driver registers in the per cpu
sink array.

So these changes are not really related to 1:1 specifically, but the
detectability of PE architected sinks. There is a need for the per cpu
array for TRBE as there is no other way of finding them - but not for
ETR - which should work just fine without changes I think.

Regards

Mike


> >
> > >  /**
> > >   * struct coresight_node - elements of a path, from source to sink
> > > @@ -784,6 +785,13 @@ static int _coresight_build_path(struct coresight_device *csdev,
> > >         if (csdev == sink)
> > >                 goto out;
> > >
> > > +       if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
> > > +           sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
> > > +               _coresight_build_path(sink, sink, path);
> > > +               found = true;
> > > +               goto out;
> > > +       }
> > > +
> > >         /* Not a sink - recursively explore each port found on this element */
> > >         for (i = 0; i < csdev->pdata->nr_outport; i++) {
> > >                 struct coresight_device *child_dev;
> > > @@ -999,8 +1007,12 @@ coresight_find_default_sink(struct coresight_device *csdev)
> > >         int depth = 0;
> > >
> > >         /* look for a default sink if we have not found for this device */
> > > -       if (!csdev->def_sink)
> > > -               csdev->def_sink = coresight_find_sink(csdev, &depth);
> > > +       if (!csdev->def_sink) {
> > > +               if (coresight_is_percpu_source(csdev))
> > > +                       csdev->def_sink = per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
> > > +               if (!csdev->def_sink)
> > > +                       csdev->def_sink = coresight_find_sink(csdev, &depth);
> > > +       }
> > >         return csdev->def_sink;
> > >  }
> > >
> > > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > > index 976ec26..bc3a5ca 100644
> > > --- a/include/linux/coresight.h
> > > +++ b/include/linux/coresight.h
> > > @@ -50,6 +50,7 @@ enum coresight_dev_subtype_sink {
> > >         CORESIGHT_DEV_SUBTYPE_SINK_PORT,
> > >         CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
> > >         CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
> > > +       CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM,
> >
> > If this is needed then could it not be ..._SINK_SYSMEM_PROC - to be
> > consistent with ..._SOURCE_PROC?
> >
> > >  };
> > >
> > >  enum coresight_dev_subtype_link {
> > > @@ -428,6 +429,17 @@ static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 o
> > >                 csa->write(val, offset, false, true);
> > >  }
> > >
> > > +static inline bool coresight_is_percpu_source(struct coresight_device *csdev)
> >
> > All cpu sources are per cpu - that is ETMv3, ETMv4, PTM, ETE - this
> > might be better as simply coresight_is_cpu_source() as all the
> > aforementioned types will return true.
> >
> > > +{
> > > +       return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
> > > +              csdev->subtype.source_subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
> > > +}
> > > +
> > > +static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
> > > +{
> > > +       return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SINK) &&
> > > +              csdev->subtype.sink_subtype == CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
> > > +}
> > >  #else  /* !CONFIG_64BIT */
> > >
> > >  static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> > > --
> > > 2.7.4
> > >
> >
> > Regards
> >
> > Mike
> > --
> > Mike Leach
> > Principal Engineer, ARM Ltd.
> > Manchester Design Centre. UK



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
