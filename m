Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F7380F47
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 19:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhENRxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 13:53:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60100 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhENRxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 13:53:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14EHpoNo038903;
        Fri, 14 May 2021 12:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621014710;
        bh=n7DLuL4pxk0A6LMaK34RCZxhdysfsbCLmks5vPOt5eE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gtdiUqI/qfzQB2JKRhWDas9W8vr+BUDOyslQPyGDLxktLbdxl4IGnLkAU4ezQpHsL
         j6FMOJ5vcBV+lUv7/o1LAw0lgK2MPMVgnWfvW4LzUkADt3Fztp7n3HJqM4vZGE/gq1
         RmqaTIqjkUBdSm/E6iDGCxhOCi6PCYa3FWoG2+Kc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14EHpob7026706
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 May 2021 12:51:50 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 14
 May 2021 12:51:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 14 May 2021 12:51:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14EHpnNJ020164;
        Fri, 14 May 2021 12:51:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: j7200-main: Mark Main NAVSS as dma-coherent
Date:   Fri, 14 May 2021 12:51:48 -0500
Message-ID: <162101469409.22902.3718929680839642431.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210510180601.19458-1-vigneshr@ti.com>
References: <20210510180601.19458-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 23:36:01 +0530, Vignesh Raghavendra wrote:
> Traffic through main NAVSS interconnect is coherent wrt ARM caches on
> J7200 SoC.  Add missing dma-coherent property to main_navss node.
> 
> Also add dma-ranges to be consistent with mcu_navss node
> and with AM65/J721e main_navss and mcu_navss nodes.

Hi Vignesh Raghavendra,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: j7200-main: Mark Main NAVSS as dma-coherent
      commit: 52ae30f55a2a40cff549fac95de82f25403bd387


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

