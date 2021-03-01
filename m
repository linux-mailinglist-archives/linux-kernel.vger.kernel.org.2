Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D8B329A52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 11:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377389AbhCBArH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 19:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbhCASmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:42:21 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE51C061793
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 10:41:34 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id a4so12143093pgc.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 10:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dSwBx3y+KujkJBs7esgxnnYZ7mLC3mS3Y2RZJX56eNw=;
        b=fQ8ip8ZCEYG7Vk9vWVkDKVrnw3j8lawc9iDfzqfCl7Hdtz6WI0IpjzQa9z9rZzOQjq
         mq/iSkTF1OErZrupbvirtGFY5Yz2BDtcvA1wdgRru/4rLpQPYUzQ/Ngjwnz7KOLIRc8v
         iX+N+HsN/GR5OWdyMP5z84kUKQ6vIhbbI6s1wYY+3GVfFmqd+v82r3LyOgYOWWexYIaJ
         ZslTBZTjDlwmW49F369uE2WrXDXW/X41SmruVJHilkHLNUySmxNSFCbImbezIXnkMK15
         9pVowhwUyFQBk7eFn/1TOpL7yW18Srt4QFXMrVWfe4Et3KSoxXSwemq5cNzf7n5xVMjK
         TsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dSwBx3y+KujkJBs7esgxnnYZ7mLC3mS3Y2RZJX56eNw=;
        b=IO6RLuQi9t7/tcM0bNWpwfoQIQBm35045jgxBDxFK3QProMPnhFoAeIwZ0oGZClI0f
         vfGp9WsMwE5PAUK4hl8xFIXnpJR/qGcHa6JDyB7expfz1/wD2yV7kO/SXpXwnyZW0zLV
         Ft+L5kVRuD40moTWuypg9nj88WHooF6go2Hw2v06CU92uahcAl0DXWJX2tzDixILFO9E
         CX2SfjCoXX5mRT4s47BaO3W/plWIZ1f33t91tvFdb9eNEe/TXPIho/k3HVN9wZaINLsL
         1jGdO1dhbhU4BptKGnBgYwoWMf+NpRCqCiWnW5xJuvyDFpJ0WQnwhHwL2UJVi2DVU6lX
         YBFQ==
X-Gm-Message-State: AOAM533sAos62Nzo4HlC6yrc5E//hbH8z3cGWTtTzhK3f/gih6Sn4/ve
        94CrBzUTDtVv2Lnyi5AwQ8+3ww==
X-Google-Smtp-Source: ABdhPJw3d3qVrl8uKK7bLsd3bzLVlBxbfvGiR4uNPqmSB5Mhhm4TLP4r6j1B/Q0e8ckVymFrAlREGw==
X-Received: by 2002:a63:7885:: with SMTP id t127mr149862pgc.237.1614624093940;
        Mon, 01 Mar 2021 10:41:33 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j35sm3152020pgj.45.2021.03.01.10.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 10:41:33 -0800 (PST)
Date:   Mon, 1 Mar 2021 11:41:31 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 11/16] remoteproc: Properly deal with the resource
 table when attached
Message-ID: <20210301184131.GB3690389@xps15>
References: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
 <20210223233515.3468677-12-mathieu.poirier@linaro.org>
 <ad106bb6-0223-61f4-0d35-3b7da43ece4f@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad106bb6-0223-61f4-0d35-3b7da43ece4f@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 05:21:15PM +0100, Arnaud POULIQUEN wrote:
