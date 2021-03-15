Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2778733C497
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhCORhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbhCORh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:37:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935B4C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:37:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so14791581pjh.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6tzWJFrnQsA9R0ltOnjmT6ONH7vUsFiXRrsDNZLyLeE=;
        b=geG7dA7E2zlS9xUqBaDEUdwx5UsGP1Xgs1ukLka9/F1hO2wL7a+sQtugn8N1aPmriD
         CR+M8zTuQqRHFM+qCDl6XyAnsg6ktSxgCsk3EIQbXTC2V2QR/IfLdA9bAS6SlWYaoUDk
         Xp1T65v1iPHG+f73m/odoiqRisah7Awbq4UHNYjDywCC/2usi9lq9kxwnslKwLMkIOtn
         1kDjtCs8jQ92/vF6qtNSvVxES7ZcYguzt0EnDJ0InuSzjl3pOc+7I7JKHg1cROahtTRG
         dvaYxM/HHN9PGujCM2A/YYY2t8AIRjROikkaqWubv9azkfGEMjsAASX1dhT3100eTeCU
         bYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6tzWJFrnQsA9R0ltOnjmT6ONH7vUsFiXRrsDNZLyLeE=;
        b=W3DrPf/L5aIK+Dxvk9wCIuTQNKWcy8u0AmmlxT43QYgVcUkyvtwcxyFz8BO5vhxFuX
         sSnb+B7VjkFXJMEh/mi4Xul8R3bvS8Q8jQfKfzkJD4EjHrtwaAldv9ZVQ4dWua2sSHTQ
         i9Zdx6xpXQ9ilbKK++cyVTvvxGU81lEe8wj/X8T4KKPhIJ2Drxkb7jWsDn2gP728S4f5
         B4gtnl8ak7M7O7MLaF1mWtzm+2ejgoyPFzrPIRJ3CgDWfoM3KVKdpCZf9MKK3uQycXIV
         5WqzZ55NmZD8wcYmPU2pYpCRctemU6VkV0RMw5rXlj9DOY7sY66q7HlFVYB01iHJWAiv
         Rkmg==
X-Gm-Message-State: AOAM5336Ypfzh71OtLdgDoimIa/8ErEynHpWPfaiz1CX1LMw6oDbNOBW
        W+u5TSDsBChRDVyU7ocWLa6eDvZimzHN+w==
X-Google-Smtp-Source: ABdhPJzjBVUfU6SxcPXB+wS9Ia8KPxsgV7MB4yaLdCDuVvNy+1MQJ3vYLTLfMobUudVVgJAtxBFz/w==
X-Received: by 2002:a17:90a:8914:: with SMTP id u20mr209590pjn.90.1615829846821;
        Mon, 15 Mar 2021 10:37:26 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a20sm14934585pfl.97.2021.03.15.10.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:37:26 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:37:24 -0600
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
Message-ID: <20210315173724.GB1342614@xps15>
References: <20210223154447.13247-1-ben.levinsky@xilinx.com>
 <20210223154447.13247-6-ben.levinsky@xilinx.com>
 <20210309165330.GA4013290@xps15>
 <38527B70-FE3A-4D05-8C2E-6A95A3D4ADF3@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38527B70-FE3A-4D05-8C2E-6A95A3D4ADF3@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 11:49:13PM +0000, Ben Levinsky wrote:
