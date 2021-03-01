Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B47329864
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbhCAXbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 18:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbhCASEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:04:43 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89310C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 10:04:01 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q204so10981750pfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 10:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vw5HrvvsSsFIw3Wy5upPbTw/Y96phUPsIzFqKD3AMZc=;
        b=JcgGjlgT6weg9toZVTlSEzS3XWNR0y0QpIhPSVx+/Wscg59QZFPkw2WZ6u1nueIH/I
         Z5JELxtGKI1LENZ7DQJlDOisRK6yFbVwut9uOtuFx2aEyOeSYxxklxfvOfr9H0UNCjNs
         KWUfP41ZZ0Tu/K7ZPdXpqsiAk16SnGE54Erd3MiU64a1WRm1sQie85+Unbh/RLLwepL/
         25kLs/VqUkTxXWaF1cVVHTpuoGYOjP1xn49DHxQ22XT4hCXqwxnq7h1xkENITokzCHRO
         fy3bihJQAZw4SxK3oJ28FnqRLlyJYzNrEwALqeOdaTNTZ/+T/ZxqSW8biWNlPbGRlQeK
         YR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vw5HrvvsSsFIw3Wy5upPbTw/Y96phUPsIzFqKD3AMZc=;
        b=bSlutu3wRYZnQhMM1EMLBRxCegnlCGrQO+BcSKMs/o12uJRS+ABHF38GHc2+R7jEpN
         G2NQLBjYamcyvhHyjZa/pyA2oTauYySZqd7zfPxTUTUWhggxYNwYZLMC2FqcwfsN2KKv
         vQGQiwa13DWJnY0onBa+kf5U1QiraB7Yc1CUrHYzg1eMQppnST6qPYGeynkxwy4ZrYLE
         r2MoBQpROxnrBD/JgvP9XNuQ2O2iNyg/JGfkuUBzFACf8OClIOnAKt01ID+YZod2i1BV
         ZDwFk1/Xj+DhUAhC7H650/VPDjq/sSGDwIjGZ9dUJhREcn9NRspvM63NBPHGVHZ359ep
         ahQw==
X-Gm-Message-State: AOAM530M+TejF/axx1V97QJXmLvFbzgL80GEcjM3VIYoucObA4yFhoY8
        igFgh9//xXFHD13w5wUo1gL+hw==
X-Google-Smtp-Source: ABdhPJwAymEQYWV0W9QJQiRK07JIRMar/E1O0kHFE9KdMR8144IIsFpzBqpZxZ4MhS9HV6m247zidA==
X-Received: by 2002:a05:6a00:2296:b029:1b6:6972:2f2a with SMTP id f22-20020a056a002296b02901b669722f2amr15841966pfe.69.1614621840869;
        Mon, 01 Mar 2021 10:04:00 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id np7sm60257pjb.10.2021.03.01.10.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 10:03:59 -0800 (PST)
Date:   Mon, 1 Mar 2021 11:03:57 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 05/16] remoteproc: Add new get_loaded_rsc_table() to
 rproc_ops
Message-ID: <20210301180357.GA3690389@xps15>
References: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
 <20210223233515.3468677-6-mathieu.poirier@linaro.org>
 <d21bebd0-6cf0-bc9d-c945-5e6aa2e5271d@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21bebd0-6cf0-bc9d-c945-5e6aa2e5271d@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 05:14:36PM +0100, Arnaud POULIQUEN wrote:
> Hi Mathieu,
> 

Good morning,

