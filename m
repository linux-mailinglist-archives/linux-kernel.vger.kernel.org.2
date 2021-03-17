Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0D33F57A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhCQQ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhCQQ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:27:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A26C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:27:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bt4so1404388pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MBYMaK89076Yqms9jzDXHj92BGi/krH6Ls/9qUJftRo=;
        b=ouzpVWP0seNzSvrU7krFFGaBGs2cJ96jR5ESDiDv5hrHSHco6PeHGfJUDN5Wnro7+L
         CjJc8tndpJjuD2eBMzmH3A4VUpX2Kz3i5DkIYRrRQnBnAryA65AvgPDI+KMd0/bs1H7b
         T+KAVkCqmFC5XiziVw7Fnw47VnARxZHvcg5pwCqDCBgt6dzDNhOIAvTfDTV0l+HmDQ7S
         x3GIl5SOXZM+MhuiM8dBdpNSKV1VROeaPmiht/xTOQWM5sSAsaVLH1zEchL8Y1DwVS5p
         ZP2BqbEe9fqCOkatrtluvdLeMaqGdmp4Z90MSGXLXR7z1kxcdaFBMoE6e73n2RVtIpqX
         mPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MBYMaK89076Yqms9jzDXHj92BGi/krH6Ls/9qUJftRo=;
        b=D9TGzukeUSofZSFxf+SpPRMOCxK4EHqc7O5p4Nm0t+kfaPoulSfyZWgnfhRJPrSHNL
         cdCuMca+ajQqOeDU+Qp8WO8DHv2zGaZ/Q/X6ca17nZwZgw97Z4O0WvVzZ1WO2/7zoFkn
         y5ze9oZ0sICCULwALyHZcapJIczk7AXgVr2su1tXEoVba3ugzBRpU7ShBu+BvugxabFS
         numoi3aPtzRg3AgERhdAZR4eeluQyClO3RJHdCDzdAiQr++Ky/Yku39BBFMZkAtbZzds
         4/uGYUvPy/y5OSqDdyB8KQ+1eL/IKQhEbvXoTVAKkX3rZ6QSYTi8DH/6G9TwqEFLnCCl
         //Tg==
X-Gm-Message-State: AOAM530tcU9YtI8bS5ym2w0arloxGqypBBX0T28oubC9dD3ce/u5IG9L
        42Wa/H+fqXZFbPusWmyhsrGy7g==
X-Google-Smtp-Source: ABdhPJx92boKt/4oQc9PjsC+hH95eM143VVVrDH6h71Zq0GlSQ3s9m6xNHY1jPU/pATwN4UYmUnPqg==
X-Received: by 2002:a17:902:bb83:b029:e5:dacc:9035 with SMTP id m3-20020a170902bb83b02900e5dacc9035mr5130619pls.80.1615998458964;
        Wed, 17 Mar 2021 09:27:38 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t16sm20450137pfc.204.2021.03.17.09.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 09:27:38 -0700 (PDT)
Date:   Wed, 17 Mar 2021 10:27:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Ben Levinsky <BLEVINSK@xilinx.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <michals@xilinx.com>,
        "Ed T. Mooring" <emooring@xilinx.com>
Subject: Re: [PATCH v26 5/5] remoteproc: Add initial zynqmp R5 remoteproc
 driver
Message-ID: <20210317162736.GB1494354@xps15>
References: <20210223154447.13247-1-ben.levinsky@xilinx.com>
 <20210223154447.13247-6-ben.levinsky@xilinx.com>
 <20210309165330.GA4013290@xps15>
 <38527B70-FE3A-4D05-8C2E-6A95A3D4ADF3@xilinx.com>
 <20210315173724.GB1342614@xps15>
 <09895E3D-AED4-4DBF-A48C-684271275D49@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09895E3D-AED4-4DBF-A48C-684271275D49@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 09:32:40PM +0000, Ben Levinsky wrote:
