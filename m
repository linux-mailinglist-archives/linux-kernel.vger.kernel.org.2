Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE13F7A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbhHYQS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52094 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbhHYQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17PGHb12081156;
        Wed, 25 Aug 2021 11:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629908257;
        bh=kzGGimG+y5/ntQhZxmDZwGOQPr7PcLvVeeunP3ssRiI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=hM9T/b5XUWCg6tQq0IUgXkwqkX8ZHGuJvcmKzivLarlZyEkOc3WItlBou03+0AH2S
         l3ASUXdY56/RYLW0i+FktKlapc1koDGBKqVbQO3C+OIFfayCfR7Zd2Z8fHP0UI/g++
         u6oAWECQeKKUtlvy2fh5w0aGkIuvWHZCx0/ifJ6U=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17PGHbiL085489
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Aug 2021 11:17:37 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 25
 Aug 2021 11:17:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 25 Aug 2021 11:17:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17PGHafH051470;
        Wed, 25 Aug 2021 11:17:37 -0500
Date:   Wed, 25 Aug 2021 11:17:36 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <ssantosh@kernel.org>, <lokeshvutla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] ARM: dts: keystone-k2*-evm: Fix mdio and dss node
 status
Message-ID: <20210825161736.ikx344bxfl5eqzgt@celibate>
References: <20210824105858.19496-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210824105858.19496-1-rogerq@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:58-20210824, Roger Quadros wrote:
> Hi Santosh,
> 
> This series fixes mdio and dss status nodes from "ok" to "okay"
> 
> As per Device Tree Specification [1], the status parameter of nodes can
> be "okay", "disabled", etc. "ok" is not a valid parameter.
> 
> U-boot Driver Model does not recognize status="ok" either and treats
> the node as disabled.

^^ I suspect the above comment in the patches is to indicate side effect
of non-compliance.

> 
> [1] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
> 
> cheers,
> -roger
> 
> Roger Quadros (2):
>   ARM: dts: keystone-k2*-evm: Fix mdio node status to "okay"
>   ARM: dts: keystone-k2g-evm: Fix dss node status to "okay"


Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