> On 2/24/21 12:35 AM, Mathieu Poirier wrote:
> > Add a new get_loaded_rsc_table() operation in order to support
> > scenarios where the remoteproc core has booted a remote processor
> > and detaches from it.  When re-attaching to the remote processor,
> > the core needs to know where the resource table has been placed
> > in memory.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> > New for V6:
> > - Don't return an error if a resource table doesn't exist.
> > ---
> > 
> >  drivers/remoteproc/remoteproc_core.c     | 32 ++++++++++++++++++++++++
> >  drivers/remoteproc/remoteproc_internal.h | 10 ++++++++
> >  include/linux/remoteproc.h               |  6 ++++-
> >  3 files changed, 47 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 8c7e9f1d50d7..0012b7bdce24 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1537,6 +1537,32 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
> >  	return ret;
> >  }
> >  
> > +static int rproc_set_loaded_rsc_table(struct rproc *rproc)
> > +{
> > +	struct resource_table *table_ptr;
> > +	struct device *dev = &rproc->dev;
> > +	size_t table_sz;
> > +	int ret;
> > +
> > +	table_ptr = rproc_get_loaded_rsc_table(rproc, &table_sz);
> > +	if (!table_ptr) {
> > +		/* Not having a resource table is acceptable */
> > +		return 0;
> 
> Would it be an over protection to set rproc->table_ptr to NULL here?
> 

I thought about that too but since memory for @rproc is allocated with kzalloc()
it wouldn't provide anything more. 

> else
> 
> Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> 
> Thanks,
> Arnaud
> 
> > +	}
> > +
> > +	if (IS_ERR(table_ptr)) {
> > +		ret = PTR_ERR(table_ptr);
> > +		dev_err(dev, "can't load resource table: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	rproc->cached_table = NULL;
> > +	rproc->table_ptr = table_ptr;
> > +	rproc->table_sz = table_sz;
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Attach to remote processor - similar to rproc_fw_boot() but without
> >   * the steps that deal with the firmware image.
> > @@ -1556,6 +1582,12 @@ static int rproc_attach(struct rproc *rproc)
> >  		return ret;
> >  	}
> >  
> > +	ret = rproc_set_loaded_rsc_table(rproc);
> > +	if (ret) {
> > +		dev_err(dev, "can't load resource table: %d\n", ret);
> > +		goto disable_iommu;
> > +	}
> > +
> >  	/* reset max_notifyid */
> >  	rproc->max_notifyid = -1;
> >  
> > diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> > index c34002888d2c..4f73aac7e60d 100644
> > --- a/drivers/remoteproc/remoteproc_internal.h
> > +++ b/drivers/remoteproc/remoteproc_internal.h
> > @@ -177,6 +177,16 @@ struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
> >  	return NULL;
> >  }
> >  
> > +static inline
> > +struct resource_table *rproc_get_loaded_rsc_table(struct rproc *rproc,
> > +						  size_t *size)
> > +{
> > +	if (rproc->ops->get_loaded_rsc_table)
> > +		return rproc->ops->get_loaded_rsc_table(rproc, size);
> > +
> > +	return NULL;
> > +}
> > +
> >  static inline
> >  bool rproc_u64_fit_in_size_t(u64 val)
> >  {
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 6b0a0ed30a03..51538a7d120d 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -368,7 +368,9 @@ enum rsc_handling_status {
> >   * RSC_HANDLED if resource was handled, RSC_IGNORED if not handled and a
> >   * negative value on error
> >   * @load_rsc_table:	load resource table from firmware image
> > - * @find_loaded_rsc_table: find the loaded resouce table
> > + * @find_loaded_rsc_table: find the loaded resource table from firmware image
> > + * @get_loaded_rsc_table: get resource table installed in memory
> > + *			  by external entity
> >   * @load:		load firmware to memory, where the remote processor
> >   *			expects to find it
> >   * @sanity_check:	sanity check the fw image
> > @@ -390,6 +392,8 @@ struct rproc_ops {
> >  			  int offset, int avail);
> >  	struct resource_table *(*find_loaded_rsc_table)(
> >  				struct rproc *rproc, const struct firmware *fw);
> > +	struct resource_table *(*get_loaded_rsc_table)(
> > +				struct rproc *rproc, size_t *size);
> >  	int (*load)(struct rproc *rproc, const struct firmware *fw);
> >  	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
> >  	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
> > 
