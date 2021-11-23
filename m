Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D734599F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhKWCHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:07:34 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49774 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhKWCHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:07:31 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AN24Cs6005358;
        Mon, 22 Nov 2021 20:04:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637633052;
        bh=ZtaP19s45n/k8sQWhrgK9O3eJF4KJgDsM3wfYMVoy40=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kwzNHQ5LEO8S3jw4kao9RMnS1p5g6fhmrr4bYwHJs+4ihCx6/rLrje4LXR4lUA9UZ
         HKj352W+gu9fuj2EWf/bx3mkXqnaGX8/RlL+QgBSRFHwaboViy5ci8uoiTYlbPVK/A
         lIYleXsQ7P+v9rZvYNL5/k3X1CsGLtPnhN15U1Po=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AN24CPp037885
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 20:04:12 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 20:04:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 20:04:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AN24BoV101668;
        Mon, 22 Nov 2021 20:04:11 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
CC:     Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] soc: ti: pruss: fix referenced node in error message
Date:   Mon, 22 Nov 2021 20:04:10 -0600
Message-ID: <163763303249.31252.7911231463957684515.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d6e24953-ea89-fd1c-6e16-7a0142118054@siemens.com>
References: <d6e24953-ea89-fd1c-6e16-7a0142118054@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan Kiszka,

On Mon, 21 Jun 2021 20:08:28 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> So far, "(null)" is reported for the node that is missing clocks.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: pruss: fix referenced node in error message
      commit: 8aa35e0bb5eaa42bac415ad0847985daa7b4890c

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

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

