Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58EF42EB0B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbhJOIJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:09:42 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:27155 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhJOIJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634285252; x=1665821252;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EryfeU3vR4sAo4D4OPyIqEP94Rho2UaVSh7mOfAzMdY=;
  b=NY/xOoMuF5NRal5MXSJC/YBQZCwycuwEURqfesx0CeWTfIq3p80+Kx/C
   I+C1tbjjSu3UQ7tj9kVjsMrQVAYK1gUcYsYqWcnoRDnbU8Eqq3xvRca7p
   CxWuozIC05jD4BFHpFH3qdNwGqRQHqkyKsij6qKKI963ZZ+WlVpeu4iso
   pHI3vet6wnwKYnqeJeoVgD6jCo/pyaFPb5LmregF1pM2cvmlRf0OScFyC
   WOjYeNq8jNH2cSkVRQ3rjEP71N8Aw8EcIiqWrKoGo24D/kJIFec1rK9CL
   PmqseNW5hkJ/sqLhG4rNm+bFKJNaQSLcwUC+xZmB7aIyJcSbyGX1663RQ
   g==;
IronPort-SDR: i/0M21ko48CHwZhw0hNcJ93vXzJjdYd3drR3kMIEA50ReyMnV2GQ+fSgNc97bL4IUDsfV4Undm
 nC16KNjvsajpF9QMrknseaJoY3pTqCfEkdx9f/pFLy2y3RE/bvUkvCK5aKvQ0vv+zl1w0wWFWo
 C3ur5SFEcAGagFIKE83IqDkM76aQy1/w93B4ZYWBjBGbyGtkNDPVtkdta7xUyOYvbwzpKzYhVH
 JadJ/KJE3Snsui+X90JDqOev3o5z7p1G8HIJz/111G1HeP39Aez8w8W7FbH4z4OJ19B29WTiSR
 rPbprP1DEnCjy/xPGDYbm9V3
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="73045475"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 01:07:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 01:07:31 -0700
Received: from [10.12.67.94] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 01:07:30 -0700
Subject: Re: [PATCH v5 14/15] clk: at91: sama7g5: set low limit for mck0 at
 32KHz
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
 <20211011112719.3951784-15-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <729e6709-e25a-4bca-a182-5cc035d6d394@microchip.com>
Date:   Fri, 15 Oct 2021 10:07:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011112719.3951784-15-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 at 13:27, Claudiu Beznea wrote:
> MCK0 could go as low as 32KHz. Set this limit.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/at91/sama7g5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index fd9d17eabf54..369dfafabbca 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -850,7 +850,7 @@ static const struct {
>   
>   /* MCK0 characteristics. */
>   static const struct clk_master_characteristics mck0_characteristics = {
> -	.output = { .min = 50000000, .max = 200000000 },
> +	.output = { .min = 32768, .max = 200000000 },
>   	.divisors = { 1, 2, 4, 3, 5 },
>   	.have_div3_pres = 1,
>   };
> 


-- 
Nicolas Ferre
