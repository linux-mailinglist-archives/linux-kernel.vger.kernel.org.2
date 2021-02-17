Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B831E14C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhBQVYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhBQVXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:23:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E01C061786
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 13:22:55 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c19so53364pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 13:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lz+gd9XLG0rhSSAchXuyyUA0mNTMvFE42OMhF4DhPbE=;
        b=KyPBJ/D53KbI8/rVY3vfzseq91VqmpyG98E96l1KleiNrKjv8gjydCgSJAsixn5PVy
         iC3QO8zPP7Z6ijeTqgyWp1WodvtCNom1OXu7aBMThhloLbcfTBWrgUUE7newf0ARKqrD
         w7cV1wlrirFzClIYZxHNVa3RAR4Xg1fUQlaqp0x2ESkhtdWUOKsUp8v+yW2uhK3kd1rs
         1poLhqpd7TjpxrQkZHoxpRThp7iBJqSfPACUXeoI+K5l1GS7CsQhPrnhVmBfTOL+EK/j
         Msk0DSfNGvLA6ty0FXUUVIYXH59dcVuoAM8vhaZHjgM2ZT8utjhYgUDlwu0GdQxyGmlF
         xNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lz+gd9XLG0rhSSAchXuyyUA0mNTMvFE42OMhF4DhPbE=;
        b=AjWgzSiEjsgO+1sP2k+omZN0POBeigvU58KQNlPJQLD8Sw8cwuXIemv1dc3KDI8Yao
         ep96Zf1B9ZVLXjKMbnv8NAiBbchiRbhxdlDOquwzELZkDM1hm0+k5Reg7ANdyHu4xs0E
         td7QrN444l62ZVHxiQNkJagXJjVwtgi0yMOTeX5ROR4CP1WYr2DVHV60BZCYq35VwePK
         8qlBSFzBJ8Lu8D45nk17L/PzW2TxSKr5Gz4KNrhAKWPIdI1K8aRnJ3ZmDltPf+VKW1Gw
         c9yDK4tsjy6IUom88U1xMTtlAQeDgKCgKVed2MFM2m3Tmuo5UZgELLX+LMDyti6ygRw+
         dRGQ==
X-Gm-Message-State: AOAM531STo1TLYW5fvYaLh8fd5R16k3hd8BP2+UNBbg59hYu0uGXmbiV
        ke5WAJRqRnVTyz6rybt/u3jXpg==
X-Google-Smtp-Source: ABdhPJxF6/L5bQjUFhTNg5HWYRKopFPRmpNg0DDkZVoV7x5SnkBc0oDRP2eV6PB5sjHyMSsQCo11cw==
X-Received: by 2002:a17:902:900c:b029:e3:2313:20d5 with SMTP id a12-20020a170902900cb02900e3231320d5mr962555plp.62.1613596974417;
        Wed, 17 Feb 2021 13:22:54 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e6sm3142725pfd.5.2021.02.17.13.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:22:53 -0800 (PST)
Date:   Wed, 17 Feb 2021 14:22:51 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 07/19] remoteproc: Add new get_loaded_rsc_table() to
 rproc_ops
Message-ID: <20210217212251.GA2800385@xps15>
References: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
 <20210211234627.2669674-8-mathieu.poirier@linaro.org>
 <406fe414-f454-c91d-8bbd-ce323a9612e7@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406fe414-f454-c91d-8bbd-ce323a9612e7@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 02:10:10PM +0100, Arnaud POULIQUEN wrote:
> Hi Mathieu,
> 
> On 2/12/21 12:46 AM, Mathieu Poirier wrote:
> > Add a new get_loaded_rsc_table() operation in order to support
> > scenarios where the remoteproc core has booted a remote processor
> > and detaches from it.  When re-attaching to the remote processor,
> > the core needs to know where the resource table has been placed
> > in memory.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> > New for V5:
> > - Added function rproc_set_loaded_rsc_table() to keep rproc_attach() clean.
> > - Setting ->cached_table, ->table_ptr and ->table_sz in the remoteproc core
> >   rather than the platform drivers.
> > ---
> >  drivers/remoteproc/remoteproc_core.c     | 35 ++++++++++++++++++++++++
> >  drivers/remoteproc/remoteproc_internal.h | 10 +++++++
> >  include/linux/remoteproc.h               |  6 +++-
> >  3 files changed, 50 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index e6606d10a4c8..741bc20de437 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1537,6 +1537,35 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
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
> > +	if (IS_ERR_OR_NULL(table_ptr)) {
> > +		if (!table_ptr)
> > +			ret = -EINVAL;
> 
> I did few tests on this showing that this approach does not cover all use cases.
> 
> The first one is a firmware without resource table. In this case table_ptr
> should be null, or we have to consider the -ENOENT error as a non error usecase.
>

Right, I'll provision for those cases.
 
> The second one, more tricky, is a firmware started by the remoteproc framework.
> In this case the resource table address is retrieved from the ELF file by the
> core part.

Correct.

> So if we detach and reattach rproc_get_loaded_rsc_table cannot return the
> address. Look to me that we should have also an alocation of the clean_table in
> rproc_start and then to keep the memory allocated until a shutdown.

I assumed the address of the resource table found in the ELF image was the same
as the one known by the platform driver.  In hindsight I realise the platform
driver may not know that address.

> 
> That said regarding the complexity to re-attach, I wonder if it would not be
> better to focus first on a simple detach, and address the reattachment in a
> separate series, to move forward in stages.

I agree that OFFLINE -> RUNNING -> DETACHED -> ATTACHED is introducing some
complexity related to the management of the resource table that where not
expected.  We could concentrate on a simple detach and see where that takes us.
It would also mean to get rid of the "autonomous-on-core-shutdown" DT binding. 

Thanks,
Mathieu

> 
> Regards,
> Arnaud
> 
> > +		else
> > +			ret = PTR_ERR(table_ptr);
> > +
> > +		dev_err(dev, "can't load resource table: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * The resource table is already loaded in device memory, no need
> > +	 * to work with a cached table.
> > +	 */
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
> > @@ -1556,6 +1585,12 @@ static int rproc_attach(struct rproc *rproc)
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
