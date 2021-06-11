Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478F23A4903
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhFKTDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:03:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54980 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhFKTDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:03:22 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15BJ1KpO050753;
        Fri, 11 Jun 2021 14:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623438081;
        bh=6Q+15fy/NVxEQ2Ca5L+lurVioUlPqc17s1EEWMcllvQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=E6u7jtIZEI/WGHhBxAvPjE4OdIq5UBVkBA1BRkqbPb+ICnondvPxsDSPSx9d9yLoC
         xb7mbagVZ3/NduyxpML9+qx0F//rrbDgQd4wBsnVRjRBI9VasYGTA6glPYoKvmx6IG
         8rXDOz02rI0fpXp6+YvCbCKuz3pkmA7DlTTCH8/A=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15BJ1K9h098039
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jun 2021 14:01:20 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 14:01:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 11 Jun 2021 14:01:20 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15BJ1KKF014371;
        Fri, 11 Jun 2021 14:01:20 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-main: fix ports mac properties
Date:   Fri, 11 Jun 2021 14:01:19 -0500
Message-ID: <162343806972.7960.17035986962918713377.b4-ty@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608184940.25934-1-grygorii.strashko@ti.com>
References: <20210608184940.25934-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 21:49:40 +0300, Grygorii Strashko wrote:
> The current device tree CPSW3g node adds non-zero "mac-address" property to
> the ports, which prevents random MAC address assignment to network devices
> if bootloader failed to update DT. This may cause more then one host to
> have the same MAC in the network.
> 
>  mac-address = [00 00 de ad be ef];
>  mac-address = [00 01 de ad be ef];
> 
> [...]

Hi Grygorii Strashko,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am642-main: fix ports mac properties
      commit: e04f89c15ea84967fae355d335c5df14349d038d


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

