Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7DB3DBC84
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhG3Pqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:46:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33796 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhG3Pqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:46:35 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16UFkOHH079028;
        Fri, 30 Jul 2021 10:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627659984;
        bh=zWC1wL/dUjWpagi3NkYNtcyulwt6EbuLhREI65OuVh8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=b5YPgB7cOC1aOGkX5cKu5Z9BG3EWiHGJGow70JsQKvURTNLDPAb3O7JnTJjTNO6HS
         D8UQUvkQNclF9dJALnGSZkAIgEzxJJ+UXObimvFX6/SN/HfJ6EtY4w6e/4WGMC3q6d
         Y+yEl61+eoqLyuf17nftu8xfI2y6CNOkUB/o0N+s=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16UFkOIb117897
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Jul 2021 10:46:24 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 30
 Jul 2021 10:46:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 30 Jul 2021 10:46:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16UFkOjH060973;
        Fri, 30 Jul 2021 10:46:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>, <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Vignesh R <vigneshr@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] arm64: dts: ti: k3-am64: Add PWM nodes
Date:   Fri, 30 Jul 2021 10:46:23 -0500
Message-ID: <162765993452.9115.3360387735192186820.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210721113625.17299-1-lokeshvutla@ti.com>
References: <20210721113625.17299-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 17:06:21 +0530, Lokesh Vutla wrote:
> Add epwm and ecap nodes for AM64 boards.
> 
> Changes since v1:
> - Mark all un-used pwm nodes as disabled.
> 
> Lokesh Vutla (4):
>   arm64: dts: ti: k3-am64-main: Add epwm nodes
>   arm64: dts: ti: k3-am64-main: Add ecap pwm nodes
>   arm64: dts: ti: k3-am642-evm: Add pwm nodes
>   arm64: dts: ti: k3-am642-sk: Add pwm nodes
> 
> [...]

Hi Lokesh Vutla,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am64-main: Add epwm nodes
      commit: 13a9a3ef66248a1b6e9acaaa5292d96f8635935b
[2/4] arm64: dts: ti: k3-am64-main: Add ecap pwm nodes
      commit: ae0df139b51a8448afb38e9706f257ab56fea097
[3/4] arm64: dts: ti: k3-am642-evm: Add pwm nodes
      commit: 8032affdf5a156a467d3b109f32cd9f57ea7afda
[4/4] arm64: dts: ti: k3-am642-sk: Add pwm nodes
      commit: c1fa5ac6c2f475b5140e6323801ed93c24e7e5cf


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

