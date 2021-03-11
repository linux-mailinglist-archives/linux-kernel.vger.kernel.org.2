Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0B337A91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCKRN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhCKRNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:13:41 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7979C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:13:41 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a24so10505547plm.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Al/T2sFWlvT3Vtl3R7CXJDlSotPrwvE7T7S7T8TsWxo=;
        b=vX5cI/xl4BhFDK1i2+FF347SCqdm4hT3gkn1huohMMQ8ojPbiVWf2kwDKNkkERnbF0
         yxLKe38HJb/UYRgAEzLIRG1OUa3AJnk00ObYH8XAEWu9IC9IcLLDaBkJwYR6YAYQqlgi
         hBGwjYYUk4eRhYTY6IgETxzP6CStwS6fkY7bG8YPsmCOysAVg0hT+A5wcH+6iGDZIdoH
         qPON9ACpFALlYYGji1aUhFopwQI8S8p++mABmayygY3pU1hwcSKKBUBTABlo7BBHTOuf
         AzsEXlImcPG1Nl0QEisfya/cxEq3GI/WC1milcDDeSkafl2en2Sf4ErVPl5Bo/yXaS64
         BRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Al/T2sFWlvT3Vtl3R7CXJDlSotPrwvE7T7S7T8TsWxo=;
        b=m8XkmCDL5e+D+F3zzQ7ZY7TVbvFKnX/249UFGLrc/xDwpDZjmEVrG5beugpQIYuQgS
         OoWgIfEbGaIvQAv0/foyt7xpZ/3h7uVxCVqPhi2lPbMj7SJcqlAenhpBh2AjTTqipxk2
         sa/cLSCU97s4muJFkkUDTDC933RSM5eU3eeTtfbx+IWsKHTfNalqyUpfxLf5zYLur1VR
         7rN2PY4wP6i1FfdOEPNSS3v9HAgL1ivlWPQ20WtwfmDJ5ekw8c9Z8rnhO5YaYNLdhBDK
         mNAnNq5rchbPbmnw4k/GwFk335RgCFAR+SAUfTSw8GbjGlTMzdOzcolxAqy4ZDx3qUif
         WRlw==
X-Gm-Message-State: AOAM531hs2uPfxJWs5wTEV+BjLxeW94qHvjuT4yUgwz6ZuLKkIbpDTVQ
        7cM58qnt8ANNBSw7yG9w10i+hibLorMnSg==
X-Google-Smtp-Source: ABdhPJxXZ2mQrWMXsr2BEClDmGES5sAN9xqNAjKyB3hrk7VnzZoXr+dIKS/+ZlZKzDwWb4gBOKS0sw==
X-Received: by 2002:a17:90a:9b18:: with SMTP id f24mr9511651pjp.96.1615482820187;
        Thu, 11 Mar 2021 09:13:40 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a1sm2838753pff.156.2021.03.11.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:13:39 -0800 (PST)
Date:   Thu, 11 Mar 2021 10:13:37 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ohad@wizery.com, arnaud.pouliquen@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 12/17] remoteproc: Properly deal with the resource
 table when stopping
Message-ID: <20210311171337.GA1113417@xps15>
References: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
 <20210310211025.1084636-13-mathieu.poirier@linaro.org>
 <YElb4PITwZtMhpAw@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YElb4PITwZtMhpAw@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:53:04PM -0600, Bjorn Andersson wrote:
> On Wed 10 Mar 15:10 CST 2021, Mathieu Poirier wrote:
> 
> > When a remote processor that was attached to is stopped, special care
> > must be taken to make sure the shutdown process is similar to what
> > it would be had it been started by the remoteproc core.
> > 
> > This patch takes care of that by making a copy of the resource
> > table currently used by the remote processor.  From that point on
> > the copy is used, as if the remote processor had been started by
> > the remoteproc core.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> > New for V7:
> >   New Patch, used to be part of 11/16 in V6.
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 53 +++++++++++++++++++++++++++-
> >  1 file changed, 52 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index e9ea2558432d..c488b1aa6119 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1634,6 +1634,52 @@ static int rproc_reset_rsc_table_on_detach(struct rproc *rproc)
> >  	return 0;
> >  }
> >  
> > +static int rproc_reset_rsc_table_on_stop(struct rproc *rproc)
> > +{
> > +	struct resource_table *table_ptr;
> > +
> > +	/* A resource table was never retrieved, nothing to do here */
> > +	if (!rproc->table_ptr)
> > +		return 0;
> > +
> > +	/*
> > +	 * If a cache table exists the remote processor was started by
> > +	 * the remoteproc core.  That cache table should be used for
> > +	 * the rest of the shutdown process.
> > +	 */
> > +	if (rproc->cached_table)
> > +		goto out;
> > +
> > +	/* Remember where the external entity installed the resource table */
> > +	table_ptr = rproc->table_ptr;
> > +
> 
> Afaict this is just a remnant from the detach case.
> 
> I think the series looks really good now, please let me know and I can
> drop the local "table_ptr" as I apply the patches.

(sigh) No matter how long you stare at a patchset there is always one that gets
away.  I will address Arnaud's comment and fix this in a new revision.

Thanks,
Mathieu 

> 
> Regards,
> Bjorn
> 
> > +	/*
> > +	 * If we made it here the remote processor was started by another
> > +	 * entity and a cache table doesn't exist.  As such make a copy of
> > +	 * the resource table currently used by the remote processor and
> > +	 * use that for the rest of the shutdown process.  The memory
> > +	 * allocated here is free'd in rproc_shutdown().
> > +	 */
> > +	rproc->cached_table = kmemdup(rproc->table_ptr,
> > +				      rproc->table_sz, GFP_KERNEL);
> > +	if (!rproc->cached_table)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * Since the remote processor is being switched off the clean table
> > +	 * won't be needed.  Allocated in rproc_set_rsc_table().
> > +	 */
> > +	kfree(rproc->clean_table);
> > +
> > +out:
> > +	/*
> > +	 * Use a copy of the resource table for the remainder of the
> > +	 * shutdown process.
> > +	 */
> > +	rproc->table_ptr = rproc->cached_table;
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Attach to remote processor - similar to rproc_fw_boot() but without
> >   * the steps that deal with the firmware image.
> > @@ -1759,7 +1805,12 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
> >  	rproc_stop_subdevices(rproc, crashed);
> >  
> >  	/* the installed resource table is no longer accessible */
> > -	rproc->table_ptr = rproc->cached_table;
> > +	ret = rproc_reset_rsc_table_on_stop(rproc);
> > +	if (ret) {
> > +		dev_err(dev, "can't reset resource table: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> >  
> >  	/* power off the remote processor */
> >  	ret = rproc->ops->stop(rproc);
> > -- 
> > 2.25.1
> > 