> 
> 
> ﻿-----Original Message-----
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> Date: Monday, March 15, 2021 at 10:37 AM
> To: Ben Levinsky <BLEVINSK@xilinx.com>
> Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Simek <michals@xilinx.com>, "Ed T. Mooring" <emooring@xilinx.com>
> Subject: Re: [PATCH v26 5/5] remoteproc: Add initial zynqmp R5 remoteproc driver
> 
>     On Thu, Mar 11, 2021 at 11:49:13PM +0000, Ben Levinsky wrote:
>     > Hi Mathieu
>     > 
>     > -----Original Message-----
>     > From: Mathieu Poirier <mathieu.poirier@linaro.org>
>     > Date: Tuesday, March 9, 2021 at 8:53 AM
>     > To: Ben Levinsky <BLEVINSK@xilinx.com>
>     > Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Simek <michals@xilinx.com>
>     > Subject: Re: [PATCH v26 5/5] remoteproc: Add initial zynqmp R5 remoteproc driver
>     > 
>     >     [...]
>     > 
>     >     > +
>     >     > +/**
>     >     > + * zynqmp_r5_probe - Probes ZynqMP R5 processor device node
>     >     > + *		       this is called for each individual R5 core to
>     >     > + *		       set up mailbox, Xilinx platform manager unique ID,
>     >     > + *		       add to rproc core
>     >     > + *
>     >     > + * @pdev: domain platform device for current R5 core
>     >     > + * @node: pointer of the device node for current R5 core
>     >     > + * @rpu_mode: mode to configure RPU, split or lockstep
>     >     > + *
>     >     > + * Return: 0 for success, negative value for failure.
>     >     > + */
>     >     > +static struct zynqmp_r5_rproc *zynqmp_r5_probe(struct platform_device *pdev,
>     >     > +					       struct device_node *node,
>     >     > +					       enum rpu_oper_mode rpu_mode)
>     >     > +{
>     >     > +	int ret, num_banks;
>     >     > +	struct device *dev = &pdev->dev;
>     >     > +	struct rproc *rproc_ptr;
>     >     > +	struct zynqmp_r5_rproc *z_rproc;
>     >     > +	struct device_node *r5_node;
>     >     > +
>     >     > +	/* Allocate remoteproc instance */
>     >     > +	rproc_ptr = devm_rproc_alloc(dev, dev_name(dev), &zynqmp_r5_rproc_ops,
>     >     > +				     NULL, sizeof(struct zynqmp_r5_rproc));
>     >     > +	if (!rproc_ptr) {
>     >     > +		ret = -ENOMEM;
>     >     > +		goto error;
>     >     > +	}
>     >     > +
>     >     > +	rproc_ptr->auto_boot = false;
>     >     > +	z_rproc = rproc_ptr->priv;
>     >     > +	z_rproc->rproc = rproc_ptr;
>     >     > +	r5_node = z_rproc->rproc->dev.parent->of_node;
>     >     > +
>     >     > +	/* Set up DMA mask */
>     >     > +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>     >     > +	if (ret)
>     >     > +		goto error;
>     >     > +
>     >     > +	/* Get R5 power domain node */
>     >     > +	ret = of_property_read_u32(node, "power-domain", &z_rproc->pnode_id);
>     >     > +	if (ret)
>     >     > +		goto error;
>     >     > +
>     >     > +	ret = r5_set_mode(z_rproc, rpu_mode);
>     >     > +	if (ret)
>     >     > +		goto error;
>     >     > +
>     >     > +	if (of_property_read_bool(node, "mboxes")) {
>     >     > +		ret = zynqmp_r5_setup_mbox(z_rproc, node);
>     >     > +		if (ret)
>     >     > +			goto error;
>     >     > +	}
>     >     > +
>     >     > +	/* go through TCM banks for r5 node */
>     >     > +	num_banks = of_count_phandle_with_args(r5_node, BANK_LIST_PROP, NULL);
>     >     > +	if (num_banks <= 0) {
>     >     > +		dev_err(dev, "need to specify TCM banks\n");
>     >     > +		ret = -EINVAL;
>     >     > +		goto error;
>     >     > +	}
>     >     > +
>     >     > +	if (num_banks > NUM_SRAMS) {
>     >     > +		dev_err(dev, "max number of srams is %d. given: %d \r\n",
>     >     > +			NUM_SRAMS, num_banks);
>     >     > +		ret = -EINVAL;
>     >     > +		goto error;
>     >     > +	}
>     >     > +
>     >     > +	/* construct collection of srams used by the current R5 core */
>     >     > +	for (; num_banks; num_banks--) {
>     >     > +		struct resource rsc;
>     >     > +		struct device_node *dt_node;
>     >     > +		resource_size_t size;
>     >     > +		int i;
>     >     > +
>     >     > +		dt_node = of_parse_phandle(r5_node, BANK_LIST_PROP, i);
>     > 
>     >     Variable @i is not initialised but it is used as an index to retrieve a handle
>     >     to the sram banks.  That code _should_ have failed frequently or at least have
>     >     yielded abnormal results often enough to be noticed.  Why wasn't it the case?
>     > 
>     >     I will stop here for the moment.
>     > 
>     > [Ben]
>     > Yes this should be initialized. The reason this got through is that as i defaults to 0 and the 0th bank housed the required data. the case where SRAMS that can be written to, 0xFFE20000 in this case of split mode and on R5-0, was not caught.
>     > 
> 
>     Here @i is a variable allocated on the stack and as such it is garanteed to be
>     garbage on initialisation - it will do anything but default to 0.
> 
> Ok.
> 
>     > Instead of i I will use 
>     > 
>     >                 sram_node = of_parse_phandle(node, BANK_LIST_PROP,              
>     >                                              num_banks - 1); 
> 
>     Do you have to start with the last bank?  If memory serves me well it isn't the
>     case in the previous revisions.  Why not go back to the implementation you had
>     in V25?  
> 
> Makes sense. Will revert as suggested.

For your next revision, go back to V25 and fix only what I commented on.  I
can't remember but you may also have to fix the put_device() problem we've been
discussing. 

> 
> 
