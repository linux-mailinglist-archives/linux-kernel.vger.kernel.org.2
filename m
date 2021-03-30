Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8390E34EF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhC3R2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:28:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23311 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhC3R2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617125282; x=1648661282;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=lTJn86OD1hQJIzSFLyNL9szvAzap292csL/L55RBcgo=;
  b=hTlK6wNNdcvY0z6P+Fc8+pyhMf4GnvQCDLk4sSE4hwZhN0vVVZDmI/E7
   Z3Wp9wR7WlqVmed6ojuPcLe2X04vngoUTJcVW3188EauQCWSktL10cLN3
   IcvGJSWE/GwvxF8yZNzXckKJY6bJewq1RAtWmbAtJtJaIGkNVYuzDSrwK
   xQGGgucUn7w7nnuqyGOVyq6s2j9vIXCp+rIrBsRDjwm1KX0L7vPMJ1szV
   P3A/4t0Y0xmS9jW53AGBMU8woH88Y8NyaCeBzv9EQrRn5f2sYmOs+Q0Ha
   DUc2Dd02iuRFtxQvwqGmnNM0YSDcepfy5IkC9nalFQurjDUWCM+VboQVb
   w==;
IronPort-SDR: SxIjD3E65azuDW8W1+wuDHt2+bDUPl0IFSPZehGFNDOfZ4iVicCDBv66UtwtixGJSZH2JR8OMV
 r4Qc4afy/o1A0BvtQQUna8n74nNEI02GT8ebfLKctMf5tFVFgCjGlwqLHnNNlaAIGB6AN3D/zN
 7DBp2y7ewwm4o5IVs2h5GpKEga4fpuYg8A+KkqGvlyhvwJGzONa4F98ciATDNq8sNjr+zHmsUn
 UikxRfbdc2IzzmdsafQ4wEBaAQd+ilnvLVBAmNcyw5pqJiLn/Ws02MXJPGGTCot5OFSsjGdGc4
 Vsg=
X-IronPort-AV: E=Sophos;i="5.81,291,1610434800"; 
   d="scan'208";a="111907435"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2021 10:28:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 10:28:01 -0700
Received: from [10.171.246.97] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 30 Mar 2021 10:27:59 -0700
Subject: Re: [RESEND PATCH 3/5] clk: at91: sama7g5: add securam's peripheral
 clock
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210324094353.1710114-1-claudiu.beznea@microchip.com>
 <20210324094353.1710114-4-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <20739a40-57f4-f100-d86a-c802c638ff78@microchip.com>
Date:   Tue, 30 Mar 2021 19:27:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324094353.1710114-4-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 at 10:43, Claudiu Beznea wrote:
> Add SECURAM's peripheral clock.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/at91/sama7g5.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index a6e20b35960e..28e26fb90417 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -377,6 +377,7 @@ static const struct {
>   	u8 id;
>   } sama7g5_periphck[] = {
>   	{ .n = "pioA_clk",	.p = "mck0", .id = 11, },
> +	{ .n = "securam_clk",	.p = "mck0", .id = 18, },
>   	{ .n = "sfr_clk",	.p = "mck1", .id = 19, },
>   	{ .n = "hsmc_clk",	.p = "mck1", .id = 21, },
>   	{ .n = "xdmac0_clk",	.p = "mck1", .id = 22, },
> 

Thanks,
   Nicolas

-- 
Nicolas Ferre
