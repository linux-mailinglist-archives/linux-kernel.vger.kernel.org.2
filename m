Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8219C32A5F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447523AbhCBNlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 08:41:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51194 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350677AbhCBMWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:22:53 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 122C5MZe088295;
        Tue, 2 Mar 2021 06:05:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614686722;
        bh=qA6jv361Vc1+x0jYalhA2uiLqg90xU60dYC38iYq+tU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZDPYVw9Nc/Cq0JSbP4oYjkV6MM2e9hbKdRvZO0T4+pf+ZcR4ynCEgJrG7JIAOKZUu
         HLjcZrRXPj8cHLKpGKAB6q43/LHlbxEsk+dWhrQTOsq8KDagRQDfeZ1IiO+Cp/TEEM
         TMV0258a3t0FPbR6BsVYKd9tiNuhGa92DRc36U6Y=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 122C5MSB110635
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Mar 2021 06:05:22 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 2 Mar
 2021 06:05:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 2 Mar 2021 06:05:21 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 122C5L8r081329;
        Tue, 2 Mar 2021 06:05:21 -0600
Date:   Tue, 2 Mar 2021 17:35:20 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j7200-som-p0: Add nodes for OSPI0
Message-ID: <20210302120518.4xe3dwd5v6hr2tav@ti.com>
References: <20210301195850.31868-1-p.yadav@ti.com>
 <20210301195850.31868-4-p.yadav@ti.com>
 <876caefd-b53e-0d1d-422c-cc3255774d88@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <876caefd-b53e-0d1d-422c-cc3255774d88@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/21 01:10PM, Vignesh Raghavendra wrote:
> 
> 
> On 3/2/21 1:28 AM, Pratyush Yadav wrote:
> > +
> > +	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
> > +		pinctrl-single,pins = <
> > +			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_OSPI0_CLK */
> > +			J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
> > +			J721E_WKUP_IOPAD(0x000c, PIN_INPUT, 0)  /* MCU_OSPI0_D0 */
> > +			J721E_WKUP_IOPAD(0x0010, PIN_INPUT, 0)  /* MCU_OSPI0_D1 */
> > +			J721E_WKUP_IOPAD(0x0014, PIN_INPUT, 0)  /* MCU_OSPI0_D2 */
> > +			J721E_WKUP_IOPAD(0x0018, PIN_INPUT, 0)  /* MCU_OSPI0_D3 */
> > +			J721E_WKUP_IOPAD(0x001c, PIN_INPUT, 0)  /* MCU_OSPI0_D4 */
> > +			J721E_WKUP_IOPAD(0x0020, PIN_INPUT, 0)  /* MCU_OSPI0_D5 */
> > +			J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* MCU_OSPI0_D6 */
> > +			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* MCU_OSPI0_D7 */
> > +			J721E_WKUP_IOPAD(0x0008, PIN_INPUT_PULLDOWN, 0)  /* MCU_OSPI0_DQS */
> > +		>;
> > +	};
> 
> There is a pulldown resistor on the board right? So, internal pulldown
> is unnecessary and may even cause conflicts.

Right. Will fix.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
