Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0193B2171
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 21:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFWUAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWUAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624478271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5hpJfpSLAUgqIRFqoRgipAVrUMETdYygvzw8aCeIUiE=;
        b=Cp0ZMah496cWrYlahNSNcpUm/FwuJ9nJH9GIgGIZ2KfOZ5xN1IiA6MnGmCwJgKgibqafax
        L11rxgOaQISBtIPk42lNjOd+g35tjnLbabDtvlLNooph4dKjHjOqAm3WM1CNDfTbzxz9WY
        Z0MfoOCfGjWPvqIzoPYVLvVFcB2kwP0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-ce_l1M8NPxK_zZgXOTwVyg-1; Wed, 23 Jun 2021 15:57:50 -0400
X-MC-Unique: ce_l1M8NPxK_zZgXOTwVyg-1
Received: by mail-wr1-f69.google.com with SMTP id u16-20020a5d51500000b029011a6a17cf62so1411993wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 12:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5hpJfpSLAUgqIRFqoRgipAVrUMETdYygvzw8aCeIUiE=;
        b=paXh2pxEYxnojXzuv5EYUF7c4OGT01J0bpngm1ZZOjys27MmQSod6t1RmQHAOu4c/a
         ys2vzEnVtPnavPvnF1elI1qZzR23wtW51GLvaX3fyoe7hS7Vg/uSI6f1/Ghf9b/hrrCa
         eI/oCiLF+ow6V3y5UL+cOur67N1Xsl9NLg5gVCUCPUfhQ0pKVOfD9EmCZ5uz6T63kcnL
         GnVJDYcmoUzFbog0G9mYeNkFXWl5ITZu7bZeFKEsDutIHq1zcv9UrpqhSNHhZSMp96lc
         puSL5thEovNJUdWZir65vP6nAmChTCIbmcMbHZyVd4Y98D0F7mj/s4mkZ9xFDEsxfhYO
         s4Cw==
X-Gm-Message-State: AOAM530NyP/qilHGZaE228+mZgQVGUsluUjcJ+SMvjlBbIOMhcVZ4+Oo
        55xDaCVZv1k7rTHK2wcGY3/tRVoqk8xxlmUbcs/2SOVF2ME0B0bmALpwtGORcyfUIw1G+Hmh5l7
        L3AiHpr0xFPkZ1zdJR3Acz4pI
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr2068123wrq.328.1624478268963;
        Wed, 23 Jun 2021 12:57:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP9Ee/r0u2WkUD30fyiQuk8HVuDiocl7zIN6hK0Y9ZcKhH7cFmmZT/egDTRMRNVklano8Vug==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr2068113wrq.328.1624478268807;
        Wed, 23 Jun 2021 12:57:48 -0700 (PDT)
Received: from redhat.com ([77.124.79.210])
        by smtp.gmail.com with ESMTPSA id c8sm940897wri.91.2021.06.23.12.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:57:48 -0700 (PDT)
Date:   Wed, 23 Jun 2021 15:57:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Jason Wang <jasowang@redhat.com>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>
Subject: Re: [kbuild] drivers/vdpa/virtio_pci/vp_vdpa.c:421 vp_vdpa_probe()
 warn: missing error code 'ret'
