Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B33733F8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhCQTL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:11:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38290 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhCQTKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:10:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12HJAjaV005132;
        Wed, 17 Mar 2021 14:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616008245;
        bh=Tr1lXzHpbqJJQa5y6bYpsIDAlJx1boXQSoQ2aG86+I4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HFy/MoyRluFqNqLcQLCeEfVE7pQjZsu4PbG5RISYUNuaCfr3MzuE99lbKnbPpkGlz
         T7UHQ7QRZcAn/dAAHw3mF9Np0KFhfcGVnlyexgPWV37EXofr1kRiANzZ8aVc4Mx74d
         nC+vXz/M+ba2d555MTrRjiSoE3snm//HKi27jPCI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12HJAj6F080447
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Mar 2021 14:10:45 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 17
 Mar 2021 14:10:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 17 Mar 2021 14:10:45 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12HJAjE5031520;
        Wed, 17 Mar 2021 14:10:45 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>, <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 0/2] AM64: Add USB support
Date:   Wed, 17 Mar 2021 14:10:39 -0500
Message-ID: <161600762739.1043.8722896780317279431.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317043007.18272-1-a-govindraju@ti.com>
References: <20210317043007.18272-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 10:00:04 +0530, Aswath Govindraju wrote:
> The following series of patches, add USB support for AM642 evm.
> 
> USB test logs,
> https://pastebin.ubuntu.com/p/YSQRBWGmzd/
> 
> Changes since v2:
> - dropped compatible string "ti,j721e-usb" leading to DT schema errors
> - Reran test logs
> - Couldn't pick up reviewed-by from kishon as a change was made in the
>   patch
> 
> [...]

Hi Aswath Govindraju,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am64-main: Add DT node for USB subsystem
      commit: d06a661309d30b654b74a4633dd78804ef16369f
[2/2] arm64: dts: ti: k3-am642-evm: Add USB support
      commit: 04a80a75baa1c80f7e5096147b6173c13ca3d3e0


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

