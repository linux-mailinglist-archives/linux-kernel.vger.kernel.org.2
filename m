Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8125F3B0753
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhFVOZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:25:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65472 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhFVOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:25:12 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MEFZtC016474;
        Tue, 22 Jun 2021 14:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Wss/ihH6E48zi7Ju6M9v6hBZQCGtIUd1crMOCo8oyJk=;
 b=G1YJ4b9D/9mxUmOIiAks63mOaIhlSKZskPMlDOWawgi3AKp5VWIu50whryJhref7pR5/
 dxfE0Y4CZ3xs8hot/b1arow8u6g4mKShaeYYlkz+tNqGX6XtHeVffkBlOUIezw/2ZOEE
 Ra/c9wCopCXDpXWTqQzfP7yghjSVbDbQkeBIVsObl/DCODdsXwSY6wB/Ch89dzGAe1At
 PPPpq8zD67j1PkvQDe+3H55dgdANyrJUR1UX6yZoWTiixLi9dO8JUUYQqUguWI2xGa4z
 l5XJ2J2ADeL7Q1K6ni4uEQShzgNkP1ORMZ7L1cb7YTJY2DXxHG3JS8TlVyYD9ikC2x8Y Ig== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39aqqvuamk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 14:22:38 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15MEFP6J025954;
        Tue, 22 Jun 2021 14:22:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 399tbstqrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 14:22:37 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15MEMaeK060778;
        Tue, 22 Jun 2021 14:22:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 399tbstqr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 14:22:36 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15MEMX1W032658;
        Tue, 22 Jun 2021 14:22:33 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jun 2021 07:22:32 -0700
Date:   Tue, 22 Jun 2021 17:22:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, "Oliver O'Halloran" <oohall@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: arch/powerpc/kernel/pci-common.c:418 pci_read_irq_line() warn:
 returning -1 instead of -ENOMEM is sloppy
Message-ID: <202106222239.AvZIEtJD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: 8cPpgCWhXKlH74J5Omg8Kzo3u3hXOoqb
X-Proofpoint-GUID: 8cPpgCWhXKlH74J5Omg8Kzo3u3hXOoqb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a96bfed64c8986d6404e553f18203cae1f5ac7e6
commit: 450be4960a0fb89b931a6bb3c3f0bb538ac4c03c powerpc/pci: Remove LSI mappings on device teardown
config: powerpc64-randconfig-m031-20210622 (attached as .config)
compiler: powerpc64le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/powerpc/kernel/pci-common.c:418 pci_read_irq_line() warn: returning -1 instead of -ENOMEM is sloppy

vim +418 arch/powerpc/kernel/pci-common.c

