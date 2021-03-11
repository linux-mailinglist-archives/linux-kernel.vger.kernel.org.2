Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B842B33753B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhCKOPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:15:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34642 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhCKOPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:15:34 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BEFSMP071222;
        Thu, 11 Mar 2021 08:15:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615472128;
        bh=MOBeXqgQwkdDRHKPpnXmIqS8GIrOxoYyKkZlQQEtqXU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=umyLxof2XEi1Vb7FGP/CbpvV6UCNourFj6U+5plzd/uKOIagZRADAhyYwS8UCj/ES
         xzuzSUzGDpkLXVIL3PkUnGbrl+RlfE+23ugrWia5c74UBiTDf2y1VJTKMPFgY0JU7Q
         STldO1pglCriKb84x6pZKUA/tQsCebiKocotCsQw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BEFS0A017541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 08:15:28 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 08:15:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 08:15:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BEFRcp114290;
        Thu, 11 Mar 2021 08:15:27 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>, Jan Kiszka <jan.kiszka@web.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am65-mcu: Add RTI watchdog entry
Date:   Thu, 11 Mar 2021 08:15:26 -0600
Message-ID: <161547210071.15533.17336165044667660899.b4-ty@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <279c20fa-6e5e-4f88-9cd1-f76297a28a19@web.de>
References: <279c20fa-6e5e-4f88-9cd1-f76297a28a19@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Feb 2021 13:49:51 +0100, Jan Kiszka wrote:
> Add the DT entry for a watchdog based on RTI1.
> 
> On SR1.0 silicon, it requires additional firmware on the MCU R5F cores
> to handle the expiry, e.g. https://github.com/siemens/k3-rti-wdt. As
> this firmware will also lock the power domain to protect it against
> premature shutdown, mark it shared.

Hi Jan Kiszka,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am65-mcu: Add RTI watchdog entry
      commit: 6674a90bb141496f56ce840c22f2f2ddccc5d397


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
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

