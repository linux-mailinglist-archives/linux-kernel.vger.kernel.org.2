Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E85D3F3243
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhHTRbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:31:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36942 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhHTRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:31:18 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KHUWoi127375;
        Fri, 20 Aug 2021 12:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629480632;
        bh=YPwF63ngXSLPfLLk8NLwcYappfRm2sFV8JXh5KGaGIg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=FM1pEWtCZ/UR1rs7YvaXSVdX7xltiJl1kDbRK74XuheUIli/VDb2yxKwdKgmRXFXv
         2WVxM6mLmabW51evOgnihXXUZ4u76/RnpOAsNi3K6MiHtGQM4HmCEOOgCXuJRZgrbD
         M/+hRiyM951n7PlR6/ELHF1jCO34b8okg+zKe9T0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KHUWWm098755
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 12:30:32 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 12:30:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 12:30:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KHUW51086945;
        Fri, 20 Aug 2021 12:30:32 -0500
Date:   Fri, 20 Aug 2021 12:30:32 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] ARM: dts: keystone-k2*-evm: Fix mdio and dss node
 status
Message-ID: <20210820173032.45st33x5435tmfyx@fragrance>
References: <20210820095341.5619-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210820095341.5619-1-rogerq@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:53-20210820, Roger Quadros wrote:
> Hi Santosh,
> 
> This series fixes mdio and dss status nodes from "ok" to "okay"
> 
> As per Device Tree core schema [1], status parameter of nodes can be either
> "okay" or "disabled".
> 
> U-boot Driver Model does not recognize status="ok" either and treats
> the node as disabled.
> 
> [1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/dt-core.yaml#L36


Wondering if it is better to refer to the device tree specification
itself rather than the schema implementation of the specification..


https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
for example.

> 
> cheers,
> -roger
> 
> Roger Quadros (2):
>   ARM: dts: keystone-k2*-evm: Fix mdio node status to "okay"
>   ARM: dts: keystone-k2g-evm: Fix dss node status to "okay"
> 
>  arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
>  arch/arm/boot/dts/keystone-k2g-evm.dts  | 2 +-
>  arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
>  arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
