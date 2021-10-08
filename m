Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C042742E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 01:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbhJHX33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 19:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhJHX32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 19:29:28 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EAEC061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 16:27:32 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l7-20020a0568302b0700b0054e40740571so7790076otv.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 16:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UcoB+5fCYF52we3qe/RiFWGs8jkkNhY5tHgymk6y40o=;
        b=NLD/D3P5mqq3fW68lN15+KWSAZeFqaGF+aJuxw9CoGyup0gCHTxodQpE6VivP1j1xp
         5aQX9A9E5vENxJWzhc/KnpOEfQf4yVBXtkQ1jV68tKH2Xc6W5i1zzZH4zwrERc4fEikS
         YjQs8tmh3d/u/5mjwciWLPIuWjtmNbaXjo9DNw6T2JbVxPABfoSIMLHv6K/wdb9LC3Ce
         Uz4OUoaTKfxJtcwA9kbHN9khRTkegkU0scHi0jdo0bhV9Zr+eWqeR2cfOylIy3HBlpNG
         +87OL0YMB3eoEKtagaw+n9hLPPuVYOpuZGqBS+RhcXe5gY6GgvMTXbMsDrce66xKl9wG
         Xy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UcoB+5fCYF52we3qe/RiFWGs8jkkNhY5tHgymk6y40o=;
        b=5Rp301M9eab78M4sy44J/OG89HoBSdmeJJqtpBRPwDRDtgiKSSa9SnvmOzwuJtNux1
         BOluuwIoZT3r+uT0g5REIsxZ17GCsUYiXO4poTL8yHxqlkposOhRvjZaZMrPAC1W+bv9
         ytKmlfn29igkjC92LK/UhiPO6APbteT8lED5pVf+n7FPjKovkJfAoCIYzn6KdB90Yb82
         dn4GADw/QKnnRw2lXL6ronQPnu/5up1IrJiM/QhxRv9SmXCmmERJ2qm1+ELhEx2xTKry
         j7fQi7aUWKx4lnRL2mw/0TxVxogSZIlvN8mup6cEUcAq0Kew9E39GkpQlrFD7zcFqN3v
         V42w==
X-Gm-Message-State: AOAM531W2qFHcHNGqUN8QEVb3CtltIo65TkVNm24dIqPHRPDdxRtO8To
        paQsJX8NDf9fnVUhBay2Tc6g35ofhUAZZA==
X-Google-Smtp-Source: ABdhPJxJ6Y5o8Ma3y0qrOQzeuoTAxD9GmIPjDyw5Vh2WcihB6FL1lmd9w2RqDM0YuWzvO8wZn8Nu2w==
X-Received: by 2002:a05:6830:60c:: with SMTP id w12mr11030494oti.370.1633735651730;
        Fri, 08 Oct 2021 16:27:31 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id h11sm165108otu.49.2021.10.08.16.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 16:27:31 -0700 (PDT)
Date:   Fri, 8 Oct 2021 16:29:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 2/4] rpmsg: char: Export eptdev create an destroy
 functions
Message-ID: <YWDURVTg1PpxRDEu@ripper>
References: <20210712123752.10449-1-arnaud.pouliquen@foss.st.com>
 <20210712123752.10449-3-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712123752.10449-3-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12 Jul 05:37 PDT 2021, Arnaud Pouliquen wrote:
[..]
> diff --git a/drivers/rpmsg/rpmsg_char.h b/drivers/rpmsg/rpmsg_char.h
> new file mode 100644
> index 000000000000..22573b60e008
> --- /dev/null
> +++ b/drivers/rpmsg/rpmsg_char.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) STMicroelectronics 2021.
> + */
> +
> +#ifndef __RPMSG_CHRDEV_H__
> +#define __RPMSG_CHRDEV_H__
> +
> +#if IS_REACHABLE(CONFIG_RPMSG_CHAR)

This does allow you to build a kernel with RPMSG_CHAR=m and RPMSG_CTRL=y
without link failures. Any modules in the system will be able to call
rpmsg_chrdev_eptdev_create(), but the rpmsg_ctrl driver will only end up
in the stub.

This sounds like a recipe for a terrible debugging session...

Regards,
Bjorn

> +/**
> + * rpmsg_chrdev_eptdev_create() - register char device based on an endpoint
> + * @rpdev:  prepared rpdev to be used for creating endpoints
> + * @parent: parent device
> + * @chinfo: associated endpoint channel information.
> + *
> + * This function create a new rpmsg char endpoint device to instantiate a new
> + * endpoint based on chinfo information.
> + */
> +int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
> +			       struct rpmsg_channel_info chinfo);
> +
> +/**
> + * rpmsg_chrdev_eptdev_destroy() - destroy created char device endpoint.
> + * @data: private data associated to the endpoint device
> + *
> + * This function destroys a rpmsg char endpoint device created by the RPMSG_DESTROY_EPT_IOCTL
> + * control.
> + */
> +int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data);
> +
> +#else  /*IS_REACHABLE(CONFIG_RPMSG_CHAR) */
> +
> +static inline int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
> +					     struct rpmsg_channel_info chinfo)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return 0;
> +}
> +
> +#endif /*IS_REACHABLE(CONFIG_RPMSG_CHAR) */
> +
> +#endif /*__RPMSG_CHRDEV_H__ */
> -- 
> 2.17.1
> 
