Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D99331D1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBPUpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBPUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:45:02 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE34C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:44:22 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b145so6924012pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9MECMeYdmfimYJ7zDt5CQyz07nG2n+cbIiQ18s/WOM0=;
        b=oQReen7pFyOi06ywuZ6TiFT4cTJV0hjiwGOZjVpnOUoOXFB8bbQiJoZLJWfM8vxI2i
         YczdC2yCZRqY8j3iha7TP9ddZjW/H+cQelo1WugeEKB+1Njz7vHIUTMRs8b/uK7//kSU
         3NS094++2h1iFjFthvGxWI6Yt8SD0QipKcS6AAiSYOovoxEm1gvcVzTM7OGjKZLVRVYg
         HVjfJUDSKtKrmCP4RNypFo9Ti2WjAySzz4ab7j11YZ6Nfe3S7szQG5iZgebsFXvHCxIj
         8R6vVgiGREwn7fHBElTNM4hI+0cHH2F2BznyiixYs5dWZIe6LexIl+XOY18SDhS7PioP
         BKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9MECMeYdmfimYJ7zDt5CQyz07nG2n+cbIiQ18s/WOM0=;
        b=P57Y/AUr0gE9LZ/q0n+o0J0BrTeEPgqCO5kZ20rfIkSaDb+Le9wNmT2+7W3t7XoLCJ
         q51QH5OxciMa4CABkaLfBZkUwl5Los4C0rl++D2vprNXALHIfBUn7mOqfPgoStgUMGZ/
         ARNHOwMD5NtBxwaU2AH/6jVnZtHD0H/cxgBgvmIbQ7LseaNeRelANDCa+P90gwA3YYBB
         YhKytv0ES6RzQbhE457xW4+m9gIw2EXC6f43f9JrCa4kvPpdHPEAo1Itkkk+kt47Ajew
         VU6cijT6hb3AUOVTqh35TIYe7Cq2HtmFt7x2NvdoMTh3TjsFZbzk6Xa8XBrNKpYg0qwt
         jZ7A==
X-Gm-Message-State: AOAM530La/CnjZxBguKdp8rF3UoqRFSzMlwo/kDC5nsFO7W2mKYphO/E
        oC4o24qIh4RojRzloOUqZvtQUg==
X-Google-Smtp-Source: ABdhPJwfl+TkajNcnBpCno49rytjM9JFtkzytXu+3cr0tOskKMMmTQl2ox9DBZWooLbkYEkIR3E0tw==
X-Received: by 2002:a62:7c55:0:b029:1dd:8c65:1ed8 with SMTP id x82-20020a627c550000b02901dd8c651ed8mr21155461pfc.24.1613508261614;
        Tue, 16 Feb 2021 12:44:21 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 68sm22497014pfe.33.2021.02.16.12.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 12:44:21 -0800 (PST)
Date:   Tue, 16 Feb 2021 13:44:19 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 08/14] coresight: core: Add support for dedicated
 percpu sinks
Message-ID: <20210216204419.GB2936551@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-9-git-send-email-anshuman.khandual@arm.com>
 <dce24164-d35b-d9d9-2fcd-e50a1bac0b38@arm.com>
 <20210204183446.GA1636242@xps15>
 <72bd5139-a6e1-64c0-c111-818bc04a81b8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72bd5139-a6e1-64c0-c111-818bc04a81b8@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 04:10:18PM +0530, Anshuman Khandual wrote:
