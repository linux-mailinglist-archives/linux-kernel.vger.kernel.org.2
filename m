Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A143505E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhCaR5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:57:49 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:61870 "EHLO
        alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCaR5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3142; q=dns/txt; s=iport;
  t=1617213436; x=1618423036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9+KK6SA8vleCLJAhsbCIqaUCPho3SAWet4gWR6pTR+U=;
  b=Y4kDA9Ojs6PaUzcrC9+ZR+rkT3qMNoL5/0oJb97nLv23/e908ij4J5H3
   lFlPFCLFYrPMi+HVd0+mXfheHvErZ6SXwDkNIsOxrSV9Wz3pjzUFcxSiQ
   wt55FynGuRjTlN59qhjl6ZdBQuGooFhFSiNN5nbVSxtFOn/PeLUrWNx+8
   A=;
X-IronPort-AV: E=Sophos;i="5.81,293,1610409600"; 
   d="scan'208";a="670998258"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 31 Mar 2021 17:57:12 +0000
Received: from zorba ([10.24.8.227])
        by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 12VHv9UF022319
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Mar 2021 17:57:10 GMT
Date:   Wed, 31 Mar 2021 10:57:09 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Ofer Licht <olicht@cisco.com>, xe-linux-external@cisco.com,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: Add support for cisco craw64 ARMv8 SoCs
Message-ID: <20210331175709.GE2469518@zorba>
References: <20210331014603.2496983-1-danielwa@cisco.com>
 <CAK8P3a1rbGPxjRiUTy3AKh4S9jqxk=SHoa9s0Z-3nhgQb3xJUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1rbGPxjRiUTy3AKh4S9jqxk=SHoa9s0Z-3nhgQb3xJUw@mail.gmail.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.8.227, [10.24.8.227]
X-Outbound-Node: rcdn-core-3.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 09:04:15AM +0200, Arnd Bergmann wrote:
> On Wed, Mar 31, 2021 at 3:46 AM Daniel Walker <danielwa@cisco.com> wrote:
> > From: Ofer Licht <olicht@cisco.com>
> 
> Thanks for the submission, it's always nice to see a new platform
 

> > Define craw64 config, dts and Makefile for Cisco
> > SoCs known as Craw.
> 
> I'd like some more information about the platform, e.g. the target
> market and maybe a link to the product information.

Our SoC is produced as an internal product. So SoC specifications aren't
widely available.

Here is an example of a Cisco product which uses this SoC,

https://www.cisco.com/c/en/us/products/collateral/switches/catalyst-9200-series-switches/nb-06-cat9200-ser-data-sheet-cte-en.html

I suspect that's not really what your looking for tho.

> > Cc: xe-linux-external@cisco.com
> > Signed-off-by: Ofer Licht <olicht@cisco.com>
> > Signed-off-by: Daniel Walker <danielwa@cisco.com>
> > ---
> >  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> >  arch/arm64/Kconfig.platforms                  |   5 +
> >  arch/arm64/boot/dts/Makefile                  |   1 +
> >  arch/arm64/boot/dts/cisco/Makefile            |   5 +
> >  .../arm64/boot/dts/cisco/craw64-dopplerg2.dts | 239 +++++++++++
> >  arch/arm64/boot/dts/cisco/craw64.dtsi         | 392 ++++++++++++++++++
> >  arch/arm64/configs/defconfig                  |   1 +
> 
> We have separate branches for dt, defconfig, and the rest, so it would be
> good to split this patch up a little more.
> 
> There should also be an entry in the top-level MAINTAINERS file.
> 
> > diff --git a/arch/arm64/boot/dts/cisco/craw64-dopplerg2.dts b/arch/arm64/boot/dts/cisco/craw64-dopplerg2.dts
> > new file mode 100644
> > index 000000000000..20ecc57b4e5c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/cisco/craw64-dopplerg2.dts
> > @@ -0,0 +1,239 @@
> > +/dts-v1/;
> > +
> > +#include "craw64.dtsi"
> > +
> > +/ {
> > +       model = "Cisco Craw64 on DopplerG 2.0";
> > +       compatible = "cisco,craw64-dopplerg2", "cisco,craw64";
> > +
> > +       memory {
> > +               device_type = "memory";
> > +               reg = <0x0 0x80000000 0x0 0x80000000>;
> > +       };
> 
> The memory size is usually filled by the boot loader, just put an
> empty node into the .dtsi file

Arnd, I must regretfully inform you that Cisco has a deep dark addiction to
bootloaders which, are, um, how do I say this diplomatically, um , brain dead.

You have some other comments below related to moving things into the bootloader,
and I can look into it, but bootloader inflexibility is wide spread inside
Cisco.

> 
> > +       doppler {
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               compatible = "simple-bus";
> > +               ranges;
> > +       };
> 
> What is this?
> 

It's a device, but the driver is not submitted. I can remove it along with the
other device driver binding we have where the drivers and bindings aren't submitted.

I'll do my best to fix the comments your given an resubmit.

Daniel
