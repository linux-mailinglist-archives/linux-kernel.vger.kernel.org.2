Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8AA3FBA50
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbhH3Qqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237049AbhH3Qqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630341941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DwpLt0Nn8hmCvChtyw4DhdvvdK1a5pRQjHi3QZl8DfY=;
        b=TqthWDvWuK4MF1zG1I1QBLsfXJwdU/jB81rFR8tLAjKwBx26cLKK+KP3X29tYOxJXQDexK
        zS5nr6h2m5TATxG139qzZqWQlWh1X3rN3AAeHW5UIWrG3TzfpPp0nMDVtD3Wo8d27ev7f0
        +EQ/xjbIbHc/K3mWBh7jKTq3/g7FJGU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-br8xbJm0NweXACvL2ai0Sw-1; Mon, 30 Aug 2021 12:45:40 -0400
X-MC-Unique: br8xbJm0NweXACvL2ai0Sw-1
Received: by mail-wr1-f72.google.com with SMTP id v18-20020adfe2920000b029013bbfb19640so3428716wri.17
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DwpLt0Nn8hmCvChtyw4DhdvvdK1a5pRQjHi3QZl8DfY=;
        b=Wtxuv9rgXkoJcq/R9XGEw3BY2DQtl8olMKRaijk3oGpzEiLQ4jK9RV9UBIcW9BmAgR
         UU9SYD3E88YreuU+R2ERRq3cTksbx5rth/jubp3uSVv0qTF04rnaUbqcpmnUr68b0qAO
         x0CUMR/1mhgpzssnQiAATLw3FjQse/wgIweHB0tVzUGdezvEbO8oHRSu1o8+oLfKU3PS
         WbU9MdsyufvuXGsBzKdkJSvJrM9cxM6wTzE/jdinXkkV3batkbUoro/Y9v7voWAT4hqI
         wy4EzWcMNdBdVhtsS3zfkt1J3XB46znDoQOj/9g3M/6G8TdWC4agrhU3s8f/1efMsAk9
         bIJA==
X-Gm-Message-State: AOAM532Xw/ycHuhURnoIRMjGLWz2ZN9oKU4cRv0jlR18VszBDvX4ZuxI
        HxTq3ZXy9fQ71R3i6chO/XR/KwQWVZQGIdNvfuhL5yBqNIIkDrOVJr0KYM9R8H2xbEgDnpbI7kD
        NdtNWJ5ZewOZpR+T9woH5e5lY
X-Received: by 2002:a7b:c0c7:: with SMTP id s7mr22213714wmh.66.1630341938872;
        Mon, 30 Aug 2021 09:45:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1InxmYxPc+elTwgeDtk1n06XG1jrg0nuqHOzc/VsrQnTeI0NrdV0I2TUE/b04fh8FnBmNlg==
X-Received: by 2002:a7b:c0c7:: with SMTP id s7mr22213695wmh.66.1630341938677;
        Mon, 30 Aug 2021 09:45:38 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3c08:b500:afb2:5ebc:3fd2:26de? ([2a0c:5a80:3c08:b500:afb2:5ebc:3fd2:26de])
        by smtp.gmail.com with ESMTPSA id f3sm26579wmj.28.2021.08.30.09.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 09:45:38 -0700 (PDT)
Message-ID: <22bbfdefb2b9a1a65a807d0aecee67e607b7ff60.camel@redhat.com>
Subject: Re: [PATCH] ARM: dts: bcm2711-rpi-4-b: Fix pcie0's unit address
From:   nsaenzju@redhat.com
To:     Rob Herring <robh@kernel.org>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stefan.wahren@i2se.com
Date:   Mon, 30 Aug 2021 18:45:31 +0200
In-Reply-To: <YSzfoyesEzAuLkSS@robh.at.kernel.org>
References: <20210830103909.323356-1-nsaenzju@redhat.com>
         <YSzfoyesEzAuLkSS@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-30 at 08:39 -0500, Rob Herring wrote:
> On Mon, Aug 30, 2021 at 12:39:09PM +0200, Nicolas Saenz Julienne wrote:
> > dtbs_check currently complains that:
> > 
> > arch/arm/boot/dts/bcm2711-rpi-4-b.dts:220.10-231.4: Warning
> > (pci_device_reg): /scb/pcie@7d500000/pci@1,0: PCI unit address format
> > error, expected "0,0"
> > 
> > Unsurprisingly pci@0,0 is the right address, as illustrated by its reg
> > property:
> > 
> > 	&pcie0 {
> > 		pci@0,0 {
> > 			/*
> > 			 * As defined in the IEEE Std 1275-1994 document,
> > 			 * reg is a five-cell address encoded as (phys.hi
> > 			 * phys.mid phys.lo size.hi size.lo). phys.hi
> > 			 * should contain the device's BDF as 0b00000000
> > 			 * bbbbbbbb dddddfff 00000000. The other cells
> > 			 * should be zero.
> > 			 */
> > 			reg = <0 0 0 0 0>;
> > 		};
> > 	};
> > 
> > The bus is clearly 0. So fix it.
> 
> s/bus/device/
> 
> The unit-address format is '<device>,<function>' (and function is 
> optional). The bus number is not part of the unit-address because that 
> is dynamic and then the path would not be fixed/known. The bus is part 
> of 'reg' for true OpenFirmware, but for FDT I think it should always be 
> 0 as the DT is static. 
> 
> Looks like the child node is wrong (both unit-address and reg) as well:
> 
>                 usb@1,0 {
>                         reg = <0x10000 0 0 0 0>;
>                         resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
>                 };
> 
> It doesn't warn because the bridge node is also missing 'device_type = 
> "pci";'.
> 
> This is all fairly hard to get right (see recent hikey970 patches for a 
> complex example). I'm thinking about writing a tool that generates a DT 
> with PCI nodes by reading the PCI hierachy from sysfs.

Just to double-check I understood everything, with:

	lspci -D -PP
	0000:00:00.0 PCI bridge: Broadcom Inc. and subsidiaries BCM2711 PCIe Bridge (rev 10)
	0000:00:00.0/01:00.0 USB controller: VIA Technologies, Inc. VL805/806 xHCI USB 3.0 Controller (rev 01)

It should look like this:

	&pcie0 {
		pci@0,0 {
			device_type = "pci";
			#address-cells = <3>;
			#size-cells = <2>;
			ranges;

			reg = <0 0 0 0 0>;

			usb@0,0 {
				reg = <0 0 0 0 0>;
				resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
			};
		};
	};

Thanks!

-- 
Nicolás Sáenz

