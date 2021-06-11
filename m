Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00743A4905
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhFKTDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:03:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55050 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhFKTDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:03:42 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15BJ1btP050871;
        Fri, 11 Jun 2021 14:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623438097;
        bh=oNYWXlYYC/1iioMcmA86F7d0ogALtgOe8ZV2+/LgoLE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rMxCW/7hhlj1A6zH2GNIiVEdrPzITZA4ClqQcC730z3ZxB7GEbWAM73u1SdIzFEag
         qxGRFlVjox5i/V2jWr2pt6vqowOC/fCOM4KgfW76m4x/dF60rIvrnvWQztLz5OqhB/
         oOBhvCQX5OllVgTJvzXFx7TYuAK9AcUD7AbuHuBQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15BJ1boN098220
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jun 2021 14:01:37 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 14:01:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 11 Jun 2021 14:01:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15BJ1aJB066668;
        Fri, 11 Jun 2021 14:01:36 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: iot2050: Configure r5f cluster on basic variant in split mode
Date:   Fri, 11 Jun 2021 14:01:36 -0500
Message-ID: <162343808815.8145.13615727789755621298.b4-ty@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <3a241e50-80a3-992a-2445-345c629d7895@siemens.com>
References: <3a241e50-80a3-992a-2445-345c629d7895@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 08:56:15 +0200, Jan Kiszka wrote:
> Lockstep mode is not supported here. So turn it off to avoid warnings
> during startup.

Hi Jan Kiszka,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: iot2050: Configure r5f cluster on basic variant in split mode
      commit: f1f55c6b77b6e88f8b9a95b7cb491bb619a1e6bc


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

