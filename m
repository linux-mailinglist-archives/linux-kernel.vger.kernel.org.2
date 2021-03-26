Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED54D34B30B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 00:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhCZXZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 19:25:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53002 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZXZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 19:25:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12QNP0JX006939;
        Fri, 26 Mar 2021 18:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616801100;
        bh=j7OoZBuv68QQ/M47gaJQ1sy1H6L4fe5gJF0kRqUncdI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NJ0J45SWldx488K/3gX78qPb+Y/X2ShqFkbOpW7tZpqSlQgL0VqPGxdRNKY7+98A6
         7VfcAp8Ve0zGRzFnq/I8IFB6wE217Nkm5cC5be2NY1P4xi0eZ6p+vqpKGOYIgtMKBu
         c4IMLuA+b09yWKJ1aJ+xyvjl7NqD65oa1Z063AWc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12QNP0Qi034024
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Mar 2021 18:25:00 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 26
 Mar 2021 18:25:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 26 Mar 2021 18:25:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12QNP0kg016399;
        Fri, 26 Mar 2021 18:25:00 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 0/3] J7200: Add support for GPIO and higher speed modes in MMCSD subsystems
Date:   Fri, 26 Mar 2021 18:24:59 -0500
Message-ID: <161680024419.21415.3859313586868944021.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326064120.31919-1-a-govindraju@ti.com>
References: <20210326064120.31919-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 12:11:17 +0530, Aswath Govindraju wrote:
> The following series of patches
> - Add support for GPIO subsystem in main and wakeup domains.
> - Add voltage regulator device tree nodes and their corresponding pinmux
>   to support power cycle and voltage switch required for UHS-I modes
> - sets respective tags in sdhci0 node to support higher speeds
> - remove no-1-8-v tag from sdhci1 node to support UHS-I modes
> - Update delay values for various speed modes supported.
> 
> [...]

Hi Aswath Govindraju,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-j7200: Add gpio nodes
      commit: e0b2e6af39ea94a6fdba53571e6711df49b6ee8d
[2/3] arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio modules
      commit: f4cc7daf460b285d3b318496654dab01472df8e4
[3/3] arm64: dts: ti: k3-j7200: Add support for higher speed modes and update delay select values for MMCSD subsystems
      commit: 9437499086c24abf298bc3c3a053faedfc19bab1


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

