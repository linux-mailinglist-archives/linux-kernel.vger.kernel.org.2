Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E536339C73
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 07:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhCMGsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 01:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhCMGsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 01:48:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B2C061574;
        Fri, 12 Mar 2021 22:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=JTzeFE/bURfHJPPR4WQb1jwntcTIXnjWNzvCJGXkvNM=; b=02qkCWOMpMzUxNlJaPViXSXaL2
        EJpRxmkuY2oQvujZy7OpHbqJYR7coHW5XrVRaCQ4gxwqm04tcezYDcaf1l4Pa1aL3W90WDEkRBVv/
        gztc+xkOL0vottsF8ON3gQmScqFDEKv1qpJRii5+BDI+Ci8bOSgSi00XqSVUU66FQVrhAqHoF3geU
        Yqa1ydhZtST/Ie9IDh1TrrL4ezGo+E1TuINnHyx0huDECYI3FIRw+rizd+au80M6j2TX91LdIWolm
        PGHQpPTAf9Vl6aVfw98dd48Vzvm1Kdfq0NMAhK/ecykMNPIVkiNBkVFdoMsCX1jzzYyIjLlN1d4r6
        AcDNKcAw==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKy49-0017iI-VC; Sat, 13 Mar 2021 06:48:03 +0000
Subject: Re: [PATCH] clk: at91: Trivial typo fixes in the file sama7g5.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mturquette@baylibre.com,
        sboyd@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        claudiu.beznea@microchip.com, eugen.hristev@microchip.com,
        tudor.ambarus@microchip.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210313053222.14706-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7b7628e9-353c-bed0-105e-d002294361db@infradead.org>
Date:   Fri, 12 Mar 2021 22:47:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210313053222.14706-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 9:32 PM, Bhaskar Chowdhury wrote:
> 
> s/critial/critical/  ......two different places
> s/parrent/parent/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/clk/at91/sama7g5.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index a6e20b35960e..9e1ec48c4474 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -166,7 +166,7 @@ static const struct {
>  		  .c = &pll_characteristics,
>  		  .t = PLL_TYPE_FRAC,
>  		   /*
> -		    * This feeds syspll_divpmcck which may feed critial parts
> +		    * This feeds syspll_divpmcck which may feed critical parts
>  		    * of the systems like timers. Therefore it should not be
>  		    * disabled.
>  		    */
> @@ -178,7 +178,7 @@ static const struct {
>  		  .c = &pll_characteristics,
>  		  .t = PLL_TYPE_DIV,
>  		   /*
> -		    * This may feed critial parts of the systems like timers.
> +		    * This may feed critical parts of the systems like timers.
>  		    * Therefore it should not be disabled.
>  		    */
>  		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
> @@ -455,7 +455,7 @@ static const struct {
>   * @pp:			PLL parents
>   * @pp_mux_table:	PLL parents mux table
>   * @r:			clock output range
> - * @pp_chg_id:		id in parrent array of changeable PLL parent
> + * @pp_chg_id:		id in parent array of changeable PLL parent
>   * @pp_count:		PLL parents count
>   * @id:			clock id
>   */
> --


-- 
~Randy

