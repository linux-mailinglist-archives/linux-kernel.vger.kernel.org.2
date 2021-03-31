Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5534FB05
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhCaIA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:00:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:59243 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbhCaIAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617177601; x=1648713601;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QAMy0aKzrxFM3Ag+XLeRLy9l4AN42Ui0jKuCNNrgJVM=;
  b=zpZwRbp99G+T1V5bA1icUTVQk9tnX6119JeBHvz1rgxbvVSVJJOnlE9p
   S89h2lHEbXYNWOXtfcdbkmABQHUXPx1NZYjOjPIlLxonuvfXcMuPQd9Gx
   pVpIEW5HaRoLDNvpHibgUwQ3W3oq9pJAvP6uzjf6qGiAV6gBc71McdLW6
   IfR0LrLrLyoHHYfY+qKjMBmY01kAxa20LaxkMP8n9tmPW4ENGdyhPYzz0
   HxCEjnmI/xM0T3r3jfuLjcFIgd/QaqrvkGDguRzGGdoHgqugOU3NmjdFy
   P2bPhag39fijH8oKfqBBcjot3asNVZqSMIIaMcuUxtTr4H7NkONwu0Gz7
   A==;
IronPort-SDR: i9OxWw8o1ULYSqFkAQsesztI4c8ZNzhFSdD6CQfiD06asGzAD1lQk4+Ueu4Hc6/5ZamFpL9NCj
 wL6a1T5DxBlFEKMBvt0ZIrnVSis72I9fpvoOUuWBV9W7QdNOaYALw7zdX3UY6Z+GEWyClTLzGP
 PP3mTxM3qdaWTC6138hN9ODPA3RH+7VjSCgDxXwv/+1RISOPvORdNxgYCakcJOuR5CGKM2rOMY
 /wfXWXlqK+uCfRqRfoTsfA9SbJ4Tb1egFydZFCbO6QEeqVcF3ydwGsxb41P3bpCnkOpWw/Il6N
 AhY=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="109181483"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 01:00:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 00:59:59 -0700
Received: from [10.171.246.91] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 31 Mar 2021 00:59:57 -0700
Subject: Re: [PATCH] clk: at91: Trivial typo fixes in the file sama7g5.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <claudiu.beznea@microchip.com>, <eugen.hristev@microchip.com>,
        <tudor.ambarus@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rdunlap@infradead.org>
References: <20210313053222.14706-1-unixbhaskar@gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <498a30fd-405b-8599-92ca-ca37269d49d4@microchip.com>
Date:   Wed, 31 Mar 2021 09:59:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210313053222.14706-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2021 at 06:32, Bhaskar Chowdhury wrote:
> s/critial/critical/  ......two different places
> s/parrent/parent/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/at91/sama7g5.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index a6e20b35960e..9e1ec48c4474 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -166,7 +166,7 @@ static const struct {
>                    .c = &pll_characteristics,
>                    .t = PLL_TYPE_FRAC,
>                     /*
> -                   * This feeds syspll_divpmcck which may feed critial parts
> +                   * This feeds syspll_divpmcck which may feed critical parts
>                      * of the systems like timers. Therefore it should not be
>                      * disabled.
>                      */
> @@ -178,7 +178,7 @@ static const struct {
>                    .c = &pll_characteristics,
>                    .t = PLL_TYPE_DIV,
>                     /*
> -                   * This may feed critial parts of the systems like timers.
> +                   * This may feed critical parts of the systems like timers.
>                      * Therefore it should not be disabled.
>                      */
>                    .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
> @@ -455,7 +455,7 @@ static const struct {
>    * @pp:                        PLL parents
>    * @pp_mux_table:      PLL parents mux table
>    * @r:                 clock output range
> - * @pp_chg_id:         id in parrent array of changeable PLL parent
> + * @pp_chg_id:         id in parent array of changeable PLL parent
>    * @pp_count:          PLL parents count
>    * @id:                        clock id
>    */
> --
> 2.26.2
> 


-- 
Nicolas Ferre
