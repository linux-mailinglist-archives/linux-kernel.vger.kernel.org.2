Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5915B30FC68
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbhBDTQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbhBDSgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:36:19 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FBC0617A9
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:34:50 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id t25so2735599pga.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3jvWmvModvzyLGbAMS7t2Ta/bGILZpVvmoEExacVaBo=;
        b=CqWkbkGkrZPiSd1/iVIeW/kBX8DyUtDrbLNu33v9s/iDYIRNZW+mJbsKT17FySRRgb
         hidpgGfanF689vY0kK7BljaSxeGOTksGg6jf04dJiAq99sWHB6ThTHfmWh9XBSCNjl69
         OkN8z6cQOItEyuufyCFS4jz2Zw0Y3T60bQG1zIpdEdfAkYG+HJepg4bVKjSebLXm2lJa
         D3hg0YhCVdSgmDVVBmJtTMKExadjojKOsg0d2DjAyOoZKNiHpB/If67NKlB5woqsvrdj
         RYi4Vrqr0933/nBrBA8DVIRPcr8FAiScSyVYtZE1dqRq87O/93WGtUd8QEdKXEuboZsO
         254Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3jvWmvModvzyLGbAMS7t2Ta/bGILZpVvmoEExacVaBo=;
        b=M954ZEsBTOq5aqVjV2B6TjwARiAVtCf4kMnlKvF0ichw24K+9yI+x9c4YqAaJJlRYC
         BfYYe6V513sjXXaUiqBF1coHC3/lFZlqC8PnKH4vb9xloWIpeAyB3HZtRpa83QWvMEWl
         +nTMkAMetnCcU5mZTR58XEOyjkdG44zuaZdgAT4/U//ttswVgWEsouePg5tgffO2/4GE
         ZHrK9fGYTkRX3uQsGnbOu27ui53O8nGkdaHFJu2lUTX7oaMsJH9NDzJpadvnFQSQ4ODy
         vTdEnx9vsUaJWZzMQRciCfy/75VzF5gJOOELZktTuaP76uRDHxHA+GMvvGOEv4QV6yuS
         Hv5w==
X-Gm-Message-State: AOAM531fAAKtJ9wsDLVLOEaOtzWrB4rszyM8+7MrlLygD7CA8rp6gzwe
        P9aNqreItH+VQ2Nik8lIR3FFDw==
X-Google-Smtp-Source: ABdhPJybVocQ63GzS49aUnVobaViLya0eEEs9a7Rm+Ct9hr+VYtUZX3IAqN/Jma7bF6zGBCw0zhfYQ==
X-Received: by 2002:aa7:808b:0:b029:1ce:8a32:f5e8 with SMTP id v11-20020aa7808b0000b02901ce8a32f5e8mr770113pff.34.1612463690270;
        Thu, 04 Feb 2021 10:34:50 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 17sm7064053pgy.53.2021.02.04.10.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:34:48 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:34:46 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 08/14] coresight: core: Add support for dedicated
 percpu sinks
Message-ID: <20210204183446.GA1636242@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-9-git-send-email-anshuman.khandual@arm.com>
 <dce24164-d35b-d9d9-2fcd-e50a1bac0b38@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce24164-d35b-d9d9-2fcd-e50a1bac0b38@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 09:16:34AM +0000, Suzuki K Poulose wrote:
> On 1/27/21 8:55 AM, Anshuman Khandual wrote:
> > Add support for dedicated sinks that are bound to individual CPUs. (e.g,
> > TRBE). To allow quicker access to the sink for a given CPU bound source,
> > keep a percpu array of the sink devices. Also, add support for building
> > a path to the CPU local sink from the ETM.
> > 
> > This adds a new percpu sink type CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM.
> > This new sink type is exclusively available and can only work with percpu
> > source type device CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC.
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
> >   drivers/hwtracing/coresight/coresight-core.c | 16 ++++++++++++++--
> >   include/linux/coresight.h                    | 12 ++++++++++++
> >   2 files changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index 0062c89..4795e28 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -23,6 +23,7 @@
> >   #include "coresight-priv.h"
> >   static DEFINE_MUTEX(coresight_mutex);
> > +DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
> >   /**
> >    * struct coresight_node - elements of a path, from source to sink
> > @@ -784,6 +785,13 @@ static int _coresight_build_path(struct coresight_device *csdev,
> >   	if (csdev == sink)
> >   		goto out;
> > +	if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
> > +	    sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
> > +		_coresight_build_path(sink, sink, path);

The return value for _coresight_build_path() needs to be checked.  Otherwise a
failure to allocate a node for the sink will go unoticed and make for a very
hard problem to debug.

> > +		found = true;
> > +		goto out;
> > +	}
> > +
> >   	/* Not a sink - recursively explore each port found on this element */
> >   	for (i = 0; i < csdev->pdata->nr_outport; i++) {
> >   		struct coresight_device *child_dev;
> > @@ -999,8 +1007,12 @@ coresight_find_default_sink(struct coresight_device *csdev)
> >   	int depth = 0;
> >   	/* look for a default sink if we have not found for this device */
> > -	if (!csdev->def_sink)
> > -		csdev->def_sink = coresight_find_sink(csdev, &depth);
> > +	if (!csdev->def_sink) {
> > +		if (coresight_is_percpu_source(csdev))
> > +			csdev->def_sink = per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
> > +		if (!csdev->def_sink)
> > +			csdev->def_sink = coresight_find_sink(csdev, &depth);
> > +	}
> >   	return csdev->def_sink;
> >   }
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 976ec26..bc3a5ca 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -50,6 +50,7 @@ enum coresight_dev_subtype_sink {
> >   	CORESIGHT_DEV_SUBTYPE_SINK_PORT,
> >   	CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
> >   	CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
> > +	CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM,

Do we absolutely need to add a new sink type?  It is only used in
_coresight_build_path() and that code could be: 

	if (coresight_is_percpu_source(csdev)) {
	    sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
            if (sink && sink == csdev) {
		_coresight_build_path(sink, sink, path);

> >   };
> >   enum coresight_dev_subtype_link {
> > @@ -428,6 +429,17 @@ static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 o
> >   		csa->write(val, offset, false, true);
> >   }
> > +static inline bool coresight_is_percpu_source(struct coresight_device *csdev)
> > +{
> > +	return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
> > +	       csdev->subtype.source_subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
> 
> Please add () around the last line. Same below.
> 
> > +}
> > +
> > +static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
> > +{
> > +	return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SINK) &&
> > +	       csdev->subtype.sink_subtype == CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
> > +}
> >   #else	/* !CONFIG_64BIT */
> >   static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> > 
> 
> With the above :
> 
> Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
