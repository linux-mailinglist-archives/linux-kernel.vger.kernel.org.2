Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B62350428
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhCaQHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:07:52 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:19790 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230385AbhCaQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:07:36 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12VG2QB4005118;
        Wed, 31 Mar 2021 18:07:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=fCjRRBFgA+ZTpV+ogrLXDlWv7XOpSNoQ+cI1j4QxNGs=;
 b=y5lcfm32LTrZM1jp6J4C6V3yuEgtqCYh7LQYfcGBdnpeR34WmOitAk9b+2bLadDH/aBE
 sx+M1MwwVcRaU4A2NyTnIIwQs/GzMpVQVGMchcgtbrr0ip9OiLHSfNppKyZKcspPg66T
 XatAum+doL7ulO+TQVU9cH2ZQHcWAo1FD2DUTEj2O8aGt2pyZiuC31wI2QWB180N+TR2
 E5fsiv6fxqVME8zfS+bfCowsBUAMNi/yKXcPy9gNAYfXfMLBHq1XSJJSl0oL6zeXWOzP
 E4znfn5nkpc8N+z2y9f+IoyhAcgNjFArmp4YkhV2tcuqVGpVqvODvmssFn9KhP8ZgQtm rA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37mab3wst3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 18:07:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3DBC110002A;
        Wed, 31 Mar 2021 18:07:24 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 28484215EFD;
        Wed, 31 Mar 2021 18:07:24 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 31 Mar
 2021 18:07:23 +0200
Subject: Re: [PATCH v3 1/7] clk: st: clkgen-pll: remove unused variable of
 struct clkgen_pll
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210330205125.25708-1-avolmat@me.com>
 <20210330205125.25708-2-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <81f857c4-8230-409b-ce73-a21326cd6ef0@foss.st.com>
Date:   Wed, 31 Mar 2021 18:07:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210330205125.25708-2-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_08:2021-03-31,2021-03-31 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 3/30/21 10:51 PM, Alain Volmat wrote:
> ODF field within the struct clkgen_pll is never used by the driver
> and can thus be removed.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v3: s/used/unused within the subject
> 
>  drivers/clk/st/clkgen-pll.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
> index 119c5b33080c..f6c56ca90c7d 100644
> --- a/drivers/clk/st/clkgen-pll.c
> +++ b/drivers/clk/st/clkgen-pll.c
> @@ -146,7 +146,6 @@ struct clkgen_pll {
>  
>  	u32 ndiv;
>  	u32 idf;
> -	u32 odf;
>  	u32 cp;
>  };
>  
> 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
