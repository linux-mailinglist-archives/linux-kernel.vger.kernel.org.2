Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B2F33755B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhCKOWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:22:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36602 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbhCKOWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:22:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BELp5Q074228;
        Thu, 11 Mar 2021 08:21:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615472511;
        bh=3z1Nu74iqUPAeOp1bCv95Unhrik9umK0paiSalDT33U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=c2/qcYoPlIkiii3uoVSjI7tF8B1E+sKg7ZgTMXDJSrGGl2+jutkz5R2HsWcc56ws2
         FHpupxYUd+js+u/DvtcoYXL3cOq5iy5UavtL5V2AQvDXRH9xtFl2EXWVVJ29ieS77P
         mBpOZglM8AU2shOj69IbLLwcONp/nBUge7L1uHHk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BELp8v112975
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 08:21:51 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 08:21:51 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 08:21:51 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BELpTT100444;
        Thu, 11 Mar 2021 08:21:51 -0600
Date:   Thu, 11 Mar 2021 08:21:51 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: Add support for Siemens IOT2050
 boards
Message-ID: <20210311142151.5o54k7kmrnatufcw@target>
References: <cover.1615369068.git.jan.kiszka@siemens.com>
 <9bff40f434e5298890e5d139cc36cc46a0ca2d76.1615369068.git.jan.kiszka@siemens.com>
 <20210311131754.i5ewls6hgeitcgre@astonish>
 <8d076ff1-cdac-941f-e796-a2e6dba792ab@siemens.com>
 <20210311140056.fzvke3rrg6c2uuoa@uncouth>
 <519ae6b7-35db-1fdd-de1e-e0155e0ca82a@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <519ae6b7-35db-1fdd-de1e-e0155e0ca82a@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:14-20210311, Jan Kiszka wrote:

[...]

> > 
> > See [1] compare the compatibles against
> > Documentation/devicetree/bindings -> I think you should describe what
> > your hardware really is though.
> 
> This SPI bus is routed to an Arduino connector. By default, userspace
> (e.g. mraa) takes ownership and adds the desired logic for what is being
> connected. We have no idea what shield or other extension the user adds,
> though.

overlays look like the right approach for variable systems like these.
It is not exactly plug and play.. but it does provide a level of
flexibility that is helpful.

[..]
> The problem here is not simple txt->yml conversion: There is no official
> binding for spidev yet, just existing users and the driver waiting for them.
> 

I think we should discuss in the spidev list to get it resolved.

> > Thanks.. While it might help me personally to get some on my internal
> > farm, it might be good to get them on kernelci as well on the longer
> > run.
> > 
> 
> Will keep that on the radar. I definitely want to get it into the CIP
> LAVA lab which is testing LTS as well.

Cool.

> Are we talking about spidev here? Then let's drop that node, but I do
> need to know how to describe spidev properly

yes - the spidev is my problem. can you drop the node and repost? i cant
locally modify and hope it works.

> 
> Or is it about those other warnings coming from your dtsi files, now
> being surfaced? If you can tell me how to resolve them, I can write patches.

I will look at the warnings later today.. I dont think they are
triggered by the board dts.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
