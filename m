Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9A0394865
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 23:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhE1Vhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 17:37:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39668 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhE1Vhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 17:37:35 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14SLZu1t000971;
        Fri, 28 May 2021 16:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622237756;
        bh=to4YGSlSfjwwrDE8P2A93/IMeS3y9zyjR5kz/hOTsuY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WV2eEyESVun/DZcA2PIjiIMEezKfFYz75JK5PnzrojPyNCKwTuABSJF2VV84xyPLc
         K+C9HfeXPzs+H+9eWrgM3vww2M9wk4bSwlSI2jgUPsj5EwL7Ritktty+KCZm1zAnSH
         36enErqyj80dzS8caBH5yAOI7jrZFdwk9B3BuUYA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14SLZubj036231
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 May 2021 16:35:56 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 16:35:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 28 May 2021 16:35:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14SLZuaZ068244;
        Fri, 28 May 2021 16:35:56 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-mcu: Fix the compatible string in GPIO DT node
Date:   Fri, 28 May 2021 16:35:55 -0500
Message-ID: <162223765491.32272.6001997528311115785.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210423060133.16473-1-a-govindraju@ti.com>
References: <20210423060133.16473-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2021 11:31:33 +0530, Aswath Govindraju wrote:
> Fix the compatible string in mcu domain GPIO device tree node.

Hi Aswath Govindraju,

I have applied the following to branch ti-k3-next on [1].

NOTE: I know you are working on yaml conversion[2] and this is a valid
bug fix as well, as a result, I dont think there is any existing norms
conflicted in picking this fixup ahead of yaml conversion merge.

Thank you!

[1/1] arm64: dts: ti: k3-am64-mcu: Fix the compatible string in GPIO DT node
      commit: ec2fb989d03e7f79f7cd901cf9abf40aebba7acf


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
[2] https://lore.kernel.org/linux-devicetree/20210524151955.8008-3-a-govindraju@ti.com/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

