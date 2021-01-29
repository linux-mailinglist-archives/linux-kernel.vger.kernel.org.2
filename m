Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE5C309024
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhA2WcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhA2WcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:32:20 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAC7C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 14:31:38 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id a20so6521508pjs.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 14:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=44aPK+qfNhVHStfDRIRpD5EW6awmzw8NVPyHtW87QUk=;
        b=I/mJtt2raReIV2iEoMHX1xil1KU9AFUZgaa0Ine2hW8R/Sm9D+KJHnuhhMJzAr1zWs
         uu7PPSZfHcva/KAgOPnjxasA3P5JvRlqkG15EUz7v5T79mFtIuGbx8z25GX9aKedCohD
         mqD2pDgj/PKw3abvd5xTIJSx/7Jov1wde8WLIMPcp9ECKvWs2oXt804Yts591zXvrQtK
         6zw42Bfee+w60zonnl4dR3kSdQV6kwsNu4yMYpbYIrgiBnDVd97zMll8dpfH3mol8feD
         LfVPIbI0e8xz6XMHG8/7f1ecO4I6nHcXOD6yLEZ3ojd1k7e4oQgjyeeS7Y+b+Y5jRIM1
         bKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=44aPK+qfNhVHStfDRIRpD5EW6awmzw8NVPyHtW87QUk=;
        b=gKCkH6wOjTSQ1aeTtBVaGT3VNRpjdl1akgEL/Q81DLmkBTF81alGIiQUDE4PhNw3e0
         Oy3IjC2Gb0sloCI2RSLfVT1RBWbUDCx+P5kEDr+YNSL2+tdJyWUSnBJyZDmJRWxVvUzG
         lU0RkjDuUnJ/07yWDsazrVxq8T6xnE2AsgM/lTugBmqrenWtZXBZSm32+gQQu5d6DYx9
         Nj7GEnplLa92Uqusm9Hrjh+ZuQalrE9hVScHFrw+8lJq06rSOFg+TdTgoiEQ82tS+sCw
         JVhp7bbuAW3wtGEJhyF8b9Byd+Y+xikgK6pbIyzOD9uLVStuH6vYvSzUvXn6HXh/ktC8
         gC3w==
X-Gm-Message-State: AOAM530A1QFleAQb1VdAct+sv9k9rmBGuO10F+2eNKyU4zQnCK0cDPgi
        13eOkZeP7e1HCzyLiUi3WLEI8A==
X-Google-Smtp-Source: ABdhPJyQgV/v73KQ9zgZ2nRJvw59hBZ/pWV5hCqHwOyxLJDf+0Q14wR+lhkPz8KLyQs3j03N8ePt5A==
X-Received: by 2002:a17:902:70c5:b029:e0:5b2:50f2 with SMTP id l5-20020a17090270c5b02900e005b250f2mr6464751plt.20.1611959498270;
        Fri, 29 Jan 2021 14:31:38 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q15sm7896588pfk.181.2021.01.29.14.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:31:37 -0800 (PST)
Date:   Fri, 29 Jan 2021 15:31:35 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 12/17] remoteproc: Introduce function rproc_detach()
Message-ID: <20210129223135.GC1319650@xps15>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
 <20201218173228.2277032-13-mathieu.poirier@linaro.org>
 <406cd7ad-060e-a611-be20-5c1869f17e73@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406cd7ad-060e-a611-be20-5c1869f17e73@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 09:50:31AM +0100, Arnaud POULIQUEN wrote:
> 
> 
> On 12/18/20 6:32 PM, Mathieu Poirier wrote:
> > Introduce function rproc_detach() to enable the remoteproc
> > core to release the resources associated with a remote processor
> > without stopping its operation.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 71 +++++++++++++++++++++++++++-
> >  include/linux/remoteproc.h           |  2 +
> >  2 files changed, 72 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index e665ed4776c3..ece3f15070b9 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1673,7 +1673,7 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
> >  /*
> >   * __rproc_detach(): Does the opposite of rproc_attach()
> >   */
> > -static int __maybe_unused __rproc_detach(struct rproc *rproc)
> > +static int __rproc_detach(struct rproc *rproc)
> >  {
> >  	struct device *dev = &rproc->dev;
> >  	int ret;
> > @@ -1927,6 +1927,75 @@ void rproc_shutdown(struct rproc *rproc)
> >  }
> >  EXPORT_SYMBOL(rproc_shutdown);
> >  
> > +/**
> > + * rproc_detach() - Detach the remote processor from the
> > + * remoteproc core
> > + *
> > + * @rproc: the remote processor
> > + *
> > + * Detach a remote processor (previously attached to with rproc_actuate()).
> 
> You rename the function to rproc_attach in you patch 04/17.
> 

Yes, good catch.

> Then Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> 
> Thanks,
> Arnaud
> 
> > + *
> > + * In case @rproc is still being used by an additional user(s), then
> > + * this function will just decrement the power refcount and exit,
> > + * without disconnecting the device.
> > + *
> > + * Function rproc_detach() calls __rproc_detach() in order to let a remote
> > + * processor know that services provided by the application processor are
> > + * no longer available.  From there it should be possible to remove the
> > + * platform driver and even power cycle the application processor (if the HW
> > + * supports it) without needing to switch off the remote processor.
> > + */
> > +int rproc_detach(struct rproc *rproc)
> > +{
> > +	struct device *dev = &rproc->dev;
> > +	int ret;
> > +
> > +	ret = mutex_lock_interruptible(&rproc->lock);
> > +	if (ret) {
> > +		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
> > +		return ret;
> > +	}
> > +
> > +	if (rproc->state != RPROC_RUNNING && rproc->state != RPROC_ATTACHED) {
> > +		ret = -EPERM;
> > +		goto out;
> > +	}
> > +
> > +	/* if the remote proc is still needed, bail out */
> > +	if (!atomic_dec_and_test(&rproc->power)) {
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +
> > +	ret = __rproc_detach(rproc);
> > +	if (ret) {
> > +		atomic_inc(&rproc->power);
> > +		goto out;
> > +	}
> > +
> > +	/* clean up all acquired resources */
> > +	rproc_resource_cleanup(rproc);
> > +
> > +	rproc_disable_iommu(rproc);
> > +
> > +	/*
> > +	 * If the remote processor was booted by the core the cached table needs
> > +	 * to be freed and ->table_ptr set to NULL because it will be
> > +	 * invalidated by rproc_resource_cleanup().  If the remote processor was
> > +	 * attached to ->cached_table is NULL and kfree() returns right away.
> > +	 *
> > +	 * In either case ->table_ptr has to be set to NULL.  It will be set
> > +	 * again when the remote processor is re-attached to.
> > +	 */
> > +	kfree(rproc->cached_table);
> > +	rproc->cached_table = NULL;
> > +	rproc->table_ptr = NULL;
> > +out:
> > +	mutex_unlock(&rproc->lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(rproc_detach);
> > +
> >  /**
> >   * rproc_get_by_phandle() - find a remote processor by phandle
> >   * @phandle: phandle to the rproc
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 9bb34c3eb847..65ece6f177b7 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -659,6 +659,8 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, size_t len,
> >  
> >  int rproc_boot(struct rproc *rproc);
> >  void rproc_shutdown(struct rproc *rproc);
> > +int rproc_detach(struct rproc *rproc);
> > +int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
> >  void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
> >  int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
> >  int rproc_coredump_add_custom_segment(struct rproc *rproc,
> > 