> 
> 
> On 2/5/21 12:04 AM, Mathieu Poirier wrote:
> > On Thu, Jan 28, 2021 at 09:16:34AM +0000, Suzuki K Poulose wrote:
> >> On 1/27/21 8:55 AM, Anshuman Khandual wrote:
> >>> Add support for dedicated sinks that are bound to individual CPUs. (e.g,
> >>> TRBE). To allow quicker access to the sink for a given CPU bound source,
> >>> keep a percpu array of the sink devices. Also, add support for building
> >>> a path to the CPU local sink from the ETM.
> >>>
> >>> This adds a new percpu sink type CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM.
> >>> This new sink type is exclusively available and can only work with percpu
> >>> source type device CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC.
> >>>
> >>> This defines a percpu structure that accommodates a single coresight_device
> >>> which can be used to store an initialized instance from a sink driver. As
> >>> these sinks are exclusively linked and dependent on corresponding percpu
> >>> sources devices, they should also be the default sink device during a perf
> >>> session.
> >>>
> >>> Outwards device connections are scanned while establishing paths between a
> >>> source and a sink device. But such connections are not present for certain
> >>> percpu source and sink devices which are exclusively linked and dependent.
> >>> Build the path directly and skip connection scanning for such devices.
> >>>
> >>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>> Cc: Mike Leach <mike.leach@linaro.org>
> >>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >>> ---
> >>> Changes in V3:
> >>>
> >>> - Updated coresight_find_default_sink()
> >>>
> >>>   drivers/hwtracing/coresight/coresight-core.c | 16 ++++++++++++++--
> >>>   include/linux/coresight.h                    | 12 ++++++++++++
> >>>   2 files changed, 26 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> >>> index 0062c89..4795e28 100644
> >>> --- a/drivers/hwtracing/coresight/coresight-core.c
> >>> +++ b/drivers/hwtracing/coresight/coresight-core.c
> >>> @@ -23,6 +23,7 @@
> >>>   #include "coresight-priv.h"
> >>>   static DEFINE_MUTEX(coresight_mutex);
> >>> +DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
> >>>   /**
> >>>    * struct coresight_node - elements of a path, from source to sink
> >>> @@ -784,6 +785,13 @@ static int _coresight_build_path(struct coresight_device *csdev,
> >>>   	if (csdev == sink)
> >>>   		goto out;
> >>> +	if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
> >>> +	    sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
> >>> +		_coresight_build_path(sink, sink, path);
> > 
> > The return value for _coresight_build_path() needs to be checked.  Otherwise a
> > failure to allocate a node for the sink will go unoticed and make for a very
> > hard problem to debug.
> 
> How about this instead ?
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 4795e28..e93e669 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -787,9 +787,10 @@ static int _coresight_build_path(struct coresight_device *csdev,
>  
>         if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
>             sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
> -               _coresight_build_path(sink, sink, path);
> -               found = true;
> -               goto out;
> +               if (_coresight_build_path(sink, sink, path) == 0) {
> +                       found = true;
> +                       goto out;
> +               }

I am missing the context now but it is a step in the right direction.  I will
re-assess on your next revision.

>         }
>  
>         /* Not a sink - recursively explore each port found on this element */
> 
> > 
> >>> +		found = true;
> >>> +		goto out;
> >>> +	}
> >>> +
> >>>   	/* Not a sink - recursively explore each port found on this element */
> >>>   	for (i = 0; i < csdev->pdata->nr_outport; i++) {
> >>>   		struct coresight_device *child_dev;
> >>> @@ -999,8 +1007,12 @@ coresight_find_default_sink(struct coresight_device *csdev)
> >>>   	int depth = 0;
> >>>   	/* look for a default sink if we have not found for this device */
> >>> -	if (!csdev->def_sink)
> >>> -		csdev->def_sink = coresight_find_sink(csdev, &depth);
> >>> +	if (!csdev->def_sink) {
> >>> +		if (coresight_is_percpu_source(csdev))
> >>> +			csdev->def_sink = per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
> >>> +		if (!csdev->def_sink)
> >>> +			csdev->def_sink = coresight_find_sink(csdev, &depth);
> >>> +	}
> >>>   	return csdev->def_sink;
> >>>   }
> >>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> >>> index 976ec26..bc3a5ca 100644
> >>> --- a/include/linux/coresight.h
> >>> +++ b/include/linux/coresight.h
> >>> @@ -50,6 +50,7 @@ enum coresight_dev_subtype_sink {
> >>>   	CORESIGHT_DEV_SUBTYPE_SINK_PORT,
> >>>   	CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
> >>>   	CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
> >>> +	CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM,
> > 
> > Do we absolutely need to add a new sink type?  It is only used in
> > _coresight_build_path() and that code could be: 
> > 
> > 	if (coresight_is_percpu_source(csdev)) {
> > 	    sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
> 
> Do you mean if (sink == per_cpu(...)) above ?
> 
> >             if (sink && sink == csdev) {
> 
> How could the sink fetched from the source csdev be the same ?

The above should have been:

        if (coresight_is_percpu_source(csdev)) {
                per_cpu_sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
                if (per_cpu_sink && per_cpu_sink == sink) {

Apologies for the confusion.

Mathieu

> 
> I would still suggest keeping CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM for
> logical separation between source and sink, which also improves clarity
> and readability.
