Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EAF368258
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 16:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbhDVOUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 10:20:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58106 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbhDVOUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:20:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13MEKClj074412;
        Thu, 22 Apr 2021 09:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619101212;
        bh=eLCNEeT9z0g1L4VWRS3pYMec87wOC2TuVWX5CHcWjjc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JX2Qi2RVy+cgLm4xZG0ELG0EljMsR2mUXfYv3oa+z9aF47wFE+SjUecuwFEDCfDjs
         dNO0AKFSR98+cG6xBzfyj7/P9Hqx9TLyBW/4dyc+pC+xazht9tuLnGETnlgs0+f3hC
         Uq6Yj9jzR0cLlz5qf1PW6nAiSFl7DCv5dX9Z7Tek=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13MEKCYg067110
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Apr 2021 09:20:12 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 22
 Apr 2021 09:20:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 22 Apr 2021 09:20:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13MEKCNu104239;
        Thu, 22 Apr 2021 09:20:12 -0500
Date:   Thu, 22 Apr 2021 09:20:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: arm: firmware: Convert linaro,optee-tz to
 json schema
Message-ID: <20210422142012.lcjiy2gaoqllzlna@nervy>
References: <20210416222518.15801-1-nm@ti.com>
 <20210421225212.GB1750844@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210421225212.GB1750844@robh.at.kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:52-20210421, Rob Herring wrote:
> On Fri, Apr 16, 2021 at 05:25:18PM -0500, Nishanth Menon wrote:
> > Convert linaro,optee-tz to json schema format for better documentation
> > and error checks.
> > 
> > NOTE:
> > 1. This change does introduce a stricter naming convention for
> >    optee nodes.
> > 2. We do have false positive checkpatch warning with this patch:
> >    "DT binding docs and includes should be a separate patch"
> 
> Not really something that needs to be in the commit msg. I'm aware of 
> the issue, just haven't gotten around to fixing it.

sure, thanks..
In this patch and my previous patches as well, I will move them all
to diffstat comment.

> > +properties:
> > +  $nodename:
> > +    const: 'optee'
> 
> Don't need quotes.

aarrgh.. yes, ofcourse.
> 
> > +
> > +  compatible:
> > +    const: linaro,optee-tz
> > +
> > +  method:
> > +    description: The method of calling the OP-TEE Trusted OS.
> > +    oneOf:
> > +      - description: |
> > +          SMC #0, with the register assignments specified
> > +          in drivers/tee/optee/optee_smc.h
> > +        items:
> > +          - const: smc
> > +      - description: |
> > +          HVC #0, with the register assignments specified
> > +          in drivers/tee/optee/optee_smc.h
> > +        items:
> > +          - const: hvc
> 
> Please just do 'enum: [ smc, hvc ]' and rework to a single description.

Sure, will do. thanks for the comments.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
