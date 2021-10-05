Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7464233ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhJEXBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:01:09 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57746 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhJEXBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:01:08 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 195MxBDi026881;
        Tue, 5 Oct 2021 17:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633474751;
        bh=fIE5iQMq7CmeQX9nJoCTacXGDRl7HP4ROJnmv4GuPAA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zJqiSmqgSoUdrsoqkPBGYGfxRX8O5pxDJ4htcan5DLiA6EBiNEIwuSdcdVUTEfnbo
         8Ib5H3RhXdjA0qO5DUUiHFUoUaig4y9Olm8HM0KQF+iY6wtQQWVFRNUM9C5/h9wzbJ
         Glep5wj5Kw0wLwbXEvj7bwbe7tuPdhwNqrbES4mM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 195MxBIB083306
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Oct 2021 17:59:11 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Oct 2021 17:59:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Oct 2021 17:59:10 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 195MxALm101008;
        Tue, 5 Oct 2021 17:59:10 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@web.de>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        Chao Zeng <chao.zeng@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>
Subject: Re: [PATCH v5 0/6] arm64: dts: Update IOT2050 boards
Date:   Tue, 5 Oct 2021 17:59:09 -0500
Message-ID: <163347457762.3486.6931163717938538588.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1632657916.git.jan.kiszka@web.de>
References: <cover.1632657916.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Sep 2021 14:05:11 +0200, Jan Kiszka wrote:
> This enhances the DTs for the IOT2050, primarily by added support for
> upcoming Production Generation 2 (PG2) and by ordering the MMC devices
> consistently across variants.
> 
> Changes in v5:
>  - fix usb0 node (for true USB 3.0 support)
>  - added reviewed/acked tags
> 
> [...]

Hi Jan Kiszka,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/6] arm64: dts: ti: iot2050: Flip mmc device ordering on Advanced devices
      commit: 06784f7679274be3ca170a689c56192143a04541
[2/6] arm64: dts: ti: iot2050: Disable SR2.0-only PRUs
      commit: 262a98b43c2a08a5446bab2030f8fb68d3699396
[3/6] arm64: dts: ti: iot2050: Add/enabled mailboxes and carve-outs for R5F cores
      commit: af755fe2b36c87abfa6f00caf7dfce6351b7412a
[4/6] dt-bindings: arm: ti: Add bindings for Siemens IOT2050 PG2 boards
      commit: 4f535a0e38f696cadc92cc980d25a4198b11ae33
[5/6] arm64: dts: ti: iot2050: Prepare for adding 2nd-generation boards
      commit: a9dbf044c600277f5d2805831a73083f3688e19f
[6/6] arm64: dts: ti: iot2050: Add support for product generation 2 boards
      commit: 614d47cc9303893c706c0c94516249eb3adaeb80


Side note:
- There are still cleanups that are in works (tsadc, cdns, etc..) - since
  these are already present and active cleanup is going on, letting it past,
  but if I do get a push back from upstream maintainers, I'd have to pull the
  series back.

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

