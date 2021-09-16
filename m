Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D1F40DA92
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhIPNEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:04:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36650 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239574AbhIPNEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:04:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18GD32VX129606;
        Thu, 16 Sep 2021 08:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631797382;
        bh=wHYZymjx/jBrm91v5piihovaZq0Zt8666w1nIykEUbE=;
        h=From:To:CC:Subject:Date;
        b=acYRzZIH2TIwb/W3G0E5XcF6vDI9oZ1jg9RUr2z/1JOFgAPRgjaWLCZcQABoxItqC
         CDKx3NybOWUlwBET3p9Y83d9v5TJQhehaU9Ko3vJT/yc3siTwsy+NEe8EvmuM7dqeM
         nSSIACfLpqX6TSzC4FR/A9h4dPADablUp/WzXcOc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18GD31xZ007600
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Sep 2021 08:03:02 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 16
 Sep 2021 08:03:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 16 Sep 2021 08:03:01 -0500
Received: from [10.250.217.65] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18GD2wxu119572;
        Thu, 16 Sep 2021 08:02:59 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vutla, Lokesh" <lokeshvutla@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>
Subject: [QUERY] Using same ITS device ID for two PCI devices (two PCI
 Requestor ID)
Message-ID: <5f8f586b-4308-dad7-d87d-9a341a248680@ti.com>
Date:   Thu, 16 Sep 2021 18:32:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Thomas,

TI's K3 platforms use GIT ITS for PCIe MSI/MSI-X interrupts. It uses
*pre_its_window* as implemented by *its_enable_quirk_socionext_synquacer* in
irq-gic-v3-its.c. So PCIe controller instead of directly writing to
GITS_TRANSLATER, will write to a separate window and the device ID is taken from
the offset to which the PCIe device writes (instead of dedicated lines from PCIe
controller to GIC ITS). So every 4-byte register address maps in this window
maps to a unique ITS device id.

All of this is already implemented in Linux Kernel
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-gic-v3-its.c#n4645

Now TI's AM64 has an issue in that it doesn't trigger interrupt if the address
in the *pre_its_window* is not aligned to 8-bytes (this is due to an invalid
bridge configuration in HW).

This means there will not be interrupts for devices with PCIe requestor ID, 0x1,
0x3, 0x5..., as the address in the pre-ITS window would be 4 (1 << 2), 12 (3 <<
2), 20 (5 << 2) respectively.

So in order to provide 8 byte aligned address always, I mapped the PCIe
requestor ID to ITS device ID such that it always provides 8-byte aligned
address. The DT property like below helped me achieve that.

msi-map = <0x0 &gic_its 0x0 0x10000>;
msi-map-mask = <0xfffe>;

So this would result in creating one "struct its_device" for 2 PCIe devices and
the pre-ITS address will be aligned to 8-bytes.

However with this, its_alloc_device_irq() for the 2nd PCIe device is failing
since we create "struct its_device" with the number of interrupt vectors
requested by the 1st PCIe device.

Would like to get your opinion on what would be the best way to workaround this
for AM64.

One option would be to create a new compatible for AM64 ("ti,am64,gic-v3-its")
allocate a minimal number of interrupt vector while creating "struct
its_device". Would that be acceptable? Any other ideas?

Thanks,
Kishon


