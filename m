Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04783D165B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbhGURrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:47:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44364 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbhGURq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:46:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16LIRWf7096278;
        Wed, 21 Jul 2021 13:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626892052;
        bh=d2/Es7VXpkTwglkRnW78ecn3XLUrQjjRqbbEcq5/3zg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FbKx2pJqW4mrf/ETTcSYfjjs6Q8+TRY+kBQ54Mxpim1kUk0VRN+rpwDG2/p4K3+CW
         6HpGnPauRaEBirt5iUM0+YpQV8/aVFhi/op4HWMIgie3MK9tPbhM49zavJRcd/26Rr
         3wfoDxZ8wq8gwx6VJGB+MnMPRH/gO6DjAWlEvphk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16LIRWYl110742
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jul 2021 13:27:32 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 21
 Jul 2021 13:27:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 21 Jul 2021 13:27:32 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16LIRTBt007178;
        Wed, 21 Jul 2021 13:27:30 -0500
Subject: Re: [PATCH v2 3/4] arm64: dts: ti: k3-am642-evm: Add pwm nodes
To:     Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        <kristo@kernel.org>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
References: <20210721113625.17299-1-lokeshvutla@ti.com>
 <20210721113625.17299-4-lokeshvutla@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <5f07d2a6-2b35-5222-cec4-dba083f23c9c@ti.com>
Date:   Wed, 21 Jul 2021 21:27:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721113625.17299-4-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/07/2021 14:36, Lokesh Vutla wrote:
> ecap0 can be configured to use pad ECAP0_IN_APWM_OUT (D18) which has a
> signal connected to Pin 1 of J12 on EVM. Add support for adding this
> pinmux so that pwm can be observed on pin 1 of Header J12
> 
> Also mark all un-used epwm and ecap pwm nodes as disabled.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts | 56 +++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
