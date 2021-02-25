Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC7E324D40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhBYJxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:53:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:39812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhBYJxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:53:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6996CAC1D;
        Thu, 25 Feb 2021 09:52:25 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, adrian.hunter@intel.com,
        sbranden@broadcom.com, alcooperx@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 0/2] sdhci-iproc CMD timeouts
Date:   Thu, 25 Feb 2021 10:52:14 +0100
Message-Id: <20210225095216.28591-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a rather odd behavior from sdhci-iproc's integration in BCM2711
(Raspberry Pi 4's SoC), and would appreciate some opinions.

The controller will timeout on SDHCI CMDs under the following conditions:

 - No SD card plugged in (the card polling thread is running, CD irq disabled).
 - BCM2711's VPU clock[1] configured at 500MHz or more, lower clocks are OK.

There is no specific command that will time out, it seems random.

Here's what I found out. The SDHCI controller runs at 100MHz, by bumping the
frequency to 150MHz the issue disapears. Might be pure luck, or maybe I hit the
nail and it's proper interference. Can't say.

Regards,
Nicolas

---

[1] For those who are not aware, here's the relationship between VPU's clock
    and emmc2's:

	 osc                                    54000000
	    plld                              3000000091
	       plld_per                        750000023
		  emmc2                        149882908
	    pllc                              2999999988
	       pllc_core0                      999999996
		  vpu                          499999998

Nicolas Saenz Julienne (2):
  ARM: dts: Fix-up EMMC2 controller's frequency
  mmc: sdhci-iproc: Set clock frequency as per DT

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts |  6 ++++++
 drivers/mmc/host/sdhci-iproc.c        | 10 ++++++++++
 2 files changed, 16 insertions(+)

-- 
2.30.1

