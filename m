Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B6B34497E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhCVPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:43:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52652 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCVPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:42:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12MFgqi6039048;
        Mon, 22 Mar 2021 10:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616427772;
        bh=6JwNNML3JlGo0jBc2dm+9A/x2VCSuSw7ushYhILov8s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WNnEzozqwHWv71GheZldMLn3AMqSh+W8z5pTH59grsugAyYIL61PP7PG+f7iFaXpB
         60C0fL03ksomCNyNaJlzhHebu7cc9mhLGD0yPzTZdydL4lzczS02i6uqfPB3gaxeWJ
         KRIrAILhAFUSsA/5Fh2TnAGAk5O8zrgosRPxCnlk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12MFgq6h052489
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Mar 2021 10:42:52 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 22
 Mar 2021 10:42:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 22 Mar 2021 10:42:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12MFgq8v005002;
        Mon, 22 Mar 2021 10:42:52 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] AM64: Add support for GPIO
Date:   Mon, 22 Mar 2021 10:42:51 -0500
Message-ID: <161642769912.26591.1917604238322825662.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210319051950.17549-1-a-govindraju@ti.com>
References: <20210319051950.17549-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 10:49:48 +0530, Aswath Govindraju wrote:
> The following series of patches adds support for gpio on AM642 evm/sk.
> 
> GPIO test logs,
> AM642-evm: https://pastebin.ubuntu.com/p/PCGmY34spb/
> AM642-sk:  https://pastebin.ubuntu.com/p/nrxzyQTKkX/
> 
> Changes since v2:
> - Rebased the series on top of ti-k3-dts-next branch
> - Added gpio test logs.
> 
> [...]

Hi Aswath Govindraju,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am64: Add GPIO DT nodes
      commit: 01a91e01b8fddaeb37b953a5e39eafbdf2d4b061
[2/2] arm64: dts: ti: k3-am642: reserve gpio in mcu domain for firmware usage
      commit: d5a4d5413dd833b3ceba395ba77f00470a3ffbe8


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

