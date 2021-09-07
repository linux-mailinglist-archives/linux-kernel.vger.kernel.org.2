Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6664402C07
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbhIGPjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:39:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34220 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbhIGPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:39:07 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 187FbtGd095460;
        Tue, 7 Sep 2021 10:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631029075;
        bh=gR3EEJyHpt8vx/sIEV8aAFRiaC5OiVjcTaFTZ3IoEGE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=mJ7PRh6cNViiQLcgv6IeZ4spjy727HD9kOaO4A/Nzfiwt9zjgiSCpGshl8MTwjTlW
         OUGVxepER5suPIDess4qR1zZTYXIfGiNqj+ugIE4WgkWw/Jgc2Rk8S6rOJMu2EnYaf
         vEAnA4R72s920jlIntwP5Fb89EWct+wJA5L4kegY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 187FbsPt012311
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Sep 2021 10:37:55 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Sep 2021 10:37:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Sep 2021 10:37:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 187FbsFm103979;
        Tue, 7 Sep 2021 10:37:54 -0500
Date:   Tue, 7 Sep 2021 10:37:54 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: Re: [PATCH 3/3] arm64: dts: ti: iot2050: Add support for product
 generation 2 boards
Message-ID: <20210907153754.2pm3mmovjjtkj5ig@overeager>
References: <cover.1631024536.git.jan.kiszka@siemens.com>
 <d678e0a2d77fbd71c95d554dcac4646c7e8e6cf0.1631024536.git.jan.kiszka@siemens.com>
 <20210907151648.5z4hnlgppurheloz@stroller>
 <37f18b9e-f640-2642-2849-ed5b61493bfa@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <37f18b9e-f640-2642-2849-ed5b61493bfa@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:27-20210907, Jan Kiszka wrote:
> On 07.09.21 17:16, Nishanth Menon wrote:
> > On 16:22-20210907, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Product Generations 1 and 2 differ in the SOC revision which requires
> >> separate device trees.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  arch/arm64/boot/dts/ti/Makefile               |  2 +
> >>  .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 46 ++++++++++++++++
> >>  .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 51 ++++++++++++++++++
> >>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 35 +-----------
> >>  ...ts => k3-am6528-iot2050-basic-common.dtsi} | 12 ++---
> >>  .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 21 ++++++++
> >>  .../boot/dts/ti/k3-am6528-iot2050-basic.dts   | 53 ++-----------------
> >>  ...=> k3-am6548-iot2050-advanced-common.dtsi} |  8 +--
> >>  .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 26 +++++++++
> >>  .../dts/ti/k3-am6548-iot2050-advanced.dts     | 52 ++----------------
> >>  10 files changed, 161 insertions(+), 145 deletions(-)
> >>  create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> >>  create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
> >>  copy arch/arm64/boot/dts/ti/{k3-am6528-iot2050-basic.dts => k3-am6528-iot2050-basic-common.dtsi} (80%)
> >>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
> >>  copy arch/arm64/boot/dts/ti/{k3-am6548-iot2050-advanced.dts => k3-am6548-iot2050-advanced-common.dtsi} (86%)
> >>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
> > 
> > 
> > Few things:
> > 
> > a) Could you split this patch so that the refactoring for SR1 is the
> >    first patch and then introduce the SR2?
> 
> Can do, sure
> 
> > b) Please call these as sr (silicon revision) rather than pg.
> 
> Nope, this is only motivated by the SR1->SR2 switch. The new products
> are called "PG2", and that is what the DT name must reflect. Took me a
> while to grasp that as well.


Aaah.. thanks.. will be good to document the same. I think you did mean
Product Generation as PG.. please call it out explicitly in the commit
message.

> 
> > c) usual request: Please add urls for the board
> 
> Where should they go? I think there is only one reasonable to share:
> 
> https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
> 
> If that is a stable link, I can't tell.


Please confirm and add that to the commit message of the patch that introduces pg2 board.

I'd also suggest adding the link to the dts file.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
