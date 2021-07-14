Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1982B3C7F31
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 09:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbhGNHRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 03:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238104AbhGNHRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 03:17:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D55B76136E;
        Wed, 14 Jul 2021 07:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626246881;
        bh=0yl6LgRMCHVYko8d2lMXrL+3MvdopKXqIaK8azMmHiA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sy2D9hYch6cByjUdwHotcJLni9CRe4Udzfkjpi2g00LD3fWvpcszikx7+RePBWIFq
         oM/aB035M7JeWxNw4vWM4Og/tFTJZ6TMzVcZrnLG5cwMAuCZJvVijDojm9tGjvwXyR
         AR7DgR2G4qTSO2p+SJ3RYQO5RZQ2k6Zdicmkj1NvtM/pUhH1FxKGhIqdOs9AkJLGhT
         7lTEfr9K/fBj/USa0JL1jPHKVbj7cJwRg3ETQNt5blN4vr7Df5C9bPbRJGWHv2cfPx
         +DiIKcup2CS46vTssZXmjaSRGunEVThzDFcoGwjJiRjzsANJfA6vWpGh7NZceQGY0f
         aZDTjejDL90rw==
Date:   Wed, 14 Jul 2021 09:14:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/8] dt-bindings: phy: Add bindings for HiKey 970
 PCIe PHY
Message-ID: <20210714091435.322d68b1@coco.lan>
In-Reply-To: <20210714022649.GA1324196@robh.at.kernel.org>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
        <baa7e71e13953b28a11fffdcef35195099feb7fd.1626157454.git.mchehab+huawei@kernel.org>
        <20210714022649.GA1324196@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 13 Jul 2021 20:26:49 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Tue, Jul 13, 2021 at 08:28:35AM +0200, Mauro Carvalho Chehab wrote:

> > +  reset-gpios:
> > +    description: PCI PERST reset GPIOs
> > +    maxItems: 4 =20
>=20
> Hiding the 4 ports in the phy?

Rob,

I'm not trying to hide anything.

There are several differences with regards to how PERST# is handled between
HiKey 960 and HiKey 970.

=46rom hardware perspective, you can see the schematics of both boards:

	https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey9=
60/hardware-docs/HiKey960_SoC_Reference_Manual.pdf
	https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-do=
cs/files/hikey970-schematics.pdf

The 960 PHY has the SoC directly connected to a PCIE M.2 slot=20
(model 10130616) without any external bridge chipset. It uses a single=20
GPIO (GPIO 089) for the PERST# signal, connected via a voltage converter
(from 1.8V to 3.3V).

	$ lspci
	00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3660 (rev 01)

The 970 PHY has an external PCI bridge chipset (PLX Technology PEX 8606).
Besides the bridge, the hardware comes with an Ethernet PCI adapter, a
M.2 slot and a mini-PCIe connector. Each one with its own PERST# signal,
mapped to different GPIO pins, and each one using its own voltage
converter.

	$ lspci
	00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
	01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Expre=
ss Gen 2 (5.0 GT/s) Switch (rev ba)
	02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Expre=
ss Gen 2 (5.0 GT/s) Switch (rev ba)
	02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Expre=
ss Gen 2 (5.0 GT/s) Switch (rev ba)
	02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Expre=
ss Gen 2 (5.0 GT/s) Switch (rev ba)
	02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Expre=
ss Gen 2 (5.0 GT/s) Switch (rev ba)
	02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Expre=
ss Gen 2 (5.0 GT/s) Switch (rev ba)
	06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/=
8411 PCI Express Gigabit Ethernet Controller (rev 07)

On other words, there are 4 GPIOs mapped to different PERST# pins in
the hardware:

- GPIO 56 is connected to the PERST# pin at PEX 8606;
- GPIO 25 is connected to the PERST# pin at the M.2 slot;
- GPIO 220 is connected to the PERST# pin at the PCIe mini slot;
- GPIO 203 is connected to the PERST# pin at the Ethernet chipset.

Maybe due to different electrical requirements, the hardware design
use different GPIOs instead of feeding them altogether.

Anyway, the fact is that the PHY on 970 has 4 different GPIOs that are
need in order for the hardware to work. and this is specific to this
particular PHY.

Now, from software perspective, the power on sequence on Hikey 960
finishes sending PERST# signal to the M.2 slot:

	static int hi3660_pcie_phy_power_on(struct phy *generic_phy)
	{
...
		/* perst assert Endpoint */
		if (!gpio_request(phy->gpio_id_reset, "pcie_perst")) {
			usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
			ret =3D gpio_direction_output(phy->gpio_id_reset, 1);
			if (ret)
				goto disable_clks;
			usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
			return 0;
		}

	disable_clks:
		kirin_pcie_clk_ctrl(phy, false);
		return ret;
	}
=09
The 970 PHY, however, sends PERST# signal in the middle of the power
on sequence, as, after sending reset, it needs to wait for the hardware
to stabilize, in order to setup an eye diagram at the PHY:

	static int hi3670_pcie_phy_power_on(struct phy *generic_phy)
	{
...
		/* perst assert Endpoints */
		usleep_range(21000, 23000);
		for (i =3D 0; i < phy->n_gpio_resets; i++) {
			ret =3D gpio_direction_output(phy->gpio_id_reset[i], 1);
			if (ret)
				return ret;
		}
		usleep_range(10000, 11000);

		ret =3D is_pipe_clk_stable(phy);
		if (!ret)
			goto disable_clks;

		hi3670_pcie_set_eyeparam(phy);

		ret =3D hi3670_pcie_noc_power(phy, false);
		if (ret)
			goto disable_clks;

		return 0;

	disable_clks:
		kirin_pcie_clk_ctrl(phy, false);
		return ret;
	}

IMO, it makes a lot more sense to map this on DT as part of the
PHY and not as part of the PCIe, but no matter how it is mapped,
this PHY still requires 4 GPIOs for PERST#.

Thanks,
Mauro
