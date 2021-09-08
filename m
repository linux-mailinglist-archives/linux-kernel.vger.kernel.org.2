Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1784033EE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 07:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhIHFuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 01:50:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60606 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbhIHFuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 01:50:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1885mie3037092;
        Wed, 8 Sep 2021 00:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631080124;
        bh=2vI1xY8COoy2aNYEy9pE5ZOXaHw78xyMeW2MhP1KkE4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=fSiD9Clff46sXzsRGhNHCV9aHgXJTZpkkLGaXW97UaG9lSv7FeYWT5W2qQ+F8pqYJ
         zhgF0YzCm0xbN3IhZavsQU/CblGMfETx8aIDFj3LLZVNSv76YcsIXYzAkGphpUWDRS
         3Loi8oITBk0t2SneWrAp/LAlUbHyQdYh7w8CuGKE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1885mieE049562
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Sep 2021 00:48:44 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Sep 2021 00:48:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Sep 2021 00:48:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1885misE016294;
        Wed, 8 Sep 2021 00:48:44 -0500
Date:   Wed, 8 Sep 2021 00:48:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am65: Flip mmc device ordering
Message-ID: <20210908054844.7ym3flo6f2pryd2x@unplug>
References: <cover.1631032682.git.jan.kiszka@siemens.com>
 <0dce149347353556e38a0bdf9a9489ffc9cf66d2.1631032682.git.jan.kiszka@siemens.com>
 <20210908024442.jskmqqye432p4nmt@gatherer>
 <674ccec8-c972-a32b-6722-922bf3c55abd@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <674ccec8-c972-a32b-6722-922bf3c55abd@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07:25-20210908, Jan Kiszka wrote:
> On 08.09.21 04:44, Nishanth Menon wrote:
> > On 18:37-20210907, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> This ensures that the SD card will remain mmc0 across devices with and
> >> without eMMC.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  arch/arm64/boot/dts/ti/k3-am65.dtsi | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> >> index a9fc1af03f27..785d931a2dd9 100644
> >> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> >> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> >> @@ -31,6 +31,8 @@ aliases {
> >>  		i2c4 = &main_i2c2;
> >>  		i2c5 = &main_i2c3;
> >>  		ethernet0 = &cpsw_port1;
> >> +		mmc0 = &sdhci1;
> >> +		mmc1 = &sdhci0;
> > 
> > Jan,
> > 
> > Responding in context of [1]. Suggestion from Aswath is to do the
> > following instead at SoC level:
> > +		mmc0 = &sdhci0;
> > +		mmc1 = &sdhci1;
> > 
> 
> Then I will leave this up to you and will go back to v1 of this patch
> (as we require it the other way around).

Could you elaborate on the rationale as to why the other way around?
That would probably provide the reasoning to override the SoC generic
definitions in the board dts/dtsi as the exception case.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
