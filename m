Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EC33D165D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbhGURrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:47:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44430 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbhGURrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:47:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16LIRkUt096410;
        Wed, 21 Jul 2021 13:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626892066;
        bh=Fq44ampXezOfB+WSg1+5wNGr/hl97u6lN02CPAF6JgQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=owcXVKOrmC69171rZ4WmDrDCO1StlfH8KPoUNdjRp7yER4sNMXipFuto5uV9cvPYe
         MzEPoz5wQXoXBL++q+QIBVj/s/YESvR0kqiblS3b76KPt02GYtsrvcXfTxjNmJBn9Y
         Lil1qgluS7rAxoSdky9iywhr7Q7qLI21gZ/+Lrzk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16LIRkP6004562
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jul 2021 13:27:46 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 21
 Jul 2021 13:27:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 21 Jul 2021 13:27:46 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16LIRisT087387;
        Wed, 21 Jul 2021 13:27:44 -0500
Subject: Re: [PATCH v2 4/4] arm64: dts: ti: k3-am642-sk: Add pwm nodes
To:     Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        <kristo@kernel.org>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
References: <20210721113625.17299-1-lokeshvutla@ti.com>
 <20210721113625.17299-5-lokeshvutla@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <a8837849-5e00-978e-bd53-5bfd420936c1@ti.com>
Date:   Wed, 21 Jul 2021 21:27:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721113625.17299-5-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/07/2021 14:36, Lokesh Vutla wrote:
> ecap0 can be configured to use pad ECAP0_IN_APWM_OUT (D18) which has a
> signal connected to Pin 1 of J3. Add support for adding this pinmux so
> that pwm can be observed on pin 1 of Header J3
> 
> Also mark all un-used epwm and ecap pwm nodes as disabled.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts | 64 ++++++++++++++++++++++++++
>   1 file changed, 64 insertions(+)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
