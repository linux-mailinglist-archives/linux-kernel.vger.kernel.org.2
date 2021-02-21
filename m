Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEAC320B71
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 16:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBUPd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 10:33:29 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:46470 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhBUPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 10:33:19 -0500
Received: by mail-ed1-f50.google.com with SMTP id v22so18705888edx.13;
        Sun, 21 Feb 2021 07:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TfagOgmuT7ZsUir5cXfHGD0aeDi2irBLm09CyFx4hkE=;
        b=JP5lSOfHAitm04+G+muqTFqIkowmL5/EYLYFVz3f8xTTVwCEEnrI3IW7yGkv2RW/mp
         mr2n2eToJDyd8X05sQxC67RkIqZ1rMFqTp6A4y1xCROcYZQsD2rNecCE8K9iBPY2Ln3T
         DZeIdj4e9JGHCrS34r0y/n17o2ntc5aGWnPyLtSUJ4joaif39rTUXwjLpk9nROVnoiYp
         dVj+coje/5iUwBA0FsbCwncpBqXxeJrLJ2yc+CQaZzv7ClU1ZG4skpfAlqZfrTw5oUYZ
         mcVs+hilv0XMZbExA8S09x8PVlZqSmxkiH60OxATr170f3A2b9UoyYexq0yDApI3Xx6r
         ZxZg==
X-Gm-Message-State: AOAM5312+jBlOBJQ+omaY4N/k69JfSHq8jDOHpRNocxS7wCQiR87Y77Y
        ZtyH8vMD/ACVkzUNWvjbA6c=
X-Google-Smtp-Source: ABdhPJxmUQhJSNqH30uOkPEd8cLojkOVSnDSJese7hRZubAABebHxRd/Br8X7uMa1IVHKdZx5CAj9A==
X-Received: by 2002:aa7:c80e:: with SMTP id a14mr5156078edt.295.1613921556480;
        Sun, 21 Feb 2021 07:32:36 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id s12sm9734668edu.28.2021.02.21.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 07:32:35 -0800 (PST)
Date:   Sun, 21 Feb 2021 16:32:34 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/25] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <20210221153234.h4qx7cxxgiy5lsw3@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-26-marcan@marcan.st>
 <20210215192906.7k3unuhph5wnkj5g@kozik-lap>
 <2e10f1e6-c86f-33ad-0c7b-4fefe4f28163@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e10f1e6-c86f-33ad-0c7b-4fefe4f28163@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 11:43:52PM +0900, Hector Martin wrote:
> On 16/02/2021 04.29, Krzysztof Kozlowski wrote:
> > On Mon, Feb 15, 2021 at 09:17:13PM +0900, Hector Martin wrote:
> > > +	memory@800000000 {
> > > +		device_type = "memory";
> > > +		reg = <0 0 0 0>; /* To be filled by loader */
> > 
> > dtc and dtschema might complain, so could you set here fake memory
> > address 0x800000000? Would that work for your bootloader?
> 
> Yeah, the bootloader just replaces the entire property anyway. I'll fill in
> some dummy values (the real usable memory range is to some extent dynamic
> and depends on firmware).
> 
> > > +	};
> > > +};
> > > +
> > > +&serial0 {
> > > +	status = "okay";
> > > +};
> > > diff --git a/arch/arm64/boot/dts/apple/apple-m1.dtsi b/arch/arm64/boot/dts/apple/apple-m1.dtsi
> > > new file mode 100644
> > > index 000000000000..45c87771b057
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/apple/apple-m1.dtsi
> > > @@ -0,0 +1,124 @@
> > > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > > +/*
> > > + * Copyright The Asahi Linux Contributors
> > > + */
> > > +
> > > +#include <dt-bindings/interrupt-controller/apple-aic.h>
> > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +/ {
> > > +	compatible = "apple,m1", "apple,arm-platform";
> > > +
> > > +	#address-cells = <2>;
> > > +	#size-cells = <2>;
> > > +
> > > +	cpus {
> > > +		#address-cells = <2>;
> > > +		#size-cells = <0>;
> > > +
> > > +		cpu0: cpu@0 {
> > > +			compatible = "apple,icestorm";
> > > +			device_type = "cpu";
> > > +			reg = <0x0 0x0>;
> > > +			enable-method = "spin-table";
> > > +			cpu-release-addr = <0 0>; /* To be filled by loader */
> > > +		};
> > 
> > New line after every device node, please.
> 
> Added newlines after all the CPU nodes.
> 
> > With this minor changes, fine for me:
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Thanks!
> 
> v3 will rename this file to apple/t8103.dtsi and the board file to
> t8103-j274.dts to better match other platforms (and to use the proper SoC ID
> for the M1); please let me know if you're okay keeping the Reviewed-by for
> that.

It's fine, keep my review tag.

Best regards,
Krzysztof

