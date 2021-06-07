Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC25B39DFED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFGPFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:05:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42128 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhFGPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:05:49 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 157F3jXQ108953;
        Mon, 7 Jun 2021 10:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623078225;
        bh=K1ruin6irZniVUvooTwtQJ4zubzVpOKUB8MYYcJT4M0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YnjXHfSoBvqLxLQzwt6qA3Bl5vu8hMcci0wEPllTzRfqmZVg/RL/nFCz0O+ySDQda
         mmjVjXek9CybYJugGnbGL+lwXVeCj2E1v10/5572zN7igFxJx+qkjQExaMGvegCaRR
         TiKvmhoycGlx/5BPz7cm/W8BIRM+b+U8e1OCezjo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 157F3j59128600
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jun 2021 10:03:45 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 10:03:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 7 Jun 2021 10:03:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 157F3iYL041669;
        Mon, 7 Jun 2021 10:03:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Suman Anna <s-anna@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4] arm64: dts: ti: k3-am65: Add support for UHS-I modes in MMCSD1 subsystem
Date:   Mon, 7 Jun 2021 10:03:43 -0500
Message-ID: <162307821120.24886.4913823870361200714.b4-ty@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210529033749.6250-1-a-govindraju@ti.com>
References: <20210529033749.6250-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2021 09:07:49 +0530, Aswath Govindraju wrote:
> UHS-I speed modes are supported in AM65 S.R. 2.0 SoC[1].
> 
> Add support by removing the no-1-8-v tag and including the voltage
> regulator device tree nodes for power cycling.
> 
> However, the 4 bit interface of AM65 SR 1.0 cannot be supported at 3.3 V or
> 1.8 V because of erratas i2025 and i2026 [2]. As the SD card is the primary
> boot mode for development usecases, continue to enable SD card and disable
> UHS-I modes in it to minimize any ageing issues happening because of
> erratas.
> 
> [...]

Hi Aswath Govindraju,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am65: Add support for UHS-I modes in MMCSD1 subsystem
      commit: 79b08ae7c411840ea5a9fba349025d217e700576


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

