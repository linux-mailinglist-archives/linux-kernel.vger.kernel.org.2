Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5488C3A48A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhFKSbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:31:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47916 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFKSbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:31:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15BITCv2038947;
        Fri, 11 Jun 2021 13:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623436152;
        bh=vtJi8HBsHLPlK+HgyQZECoQroPA7sQr/5MsATuQ6VT8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tvXsxuiypwI1mKUZgFlSV2ibW0k+ur2OjjmcXfRZRp8GA8Yq9zwZu/AfXRkgPE6TN
         30eacINmO9pgNEYy1evo6z7iRBqyRxqv+LmS4DhQbzF3cU+DATYEWqWne75WThj/7C
         ulnfChs15UbJoYd8WF70vk/0Nr3MO4BgI6SM9IRY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15BITCNs085869
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jun 2021 13:29:12 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 13:29:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 11 Jun 2021 13:29:12 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15BIT9UB014916;
        Fri, 11 Jun 2021 13:29:09 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add SYSFW reserved ranges
 in OCRAM
To:     Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20210609140604.9490-1-vigneshr@ti.com>
 <81e61d1a-efde-0bff-719c-607752bfdbc1@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <dd2261dd-8285-5a47-526f-5b9e7056aa84@ti.com>
Date:   Fri, 11 Jun 2021 23:59:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <81e61d1a-efde-0bff-719c-607752bfdbc1@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/21 8:56 PM, Lokesh Vutla wrote:
> 
> 
> On 09/06/21 7:36 pm, Vignesh Raghavendra wrote:
>> Last 256K of OCRAM (256K@0x701c0000) is reserved for SYSFW usage. Hence
>> add an entry in DT so that its not used for generic pool memory
>> allocation.
>>
>> Without this certain drivers using SRAM as generic shared memory pool
>> may end up being allocated memory from this range and will lead to boot
>> time crash when the reserved range is accessed (due to firewall
>> violation).
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> 
> You might want to re-base on top of Aswath's patch updating ATF address. Otherwise:
> 
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> 

Actually, this patch should go in before Aswath's patch as moving ATF
location around exposed issue of drivers getting memory allocations
overlapping SYSFW reserved ranges

Regards
Vignesh
