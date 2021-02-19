Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089EE31F9DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 14:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhBSNXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 08:23:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:47395 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSNXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 08:23:08 -0500
IronPort-SDR: loKQ7QdP5Aw12qRDC7FBheez+Y0EyMlDg3jaoNlJhDeqZNnG8j8g7HDWMPehnRNwyXoVZ/fPxt
 4n52d00IhSSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="170967301"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="170967301"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 05:21:21 -0800
IronPort-SDR: 3q8hi1rFIVObABHTdIvXWQsb7hE6eyKB8Ko885U9Tjr4mUp0S+fE5oX8095Rq5u6jmpnDVWmlF
 iD9uZ9AMe0gQ==
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="386910992"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 05:21:19 -0800
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com> <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com> <CAHp75Vep0Fm1k_7gJcozk4t316QmUgt5Qe3PauwDg=py5VnHfQ@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 26.3
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v1 01/12] gna: add driver module
In-reply-to: <CAHp75Vep0Fm1k_7gJcozk4t316QmUgt5Qe3PauwDg=py5VnHfQ@mail.gmail.com>
Date:   Fri, 19 Feb 2021 14:21:17 +0100
Message-ID: <85blcgw5v6.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Tue, Feb 16, 2021 at 6:11 PM Maciej Kwapulinski
> <maciej.kwapulinski@linux.intel.com> wrote:
>>
....
>> +err_clear_master:
>> +       pci_clear_master(pcidev);
>> +err_release_regions:
>> +       pci_release_regions(pcidev);
>> +end:
>> +       dev_err(&pcidev->dev, "gna probe failed with %d\n", ret);
>> +       return ret;
>
> These are all completely redundant.
>

following is refactor of gna_probe(), but without pci_release_regions(),
smatch (v7fcfe259) produces warning:
  drivers/misc/gna/gna_device.c:78 gna_probe() warn: 'pcidev' not
  released on lines: 56,65.

here's the code refactored:

int gna_probe(struct pci_dev *pcidev, const struct pci_device_id *pci_id)
{
	struct gna_private *gna_priv;
	int ret;

	ret = pcim_enable_device(pcidev);
	if (ret) {
		dev_err(&pcidev->dev, "pci device can't be enabled\n");
		return ret;
	}

	ret = pci_request_regions(pcidev, GNA_DRV_NAME);
	if (ret)
		return ret;

	ret = pci_set_dma_mask(pcidev, DMA_BIT_MASK(64));
	if (ret) {
		dev_err(&pcidev->dev, "pci_set_dma_mask returned error %d\n", ret);
		return ret;
	}

	pci_set_master(pcidev);

	/* init gna device */
	gna_priv = devm_kzalloc(&pcidev->dev, sizeof(*gna_priv), GFP_KERNEL);
	if (!gna_priv) {
		//pci_release_regions(pcidev);
		return -ENOMEM;                 // line 56
	}
	/* Map BAR0 */
	gna_priv->bar0.iostart = pci_resource_start(pcidev, 0);
	gna_priv->bar0.iosize = pci_resource_len(pcidev, 0);
	gna_priv->bar0.mem_addr = pcim_iomap(pcidev, 0, 0);
	if (!gna_priv->bar0.mem_addr) {
		//pci_release_regions(pcidev);
		dev_err(&pcidev->dev, "could not map BAR 0\n");
		return -EINVAL;               // line 65
	}

	dev_dbg(&pcidev->dev, "bar0 io start: 0x%llx\n", (unsigned long long)gna_priv->bar0.iostart);
	dev_dbg(&pcidev->dev, "bar0 io size: %llu\n", (unsigned long long)gna_priv->bar0.iosize);
	dev_dbg(&pcidev->dev, "bar0 memory address: %p\n", gna_priv->bar0.mem_addr);

	ret = gna_dev_init(gna_priv, pcidev, pci_id);
	if (ret) {
		dev_err(&pcidev->dev, "could not initialize gna private structure\n");
		return ret;
	}

	return 0;
}

I've also added 'noinline' directive to pci_release_regions(), to see if
it is called by the core code on "rmmod gna", but can't see the call.

Is the smatch tool that causes problems here?
Do You suggest other way to handle the problem?
