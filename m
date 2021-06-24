Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FAB3B25F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 06:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhFXECo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 00:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230180AbhFXECf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 00:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624507216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQXImDS27OqfTTyxEftOrTqlidxpnLMHIRuGoUgOeZk=;
        b=DjkLk/eLrGlqOWNhrQNkD7ps9V5fSqvqsrABNnvVslkp1U031oyghTyCXxert0CCgi2QXJ
        kxYzVJszLmZBx34fllRwPZRzOF5OwxGD7z93ZvuKVuq+JWceMb3UAiCY822zTAVsHfd1MU
        ZdMqO98jREWgukq7kZiUKk7rLWu9Ysc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-N92HwA7dOqqjhU1FS3xLKA-1; Thu, 24 Jun 2021 00:00:12 -0400
X-MC-Unique: N92HwA7dOqqjhU1FS3xLKA-1
Received: by mail-pl1-f198.google.com with SMTP id g16-20020a1709028690b029011e9e164a59so1635167plo.23
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 21:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dQXImDS27OqfTTyxEftOrTqlidxpnLMHIRuGoUgOeZk=;
        b=UScBCorT1jMCi1x4ZOasiCLnKGW6WQiYHB35NX1n3UUdZvX6ztnAibb1apTp5N96Gr
         ocQKMKEI1IeTr6Jc8A4cwOu0Qfz3sdmOpWHLJGFt7OrPh8/qS7kwViXEi+ofWrpoBQZF
         T1G7D4JPUeGzSWfnh4iWRz3AsFQvbB9zchFNqqtw3Ayc+czyEdd+plLuEbHBsCGpocMC
         0t2DM+swbPHWbqQu90whGq5TwJU0w+0f51QfcgHsPn0+jrBG8hRyb/eUgdVdp8YdKheE
         dd8bhgVQr7i6hUIQQ/Uc9ebfgbFYJnrCbvR3iyQ5nX709yGmfF2r5GUxY5zY+0hEPbai
         fNfg==
X-Gm-Message-State: AOAM532803zIR6oERScO1ZfqAqgW5JuUUG8r18UMJeXCXFoDJ71sjT90
        /xipyd7NfUSZUMQUtSPuMjeuyuRID8gjJ0KlxbJWiEG4Xq3AY8wFIs07bEtOK9Yq+JF5n9XsrCr
        VGCdmoEJtZyKPuTiR0QF/3/fn
X-Received: by 2002:a17:902:8305:b029:120:1d69:6bd8 with SMTP id bd5-20020a1709028305b02901201d696bd8mr2815602plb.2.1624507211090;
        Wed, 23 Jun 2021 21:00:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys/YaKXC05ax1CGrgduNihPF8c3v4UwG7HT26z6yT46DOJfiaaII7tGA4kEeWQs6luyED0ww==
X-Received: by 2002:a17:902:8305:b029:120:1d69:6bd8 with SMTP id bd5-20020a1709028305b02901201d696bd8mr2815574plb.2.1624507210795;
        Wed, 23 Jun 2021 21:00:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u24sm1169739pfm.200.2021.06.23.21.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 21:00:10 -0700 (PDT)
Subject: Re: [kbuild] drivers/vdpa/virtio_pci/vp_vdpa.c:421 vp_vdpa_probe()
 warn: missing error code 'ret'
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>
References: <202106231257.8kp6t8DF-lkp@intel.com>
 <20210623155701-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c59b7d7a-2861-c1c2-329b-b73097364abe@redhat.com>
Date:   Thu, 24 Jun 2021 12:00:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623155701-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/24 ÉÏÎç3:57, Michael S. Tsirkin Ð´µÀ:
> On Wed, Jun 23, 2021 at 12:21:36PM +0300, Dan Carpenter wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
>> head:   0c18f29aae7ce3dadd26d8ee3505d07cc982df75
>> commit: 11d8ffed00b231356008b35a3b0bc192e42333fa vp_vdpa: switch to use vp_modern_map_vq_notify()
>> config: microblaze-randconfig-m031-20210622 (attached as .config)
>> compiler: microblaze-linux-gcc (GCC) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> New smatch warnings:
>> drivers/vdpa/virtio_pci/vp_vdpa.c:421 vp_vdpa_probe() warn: missing error code 'ret'
>>
>> Old smatch warnings:
>> drivers/vdpa/virtio_pci/vp_vdpa.c:168 vp_vdpa_request_irq() warn: inconsistent indenting
>>
>> vim +/ret +421 drivers/vdpa/virtio_pci/vp_vdpa.c
>>
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  367  static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  368  {
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  369  	struct virtio_pci_modern_device *mdev;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  370  	struct device *dev = &pdev->dev;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  371  	struct vp_vdpa *vp_vdpa;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  372  	int ret, i;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  373
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  374  	ret = pcim_enable_device(pdev);
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  375  	if (ret)
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  376  		return ret;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  377
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  378  	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  379  				    dev, &vp_vdpa_ops, NULL);
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  380  	if (vp_vdpa == NULL) {
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  381  		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  382  		return -ENOMEM;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  383  	}
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  384
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  385  	mdev = &vp_vdpa->mdev;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  386  	mdev->pci_dev = pdev;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  387
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  388  	ret = vp_modern_probe(mdev);
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  389  	if (ret) {
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  390  		dev_err(&pdev->dev, "Failed to probe modern PCI device\n");
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  391  		goto err;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  392  	}
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  393
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  394  	pci_set_master(pdev);
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  395  	pci_set_drvdata(pdev, vp_vdpa);
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  396
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  397  	vp_vdpa->vdpa.dma_dev = &pdev->dev;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  398  	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  399
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  400  	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  401  	if (ret) {
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  402  		dev_err(&pdev->dev,
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  403  			"Failed for adding devres for freeing irq vectors\n");
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  404  		goto err;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  405  	}
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  406
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  407  	vp_vdpa->vring = devm_kcalloc(&pdev->dev, vp_vdpa->queues,
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  408  				      sizeof(*vp_vdpa->vring),
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  409  				      GFP_KERNEL);
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  410  	if (!vp_vdpa->vring) {
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  411  		ret = -ENOMEM;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  412  		dev_err(&pdev->dev, "Fail to allocate virtqueues\n");
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  413  		goto err;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  414  	}
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  415
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  416  	for (i = 0; i < vp_vdpa->queues; i++) {
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  417  		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
>> 11d8ffed00b231 Jason Wang 2021-04-15  418  		vp_vdpa->vring[i].notify = vp_modern_map_vq_notify(mdev, i);
>> 11d8ffed00b231 Jason Wang 2021-04-15  419  		if (!vp_vdpa->vring[i].notify) {
>> 11d8ffed00b231 Jason Wang 2021-04-15  420  			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
>>
>> ret = -ENOMEM;?
>
> More like EINVAL


Right, patch posted.

Thanks


>
>> 11d8ffed00b231 Jason Wang 2021-04-15 @421  			goto err;
>> 11d8ffed00b231 Jason Wang 2021-04-15  422  		}
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  423  	}
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  424  	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  425
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  426  	ret = vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  427  	if (ret) {
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  428  		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  429  		goto err;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  430  	}
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  431
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  432  	return 0;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  433
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  434  err:
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  435  	put_device(&vp_vdpa->vdpa.dev);
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  436  	return ret;
>> 64b9f64f80a6f4 Jason Wang 2021-02-23  437  }
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
>> _______________________________________________
>> kbuild mailing list -- kbuild@lists.01.org
>> To unsubscribe send an email to kbuild-leave@lists.01.org