> 
> 
> On 2/24/21 12:35 AM, Mathieu Poirier wrote:
> > If it is possible to detach the remote processor, keep an untouched
> > copy of the resource table.  That way we can start from the same
> > resource table without having to worry about original values or what
> > elements the startup code has changed when re-attaching to the remote
> > processor.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> > New for V6:
> > - Double free of the cached table has been fixed.
> > - rproc_reset_loaded_rsc_table() has seen a complete re-write.
> > - rproc_stop() now calls rproc_reset_loaded_rsc_table() rather than
> >   dealing with the cached.  This allows to properly shutdown a
> >   remote processor that was attached to.
> > ---
> > 
> >  drivers/remoteproc/remoteproc_core.c | 86 +++++++++++++++++++++++++++-
> >  include/linux/remoteproc.h           |  3 +
> >  2 files changed, 88 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index fc01b29290a6..3a4692cc5220 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1556,6 +1556,21 @@ static int rproc_set_loaded_rsc_table(struct rproc *rproc)
> >  		return ret;
> >  	}
> >  
> > +	/*
> > +	 * If it is possible to detach the remote processor, keep an untouched
> > +	 * copy of the resource table.  That way we can start fresh again when
> > +	 * the remote processor is re-attached, that is:
> > +	 *
> > +	 *      DETACHED -> ATTACHED -> DETACHED -> ATTACHED
> > +	 *
> > +	 * Free'd in rproc_reset_loaded_rsc_table().
> > +	 */
> > +	if (rproc->ops->detach) {
> > +		rproc->clean_table = kmemdup(table_ptr, table_sz, GFP_KERNEL);
> > +		if (!rproc->clean_table)
> > +			return -ENOMEM;
> > +	}
> > +
> >  	rproc->cached_table = NULL;
> >  	rproc->table_ptr = table_ptr;
> >  	rproc->table_sz = table_sz;
> > @@ -1563,6 +1578,65 @@ static int rproc_set_loaded_rsc_table(struct rproc *rproc)
> >  	return 0;
> >  }
> >  
> > +static int rproc_reset_loaded_rsc_table(struct rproc *rproc)
> 
> I spent some time to review this function that handles both the resource table
> for both the stop and detach. To make it easier to read, I would divide it into
> two functions.

I suspected rproc_reset_loaded_rsc_table() was trying to do too many things for
its own good and you just confirmed that.

