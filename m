Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC2A39487A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 23:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhE1Vv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 17:51:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42098 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE1Vv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 17:51:28 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14SLnoPK082388;
        Fri, 28 May 2021 16:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622238590;
        bh=XCnkoYinxBiG1zmVc0uHZ4SOvw0tN3dtLz+aEzJIxyI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pKLjhZGjzg6Rsxx6ogoBuOyB7ce6HrZQRbUNsIgBoabGgkzGi9RCl7/b9bTNh9hyQ
         P7JVPWY07qfKofVKrsFzdbBtdrQRIQmuMNmAukU9AlznrjIdCex48TUGIPkq602qT6
         R4k2tiMaN0+PvnETDjRykAr2OJdIRCvB9m7iLWMc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14SLnoTh128980
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 May 2021 16:49:50 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 16:49:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 28 May 2021 16:49:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14SLnoUg091386;
        Fri, 28 May 2021 16:49:50 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        <devicetree@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH next] arm64: dts: ti: k3-am654x/j721e/j7200-common-proc-board: fix MCU_RGMII1_TXC direction
Date:   Fri, 28 May 2021 16:49:49 -0500
Message-ID: <162223856469.6650.3982154693842996954.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210526132041.6104-1-grygorii.strashko@ti.com>
References: <20210526132041.6104-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 16:20:41 +0300, Grygorii Strashko wrote:
> The MCU RGMII MCU_RGMII1_TXC pin is defined as input by mistake, although
> this does not make any difference functionality wise it's better to update
> to avoid confusion.
> 
> Hence fix MCU RGMII MCU_RGMII1_TXC pin pinmux definitions to be an output
> in K3 am654x/j721e/j7200 board files.

Hi Grygorii Strashko,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am654x/j721e/j7200-common-proc-board: fix MCU_RGMII1_TXC direction
      commit: 69db725cdb2b803af67897a08ea54467d11f6020


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