> Hi Mathieu
> 
> ﻿-----Original Message-----
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> Date: Tuesday, March 9, 2021 at 8:53 AM
> To: Ben Levinsky <BLEVINSK@xilinx.com>
> Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Simek <michals@xilinx.com>
> Subject: Re: [PATCH v26 5/5] remoteproc: Add initial zynqmp R5 remoteproc driver
> 
>     [...]
> 
>     > +
>     > +/**
>     > + * zynqmp_r5_probe - Probes ZynqMP R5 processor device node
>     > + *		       this is called for each individual R5 core to
>     > + *		       set up mailbox, Xilinx platform manager unique ID,
>     > + *		       add to rproc core
>     > + *
>     > + * @pdev: domain platform device for current R5 core
>     > + * @node: pointer of the device node for current R5 core
>     > + * @rpu_mode: mode to configure RPU, split or lockstep
>     > + *
>     > + * Return: 0 for success, negative value for failure.
>     > + */
>     > +static struct zynqmp_r5_rproc *zynqmp_r5_probe(struct platform_device *pdev,
>     > +					       struct device_node *node,
>     > +					       enum rpu_oper_mode rpu_mode)
>     > +{
>     > +	int ret, num_banks;
>     > +	struct device *dev = &pdev->dev;
>     > +	struct rproc *rproc_ptr;
>     > +	struct zynqmp_r5_rproc *z_rproc;
>     > +	struct device_node *r5_node;
>     > +
>     > +	/* Allocate remoteproc instance */
>     > +	rproc_ptr = devm_rproc_alloc(dev, dev_name(dev), &zynqmp_r5_rproc_ops,
>     > +				     NULL, sizeof(struct zynqmp_r5_rproc));
>     > +	if (!rproc_ptr) {
>     > +		ret = -ENOMEM;
>     > +		goto error;
>     > +	}
>     > +
>     > +	rproc_ptr->auto_boot = false;
>     > +	z_rproc = rproc_ptr->priv;
>     > +	z_rproc->rproc = rproc_ptr;
>     > +	r5_node = z_rproc->rproc->dev.parent->of_node;
>     > +
>     > +	/* Set up DMA mask */
>     > +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>     > +	if (ret)
>     > +		goto error;
>     > +
>     > +	/* Get R5 power domain node */
>     > +	ret = of_property_read_u32(node, "power-domain", &z_rproc->pnode_id);
>     > +	if (ret)
>     > +		goto error;
>     > +
>     > +	ret = r5_set_mode(z_rproc, rpu_mode);
>     > +	if (ret)
>     > +		goto error;
>     > +
>     > +	if (of_property_read_bool(node, "mboxes")) {
>     > +		ret = zynqmp_r5_setup_mbox(z_rproc, node);
>     > +		if (ret)
>     > +			goto error;
>     > +	}
>     > +
>     > +	/* go through TCM banks for r5 node */
>     > +	num_banks = of_count_phandle_with_args(r5_node, BANK_LIST_PROP, NULL);
>     > +	if (num_banks <= 0) {
>     > +		dev_err(dev, "need to specify TCM banks\n");
>     > +		ret = -EINVAL;
>     > +		goto error;
>     > +	}
>     > +
>     > +	if (num_banks > NUM_SRAMS) {
>     > +		dev_err(dev, "max number of srams is %d. given: %d \r\n",
>     > +			NUM_SRAMS, num_banks);
>     > +		ret = -EINVAL;
>     > +		goto error;
>     > +	}
>     > +
>     > +	/* construct collection of srams used by the current R5 core */
>     > +	for (; num_banks; num_banks--) {
>     > +		struct resource rsc;
>     > +		struct device_node *dt_node;
>     > +		resource_size_t size;
>     > +		int i;
>     > +
>     > +		dt_node = of_parse_phandle(r5_node, BANK_LIST_PROP, i);
> 
>     Variable @i is not initialised but it is used as an index to retrieve a handle
>     to the sram banks.  That code _should_ have failed frequently or at least have
>     yielded abnormal results often enough to be noticed.  Why wasn't it the case?
> 
>     I will stop here for the moment.
> 
> [Ben]
> Yes this should be initialized. The reason this got through is that as i defaults to 0 and the 0th bank housed the required data. the case where SRAMS that can be written to, 0xFFE20000 in this case of split mode and on R5-0, was not caught.
> 

Here @i is a variable allocated on the stack and as such it is garanteed to be
garbage on initialisation - it will do anything but default to 0.


> Instead of i I will use 
> 
>                 sram_node = of_parse_phandle(node, BANK_LIST_PROP,              
>                                              num_banks - 1); 

Do you have to start with the last bank?  If memory serves me well it isn't the
case in the previous revisions.  Why not go back to the implementation you had
in V25?  

