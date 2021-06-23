Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDDC3B16BD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhFWJYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:24:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37804 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229833AbhFWJYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:24:13 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15N9BrTk016502;
        Wed, 23 Jun 2021 09:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=taRYAqUdRjfF7zaIS/LJQE4VXVji6ShAonjfs9yUBFk=;
 b=SYNQIzsImSd73uOOlF7gNGzVThjAg3wSHlkKK3IO3E03DeLwCCHIsOu0dfejTsrEIe9f
 J9euWTRsNqJCPIWOx/4Jttmupitu6h8fkGgp3gPWURBv59pbdbkRGVxJBTOvj42loC7y
 tz1NVaRqS11lJNelv9PZTEtRjcTWMPi90v+uu9DkXVicu1iOGN1/TKx/SvwI53QryxyG
 1iFAObNsO7/A6b70wJTjSaEwEQ9hUaFocDScS3KeaZEDfAyme9BGpJwjA5RNqjAhCdev
 Yg9UOXyhQjhU1ZAuXfeMsVD1QDCJ1FY0pWeAuP9Sjsddu2r509cToZS9vDZ74jv39aze 8A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39aqqvwcec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 09:21:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15N9FtSY021000;
        Wed, 23 Jun 2021 09:21:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 399tbu7ws2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 09:21:46 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15N9Lkfv038189;
        Wed, 23 Jun 2021 09:21:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 399tbu7wrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 09:21:46 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15N9Li1B024394;
        Wed, 23 Jun 2021 09:21:44 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jun 2021 09:21:43 +0000
Date:   Wed, 23 Jun 2021 12:21:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jason Wang <jasowang@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: [kbuild] drivers/vdpa/virtio_pci/vp_vdpa.c:421 vp_vdpa_probe() warn:
 missing error code 'ret'
Message-ID: <202106231257.8kp6t8DF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: 575HLYZO6NFB5K2R4PDUNSGBPX4GDSTS
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: nNnPvcKbQ9dOSrQq6JO0QennmTqjTX5l
X-Proofpoint-GUID: nNnPvcKbQ9dOSrQq6JO0QennmTqjTX5l
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   0c18f29aae7ce3dadd26d8ee3505d07cc982df75
commit: 11d8ffed00b231356008b35a3b0bc192e42333fa vp_vdpa: switch to use vp_modern_map_vq_notify()
config: microblaze-randconfig-m031-20210622 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/vdpa/virtio_pci/vp_vdpa.c:421 vp_vdpa_probe() warn: missing error code 'ret'

Old smatch warnings:
drivers/vdpa/virtio_pci/vp_vdpa.c:168 vp_vdpa_request_irq() warn: inconsistent indenting

vim +/ret +421 drivers/vdpa/virtio_pci/vp_vdpa.c

