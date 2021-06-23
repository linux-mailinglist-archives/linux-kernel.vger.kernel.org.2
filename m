Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE73B1DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhFWPyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:54:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40080 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhFWPyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:54:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15NFpZZJ061216;
        Wed, 23 Jun 2021 10:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624463495;
        bh=MAskDN6HV5/WVFUoTzsQVtQMk0Q8MJ++DLwO5ORRNyg=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=rf3cA3xx1BP8eTTpiMBES4P1irjChGz0LMS5vk9eTelX8vWPLeMRTE+04zdgr3g8H
         lsN5te0nF9QjWneuwfZAp/NmZEneZCRi8EQQ8uqbHU0kpSW1kmS4ZsNEzL0N8jQCEt
         zOsztNCVgwPzIx7fkFkkna2fSIPfVY4rec+wWFgg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15NFpZGR041669
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jun 2021 10:51:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 23
 Jun 2021 10:51:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 23 Jun 2021 10:51:35 -0500
Received: from [10.250.33.41] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15NFpYVR078509;
        Wed, 23 Jun 2021 10:51:35 -0500
Subject: Re: [PATCH] soc: ti: pruss: fix referenced node in error message
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Kishon Vijay Abraham <kishon@ti.com>
References: <d6e24953-ea89-fd1c-6e16-7a0142118054@siemens.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <d2e95cc3-2575-7c54-186e-aa421495862e@ti.com>
Date:   Wed, 23 Jun 2021 10:51:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d6e24953-ea89-fd1c-6e16-7a0142118054@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/21 1:08 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> So far, "(null)" is reported for the node that is missing clocks.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
>  drivers/soc/ti/pruss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
> index f22ac1edbdd0..afc8aae68035 100644
> --- a/drivers/soc/ti/pruss.c
> +++ b/drivers/soc/ti/pruss.c
> @@ -129,7 +129,7 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
>  
>  	clks_np = of_get_child_by_name(cfg_node, "clocks");
>  	if (!clks_np) {
> -		dev_err(dev, "%pOF is missing its 'clocks' node\n", clks_np);
> +		dev_err(dev, "%pOF is missing its 'clocks' node\n", cfg_node);
>  		return -ENODEV;
>  	}
>  
> 

