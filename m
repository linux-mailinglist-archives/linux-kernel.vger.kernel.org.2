Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF0333F8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhCQTPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:15:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43378 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhCQTPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:15:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12HJFCZt064171;
        Wed, 17 Mar 2021 14:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616008512;
        bh=c68VnP2lKVw7BrF/hN26uvDmRQ7vdB5gkv6zCnPUm2U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uPrB7knlVEo8ZcZO1yen0rXN7FEj+SQRX/Fsmobfmd1iTKHIvG+5yb2D31L7JV+Td
         +IzNjvMFJkMjlOrtqgAYw7MW9x+I40tZd4S3n4detpO4voS/eARC3bPUeTDPDLH+He
         zj/JfKx8LsEtt+uq4pxxIHfZEfk9q1tOAR7+cnks=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12HJFC03086181
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Mar 2021 14:15:12 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 17
 Mar 2021 14:15:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 17 Mar 2021 14:15:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12HJFCBA039352;
        Wed, 17 Mar 2021 14:15:12 -0500
Date:   Wed, 17 Mar 2021 14:15:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 0/3] AM64: Add SERDES DT bindings
Message-ID: <20210317191512.pb3xzirik67msyvj@bonus>
References: <20210310112745.3445-1-kishon@ti.com>
 <YFGjPNonIlA4Anar@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YFGjPNonIlA4Anar@vkoul-mobl.Dlink>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:05-20210317, Vinod Koul wrote:
> On 10-03-21, 16:57, Kishon Vijay Abraham I wrote:
> > Patch series adds device tree bindings to support SERDES in AM64
> > platform.
> > 
> > This is split from [1] since this binding is also required for AM64
> > USB DT patches to be merged.
> > 
> > Vinod,
> > 
> > Once the 1st patch of the series is reviewed by Rob, can you merge and
> > prepare a immutable tag to be used by Nishant Menon so that he can merge
> > USB3 DT patches.
> 
> Applied and tag:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/ti-serdes-for-5.13
> 

Thanks Vinod. Much appreciated.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
