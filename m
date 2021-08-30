Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1088E3FB715
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 15:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhH3Nkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 09:40:43 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43829 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhH3Nkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 09:40:42 -0400
Received: by mail-ot1-f48.google.com with SMTP id x10-20020a056830408a00b004f26cead745so18375870ott.10;
        Mon, 30 Aug 2021 06:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/HFidGIZmRuHY79xFNqRZ/4XxqjhggtR+nv+mqzgiS8=;
        b=BBAKgFSpNP2ogRniyRzBuFL84KdWIOIRlQUxQL3SjrrM8ryBjQcqDMoJKyIWx1tgjX
         xVtR77hFqtAH1r2I+SUiNFlWrMDozlaOJIuJSmYXSjvQz9mEuuleVrXu3NpMXeVHVN53
         NvG9C82utv7zTUnT+iB6L6W7WwBqHwdmEg6LQrDjDZcSKnU9avvAoE6mYnvRJz+QxdPy
         LPZILxZy9NaXtSYqDfkjVZwAxyrke2umjWGrUp5RzCc5ccYMN3ihbigZsi/aIoB1Ampl
         aWIlsKLo5D0d1ZX4HNDwG1Ob3CuaYEWSN5D7k4tjGmUleOh1SIvvcGgvTLVY0rz0EKUf
         HCPA==
X-Gm-Message-State: AOAM533qwPPNUkAPJKFykG/ml53X3ZPX65ynxVjvjPM3oO3fjqyW8wG0
        5WbpGJ9brUcF4oxNkB3Fi0DFTFlj8Q==
X-Google-Smtp-Source: ABdhPJwGWHRyZL4/9mqDbTePFL9qlSiaIaKiiiJb2g4TRseDyP+CMpC9q72iesHesw51sVnXGiSG4Q==
X-Received: by 2002:a9d:2ec:: with SMTP id 99mr19319698otl.46.1630330788769;
        Mon, 30 Aug 2021 06:39:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b24sm2954533oic.33.2021.08.30.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 06:39:48 -0700 (PDT)
Received: (nullmailer pid 1929911 invoked by uid 1000);
        Mon, 30 Aug 2021 13:39:47 -0000
Date:   Mon, 30 Aug 2021 08:39:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     nsaenz@kernel.org, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stefan.wahren@i2se.com
Subject: Re: [PATCH] ARM: dts: bcm2711-rpi-4-b: Fix pcie0's unit address
Message-ID: <YSzfoyesEzAuLkSS@robh.at.kernel.org>
References: <20210830103909.323356-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830103909.323356-1-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 12:39:09PM +0200, Nicolas Saenz Julienne wrote:
> dtbs_check currently complains that:
> 
> arch/arm/boot/dts/bcm2711-rpi-4-b.dts:220.10-231.4: Warning
> (pci_device_reg): /scb/pcie@7d500000/pci@1,0: PCI unit address format
> error, expected "0,0"
> 
> Unsurprisingly pci@0,0 is the right address, as illustrated by its reg
> property:
> 
> 	&pcie0 {
> 		pci@0,0 {
> 			/*
> 			 * As defined in the IEEE Std 1275-1994 document,
> 			 * reg is a five-cell address encoded as (phys.hi
> 			 * phys.mid phys.lo size.hi size.lo). phys.hi
> 			 * should contain the device's BDF as 0b00000000
> 			 * bbbbbbbb dddddfff 00000000. The other cells
> 			 * should be zero.
> 			 */
> 			reg = <0 0 0 0 0>;
> 		};
> 	};
> 
> The bus is clearly 0. So fix it.

s/bus/device/

The unit-address format is '<device>,<function>' (and function is 
optional). The bus number is not part of the unit-address because that 
is dynamic and then the path would not be fixed/known. The bus is part 
of 'reg' for true OpenFirmware, but for FDT I think it should always be 
0 as the DT is static. 

Looks like the child node is wrong (both unit-address and reg) as well:

                usb@1,0 {
                        reg = <0x10000 0 0 0 0>;
                        resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
                };

It doesn't warn because the bridge node is also missing 'device_type = 
"pci";'.

This is all fairly hard to get right (see recent hikey970 patches for a 
complex example). I'm thinking about writing a tool that generates a DT 
with PCI nodes by reading the PCI hierachy from sysfs.

Rob
