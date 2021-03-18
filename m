Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E621D3407CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhCROZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:25:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57076 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhCROZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:25:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12IEP8rQ119152;
        Thu, 18 Mar 2021 09:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616077508;
        bh=AS5mc4D+zGl7h7RvNCtg/TsfCUXanbmzNv2rPurXutI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nbIBRamJTnOuw2oIflzjPhjngHBNID7Vev58b3uMoNFOTY3h4sPVgtJotEOKLCqug
         478NAXBOHMTo07lhKZ3Rmf/UKij5tYp1LY64Px4KmGTHngbY7RVFg5tH+Yh916PEqm
         G+jqc7qPLV07n64hEtj770N0fN5koJP4sXfI69jk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12IEP8Qf124522
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Mar 2021 09:25:08 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 18
 Mar 2021 09:25:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 18 Mar 2021 09:25:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12IEP72N110676;
        Thu, 18 Mar 2021 09:25:07 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [RESEND PATCH v2 1/2] arm64: dts: ti: k3-am64-main: Add OSPI node
Date:   Thu, 18 Mar 2021 09:25:07 -0500
Message-ID: <161607554267.23461.17402124466947052334.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210318113757.21012-1-vigneshr@ti.com>
References: <20210318113757.21012-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 17:07:56 +0530, Vignesh Raghavendra wrote:
> AM64 SoC has a single Octal SPI (OSPI) instance under Flash SubSystem
> (FSS).  Add DT entry for the same.

Hi Vignesh Raghavendra,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am64-main: Add OSPI node
      commit: 81623c55868475c4a81c7cdce38191c92ea37022
[2/2] arm64: dts: ti: k3-am64-evm/sk: Add OSPI flash DT node
      commit: e4e4e89482eafab0774ac0f93dc998eea84e626c

Thanks for rebasing and helping sequence. I have taken note that we
will be converting the binding to yaml in near future, so inline with
what we are doing now, accepting the patches.

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

