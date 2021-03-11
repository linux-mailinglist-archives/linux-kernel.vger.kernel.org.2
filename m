Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9AE33732B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhCKM4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:56:44 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35658 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhCKM4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:56:42 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BCuYgP088168;
        Thu, 11 Mar 2021 06:56:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615467394;
        bh=uJnbpXnms4SnS3ynBidcwyRbReyVdV/vvIAziDN5u2Y=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=eiw0w5ZSmClt/K+h/fgH6BwoQk6014EL0cCZ9O8C+IIio13L1ZG2G7PBu9QU0Bp26
         mDVrxWwOLIQ8Ro5piLQJMQRWBk682EIopWnNi8vJVbyr0Vvlf5yp1B+AhzwJF8yklk
         Kjb3jjNuXWB84jiY8cr4zhhUgVRyC+cbcWKxHHcU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BCuYMt083319
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 06:56:34 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 06:56:34 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 06:56:34 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BCuY44046511;
        Thu, 11 Mar 2021 06:56:34 -0600
Date:   Thu, 11 Mar 2021 06:56:34 -0600
From:   Nishanth Menon <nm@ti.com>
To:     "Bajjuri, Praneeth" <praneeth@ti.com>
CC:     Jan Kiszka <jan.kiszka@web.de>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am65-mcu: Add RTI watchdog entry
Message-ID: <20210311125634.sasiot7hemsdcajl@thrash>
References: <279c20fa-6e5e-4f88-9cd1-f76297a28a19@web.de>
 <9097f361-419f-995f-2f05-d17a949af1cb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9097f361-419f-995f-2f05-d17a949af1cb@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:36-20210310, Bajjuri, Praneeth wrote:
> 
> 
> On 2/20/2021 6:49 AM, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> > Add the DT entry for a watchdog based on RTI1.
> > 
> > On SR1.0 silicon, it requires additional firmware on the MCU R5F cores
> > to handle the expiry, e.g. https://github.com/siemens/k3-rti-wdt. As
> > this firmware will also lock the power domain to protect it against
> > premature shutdown, mark it shared.
> > 
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Acked-by: Praneeth Bajjuri <praneeth@ti.com>
> 
> > ---
> >   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > index 7454c8cec0cc..903796bf7d64 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > @@ -308,4 +308,13 @@ mcu_r5fss0_core1: r5f@41400000 {
> >   			ti,loczrama = <1>;
> >   		};
> >   	};
> > +
> > +	mcu_rti1: rti@40610000 {

Jan, I was about to pick up the patches and was running through
my sanity checks and the following caught my eye with dtbs_check
(dtschema is at 2021.2.1) test against next-20210311

/workdir/arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml: rti@40610000: $nodename:0: 'rti@40610000' does not match '^watchdog(@.*|-[0-9a-f])?$'

Please use watchdog@40610000 instead of rti@40610000

Since this is a minor change, I have done this change locally. let me
know if you have an issue and I can drop it off my branch for a new
version.

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
