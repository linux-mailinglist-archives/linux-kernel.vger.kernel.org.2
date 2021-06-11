Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56F73A48FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhFKTCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:02:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34648 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFKTCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:02:47 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15BJ0ev4085288;
        Fri, 11 Jun 2021 14:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623438040;
        bh=vFfJv1DJK8Bw4YTTIhR/MlPi6BczN33Mge3qrZ5xeZI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Pco79IsprNwJadNVmHiG8WfKA7TzSejZbVwpyxLrCx3nAZyRWKoVY0Lotlauozmae
         OKMUkfUyR8ocXMAQ3wOAcxB7ffLKSe+qYKceGXxX37xNPpxAydQJaHxChfErJjXWhs
         gdsdaPL+3P9JVNTXbq/o6+rxsnLfWhdAj9PYDSWE=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15BJ0e9s075908
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jun 2021 14:00:40 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 14:00:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 11 Jun 2021 14:00:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15BJ0ewO065001;
        Fri, 11 Jun 2021 14:00:40 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: am65/am64: Fix ti,pindir-d0-out-d1-in property to boolean
Date:   Fri, 11 Jun 2021 14:00:39 -0500
Message-ID: <162343802641.7621.4442458748650241719.b4-ty@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608051414.14873-1-a-govindraju@ti.com>
References: <20210608051414.14873-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 10:44:12 +0530, Aswath Govindraju wrote:
> The following series of patches fix "ti,pindir-d0-out-d1-in" property to
> boolean.
> 
> changes since v1:
> - added fixes tags
> - split the series according to their respective trees
> 
> [...]

Hi Aswath Govindraju,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: am65: align ti,pindir-d0-out-d1-in property with dt-shema
      commit: 5c5217c76a26d04e44e7c359cd5f044adb648d31
[2/2] arm64: dts: ti: k3-am642-evm: align ti,pindir-d0-out-d1-in property with dt-shema
      commit: 7c5b7c6071396c9de09048b8ffa21e0b29b99f7b


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

