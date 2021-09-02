Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6223FECD5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhIBLWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:22:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53140 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245183AbhIBLWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:22:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 182BLD8R057259;
        Thu, 2 Sep 2021 06:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1630581673;
        bh=QOjj7K5ad4EhepmrgReVpz9RMl04u23uH7kgziZE80g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sDy4fNz9AWwDDztCOC0aL6bJWpQGx7u3exNTsyOTRXm7syYya0KFfunwXWIap2Ftl
         uXfeQBLmdbn9pNErpFptVIv4Y0wquuL586Jg3CDCa6xqHrXHoSVXNpi3pqsORY0Wwp
         m3lj8hISli5NCMTd5Mz8+Mz8TYQgOnpFnuLXHVKs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 182BLDOv122771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Sep 2021 06:21:13 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Sep 2021 06:21:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Sep 2021 06:21:12 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 182BLAhc034344;
        Thu, 2 Sep 2021 06:21:11 -0500
Subject: Re: [PATCH v2 1/2] ARM: dts: keystone-k2*-evm: Fix mdio node status
 to "okay"
To:     Roger Quadros <rogerq@kernel.org>, <ssantosh@kernel.org>
CC:     <nm@ti.com>, <lokeshvutla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210824105858.19496-1-rogerq@kernel.org>
 <20210824105858.19496-2-rogerq@kernel.org>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <0f54033a-cbb3-6e00-edf7-946c4a5be3f8@ti.com>
Date:   Thu, 2 Sep 2021 14:21:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824105858.19496-2-rogerq@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/08/2021 13:58, Roger Quadros wrote:
> As per Device Tree Specification [1], the status parameter of nodes can
> be "okay", "disabled", etc. "ok" is not a valid parameter.
> 
> U-boot Driver Model does not recognize status="ok" either and treats
> the node as disabled.
> 
> [1] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
> 
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>   arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
>   arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
>   arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