4666ca2aa34410 Benjamin Herrenschmidt 2011-11-29  410  static int pci_read_irq_line(struct pci_dev *pci_dev)
58083dade53cd4 Kumar Gala             2007-06-27  411  {
c591c2e36ccc9a Alexey Kardashevskiy   2018-02-09  412  	int virq;
450be4960a0fb8 Oliver O'Halloran      2020-12-02  413  	struct pci_intx_virq *vi, *vitmp;
450be4960a0fb8 Oliver O'Halloran      2020-12-02  414  
450be4960a0fb8 Oliver O'Halloran      2020-12-02  415  	/* Preallocate vi as rewind is complex if this fails after mapping */
450be4960a0fb8 Oliver O'Halloran      2020-12-02  416  	vi = kzalloc(sizeof(struct pci_intx_virq), GFP_KERNEL);
450be4960a0fb8 Oliver O'Halloran      2020-12-02  417  	if (!vi)
450be4960a0fb8 Oliver O'Halloran      2020-12-02 @418  		return -1;

-ENOMEM;

58083dade53cd4 Kumar Gala             2007-06-27  419  
b0494bc8ee449f Benjamin Herrenschmidt 2008-10-27  420  	pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
58083dade53cd4 Kumar Gala             2007-06-27  421  
58083dade53cd4 Kumar Gala             2007-06-27  422  	/* Try to get a mapping from the device-tree */
c591c2e36ccc9a Alexey Kardashevskiy   2018-02-09  423  	virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
c591c2e36ccc9a Alexey Kardashevskiy   2018-02-09  424  	if (virq <= 0) {
58083dade53cd4 Kumar Gala             2007-06-27  425  		u8 line, pin;
58083dade53cd4 Kumar Gala             2007-06-27  426  
58083dade53cd4 Kumar Gala             2007-06-27  427  		/* If that fails, lets fallback to what is in the config
58083dade53cd4 Kumar Gala             2007-06-27  428  		 * space and map that through the default controller. We
58083dade53cd4 Kumar Gala             2007-06-27  429  		 * also set the type to level low since that's what PCI
58083dade53cd4 Kumar Gala             2007-06-27  430  		 * interrupts are. If your platform does differently, then
58083dade53cd4 Kumar Gala             2007-06-27  431  		 * either provide a proper interrupt tree or don't use this
58083dade53cd4 Kumar Gala             2007-06-27  432  		 * function.
58083dade53cd4 Kumar Gala             2007-06-27  433  		 */
58083dade53cd4 Kumar Gala             2007-06-27  434  		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_PIN, &pin))
450be4960a0fb8 Oliver O'Halloran      2020-12-02  435  			goto error_exit;
58083dade53cd4 Kumar Gala             2007-06-27  436  		if (pin == 0)
450be4960a0fb8 Oliver O'Halloran      2020-12-02  437  			goto error_exit;
58083dade53cd4 Kumar Gala             2007-06-27  438  		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &line) ||
54a24cbbd0184f Benjamin Herrenschmidt 2007-12-20  439  		    line == 0xff || line == 0) {
450be4960a0fb8 Oliver O'Halloran      2020-12-02  440  			goto error_exit;
58083dade53cd4 Kumar Gala             2007-06-27  441  		}
b0494bc8ee449f Benjamin Herrenschmidt 2008-10-27  442  		pr_debug(" No map ! Using line %d (pin %d) from PCI config\n",
54a24cbbd0184f Benjamin Herrenschmidt 2007-12-20  443  			 line, pin);
58083dade53cd4 Kumar Gala             2007-06-27  444  
58083dade53cd4 Kumar Gala             2007-06-27  445  		virq = irq_create_mapping(NULL, line);
ef24ba7091517d Michael Ellerman       2016-09-06  446  		if (virq)
ec775d0e70eb6b Thomas Gleixner        2011-03-25  447  			irq_set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
58083dade53cd4 Kumar Gala             2007-06-27  448  	}
ef24ba7091517d Michael Ellerman       2016-09-06  449  
ef24ba7091517d Michael Ellerman       2016-09-06  450  	if (!virq) {
b0494bc8ee449f Benjamin Herrenschmidt 2008-10-27  451  		pr_debug(" Failed to map !\n");
450be4960a0fb8 Oliver O'Halloran      2020-12-02  452  		goto error_exit;
58083dade53cd4 Kumar Gala             2007-06-27  453  	}
58083dade53cd4 Kumar Gala             2007-06-27  454  
b0494bc8ee449f Benjamin Herrenschmidt 2008-10-27  455  	pr_debug(" Mapped to linux irq %d\n", virq);
58083dade53cd4 Kumar Gala             2007-06-27  456  
58083dade53cd4 Kumar Gala             2007-06-27  457  	pci_dev->irq = virq;
58083dade53cd4 Kumar Gala             2007-06-27  458  
450be4960a0fb8 Oliver O'Halloran      2020-12-02  459  	mutex_lock(&intx_mutex);
450be4960a0fb8 Oliver O'Halloran      2020-12-02  460  	list_for_each_entry(vitmp, &intx_list, list_node) {
450be4960a0fb8 Oliver O'Halloran      2020-12-02  461  		if (vitmp->virq == virq) {
450be4960a0fb8 Oliver O'Halloran      2020-12-02  462  			kref_get(&vitmp->kref);
450be4960a0fb8 Oliver O'Halloran      2020-12-02  463  			kfree(vi);
450be4960a0fb8 Oliver O'Halloran      2020-12-02  464  			vi = NULL;
450be4960a0fb8 Oliver O'Halloran      2020-12-02  465  			break;
450be4960a0fb8 Oliver O'Halloran      2020-12-02  466  		}
450be4960a0fb8 Oliver O'Halloran      2020-12-02  467  	}
450be4960a0fb8 Oliver O'Halloran      2020-12-02  468  	if (vi) {
450be4960a0fb8 Oliver O'Halloran      2020-12-02  469  		vi->virq = virq;
450be4960a0fb8 Oliver O'Halloran      2020-12-02  470  		kref_init(&vi->kref);
450be4960a0fb8 Oliver O'Halloran      2020-12-02  471  		list_add_tail(&vi->list_node, &intx_list);
450be4960a0fb8 Oliver O'Halloran      2020-12-02  472  	}
450be4960a0fb8 Oliver O'Halloran      2020-12-02  473  	mutex_unlock(&intx_mutex);
450be4960a0fb8 Oliver O'Halloran      2020-12-02  474  
58083dade53cd4 Kumar Gala             2007-06-27  475  	return 0;
450be4960a0fb8 Oliver O'Halloran      2020-12-02  476  error_exit:
450be4960a0fb8 Oliver O'Halloran      2020-12-02  477  	kfree(vi);
450be4960a0fb8 Oliver O'Halloran      2020-12-02  478  	return -1;
58083dade53cd4 Kumar Gala             2007-06-27  479  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

