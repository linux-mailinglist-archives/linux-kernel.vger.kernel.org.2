Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A693D70F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbhG0ILa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 04:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235874AbhG0IL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:11:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE01A60527;
        Tue, 27 Jul 2021 08:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627373487;
        bh=zVqEdy3HT0nY8M2r7ytmalbkDZCkuC6kKnk5DTAldt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qkONxAMBkplh6w8TVbdOBYTugIGhUMN5hMMUiDc07rH6uelsS8P7180mk4IL81jDN
         irY84ozNrDsgpOxDqmffFLL2AwiwYFpRq0Ga+Nj+l4MIJUium7fqom5OLTQXUZ0TiN
         RX0qQldnNwXPY9zdkwdugsy+h9gvSM3QVQYbaSYYN1bIo0tPShH7Xz7esdn0xMxmAB
         GwhsidMKS+vfmqcE9Xgee4Nji1NIosmPKuu6zZZML+TtjhOHYc6QmKfs18gzNaL5e4
         EOFtjT/mWoYRe1xytqVi6GjaimnBepLNu58XwjuD64gDlm61J4/ruvzKsXjZcXRX0B
         uFKJxeCnWHM6A==
Date:   Tue, 27 Jul 2021 10:11:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/8] dt-bindings: phy: Add bindings for HiKey 970
 PCIe PHY
Message-ID: <20210727101122.204b6b9e@coco.lan>
In-Reply-To: <20210714174225.GA8988@workstation>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
        <baa7e71e13953b28a11fffdcef35195099feb7fd.1626157454.git.mchehab+huawei@kernel.org>
        <20210714022649.GA1324196@robh.at.kernel.org>
        <20210714091435.322d68b1@coco.lan>
        <20210714174225.GA8988@workstation>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

Em Wed, 14 Jul 2021 23:12:25 +0530
Manivannan Sadhasivam <mani@kernel.org> escreveu:

> I'm not sure about this. That fact that the PCIe device's PERST# signal
> wired to different GPIOs doesn't mean that those GPIOs belong to the PHY.
> Those GPIOs should be independent of the PCIe core controlled manually
> by the driver.
> 
> I think this issue is somewhat similar to the one we are dealing on the
> Qcom platforms [1] where each PCIe device uses a different GPIO and voltage
> config to operate. And those need to be active for the link training to
> succeed.
> 
> So perhaps we should aim for a common solution? The GPIO and voltage
> layout should be described in DT for each port exposed by the SoC/board.
> 
> Thanks,
> Mani
> 
> [1] https://lkml.org/lkml/2021/6/21/1524

After re-visiting this issue, I'm starting to think that this should
be mapped as something similar to:

	pcie@xxxx {
...
		slot {
			slot#1 {
				// clock, power supply, reset pins, etc
			}
			slot#2 {
				// clock, power supply, reset pins, etc
			}
...
		}
	};

E. g. placing each specific PCIe device requirement inside the pcie
or phy, as it should be up to the driver to initialize each PCIe 
child-specific requirements when the hardware is ready for that.

---

A longer explanation why this should be initialized during PHY
power on sequence:

On my tests with Kirin 970, there are some steps to be done before
enabling the clocks and sending PERST# signals, plus some extra
steps to run after PERST# is sent to all devices.

While playing with PHY split, I noticed that Linux and/or the SoC
is very sensitive to an specific probing order. If such order is
not followed, an ARM SError happens and the Kernel panics
with something similar to:

  [    1.837458] SError Interrupt on CPU0, code 0xbf000002 -- SError
  [    1.837462] CPU: 0 PID: 74 Comm: kworker/0:1 Not tainted 5.8.0+ #205
  [    1.837463] Hardware name: HiKey970 (DT)
  [    1.837465] Workqueue: events deferred_probe_work_func
  [    1.837467] pstate: 20000005 (nzCv daif -PAN -UAO BTYPE=--)
  [    1.837468] pc : _raw_spin_unlock_irqrestore+0x18/0x50
  [    1.837469] lr : regmap_unlock_spinlock+0x14/0x20
...
  [    1.837507] Kernel panic - not syncing: Asynchronous SError Interrupt


One example is with regards to the clocks required for the PCIe
to work:

	clocks = <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
		 <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
		 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
		 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
		 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;

If them aren't initialized at the expected order, the Kernel
hangs. The same applies to the slot-specific clocks.

So, basically, the driver needs to initialize them on this
sequence:

	1. PHY ref clock;
	2. APB sys and phy clock;
	3. aclk and aux_clk;
	<some settings at the PHY hardware>
	4. slot-specific clocks.

failing to follow a valid power-on sequence crashes the Kernel.


Thanks,
Mauro
