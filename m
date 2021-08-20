Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574203F3277
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhHTRuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:50:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41084 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhHTRuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:50:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KHnIMj003405;
        Fri, 20 Aug 2021 12:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629481758;
        bh=8g5gWRCq88/BlPvTxGIh0QRE5pCHUL6wXTt7OaVUmGY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=nYhayd58YsoiTk3IlGeM38CwZYtaG4h3XX+f9F664KZJQF79DXNIRCX4VvNQ8+CMg
         Ngd8rCnjHsAVRzipNeMFMbp9qPWZZgz5PYCiFOCrLDpMFoaFADxIudwPWWBJ+z2pLy
         kFKoBDYq+JdNMApOwz6DtHYSygkMOg0vmAG9D5rI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KHnIQV058919
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 12:49:18 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 12:49:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 12:49:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KHnHR8122874;
        Fri, 20 Aug 2021 12:49:17 -0500
Date:   Fri, 20 Aug 2021 12:49:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     jing yangyang <cgel.zte@gmail.com>
CC:     Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] clk/keystone: fix application of sizeof to
 pointer
Message-ID: <20210820174917.4emwkb75i2yydm7c@expel>
References: <84a6ba16686347099a3dab2e5161a930e792eb6e.1629198281.git.jing.yangyang@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <84a6ba16686347099a3dab2e5161a930e792eb6e.1629198281.git.jing.yangyang@zte.com.cn>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:20-20210819, jing yangyang wrote:
> sizeof when applied to a pointer typed expression gives the size of
> the pointer.
> 
> ./drivers/clk/keystone/sci-clk.c:398:8-14: ERROR application of sizeof to pointer
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> ---
>  drivers/clk/keystone/sci-clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> index 7e1b136..010a61a 100644
> --- a/drivers/clk/keystone/sci-clk.c
> +++ b/drivers/clk/keystone/sci-clk.c
> @@ -395,7 +395,7 @@ static struct clk_hw *sci_clk_get(struct of_phandle_args *clkspec, void *data)
>  	key.clk_id = clkspec->args[1];
>  
>  	clk = bsearch(&key, provider->clocks, provider->num_clocks,
> -		      sizeof(clk), _cmp_sci_clk);
> +		      sizeof(*clk), _cmp_sci_clk);

I am trying to understand this.. bsearch uses base + size to do
iteration, provider is sci_clk_provider ->num_clocks is struct sci_clk
** same as clk. iteration is done on provider->clocks .. not on *clk,
am I missing something? or is it one of those testing patches?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
