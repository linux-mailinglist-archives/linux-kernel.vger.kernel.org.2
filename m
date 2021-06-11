Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30E3A492A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhFKTFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:05:36 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55522 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhFKTF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:05:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15BJ3QYU051446;
        Fri, 11 Jun 2021 14:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623438206;
        bh=4z2yECl1pwOy5jeE82zgCqV0bkobTEttXJNnv5reNLc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qGPj8JFtDUrMXWTBL2GBJVXGXi8VfMZyXYuDNv3C2YkRrcDWy2al8FPqFoSPgKqQt
         O8Wy8YPAhVxixYN5dSTsmaTb8KU431oaOuGjxvcc+HhBRNi+0Sa9AVd1ALT7w8yXtX
         8lolOMSRpecze3OtTFcA69GBSicUwGuQxUw1sN+k=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15BJ3Pfm100081
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jun 2021 14:03:26 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 14:03:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 11 Jun 2021 14:03:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15BJ3Pol107518;
        Fri, 11 Jun 2021 14:03:25 -0500
Date:   Fri, 11 Jun 2021 14:03:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add SYSFW reserved ranges
 in OCRAM
Message-ID: <20210611190325.6mg4nzhreotsn3db@attribute>
References: <20210609140604.9490-1-vigneshr@ti.com>
 <81e61d1a-efde-0bff-719c-607752bfdbc1@ti.com>
 <dd2261dd-8285-5a47-526f-5b9e7056aa84@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dd2261dd-8285-5a47-526f-5b9e7056aa84@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:59-20210611, Vignesh Raghavendra wrote:
> 
> 
> On 6/9/21 8:56 PM, Lokesh Vutla wrote:
> > 
> > 
> > On 09/06/21 7:36 pm, Vignesh Raghavendra wrote:
> >> Last 256K of OCRAM (256K@0x701c0000) is reserved for SYSFW usage. Hence
> >> add an entry in DT so that its not used for generic pool memory
> >> allocation.
> >>
> >> Without this certain drivers using SRAM as generic shared memory pool
> >> may end up being allocated memory from this range and will lead to boot
> >> time crash when the reserved range is accessed (due to firewall
> >> violation).
> >>
> >> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > 
> > You might want to re-base on top of Aswath's patch updating ATF address. Otherwise:
> > 
> > Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> > 
> 
> Actually, this patch should go in before Aswath's patch as moving ATF
> location around exposed issue of drivers getting memory allocations
> overlapping SYSFW reserved ranges


I have applied Aswath's patch, please rebase. understood this is a bug,
but either way, it really was'nt a regression of stuff that was present.

please fix and send asap so that I can pick it up.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
