Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0F1380F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 19:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhENRxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 13:53:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33546 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbhENRxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 13:53:23 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14EHq8em122052;
        Fri, 14 May 2021 12:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621014728;
        bh=WJxEmaqQh0134GlcK2ZN95rUJMUmqIC4G5xF14/r048=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=enQj06yBfFNkxbOz6gWjRSkMpsLyBvjsegblvN3DvTbUcHYV+qc+LCmQ5kBqH/3Q5
         HNYEFHL4DNMwzoZDApn2jVMl+C1XwHp/pq4JKem1oxwtpyT++TqZlpssldvdJeKt1t
         WJwJ3zhbAD0Zh7xTAEpmfQkw2bflBBO50BwbvRNA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14EHq8ek072682
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 May 2021 12:52:08 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 14
 May 2021 12:52:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 14 May 2021 12:52:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14EHq8Wx089936;
        Fri, 14 May 2021 12:52:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] arm64: dts: ti: k3-*: Fixup nodes to exposed to be non-compliant with yaml
Date:   Fri, 14 May 2021 12:52:07 -0500
Message-ID: <162101471740.23039.13267585824105304513.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210510145033.7426-1-nm@ti.com>
References: <20210510145033.7426-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 09:50:29 -0500, Nishanth Menon wrote:
> Series of minor fixups for v5.13-rc1 for compliance exposed by yaml
> conversion in the series:
> https://lore.kernel.org/linux-arm-kernel/20210503190824.GA2192378@robh.at.kernel.org/#t
> 
> Minimal testing performed on k3 platforms.
> 
> If possible, will be good to get in 5.13 window.
> 
> [...]

Hi Nishanth Menon,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-*: Rename the TI-SCI clocks node name
      commit: a0812885fa7a1074c8003484b8176ffe28d5df68
[2/4] arm64: dts: ti: k3-am65-wakeup: Add debug region to TI-SCI node
      commit: 830454bbd628330c3779c3de637b709dae790da0
[3/4] arm64: dts: ti: k3-am65-wakeup: Drop un-necessary properties from dmsc node
      commit: 421c06b8761abd7d953148f5b955b4149df9846e
[4/4] arm64: dts: ti: k3-*: Rename the TI-SCI node
      commit: 9d3c9378f96a95f15881ee3373d2c2f773273fc2


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

