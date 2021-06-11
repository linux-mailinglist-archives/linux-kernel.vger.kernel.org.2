Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF5B3A4901
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFKTDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:03:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54904 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhFKTDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:03:03 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15BJ11s3050506;
        Fri, 11 Jun 2021 14:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623438061;
        bh=dea9SMNBnAMsMdU421uum3fSWxw4ryxnLow1E3qoajE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JF0gNbuoMvLBokc0yXu7ii78yfy88YTPiCfn39wlqNw3I8jT0z8A/qy8B/jHLUH8s
         mnO5Fy3JXtzqtBCDqJX9Ow/PewK3pV5ZElEXy8/jCtQPMPS8rZ41zECfL/06ubBTKZ
         20cSgp0HShiYzzR2/ichaiGOLb5uTmjhkCgTlVpE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15BJ10km097165
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jun 2021 14:01:00 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 14:01:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 11 Jun 2021 14:01:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15BJ10VK013420;
        Fri, 11 Jun 2021 14:01:00 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: Drop reg-io-width/reg-shift from UART nodes
Date:   Fri, 11 Jun 2021 14:00:59 -0500
Message-ID: <162343804842.7793.10581647802946840199.b4-ty@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210607134558.23704-1-vigneshr@ti.com>
References: <20210607134558.23704-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 19:15:58 +0530, Vignesh Raghavendra wrote:
> 8250_omap compatible UART IPs on all SoCs have registers aligned at 4
> byte address boundary and constant byte addressability. Thus there is no
> need for reg-io-width or reg-shift DT properties.  These properties are
> not used by 8250_omap driver nor documented as part of binding document.
> Therefore drop them.
> 
> This is in preparation to move omap-serial.txt to YAML format.

Hi Vignesh Raghavendra,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: Drop reg-io-width/reg-shift from UART nodes
      commit: 53af668e7c154c33f69e3f631261155b0cf2a784


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

