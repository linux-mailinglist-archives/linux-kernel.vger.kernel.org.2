Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7AF308F88
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 22:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhA2ViU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 16:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhA2ViS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 16:38:18 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A9AC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:37:38 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id j11so3436215plt.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SrywxkhnsrhfDSQfSh3vuiKPpzrqoaLpb/9iy65ia3c=;
        b=t1Z3aKCcMZfhCcEf09Qx+Y/J6iJoNKP+w6T/5m6ysuRjjHASq3d0AcB2I1uuoExw3v
         fuNQdN+Zqpjz+RiGBmqOA5CqMSmHpt4VCz8M95GUF+wadsTZzi6K5VIGh2ojL0ilfd5Z
         kduHcrJv4iTnYOouh/p8tvRTQng2ccogSM+Hi4ccSRWOLumZv3lqO01dsvY1s21wHqwL
         EDOnClmFWstgVE7/EwUwL2uoHz5TNU1jcgzRQfetXjjUa+jXmt2a6Tad1/A8Erq1qM7Z
         YtzJeWOW9pV9DkkpRcazF6LkpBxeLj0hpszCgFtp2kcUcZgDA5NCFFE8RXwc1X3GNcoj
         vrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SrywxkhnsrhfDSQfSh3vuiKPpzrqoaLpb/9iy65ia3c=;
        b=XulViW3h+w/lMm9nIIIVaHU9Uze/6LpDPyGR+H38EpsWf9/Oub1DkZ6X8KWcyFKsyX
         oKIoqDGcu8f+qi8RdRJckDH1cfAle/1v3HjnxVmbX3s/UKzsgY8iOMntIHpTE+ouChPu
         gsrFFCm2ODMWK5aSspfELSevdilUMQx2uIXJDPb1Mn7Sre9tB/BWxo888gsI6fwsEMkZ
         3wH3unGnc1TwQkI03K98AojJSWUGmzVNijquK1GiuGKaR9ffUQ7lMkzOIe1LJNYiK10V
         nK6mAK5EtL2MzNRA29n4UPMqMFQYGc56jddDI2X9HGOiPtZP5qI/+aKWPld+s8XYIZf0
         nOIQ==
X-Gm-Message-State: AOAM533JoPSgdCXu5+ZwZ5H1acKnGoGlJth8aey7aMUxwB3biJt/6fHc
        bMGNaRDem6JEoAPTIK2UogHvgw==
X-Google-Smtp-Source: ABdhPJyg0qjOgkEMEtcWc76txMLsgL45EqaXl5uGsCPJID91XIu/+lLf9GJL9DbW5r85gXEMFOvizA==
X-Received: by 2002:a17:90a:7c45:: with SMTP id e5mr1056044pjl.170.1611956258055;
        Fri, 29 Jan 2021 13:37:38 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p68sm94258pfb.60.2021.01.29.13.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 13:37:37 -0800 (PST)
Date:   Fri, 29 Jan 2021 14:37:35 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/17] remoteproc: Add new get_loaded_rsc_table()
 remoteproc operation
Message-ID: <20210129213735.GA1319650@xps15>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
 <20201218173228.2277032-6-mathieu.poirier@linaro.org>
 <47edac31-2f5f-efa9-2699-9fbec7f0d263@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47edac31-2f5f-efa9-2699-9fbec7f0d263@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 09:44:28AM +0100, Arnaud POULIQUEN wrote:
> Hi Mathieu,
> 
> Come back on you series...
> 
> On 12/18/20 6:32 PM, Mathieu Poirier wrote:
> > Add an new get_loaded_rsc_table() operation in order to support
> > scenarios where the remoteproc core has booted a remote processor
> > and detaches from it.  When re-attaching to the remote processor,
> > the core needs to know where the resource table has been placed
> > in memory.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_core.c     | 6 ++++++
> >  drivers/remoteproc/remoteproc_internal.h | 8 ++++++++
> >  include/linux/remoteproc.h               | 5 ++++-
> >  3 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index d0f6b39b56f9..3d87c910aca7 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1556,6 +1556,12 @@ static int rproc_attach(struct rproc *rproc)
> >  		return ret;
> >  	}
> >  
> > +	ret = rproc_get_loaded_rsc_table(rproc);
> > +	if (ret) {
> > +		dev_err(dev, "can't load resource table: %d\n", ret);
> > +		goto disable_iommu;
> > +	}
> > +
> 
> This function is rather ambiguous. Without the example of stm32, it is not
> obvious what the platform driver has to do in this ops. And the update of rproc
> in the in the core instead of in platform driver seems to me more reliable.
> 
> Here is a suggestion considering that ->cached_table is always NULL:
> 
> 
> struct resource_table *rproc_get_loaded_rsc_table(struct rproc *rproc,
>                                                   size_t* size)
> {
> 
> 	if (rproc->ops->get_loaded_rsc_table) {
> 		return rproc->ops->get_loaded_rsc_table(rproc, size);
> 
> 	*size = 0;
> 	return NULL;
> }
> 
> then in rproc_attach:
> 
> 	table_ptr = rproc_get_loaded_rsc_table(rproc, &tab_size);
> 	if (PTR_ERR(table_ptr) {
> 		dev_err(dev, "can't load resource table: %d\n", ret);
> 		goto disable_iommu;
> 	}
>  	rproc->cached_table = NULL;
>  	rproc->table_ptr = table_ptr;
>  	rproc->table_sz = table_sz;
>

Much better yes, thanks for the suggestion.
 
> 
> Thanks,
> Arnaud
> 
> >  	/* reset max_notifyid */
> >  	rproc->max_notifyid = -1;
> >  
> > diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> > index c34002888d2c..c48b301d6ad1 100644
> > --- a/drivers/remoteproc/remoteproc_internal.h
> > +++ b/drivers/remoteproc/remoteproc_internal.h
> > @@ -177,6 +177,14 @@ struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
> >  	return NULL;
> >  }
> >  
> > +static inline int rproc_get_loaded_rsc_table(struct rproc *rproc)
> > +{
> > +	if (rproc->ops->get_loaded_rsc_table)
> > +		return rproc->ops->get_loaded_rsc_table(rproc);
> > +
> > +	return 0;
> > +}
> > +
> >  static inline
> >  bool rproc_u64_fit_in_size_t(u64 val)
> >  {
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 3fa3ba6498e8..571615e77e6f 100644
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
> > @@ -389,6 +391,7 @@ struct rproc_ops {
> >  			  int offset, int avail);
> >  	struct resource_table *(*find_loaded_rsc_table)(
> >  				struct rproc *rproc, const struct firmware *fw);
> > +	int (*get_loaded_rsc_table)(struct rproc *rproc);
> >  	int (*load)(struct rproc *rproc, const struct firmware *fw);
> >  	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
> >  	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
> > 
