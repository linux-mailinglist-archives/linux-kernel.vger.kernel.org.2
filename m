Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05254233EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbhJEW6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:58:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49612 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhJEW6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:58:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 195Mu6us082014;
        Tue, 5 Oct 2021 17:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633474566;
        bh=fsX+WcE903z57eEAUn7eoIT7y8KU6OqMzWT8D2eLaos=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lUVDYpw4HRp4RNQayv4SLOqd6xOri+dzGCeLsOJdECnXaPC9/2WoiSR/+Zu9gbmXj
         ruopqEaWH4fD9NG9Ly4aXzfIxrm0qEBpS28ooGGRGAlayWalbAyspVSRU1avhT4Ryc
         O+1uE4V2qYt/ICkWvhKKtTDlfLTOGAR7ofMQ8HBc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 195Mu6w8079094
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Oct 2021 17:56:06 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Oct 2021 17:56:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Oct 2021 17:56:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 195Mu5bM096616;
        Tue, 5 Oct 2021 17:56:05 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Hari Nagalla <hnagalla@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sinthu Raja <sinthu.raja@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>
Subject: Re: (subset) [PATCH V2 0/4] arm64: dts: ti: k3-j721e/j7200: Introduce EVM compatible
Date:   Tue, 5 Oct 2021 17:56:05 -0500
Message-ID: <163347451826.3195.7831470112077815490.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210925201430.11678-1-nm@ti.com>
References: <20210925201430.11678-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 15:14:26 -0500, Nishanth Menon wrote:
> This is prep work for potentially introducing new platforms for
> j721e/j7200 and brings these evms on par with AM65 and AM64 usage
> models as well for consistency.
> 
> Changes since v1:
> * Modified the series so that backward compatibility is still maintained
> * No more conflict or dependence with [1].
> * Added consistency to am642/am654 platforms as well.
> 
> [...]

Hi Nishanth Menon,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] dt-bindings: arm: ti: Add missing compatibles for j721e/j7200 evms
      commit: c4d269c95545929263bdd06392d4ef4791363bda
[3/4] arm64: dts: ti: k3-j721e-common-proc-board: Add j721e-evm compatible
      commit: c47eebaf4d76d995104e811b040d196082b880fd
[4/4] arm64: dts: ti: k3-j7200-common-proc-board: Add j7200-evm compatible
      commit: 2cf3213d2331526f00ca31a5b00450e920a03908


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

