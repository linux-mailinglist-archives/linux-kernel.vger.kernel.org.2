Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5833753D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhCKOQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:16:28 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32830 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhCKOQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:16:13 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BEG8fU122858;
        Thu, 11 Mar 2021 08:16:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615472168;
        bh=otsioTu5qCUse4Zaap7lDZdr6bDLm7MeSEmVeWJ8PVk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dAeozZWqFTSw2O6hPImspbfN2I51ihS3M7KLua5IO05zMFcABKVqIdC8l5fND4Iu0
         Ol46Dhf9S7rbUt+eTLUauI58r0WhJGC8u/XpF0DyfgepvJ7eA/mcrPO25iHPNLxqdf
         XosQoNmsA6acOWWFbQoT+Pqyj0dwiY39tIjKwhEM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BEG7xe103343
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 08:16:08 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 08:16:07 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 08:16:07 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BEG7NF075903;
        Thu, 11 Mar 2021 08:16:07 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Faiz Abbas <faiz_abbas@ti.com>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems
Date:   Thu, 11 Mar 2021 08:16:06 -0600
Message-ID: <161547214086.15807.8150332275762636624.b4-ty@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210305054104.10153-1-a-govindraju@ti.com>
References: <20210305054104.10153-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 11:11:04 +0530, Aswath Govindraju wrote:
> According to latest errata of J721e [1], HS400 mode is not supported
> in MMCSD0 subsystem (i2024) and SDR104 mode is not supported in MMCSD1/2
> subsystems (i2090). Therefore, replace mmc-hs400-1_8v with mmc-hs200-1_8v
> in MMCSD0 subsystem and add a sdhci mask to disable SDR104 speed mode.
> 
> Also, update the itap delay values for all the MMCSD subsystems according
> the latest J721e data sheet[2]
> 
> [...]

Hi Aswath Govindraju,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems
      commit: eb8f6194e8074d7b00642dd75cf04d13e1b218e4


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
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