Message-ID: <20210623155701-mutt-send-email-mst@kernel.org>
References: <202106231257.8kp6t8DF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106231257.8kp6t8DF-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 12:21:36PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> head:   0c18f29aae7ce3dadd26d8ee3505d07cc982df75
> commit: 11d8ffed00b231356008b35a3b0bc192e42333fa vp_vdpa: switch to use vp_modern_map_vq_notify()
> config: microblaze-randconfig-m031-20210622 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/vdpa/virtio_pci/vp_vdpa.c:421 vp_vdpa_probe() warn: missing error code 'ret'
> 
> Old smatch warnings:
> drivers/vdpa/virtio_pci/vp_vdpa.c:168 vp_vdpa_request_irq() warn: inconsistent indenting
> 
> vim +/ret +421 drivers/vdpa/virtio_pci/vp_vdpa.c
> 
> 64b9f64f80a6f4 Jason Wang 2021-02-23  367  static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 64b9f64f80a6f4 Jason Wang 2021-02-23  368  {
> 64b9f64f80a6f4 Jason Wang 2021-02-23  369  	struct virtio_pci_modern_device *mdev;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  370  	struct device *dev = &pdev->dev;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  371  	struct vp_vdpa *vp_vdpa;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  372  	int ret, i;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  373  
> 64b9f64f80a6f4 Jason Wang 2021-02-23  374  	ret = pcim_enable_device(pdev);
> 64b9f64f80a6f4 Jason Wang 2021-02-23  375  	if (ret)
> 64b9f64f80a6f4 Jason Wang 2021-02-23  376  		return ret;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  377  
> 64b9f64f80a6f4 Jason Wang 2021-02-23  378  	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> 64b9f64f80a6f4 Jason Wang 2021-02-23  379  				    dev, &vp_vdpa_ops, NULL);
> 64b9f64f80a6f4 Jason Wang 2021-02-23  380  	if (vp_vdpa == NULL) {
> 64b9f64f80a6f4 Jason Wang 2021-02-23  381  		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> 64b9f64f80a6f4 Jason Wang 2021-02-23  382  		return -ENOMEM;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  383  	}
> 64b9f64f80a6f4 Jason Wang 2021-02-23  384  
> 64b9f64f80a6f4 Jason Wang 2021-02-23  385  	mdev = &vp_vdpa->mdev;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  386  	mdev->pci_dev = pdev;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  387  
> 64b9f64f80a6f4 Jason Wang 2021-02-23  388  	ret = vp_modern_probe(mdev);
> 64b9f64f80a6f4 Jason Wang 2021-02-23  389  	if (ret) {
> 64b9f64f80a6f4 Jason Wang 2021-02-23  390  		dev_err(&pdev->dev, "Failed to probe modern PCI device\n");
> 64b9f64f80a6f4 Jason Wang 2021-02-23  391  		goto err;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  392  	}
> 64b9f64f80a6f4 Jason Wang 2021-02-23  393  
> 64b9f64f80a6f4 Jason Wang 2021-02-23  394  	pci_set_master(pdev);
> 64b9f64f80a6f4 Jason Wang 2021-02-23  395  	pci_set_drvdata(pdev, vp_vdpa);
> 64b9f64f80a6f4 Jason Wang 2021-02-23  396  
> 64b9f64f80a6f4 Jason Wang 2021-02-23  397  	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  398  	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
> 64b9f64f80a6f4 Jason Wang 2021-02-23  399  
> 64b9f64f80a6f4 Jason Wang 2021-02-23  400  	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
> 64b9f64f80a6f4 Jason Wang 2021-02-23  401  	if (ret) {
> 64b9f64f80a6f4 Jason Wang 2021-02-23  402  		dev_err(&pdev->dev,
> 64b9f64f80a6f4 Jason Wang 2021-02-23  403  			"Failed for adding devres for freeing irq vectors\n");
> 64b9f64f80a6f4 Jason Wang 2021-02-23  404  		goto err;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  405  	}
> 64b9f64f80a6f4 Jason Wang 2021-02-23  406  
> 64b9f64f80a6f4 Jason Wang 2021-02-23  407  	vp_vdpa->vring = devm_kcalloc(&pdev->dev, vp_vdpa->queues,
> 64b9f64f80a6f4 Jason Wang 2021-02-23  408  				      sizeof(*vp_vdpa->vring),
> 64b9f64f80a6f4 Jason Wang 2021-02-23  409  				      GFP_KERNEL);
> 64b9f64f80a6f4 Jason Wang 2021-02-23  410  	if (!vp_vdpa->vring) {
> 64b9f64f80a6f4 Jason Wang 2021-02-23  411  		ret = -ENOMEM;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  412  		dev_err(&pdev->dev, "Fail to allocate virtqueues\n");
> 64b9f64f80a6f4 Jason Wang 2021-02-23  413  		goto err;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  414  	}
> 64b9f64f80a6f4 Jason Wang 2021-02-23  415  
> 64b9f64f80a6f4 Jason Wang 2021-02-23  416  	for (i = 0; i < vp_vdpa->queues; i++) {
> 64b9f64f80a6f4 Jason Wang 2021-02-23  417  		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
> 11d8ffed00b231 Jason Wang 2021-04-15  418  		vp_vdpa->vring[i].notify = vp_modern_map_vq_notify(mdev, i);
> 11d8ffed00b231 Jason Wang 2021-04-15  419  		if (!vp_vdpa->vring[i].notify) {
> 11d8ffed00b231 Jason Wang 2021-04-15  420  			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
> 
> ret = -ENOMEM;?


More like EINVAL

> 11d8ffed00b231 Jason Wang 2021-04-15 @421  			goto err;
> 11d8ffed00b231 Jason Wang 2021-04-15  422  		}
> 64b9f64f80a6f4 Jason Wang 2021-02-23  423  	}
> 64b9f64f80a6f4 Jason Wang 2021-02-23  424  	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  425  
> 64b9f64f80a6f4 Jason Wang 2021-02-23  426  	ret = vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
> 64b9f64f80a6f4 Jason Wang 2021-02-23  427  	if (ret) {
> 64b9f64f80a6f4 Jason Wang 2021-02-23  428  		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
> 64b9f64f80a6f4 Jason Wang 2021-02-23  429  		goto err;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  430  	}
> 64b9f64f80a6f4 Jason Wang 2021-02-23  431  
> 64b9f64f80a6f4 Jason Wang 2021-02-23  432  	return 0;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  433  
> 64b9f64f80a6f4 Jason Wang 2021-02-23  434  err:
> 64b9f64f80a6f4 Jason Wang 2021-02-23  435  	put_device(&vp_vdpa->vdpa.dev);
> 64b9f64f80a6f4 Jason Wang 2021-02-23  436  	return ret;
> 64b9f64f80a6f4 Jason Wang 2021-02-23  437  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
> 
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org

