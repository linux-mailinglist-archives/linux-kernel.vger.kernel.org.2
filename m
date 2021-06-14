Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944BD3A6900
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhFNObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:31:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57612 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhFNObH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:31:07 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15EESnwd040412;
        Mon, 14 Jun 2021 09:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623680929;
        bh=+4NtWY3cuQShN1zQE/NiVLAmhqWotJAF5lyZWU71+cQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BosDe65qpSRNQ8+oFac8/3XawPJ7QQK+tMYxrP0X4+TGO4SI1BOmbXwHHz/ZpVG0a
         hAwxR5tkLqfvMg7raDq2yv6NCmcdHtkqFI2rU70X8oluoRqxwcIsid+iPuk6Vt6aWm
         SfYZIsDLW/vw4k3dorWGYUo3tKb8lp8rzAj21RfE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15EESn89073580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jun 2021 09:28:49 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 14
 Jun 2021 09:28:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 14 Jun 2021 09:28:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15EESn1T061901;
        Mon, 14 Jun 2021 09:28:49 -0500
Date:   Mon, 14 Jun 2021 09:28:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add SYSFW reserved ranges
 in OCRAM
Message-ID: <20210614142849.ogi4emuqgxg3m7ls@constrict>
References: <20210609140604.9490-1-vigneshr@ti.com>
 <20210611191640.lczsliyzasjie6lm@dismantle>
 <84e5865f-e107-f0e1-ca8b-b6bd655e92e6@ti.com>
 <36ff3c65-2f5e-2997-9fb5-a5e8d3230a75@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <36ff3c65-2f5e-2997-9fb5-a5e8d3230a75@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:18-20210614, Aswath Govindraju wrote:
> Hi Vignesh,
> 
> On 12/06/21 12:51 pm, Vignesh Raghavendra wrote:
> > +Aswath
> > 
> > On 6/12/21 12:46 AM, Nishanth Menon wrote:
> >> On 19:36-20210609, Vignesh Raghavendra wrote:
> >>> Last 256K of OCRAM (256K@0x701c0000) is reserved for SYSFW usage. Hence
> >>> add an entry in DT so that its not used for generic pool memory
> >>> allocation.
> >>
> >> Are you really sure?? I know that I had set a budget for 16K in sysfw
> >> when I did the memory split up for sysfw of which 16k is actually used.
> >>
> >> Not sure where this 256K bucket started off from.. am I missing
> >> something here?
> >>
> > 
> > Per: http://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am64x/firewalls.html
> > 
> > 24	dmsc	0x44060000	0x4407BFFF	dmsc,rwcd	 	 // alias for 0x701E0000
> > 24	dmsc	0x701FC000	0x701FFFFF	sproxy_private,rwcd	 	 
> > 24	dmsc	0x4407C000	0x4407FFFF	sproxy_private,rwcd	 	 
> > 24	dmsc	0x701C0000	0x701DFFFF	everyone,rwcd	 	 
> > 
> > So it looks like only 128K@0x701E0000 is firewalled off. 
> > Will update the patch.
> > 
> > This makes me wonder why ATF is being moved to 0x701a0000-0x701c0000
> > leaving a hole at 0x701C0000-0x701DFFFF? 
> > 
> > 
> 
> The reason for leaving the hole at 0x701C0000-0x701DFFFF was because
> initially there was a bug in SYSFW which lead to the usage of the above
> region too by it. However, this bug was recently fixed and the the above
> region can be used for ATF.


OK. I am going to drop the TF-A update patch from my queue.

NOTE:
a) Default device configuration (if no specific API call[1]) is done
   assumes last 128K is reserved.
b) if bootloader does invoke optionally a call[1] then only 16K is
   reserved for communication and remainder of 128K is released for usage
   with the constraint that TF-A/OPTEE takes control of security resources.
c) This is only a feature in AM64x devices so, handling is device
   specific.

Hence, on AM64x: (a) should be our default configuration and (b) can
be board specific configuration OR overlay depending on bootloader
capability.

[1] http://downloads.ti.com/tisci/esd/latest/6_topic_user_guides/security_handover.html#triggering-security-handover
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