64b9f64f80a6f4 Jason Wang 2021-02-23  367  static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
64b9f64f80a6f4 Jason Wang 2021-02-23  368  {
64b9f64f80a6f4 Jason Wang 2021-02-23  369  	struct virtio_pci_modern_device *mdev;
64b9f64f80a6f4 Jason Wang 2021-02-23  370  	struct device *dev = &pdev->dev;
64b9f64f80a6f4 Jason Wang 2021-02-23  371  	struct vp_vdpa *vp_vdpa;
64b9f64f80a6f4 Jason Wang 2021-02-23  372  	int ret, i;
64b9f64f80a6f4 Jason Wang 2021-02-23  373  
64b9f64f80a6f4 Jason Wang 2021-02-23  374  	ret = pcim_enable_device(pdev);
64b9f64f80a6f4 Jason Wang 2021-02-23  375  	if (ret)
64b9f64f80a6f4 Jason Wang 2021-02-23  376  		return ret;
64b9f64f80a6f4 Jason Wang 2021-02-23  377  
64b9f64f80a6f4 Jason Wang 2021-02-23  378  	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
64b9f64f80a6f4 Jason Wang 2021-02-23  379  				    dev, &vp_vdpa_ops, NULL);
64b9f64f80a6f4 Jason Wang 2021-02-23  380  	if (vp_vdpa == NULL) {
64b9f64f80a6f4 Jason Wang 2021-02-23  381  		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
64b9f64f80a6f4 Jason Wang 2021-02-23  382  		return -ENOMEM;
64b9f64f80a6f4 Jason Wang 2021-02-23  383  	}
64b9f64f80a6f4 Jason Wang 2021-02-23  384  
64b9f64f80a6f4 Jason Wang 2021-02-23  385  	mdev = &vp_vdpa->mdev;
64b9f64f80a6f4 Jason Wang 2021-02-23  386  	mdev->pci_dev = pdev;
64b9f64f80a6f4 Jason Wang 2021-02-23  387  
64b9f64f80a6f4 Jason Wang 2021-02-23  388  	ret = vp_modern_probe(mdev);
64b9f64f80a6f4 Jason Wang 2021-02-23  389  	if (ret) {
64b9f64f80a6f4 Jason Wang 2021-02-23  390  		dev_err(&pdev->dev, "Failed to probe modern PCI device\n");
64b9f64f80a6f4 Jason Wang 2021-02-23  391  		goto err;
64b9f64f80a6f4 Jason Wang 2021-02-23  392  	}
64b9f64f80a6f4 Jason Wang 2021-02-23  393  
64b9f64f80a6f4 Jason Wang 2021-02-23  394  	pci_set_master(pdev);
64b9f64f80a6f4 Jason Wang 2021-02-23  395  	pci_set_drvdata(pdev, vp_vdpa);
64b9f64f80a6f4 Jason Wang 2021-02-23  396  
64b9f64f80a6f4 Jason Wang 2021-02-23  397  	vp_vdpa->vdpa.dma_dev = &pdev->dev;
64b9f64f80a6f4 Jason Wang 2021-02-23  398  	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
64b9f64f80a6f4 Jason Wang 2021-02-23  399  
64b9f64f80a6f4 Jason Wang 2021-02-23  400  	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
64b9f64f80a6f4 Jason Wang 2021-02-23  401  	if (ret) {
64b9f64f80a6f4 Jason Wang 2021-02-23  402  		dev_err(&pdev->dev,
64b9f64f80a6f4 Jason Wang 2021-02-23  403  			"Failed for adding devres for freeing irq vectors\n");
64b9f64f80a6f4 Jason Wang 2021-02-23  404  		goto err;
64b9f64f80a6f4 Jason Wang 2021-02-23  405  	}
64b9f64f80a6f4 Jason Wang 2021-02-23  406  
64b9f64f80a6f4 Jason Wang 2021-02-23  407  	vp_vdpa->vring = devm_kcalloc(&pdev->dev, vp_vdpa->queues,
64b9f64f80a6f4 Jason Wang 2021-02-23  408  				      sizeof(*vp_vdpa->vring),
64b9f64f80a6f4 Jason Wang 2021-02-23  409  				      GFP_KERNEL);
64b9f64f80a6f4 Jason Wang 2021-02-23  410  	if (!vp_vdpa->vring) {
64b9f64f80a6f4 Jason Wang 2021-02-23  411  		ret = -ENOMEM;
64b9f64f80a6f4 Jason Wang 2021-02-23  412  		dev_err(&pdev->dev, "Fail to allocate virtqueues\n");
64b9f64f80a6f4 Jason Wang 2021-02-23  413  		goto err;
64b9f64f80a6f4 Jason Wang 2021-02-23  414  	}
64b9f64f80a6f4 Jason Wang 2021-02-23  415  
64b9f64f80a6f4 Jason Wang 2021-02-23  416  	for (i = 0; i < vp_vdpa->queues; i++) {
64b9f64f80a6f4 Jason Wang 2021-02-23  417  		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
11d8ffed00b231 Jason Wang 2021-04-15  418  		vp_vdpa->vring[i].notify = vp_modern_map_vq_notify(mdev, i);
11d8ffed00b231 Jason Wang 2021-04-15  419  		if (!vp_vdpa->vring[i].notify) {
11d8ffed00b231 Jason Wang 2021-04-15  420  			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);

ret = -ENOMEM;?

11d8ffed00b231 Jason Wang 2021-04-15 @421  			goto err;
11d8ffed00b231 Jason Wang 2021-04-15  422  		}
64b9f64f80a6f4 Jason Wang 2021-02-23  423  	}
64b9f64f80a6f4 Jason Wang 2021-02-23  424  	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
64b9f64f80a6f4 Jason Wang 2021-02-23  425  
64b9f64f80a6f4 Jason Wang 2021-02-23  426  	ret = vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
64b9f64f80a6f4 Jason Wang 2021-02-23  427  	if (ret) {
64b9f64f80a6f4 Jason Wang 2021-02-23  428  		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
64b9f64f80a6f4 Jason Wang 2021-02-23  429  		goto err;
64b9f64f80a6f4 Jason Wang 2021-02-23  430  	}
64b9f64f80a6f4 Jason Wang 2021-02-23  431  
64b9f64f80a6f4 Jason Wang 2021-02-23  432  	return 0;
64b9f64f80a6f4 Jason Wang 2021-02-23  433  
64b9f64f80a6f4 Jason Wang 2021-02-23  434  err:
64b9f64f80a6f4 Jason Wang 2021-02-23  435  	put_device(&vp_vdpa->vdpa.dev);
64b9f64f80a6f4 Jason Wang 2021-02-23  436  	return ret;
64b9f64f80a6f4 Jason Wang 2021-02-23  437  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

