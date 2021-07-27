Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC083D6FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 08:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhG0GwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 02:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235471AbhG0GwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 02:52:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8C9E610A7;
        Tue, 27 Jul 2021 06:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627368731;
        bh=1shv90NXbVnI0EhBrF+Di0h2ODnyb3HL6k1slRT7B2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TAMBdQGIXiYimN4KiU03WNk34Xj4T9BdDaCUEhyE2ZlNDHEGap0JfqhKdBHOQ+zvh
         7kVFBc7vt0vsY6C4FjqLLDD0LS8Sz2FijpzcuPXT0R98PdKPbZ7O00B98+wect0AAR
         JPSAsIBKr90OMnXjpwFFSkgzibrkIOG7+wKCWDuzSKZr2tyUUHDtyPYYvDmkidkD60
         hqRQ2hD7BToNeF9ZmbH58RJDGIXYBzJjCtjcHxlugH4fuLRs8/AUbYgSX9SIINL2OW
         mr1D35eNJBSNSwfeKYXqt+0ldOgnJgfgnpM7YousGlDIgQan9nqlzk6vUFx8ygYBip
         3qBs4nNd6FS2Q==
Date:   Tue, 27 Jul 2021 08:52:05 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v7 06/10] dt-bindings: phy: Add bindings for HiKey 970
 PCIe PHY
Message-ID: <20210727085205.5aafb5c9@coco.lan>
In-Reply-To: <20210727015020.403bbf73@coco.lan>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
        <946f2426bc542638240980931eae924c57f2ba27.1626855713.git.mchehab+huawei@kernel.org>
        <20210723225059.GA2727093@robh.at.kernel.org>
        <20210724021244.780297ee@coco.lan>
        <CAL_JsqLA7Z908SQKkZpyEcCvpkWsW3pa42eajpxCSkbUy4rv9g@mail.gmail.com>
        <20210727015020.403bbf73@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 27 Jul 2021 01:50:20 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Mon, 26 Jul 2021 15:37:28 -0600
> Rob Herring <robh@kernel.org> escreveu:
> 

> > > > > +  reset-gpios:
> > > > > +    description: PCI PERST reset GPIOs
> > > > > +    maxItems: 4
> > > > > +
> > > > > +  clkreq-gpios:
> > > > > +    description: Clock request GPIOs
> > > > > +    maxItems: 3    
> > > >
> > > > Again, this will not work.    
> > >
> > > Just to be sure: you're talking about the PERST# gpios (e. g. reset-gpios)
> > > here, right?    
> > 
> > Both that and CLKREQ.

The original DT from the downstream version (found at Linaro's tree)
has:

	pcie@f4000000 {
		compatible = "hisilicon,hikey970";
...
		switch,reset-gpios = <&gpio7 0 0 >;
		eth,reset-gpios = <&gpio25 2 0 >;
		m_2,reset-gpios = <&gpio3 1 0 >;
		mini1,reset-gpios = <&gpio27 4 0 >;

		eth,clkreq-gpios = <&gpio20 6 0 >;
		m_2,clkreq-gpios = <&gpio27 3 0 >;
		mini1,clkreq-gpios = <&gpio17 0 0 >;
	};

So, if we're willing to have a single reset-gpios for the PCIe
interface, in order to follow the current pci-bus.yaml schema,
this would probably be:

	reset-gpios = <&gpio7 0 0 >;

which maps to the PEX8606 PCIe bridge chip.

With that, DT still need to point a per-slot clkreq and
reset-gpio.

One alternative would be to map it as either 3 PCI or PHY
child nodes. E. g. something like this:

	pcie@f4000000 {
		compatible = "hisilicon,kirin970-pcie";
...
		reset-gpios = <&gpio7 0 0 >;

		slot {
			eth {
				reset-gpios = <&gpio25 2 0>;
				clkreq-gpios = <&gpio20 6 0>;
			};
			m2 {
				reset-gpios = <&gpio3 1 0>;
				clkreq-gpios = <&gpio27 3 0>;
			};
			mini1 {
				reset-gpios = <&gpio27 4 0>;
				clkreq-gpios = <&gpio17 0 0>;
			};
		};
	};


Placing the child nodes ("slot"?) at the pci bus properties makes more
sense to me, but placing them at the PHY node has the advantage of 
only affecting Kirin 970.

In either case, if each child would need a different power supply,
it won't be hard to add a "slot-supply" property later on. 

Would something like that be acceptable for you?

> > > If you have a better idea, I'm all ears.    
> > 
> > There's already a spec for populating PCI devices in DT. It's existed
> > for over 20 years with OpenFirmware[1]. It's not widely used on FDT
> > systems because most cases to date are just a single device attached
> > and they don't have extra things needing to be described in DT. There
> > are a few, but not many examples in the tree of PCI devices with DT
> > nodes. That's the only way to generically describe the topology you
> > have.  
> >
> > [1] https://www.devicetree.org/open-firmware/home.html#OFDbussupps  

I was unable to find anything useful there at the two PCI documents.

This one:
	https://www.devicetree.org/open-firmware/bindings/pci/pci-express.txt

has just one property that might be useful:

	physical-slot#

The main one:
	https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf

mentions a few child properties, but it doesn't show how those were
supposed to be mapped, and none of the properties mentioned there
specify clocks, gpios, or reset pins.

Thanks,
Mauro
