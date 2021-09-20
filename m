Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAE412696
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355920AbhITTEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 15:04:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43576 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348795AbhITTCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 15:02:03 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18KJ0UX9116530;
        Mon, 20 Sep 2021 14:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632164430;
        bh=IMClnU/YyQnWbSBEqOxsGPP8IYZ4Cdu8zn/o3dLTNU8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PvuLQRkRU+t/dsc8+Z2nrbqXatgEtA/qLFM/iGJRlHIj3+c+GlrvVEvlLQZYbjRPw
         FK5l6NtHxj1iOV21wRJEx64bo1ra313AzxzBMDfEoVDKcK+dYzlnzN3Ys7fl+G6SG8
         qG+ZQbJodSH8bO8ddgYv7olsT6p8jEMMqWZy8eHk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18KJ0UBD019024
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 14:00:30 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 14:00:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 14:00:30 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18KJ0U73056427;
        Mon, 20 Sep 2021 14:00:30 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, Keerthy <j-keerthy@ti.com>,
        <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am65: Relocate thermal-zones to SoC specific location
Date:   Mon, 20 Sep 2021 14:00:29 -0500
Message-ID: <163216442066.26716.12895024908569774890.b4-ty@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210916181801.32588-1-nm@ti.com>
References: <20210916181801.32588-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 13:18:01 -0500, Nishanth Menon wrote:
> When commit 64f9147d914d ("arm64: dts: ti: am654: Add thermal
> zones") introduced thermal-zones for am654, it defined as under the
> common am65-wakeup bus segment, when it is am654 specific (other SoC
> spins can have slightly different thermal characteristics). Futher,
> thermal-zones is introduced under simple-bus node, when it has no
> actual register or base address.
> 
> [...]

Hi Nishanth Menon,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am65: Relocate thermal-zones to SoC specific location
      commit: 6037c75b193ac7aec33f131cd48744549b552604


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

