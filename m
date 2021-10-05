Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9CF423407
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhJEXDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:03:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52186 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbhJEXDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:03:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 195N1CKc036057;
        Tue, 5 Oct 2021 18:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633474872;
        bh=8bF7XWMLnq1JIVdx+A5jJf2B1xTmqN38E++1DLlw/wQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yquhNhGMpnblFFk1NpajxxlQKlgqY59awxK1/INYZeozrFm+OLz0JCOWRuB6r4kd3
         Cbnj9qzstzIAaiH4SRw9cxHl90YL4M83kjmBzsYKbr8qGLjowUpP89KjAM3o9PNsWJ
         Mlyji3WHgXdtK5DRaB9cbbU+M/bf1JDyRJKL3Prs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 195N1C37113277
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Oct 2021 18:01:12 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Oct 2021 18:01:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Oct 2021 18:01:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 195N1CMr055302;
        Tue, 5 Oct 2021 18:01:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        Sinthu Raja <sinthu.raja@ti.com>, <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 0/4] arm64: dts: ti: Add support for J721E starter kit
Date:   Tue, 5 Oct 2021 18:01:11 -0500
Message-ID: <163347475988.4033.15681199513108977904.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210929081333.26454-1-sinthu.raja@ti.com>
References: <20210929081333.26454-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 13:43:29 +0530, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> Hi,
> This series of patches add support for J721e Starter kit(SK)[1]. J721e SK
> is a low cost, small form factor board designed for TI’s J721E SoC.
> 
> Changes in V3:
> - Introduced IPC sub mailbox nodes patch.
> - Introduced DDR carveout memory nodes patch.
> - Updated board name to starter kit
> - Fixed DTS binding errors.
> - Updated commit message, $subject which includes adding board URL,
> 
> [...]

Hi Sinthu Raja,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] dt-bindings: arm: ti: Add compatible for J721E SK
      commit: 2927c9a56e36788859606f445a5290bf21c9ab53
[2/4] arm64: dts: ti: Add support for J721E SK
      commit: 1bfda92a3a36c4dbd2b15a7f6660b673f4a2e475
[3/4] arm64: dts: ti: k3-j721e-sk: Add IPC sub-mailbox nodes
      commit: e910e5b6763d8b895ca1bba918a39d20e3361358
[4/4] arm64: dts: ti: k3-j721e-sk: Add DDR carveout memory nodes
      commit: f46d16cf5b43b66de030f0e3b2f20d24ba95f369


Side note:
- There are still cleanups that are in works (tsadc, cdns, etc..) - since
  these are already present and active cleanup is going on, letting it past,
  but if I do get a push back from upstream maintainers, I'd have to pull the
  series back.
- I had applied the yaml cleanup for j721e, so I had to apply based on the
  offset. Let me know if the changes are troublesome, else no action is
  needed - I have built and run it through the usual guantlet as best as I
  can.

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

