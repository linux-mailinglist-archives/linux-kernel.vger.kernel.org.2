Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458C332BEB0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574945AbhCCRe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:34:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55186 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbhCCOHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:07:16 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 123E5KbK030138;
        Wed, 3 Mar 2021 08:05:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614780320;
        bh=sny2YcpGa4DQa7cTGGJ00vnhQUe+5Yv3lyKxESu3egQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qoii31p7VqP9cyjdUjx5aw4dxClyQ4Wm6uITtyWExRNAxzyOP2k3ycT9g4LKYvoz6
         kG2SFS23dVMP++HuoQzfYwRWQwcdbz0EmrXcT+/uBzqP81IXlChq9hLsyA15WQFrC/
         VzYIlSKAfYrBB1gVUaIyOT7zXi8l45hGAsQHCcTg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 123E5KNx032649
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Mar 2021 08:05:20 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 3 Mar
 2021 08:05:19 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 3 Mar 2021 08:05:19 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 123E5Jht107458;
        Wed, 3 Mar 2021 08:05:19 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Bao Cheng Su <baocheng.su@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Le Jin <le.jin@siemens.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] arm64: Add TI AM65x-based IOT2050 boards
Date:   Wed, 3 Mar 2021 08:05:18 -0600
Message-ID: <161477999018.19253.13540036146776431880.b4-ty@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613071976.git.jan.kiszka@siemens.com>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 20:32:52 +0100, Jan Kiszka wrote:
> Changes in v2:
>  - address board-specific issues found by kernel_verify_patch
>  - remove dead l2-cache node from iot2050-basic DT
>  - add binding for Siemens vendor prefix
>  - factor out board bindings into separate patch
>  - add missing device_type to common ti,am654-pcie-rc nodes
> 
> [...]

Hi Jan Kiszka,

I have picked patch #4 in your series to the following to branch
ti-k3-dts-next on [1]. Thank you! Rest of the series will have to be
reposted *after* Rob Herring Acks the bindings (monitor status in
queue [2]).

[4/4] arm64: dts: ti: k3-am65-main: Add device_type to pcie*_rc nodes
      commit: 0d7571c36331aafce485fa105959b498c86615d7

I have picked patch #4 for the next kernel window for now, given it is
a trivial fix.

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
[2] https://patchwork.ozlabs.org/project/devicetree-bindings/list/?param=3&page=2
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

