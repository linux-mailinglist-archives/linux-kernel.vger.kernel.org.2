Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B814539F943
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhFHOga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:36:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51420 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhFHOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:36:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 158EYQbI015392;
        Tue, 8 Jun 2021 09:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623162866;
        bh=kLVOLQpzpEYWHMfnJk1j34dVERgJQyKRpIuMcUEPRMw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=y45V/aU00ptfJpFX4yusnpqTXUNmwH/SvV9te9MRHsA4BbHD85VoK5rvugvJL/w+R
         I2r7MvMr08SK/2EMqW51ILQtaTlBJX2YoqL1SM/mh2Eppi31tRohuzIphuNcNERwgb
         MVAjcLUwvEnyTdXyeT0pNvFPUd7iqb5qvcjZx1Qg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 158EYQiV055988
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jun 2021 09:34:26 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 8 Jun
 2021 09:34:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 8 Jun 2021 09:34:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 158EYQDR113576;
        Tue, 8 Jun 2021 09:34:26 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] J721E: Use external clock in EVM for SERDES
Date:   Tue, 8 Jun 2021 09:34:25 -0500
Message-ID: <162316285077.9448.15907397272506220015.b4-ty@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210603143427.28735-1-kishon@ti.com>
References: <20210603143427.28735-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 20:04:23 +0530, Kishon Vijay Abraham I wrote:
> J721E EVM has clock generator that feeds both to the SERDES and to the
> PCIe slot present in the EVM. In order to use common reference clock on
> either side of the link, configure SERDES to use external reference
> clock.
> 
> Previously SERDES used internal reference clock and the attached device
> used clock from clock generator in the EVM.
> 
> [...]

Hi Kishon Vijay Abraham I,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-j721e-main: Fix external refclk input to SERDES
      commit: 5c6d0b55b46aeb91355e6a9616decf50a3778c91
[2/4] arm64: dts: ti: k3-j721e-main: Add #clock-cells property to serdes DT node
      commit: 2427bfb335eb5f291a821e91c4c520351ce933df
[3/4] arm64: dts: ti: k3-j721e-common-proc-board: Use external clock for SERDES
      commit: f2a7657ad7a821de9cc77d071a5587b243144cd5
[4/4] arm64: dts: ti: k3-j721e-common-proc-board: Re-name "link" name as "phy"
      commit: 02b4d9186121d842a53e347f53a86ec7f2c6b0c7


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

