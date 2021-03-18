Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30E93407C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhCROZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:25:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57048 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhCROZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:25:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12IEOxVD119063;
        Thu, 18 Mar 2021 09:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616077499;
        bh=8j1w2tBDnp1rHlUVX6Sn6y9ad56f41JpDrOBlCFR3mM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vG6e33mde9H5BqCwAL+j6H4hAqFX4BzsYTBQWvefX+FomK744OO9Dk5ErZes/M8x7
         g1N9NcGc+P2jGEbMmS4CCDf7GE4fO5oPidBljxJRjz+I2cthKhmPSUixVAMHX6AW8F
         /IrR/Wxol3G/O5hTw4KYzy8qYOkjClrNwQdjRlZ8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12IEOxkv025981
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Mar 2021 09:24:59 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 18
 Mar 2021 09:24:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 18 Mar 2021 09:24:59 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12IEOwJq093940;
        Thu, 18 Mar 2021 09:24:59 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [RESEND PATCH] arm64: dts: ti: k3-am64-main: Add ADC nodes
Date:   Thu, 18 Mar 2021 09:24:58 -0500
Message-ID: <161607554267.23461.3716611573021877758.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210318113443.20036-1-vigneshr@ti.com>
References: <20210318113443.20036-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 17:04:43 +0530, Vignesh Raghavendra wrote:
> AM64 SoC has a single ADC IP with 8 channels. Add DT node for the same.
> 
> Default usecase is to control ADC from non Linux core on the system on
> AM642 GP EVM, therefore mark the node as reserved in k3-am642-evm.dts
> file. ADC lines are not pinned out on AM642 SK board, therefore disable
> the node in k3-am642-sk.dts file.

Hi Vignesh Raghavendra,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am64-main: Add ADC nodes
      commit: fad4e18fe4dccacf68418da01e98c4b8fb590023

Thanks for rebasing and helping sequence. I have taken note that we
will be converting the binding to yaml in near future, so inline with
what we are doing now, accepting the patch.

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

