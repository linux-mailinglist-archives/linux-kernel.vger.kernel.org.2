Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C57A32826B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhCAPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:25:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52222 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbhCAPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:25:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 121FNvvn092689;
        Mon, 1 Mar 2021 09:23:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614612237;
        bh=RrsqEvry1fSgLfAcyynxOYub9w000fRlB5AlPwq0Eh0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pCOIcC2U5PbNvmUoXfAMKmHAd9FPTRkBKwoqKOqbFJzp4p33THFXrNcuxeLtzx6sr
         vzbAS3c6/vTPF2XxHqN9GtAd0f4hho25/MoTkMrvZ7HX/U0UTlqGGpCZ2hXWXiLRaZ
         Sr09x84ddBbcjLv50MiatX/7Wre6dAPkgqbcaorM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 121FNv1e097262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Mar 2021 09:23:57 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Mar
 2021 09:23:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Mar 2021 09:23:56 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 121FNunj077985;
        Mon, 1 Mar 2021 09:23:56 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <devicetree@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems
Date:   Mon, 1 Mar 2021 09:23:55 -0600
Message-ID: <161461221897.7789.9478370543564524622.b4-ty@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225132736.26429-1-a-govindraju@ti.com>
References: <20210225132736.26429-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 18:57:36 +0530, Aswath Govindraju wrote:
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
      commit: 9e3faed4dc176d06dc2bed5f16a33085af10fb1c


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

