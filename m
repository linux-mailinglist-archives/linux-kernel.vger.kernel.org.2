Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EF9337548
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhCKORc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:17:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33124 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbhCKORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:17:18 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BEHDTf123219;
        Thu, 11 Mar 2021 08:17:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615472233;
        bh=RJ+Hl65kVO9Nq2o/JK00f0BDvO0IoP/VbHeYgicOfv8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GGUVCt/SsQg8ea3wJAvqR6s2BkH9EDjA5B4em8LZopFqRnZcJXe8VVBINljKECflY
         Sb++/cvFuMEhUvzw45piwEFTVbtqriHGLLiJe4CcX9gJJWIODGAJjPnfoYH/xrxPjP
         2YcZg1oqjDpQUZwCeUKAvxeQbWnDapT4zw3eAacY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BEHDu1105182
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 08:17:13 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 08:17:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 08:17:13 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BEHD0g077781;
        Thu, 11 Mar 2021 08:17:13 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Pratyush Yadav <p.yadav@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 0/3] Enable 8D-8D-8D mode on J721E, J7200, AM654
Date:   Thu, 11 Mar 2021 08:17:12 -0600
Message-ID: <161547217307.16039.18227037879327861726.b4-ty@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210305153926.3479-1-p.yadav@ti.com>
References: <20210305153926.3479-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 21:09:23 +0530, Pratyush Yadav wrote:
> Now that the OSPI controller driver and the SPI NOR core have support
> for 8D-8D-8D mode, the device tree can be updated to allow Octal DTR
> transactions.
> 
> Pratyush Yadav (3):
>   arm64: dts: ti: k3-j721e-som-p0: Enable 8D-8D-8D mode on OSPI
>   arm64: dts: ti: am654-base-board: Enable 8D-8D-8D mode on OSPI
>   arm64: dts: ti: k3-j7200-som-p0: Add nodes for OSPI0
> 
> [...]

Hi Pratyush Yadav,


I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-j721e-som-p0: Enable 8D-8D-8D mode on OSPI
      commit: 4c20ee99dd1a36ab89c6a8c51ed25e9328d8a8cc
[2/3] arm64: dts: ti: am654-base-board: Enable 8D-8D-8D mode on OSPI
      commit: 7c172b30a540644fa53051e947d6712be5d6d6ce
[3/3] arm64: dts: ti: k3-j7200-som-p0: Add nodes for OSPI0
      commit: efbdf2e9183bd5e75c64d251c6b673ca61ea01b3


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

