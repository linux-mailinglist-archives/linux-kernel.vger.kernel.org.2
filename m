Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E8F39F958
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhFHOkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:40:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52234 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhFHOkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:40:33 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 158EcbGr016940;
        Tue, 8 Jun 2021 09:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623163117;
        bh=3pyK6CAwRyvWaeUBhVTbQzJs7ys6z8cOCX6qJ4mAoFs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iZtCdxaeUOFLmQ5EnX35CGrrsrmKrQyaVWDp3rzjYs2RxVRGoEhbGco31uLr2fL3L
         ySPf6UPHvvmxR7fcVicz0jDM1+MZP0ngArs+7HRDOglTZ21GwPAyK6CQqtfpXwlXaF
         RvSQ/S5OcPIimYwh/heJLPNIHgctflxiUfjPcjLs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 158EcbHV061524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jun 2021 09:38:37 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 8 Jun
 2021 09:38:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 8 Jun 2021 09:38:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 158EcapU121452;
        Tue, 8 Jun 2021 09:38:36 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] AM64: EVM/SK: Enable PCIe and USB
Date:   Tue, 8 Jun 2021 09:38:35 -0500
Message-ID: <162316287234.9624.10615974945267054848.b4-ty@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210603142251.14563-1-kishon@ti.com>
References: <20210603142251.14563-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 19:52:46 +0530, Kishon Vijay Abraham I wrote:
> AM642 EVM has one PCIe slot (no USB slot) and AM642 SK has one USB slot
> (no PCIe slot).
> AM64 SoC has one SERDES module which can be used by either PCIe or USB.
> 
> Add DT nodes to represent and enable SERDES/PCIe/USB modules in EVM/SK.
> 
> Changes from v3:
> 1) Limit the lines to < 100
> 
> [...]

Hi Kishon Vijay Abraham I,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-am64-main: Add SERDES DT node
      commit: 68fefbfed8ba67957b4ab18be4dfb8051b625321
[2/5] arm64: dts: ti: k3-am64-main: Add PCIe DT node
      commit: 4a868bffd876086d9017753a2d5c88a118fe6d5a
[3/5] arm64: dts: ti: k3-am642-evm: Enable PCIe and SERDES
      commit: 354065bed2d15f6ff7796c8105133ccdf3a84917
[4/5] arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed HOST port
      commit: 4e8aa4e3559a7f71e333b0fb8661f302aec64c5c
[5/5] arm64: dts: ti: k3-am642-sk: Disable PCIe
      commit: c90ec93d94f2bddf3873f2dfbc7b4859e09c01ef


Note: we do have this consistent definition unit address conflict in
PCIe subnode on multiple SoCs, which though logical, as we discussed
in [2], is something to look at as needed.
/bus@f4000/pcie@f102000: duplicate unit-address (also used in node
/bus@f4000/pcie-ep@f102000)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git
[2] https://lore.kernel.org/linux-arm-kernel/ab908779-804f-75c3-d9cc-98a3a558e686@ti.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
