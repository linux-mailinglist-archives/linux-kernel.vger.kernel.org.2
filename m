Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007A939486A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 23:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhE1Vok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 17:44:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40976 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE1Voj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 17:44:39 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14SLgvli080286;
        Fri, 28 May 2021 16:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622238177;
        bh=NTS8xGfi85s6wvVH3H4ut0lmVjGNdF1kNZLJAI0SOG0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fJqRQJLPQBrixpcE2q0govjHRSJwSI2YAuDIF6MhZBU7cpDY4XNvJiOtoR7nzS6Oz
         3JbUngRGVy9mHNl/JpaxctSz836yYYSrJsKwcXqQU/0Pq7cTSYS+kySvY+jSJjncqu
         BC8j/e2TRx3nFLCrLMKkqoafYJBfgsKjytOpJKRA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14SLgvrk121396
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 May 2021 16:42:57 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 16:42:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 28 May 2021 16:42:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14SLgv3V058266;
        Fri, 28 May 2021 16:42:57 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Remove "#address-cells" property from GPIO DT nodes
Date:   Fri, 28 May 2021 16:42:56 -0500
Message-ID: <162223779305.32487.3166148122451417989.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210423064758.25520-1-a-govindraju@ti.com>
References: <20210423064758.25520-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2021 12:17:57 +0530, Aswath Govindraju wrote:
> GPIO device tree nodes do not have child nodes. Therefore, "#address-cells"
> property should not be added.

Hi Aswath Govindraju,

I have applied the following to branch ti-k3-next on [1].

NOTE: I know this adds warnings with W=2 build of dtbs, BUT, just like
xilinx guys[2] and us[33 -> we have already established #address-cells = <0>
make no sense and dtc is still broken as of next-20210528

So, as far as I am concerned, I am going to keep ignoring these kind of
warnings - and "To" Andre as well.. hopefully we can get around to cleaning
this up some day.

Thank you!

[1/1] arm64: dts: ti: k3-j7200: Remove "#address-cells" property from GPIO DT nodes
      commit: 6ec8ba764165f6ecb6f6f7efbfd2ec7ad76dedcb


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
[2] https://lore.kernel.org/linux-devicetree/CAL_Jsq++DyiKG9smQGx9FAPDJnVrezcXNb0Y5uh-5_2GBzTQpQ@mail.gmail.com/
[3] https://lore.kernel.org/linux-devicetree/20210126163839.57491132@slackpad.fritz.box/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

