Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763E5380F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 19:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhENRxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 13:53:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33620 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhENRxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 13:53:40 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14EHqQ9e122213;
        Fri, 14 May 2021 12:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621014746;
        bh=dUbYK3aAWC/7fIPdiCT3rhtAH3KRV/hTD9dRvHny1sA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PysmSnez3Cnl1NmVl8+WVblBBkn+CQHK52qNdfXegzWkIFOhuM8GkRiTA2+wEV3WD
         R3OhvsnLm7Uoo0ORK0tbFphd4BSVubWRVGq2s721xaTMWIL5OHIu4pT/yoQb52ZK0S
         /A5chLZn41SGZlTpw0MkfAByweH6H1J+rn6HRAoo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14EHqQPp129282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 May 2021 12:52:26 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 14
 May 2021 12:52:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 14 May 2021 12:52:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14EHqPSY090254;
        Fri, 14 May 2021 12:52:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nishanth Menon <nm@ti.com>, <grygorii.strashko@ti.com>,
        <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lokeshvutla@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am65|j721e|am64: Map the dma / navigator subsystem via explicit ranges
Date:   Fri, 14 May 2021 12:52:25 -0500
Message-ID: <162101473289.23146.5275338895525889266.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210510145429.8752-1-nm@ti.com>
References: <20210510145429.8752-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 09:54:29 -0500, Nishanth Menon wrote:
> Instead of using empty ranges property, lets map explicitly the address
> range that is mapped onto the dma / navigator subsystems (navss/dmss).
> 
> This is also exposed via the dtbs_check with dt-schema newer than
> 2021.03 version by throwing out following:
> arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml: bus@100000: main-navss:
> {'type': 'object'} is not allowed for
> {'compatible': ['simple-mfd'], '#address-cells': [[2]], .....
> 
> [...]

Hi Nishanth Menon,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am65|j721e|am64: Map the dma / navigator subsystem via explicit ranges
      commit: 9ecdb6d6b11434494af4bad11b03f0dcda1eebbd


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

