Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F323AA7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 02:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhFQANX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 20:13:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47448 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhFQANW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 20:13:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15H0B9X5104835;
        Wed, 16 Jun 2021 19:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623888669;
        bh=IjmD2rvhHBdo8T/6BDCNc/0PrvTw3vejTU3n4e8Wb7g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=owemCsNkobLsTYaqa1HFex+MDL+YC9fS3FLdozpdo6Z3Kgbf7BUpgty9ySjQJN6be
         eeG94u7VsqUdh1/QYJrW5HUw2IspWqGyf0MhXh3bOghq4+xTOGk0tip1f82khNN0mF
         Oa3Rrito2oHymBtGUrvqtG+1XOcAKT8smborGx7o=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15H0B9sJ057820
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jun 2021 19:11:09 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 16
 Jun 2021 19:11:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 16 Jun 2021 19:11:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15H0B9bZ028397;
        Wed, 16 Jun 2021 19:11:09 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] AM64: Update the locations of various elements in SRAM
Date:   Wed, 16 Jun 2021 19:11:08 -0500
Message-ID: <162388856677.17633.14731996075089826400.b4-ty@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210616171224.24635-1-a-govindraju@ti.com>
References: <20210616171224.24635-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 22:42:21 +0530, Aswath Govindraju wrote:
> The following series of patches,
> - Increase the maximum size of TF-A
> - Update the location of TF-A due to a limitation for DFU boot
> - Indicate reserved locations for DMSC code and secure proxy
> 
> 
> Link to corresponding U-Boot series that makes these changes:
> - https://patchwork.ozlabs.org/project/uboot/list/?series=249235
> 
> [...]

Hi Aswath Govindraju,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!


NOTE: I updated the $subject of patch #3 to be:
arm64: dts: ti: k3-am64-main: Update TF-A load address to workaround USB DFU
limitation

[1/3] arm64: dts: ti: k3-am64-main: Update TF-A's maximum size and node name
      commit: 263820efa3fb08cc606736b68290d9be9c46e2e5
[2/3] arm64: dts: ti: k3-am64-main: Reserve OCMRAM for DMSC-lite and secure proxy communication
      commit: 454a9d4aaacb89daea350d21628992bb83de649f
[3/3] arm64: dts: ti: k3-am64-main: Update TF-A load address to workaround USB DFU limitation
      commit: 3de27ef12ccb50205e602d92f29d082429aa2964


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

