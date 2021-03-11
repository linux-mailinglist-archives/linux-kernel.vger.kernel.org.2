Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2F337CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCKSjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:39:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35438 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhCKSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:38:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BIbOBC060332;
        Thu, 11 Mar 2021 12:37:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615487844;
        bh=l1GLYNM7GSCnR+DUjlpPTr+HxeLYb/XQF100uzvva48=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DnYwce3UNBkO6y7tonNLSqL8JKdDRg9BGByBzkeGt0XzuS5UIby3qkkMUhrsxf1Mc
         mbC4Cxby2HLmRwHW/9v6DziLnP4tjCSBWi4tguZM4Tusz5MKHX8qjz5mvqfkSGiuRh
         fUt1j4OGWVY0cOUxZqKv3Lh7T1NnyBns8y54W0XY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BIbO2K087195
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 12:37:24 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 12:37:24 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 12:37:24 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BIbO2S017089;
        Thu, 11 Mar 2021 12:37:24 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        Le Jin <le.jin@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] arm64: Add TI AM65x-based IOT2050 boards
Date:   Thu, 11 Mar 2021 12:37:23 -0600
Message-ID: <161548777684.19604.14729158726589152309.b4-ty@ti.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b814c1
In-Reply-To: <cover.1615473223.git.jan.kiszka@siemens.com>
References: <cover.1615473223.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 15:33:40 +0100, Jan Kiszka wrote:
> Changes in v4:
>  - dropped spidev node
>  - rebased over ti-k3-dts-next
> 
> Jan
> 
> Jan Kiszka (3):
>   dt-bindings: Add Siemens vendor prefix
>   dt-bindings: arm: ti: Add bindings for Siemens IOT2050 boards
>   arm64: dts: ti: Add support for Siemens IOT2050 boards
> 
> [...]

Hi Jan Kiszka,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] dt-bindings: Add Siemens vendor prefix
      commit: 61a9114b891f0a4e5e4bee2bc93745343234973e
[2/3] dt-bindings: arm: ti: Add bindings for Siemens IOT2050 boards
      commit: 807a2b86269e6eea9ac9d4cd3aafccf8478449ee
[3/3] arm64: dts: ti: Add support for Siemens IOT2050 boards
      commit: e180f76d06412bb412ab675dadeb8c2b64da1dcf


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

