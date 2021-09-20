Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4E4412690
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 21:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbhITTDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 15:03:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35980 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349294AbhITTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 15:01:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18KIxsvv075145;
        Mon, 20 Sep 2021 13:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632164394;
        bh=A80Ct686Xs/FolEJom9QtoFvIOt0EXApC7DFV0z1BHQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=b1wbWOZqJBt/JqQ8jU2LhVQxr7VtPPC2977SHGMSH1bj8klg9TQ8+48/gYpzflBiE
         UPmJhgpGvoR9Pq2x/GUwAdxF+YMwdpe3HfxyVP4z7wL4B3EPVkLpShvNHmPLyx4/eR
         b+aUh4HCiI8w0ODXEA5vs42TWWcjBKHK4BagVpwQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18KIxs1a017450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 13:59:54 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 13:59:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 13:59:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18KIxrAx062708;
        Mon, 20 Sep 2021 13:59:53 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <lokeshvutla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/6] AM65/J7200/J721E: Misc PCIe DT fixes
Date:   Mon, 20 Sep 2021 13:59:53 -0500
Message-ID: <163216437360.26385.10417668660667266150.b4-ty@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210915055358.19997-1-kishon@ti.com>
References: <20210915055358.19997-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 11:23:52 +0530, Kishon Vijay Abraham I wrote:
> Patch series adds a bunch of PCIe DT fixes. Except from
> "[PATCH 5/6] arm64: dts: ti: j7200-main: Add *max-virtual-functions*
>  for pcie-ep DT node" which adds *max-virtual-functions* property
> to PCIe DT node, rest of them are fixes or cleanups on already added
> DT properties.
> 
> If required I can post 5th patch separately to be merged for next merge
> window while the rest can go in this -rc cycle.
> 
> [...]

Hi Kishon Vijay Abraham I,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/6] arm64: dts: ti: k3-j721e-main: Fix "max-virtual-functions" in PCIe EP nodes
      commit: 9af3ef954975c383eeb667aee207d9ce6fbef8c4
[2/6] arm64: dts: ti: k3-j721e-main: Fix "bus-range" upto 256 bus number for PCIe
      commit: 5f46633565b1c1e1840a927676065d72b442dac4
[3/6] arm64: dts: ti: j7200-main: Fix "vendor-id"/"device-id" properties of pcie node
      commit: 0d553792726a61ced760422e74ea67552ac69cdb
[4/6] arm64: dts: ti: j7200-main: Fix "bus-range" upto 256 bus number for PCIe
      commit: 8bb8429290c0043a78804ae48294b53f781ee426
[5/6] arm64: dts: ti: j7200-main: Add *max-virtual-functions* for pcie-ep DT node
      commit: b6021ba03bdf25b7bf7751e107fed2f92dbb8e50
[6/6] arm64: dts: ti: k3-am65-main: Cleanup "ranges" property in "pcie" DT node
      commit: 1c953935c00537009c5b41ebdbef807d8536943a


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
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