> I added a proposal at the end of this mail.
> 
> Regards,
> Arnaud
> 
> > +{
> > +	struct resource_table *table_ptr;
> > +
> > +	/*
> > +	 * The cached table is already set if the remote processor was started
> > +	 * by the remoteproc core.
> > +	 */
> > +	if (rproc->state == RPROC_RUNNING) {
> > +		rproc->table_ptr = rproc->cached_table;
> > +		return 0;
> > +	}
> > +
> > +	/* A resource table was never retrieved, nothing to do here */
> > +	if (!rproc->table_ptr)
> > +		return 0;
> > +
> > +	/*
> > +	 * If we made it to this point a cached_table _must_ have been
> > +	 * allocated in rproc_set_loaded_rsc_table().  If one isn't present
> > +	 * something went really wrong and we must complain.
> > +	 */
> > +	if (WARN_ON(!rproc->clean_table))
> > +		return -EINVAL;
> > +
> > +	/* Remember where the external entity installed the resource table */
> > +	table_ptr = rproc->table_ptr;
> > +
> > +	/*
> > +	 * Make a copy of the resource table currently used by the remote
> > +	 * processor.  Free'd in rproc_detach() or rproc_shutdown().
> > +	 */
> > +	rproc->cached_table = kmemdup(rproc->table_ptr,
> > +				      rproc->table_sz, GFP_KERNEL);
> > +	if (!rproc->cached_table)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * Use a copy of the resource table for the remainder of the
> > +	 * shutdown process.
> > +	 */
> > +	rproc->table_ptr = rproc->cached_table;
> > +
> > +	/*
> > +	 * Reset the memory area where the firmware loaded the resource table
> > +	 * to its original value.  That way when we re-attach the remote
> > +	 * processor the resource table is clean and ready to be used again.
> > +	 */
> > +	memcpy(table_ptr, rproc->clean_table, rproc->table_sz);
> > +
> > +	/*
> > +	 * The clean resource table is no longer needed.  Allocated in
> > +	 * rproc_set_loaded_rsc_table().
> > +	 */
> > +	kfree(rproc->clean_table);
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Attach to remote processor - similar to rproc_fw_boot() but without
> >   * the steps that deal with the firmware image.
> > @@ -1688,7 +1762,11 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
> >  	rproc_stop_subdevices(rproc, crashed);
> >  
> >  	/* the installed resource table is no longer accessible */
> > -	rproc->table_ptr = rproc->cached_table;
> > +	ret = rproc_reset_loaded_rsc_table(rproc);
> > +	if (ret) {
> > +		dev_err(dev, "can't reset resource table: %d\n", ret);
> > +		return ret;
> > +	}
> >  
> >  	/* power off the remote processor */
> >  	ret = rproc->ops->stop(rproc);
> > @@ -1721,6 +1799,9 @@ static int __rproc_detach(struct rproc *rproc)
> >  	/* Stop any subdevices for the remote processor */
> >  	rproc_stop_subdevices(rproc, false);
> >  
> > +	/* the installed resource table is no longer accessible */
> > +	ret = rproc_reset_loaded_rsc_table(rproc);
> > +
> >  	/* Tell the remote processor the core isn't available anymore */
> >  	ret = rproc->ops->detach(rproc);
> >  	if (ret) {
> > @@ -1997,6 +2078,9 @@ int rproc_detach(struct rproc *rproc)
> >  
> >  	rproc_disable_iommu(rproc);
> >  
> > +	/* Free the copy of the resource table */
> > +	kfree(rproc->cached_table);
> > +	rproc->cached_table = NULL;
> >  	rproc->table_ptr = NULL;
> >  out:
> >  	mutex_unlock(&rproc->lock);
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index e1c843c19cc6..e5f52a12a650 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -514,6 +514,8 @@ struct rproc_dump_segment {
> >   * @recovery_disabled: flag that state if recovery was disabled
> >   * @max_notifyid: largest allocated notify id.
> >   * @table_ptr: pointer to the resource table in effect
> > + * @clean_table: copy of the resource table without modifications.  Used
> > + *		 when a remote processor is attached or detached from the core
> >   * @cached_table: copy of the resource table
> >   * @table_sz: size of @cached_table
> >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> > @@ -550,6 +552,7 @@ struct rproc {
> >  	bool recovery_disabled;
> >  	int max_notifyid;
> >  	struct resource_table *table_ptr;
> > +	struct resource_table *clean_table;
> >  	struct resource_table *cached_table;
> >  	size_t table_sz;
> >  	bool has_iommu;
> > 
> 
> 
> ---
>  drivers/remoteproc/remoteproc_core.c | 101 ++++++++++++++++++++++++++-
>  include/linux/remoteproc.h           |   3 +
>  2 files changed, 103 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> index fc01b29290a6..cc24c360eb8b 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1556,6 +1556,21 @@ static int rproc_set_loaded_rsc_table(struct rproc *rproc)
>  		return ret;
>  	}
> 
> +	/*
> +	 * If it is possible to detach the remote processor, keep an untouched
> +	 * copy of the resource table.  That way we can start fresh again when
> +	 * the remote processor is re-attached, that is:
> +	 *
> +	 *      DETACHED -> ATTACHED -> DETACHED -> ATTACHED
> +	 *
> +	 * Free'd in rproc_reset_loaded_rsc_table().
> +	 */
> +	if (rproc->ops->detach) {
> +		rproc->clean_table = kmemdup(table_ptr, table_sz, GFP_KERNEL);
> +		if (!rproc->clean_table)
> +			return -ENOMEM;
> +	}
> +
>  	rproc->cached_table = NULL;
>  	rproc->table_ptr = table_ptr;
>  	rproc->table_sz = table_sz;
> @@ -1563,6 +1578,79 @@ static int rproc_set_loaded_rsc_table(struct rproc *rproc)
>  	return 0;
>  }
> 
> +static int rproc_set_to_cached_rsc_table(struct rproc *rproc)
> +{
> +	/* A resource table was never retrieved, nothing to do here */
> +	if (!rproc->table_ptr)
> +		return 0;
> +
> +	/*
> +	 * The cached table is already set if the remote processor was started
> +	 * by the remoteproc core.
> +	 */
> +	if (!rproc->cached_table) {
> +		rproc->table_ptr = rproc->cached_table;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Make a copy of the resource table currently used by the remote
> +	 * processor.  Free'd in rproc_detach() or rproc_shutdown().
> +	 */
> +	rproc->cached_table = kmemdup(rproc->table_ptr,
> +				      rproc->table_sz, GFP_KERNEL);
> +	if (!rproc->cached_table)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Use a copy of the resource table for the remainder of the
> +	 * shutdown process.
> +	 */
> +	rproc->table_ptr = rproc->cached_table;
> +
> +	return 0;
> +}
> +
> +static int rproc_reset_loaded_rsc_table(struct rproc *rproc)
> +{
> +	struct resource_table *table_ptr;
> +	int ret;
> +
> +	/* A resource table was never retrieved, nothing to do here */
> +	if (!rproc->table_ptr)
> +		return 0;
> +
> +	/*
> +	 * If we made it to this point a cached_table _mst_ have been
> +	 * allocated in rproc_set_loaded_rsc_table().  If one isn't present
> +	 * something went really wrong and we must complain.
> +	 */
> +	if (WARN_ON(!rproc->clean_table))
> +		return -EINVAL;
> +
> +	/* Remember where the external entity installed the resource table */
> +	table_ptr = rproc->table_ptr;
> +
> +	ret = rproc_set_to_cached_rsc_table(rproc);
> +	if (ret)
> +		return ret;

Ok, let's split them.  On the flip side I don't think calling
rproc_set_to_cached_rsc_table() from rproc_reset_loaded_rsc_table() helps with
clarity.

I will simply spin off two distinct functions that do exactly what they are
supposed to do.  There will be code duplication but I'm good with that if it
helps with readability and maintenance.  

I will rename rproc_set_loaded_rsc_table() to rproc_set_rsc_table() and spinoff
two new functions: rproc_reset_rsc_table_stop() and
rproc_reset_rsc_table_detach().

Hopefully that will work better.

> +
> +	/*
> +	 * Reset the memory area where the firmware loaded the resource table
> +	 * to its original value.  That way when we re-attach the remote
> +	 * processor the resource table is clean and ready to be used again.
> +	 */
> +	memcpy(table_ptr, rproc->clean_table, rproc->table_sz);
> +
> +	/*
> +	 * The clean resource table is no longer needed.  Allocated in
> +	 * rproc_set_loaded_rsc_table().
> +	 */
> +	kfree(rproc->clean_table);
> +
> +	return 0;
> +}
> +
>  /*
>   * Attach to remote processor - similar to rproc_fw_boot() but without
>   * the steps that deal with the firmware image.
> @@ -1688,7 +1776,11 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
>  	rproc_stop_subdevices(rproc, crashed);
> 
>  	/* the installed resource table is no longer accessible */
> -	rproc->table_ptr = rproc->cached_table;
> +	ret = rproc_set_to_cached_rsc_table(rproc);
> +	if (ret) {
> +		dev_err(dev, "can't reset resource table: %d\n", ret);
> +		return ret;
> +	}
> 
>  	/* power off the remote processor */
>  	ret = rproc->ops->stop(rproc);
> @@ -1721,6 +1813,9 @@ static int __rproc_detach(struct rproc *rproc)
>  	/* Stop any subdevices for the remote processor */
>  	rproc_stop_subdevices(rproc, false);
> 
> +	/* The installed resource table need to be reset and no longer accessible */
> +	ret = rproc_reset_loaded_rsc_table(rproc);
> +
>  	/* Tell the remote processor the core isn't available anymore */
>  	ret = rproc->ops->detach(rproc);
>  	if (ret) {
> @@ -1941,6 +2036,7 @@ void rproc_shutdown(struct rproc *rproc)
> 
>  	/* Free the copy of the resource table */
>  	kfree(rproc->cached_table);
> +	kfree(rproc->clean_table);
>  	rproc->cached_table = NULL;
>  	rproc->table_ptr = NULL;
>  out:
> @@ -1997,6 +2093,9 @@ int rproc_detach(struct rproc *rproc)
> 
>  	rproc_disable_iommu(rproc);
> 
> +	/* Free the copy of the resource table */
> +	kfree(rproc->cached_table);
> +	rproc->cached_table = NULL;
>  	rproc->table_ptr = NULL;
>  out:
>  	mutex_unlock(&rproc->lock);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e1c843c19cc6..e5f52a12a650 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -514,6 +514,8 @@ struct rproc_dump_segment {
>   * @recovery_disabled: flag that state if recovery was disabled
>   * @max_notifyid: largest allocated notify id.
>   * @table_ptr: pointer to the resource table in effect
> + * @clean_table: copy of the resource table without modifications.  Used
> + *		 when a remote processor is attached or detached from the core
>   * @cached_table: copy of the resource table
>   * @table_sz: size of @cached_table
>   * @has_iommu: flag to indicate if remote processor is behind an MMU
> @@ -550,6 +552,7 @@ struct rproc {
>  	bool recovery_disabled;
>  	int max_notifyid;
>  	struct resource_table *table_ptr;
> +	struct resource_table *clean_table;
>  	struct resource_table *cached_table;
>  	size_t table_sz;
>  	bool has_iommu;
> -- 
