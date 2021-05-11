Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE01C37AC03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhEKQfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:35:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51212 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhEKQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:35:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14BGXwMS004198;
        Tue, 11 May 2021 11:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620750838;
        bh=gnzp79Uxh8GP46+NAdBtG+RKNjsXiTwM32k0QEF82eo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=mCd/oElxd2OcNExuFCbZ7e07+aI4zeA/AzCqiwBWEF4H7F6uzw4e/qYhhjrf9p7qI
         UGMVTTdmeqkm0reOEXoF4vDQqq6jbMpnEqnQWtoiRDSedi86q/3p6gEfRsV244vul+
         DiMYmKAzeqefIP54VdchLnwXZ8+ha+yCFKZ2DVHg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14BGXwuY097360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 May 2021 11:33:58 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 11
 May 2021 11:33:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 11 May 2021 11:33:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14BGXv8x116942;
        Tue, 11 May 2021 11:33:57 -0500
Date:   Tue, 11 May 2021 11:33:57 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am65: Add support for UHS-I modes
 in MMCSD1 subsystem
Message-ID: <20210511163357.2kp2jpg4uyk5nb5u@sizing>
References: <20210511095339.16268-1-a-govindraju@ti.com>
 <200b5648-b2d9-b4c9-f81a-b39c3baf81f9@siemens.com>
 <7561137c-adf1-bf03-c442-ff8174b2f143@ti.com>
 <95539fea-8190-7a3d-05aa-90824eb03293@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <95539fea-8190-7a3d-05aa-90824eb03293@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:26-20210511, Jan Kiszka wrote:
[...]
> >>> +&sdhci1 {
> >>> +	no-1-8-v;
> >>> +};
> >>> +
> >>
> >> Let's move that to k3-am65-iot2050-common.dtsi, to avoid repeating
> >> yourself. There is already a sdhci1 extension.
> >>
> > 
> > The reason why I added these tags in board dts and not in the common
> > dtsi is because if it was added in the common board then for all the iot
> > boards this will be applicable and in future if a different version of
> > iot boards use S.R. 2.0 then we might have to change it again.
> 
> Yes, we will have to take care of the split-up for SR2.0-based variants.
> I didn't have the chance study their DTs yet but I strongly suspect that
> there will be more differences. Then we may add some
> k3-am65-iot2050-common-{SR1,SR2}.dtsi.
> 
> So, I would not try to refactor when not all variables are on the table yet.


I agree with Jan. lets bring it in the current common.dtsi and see the
sr2 introduction separately.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
