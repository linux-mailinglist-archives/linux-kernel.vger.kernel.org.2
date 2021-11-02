Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8594E442BF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 11:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhKBK7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 06:59:53 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:19591 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhKBK7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 06:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635850635; x=1667386635;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SIUPUU55vSWyOBfzNwHvs0zIbo+l0kHmiuexipAo3M0=;
  b=ZSTmL6zMRRBfTRYodbvxuBztVCKiKwy7WyfCAlvxlRqukLCkiSb93+p/
   64I+hWBufXGAl1At7Z72AV8NGhMI0Q0xW4E4K4ytth8cT18kONRaxsHGK
   BUnEpZ5EKRvQ1uewqYD5xWQAIPunEsGwPrprIitgRB3/nJLoTQoqdPFvV
   1Eia7qdBVglYj0yWmHZPt1dIBZ3Jv65SKsEEs/oE+zbiK5LnfpNMB2mjS
   eP7pnWNy2nc023zWin3ta49IWjPKm9SXWftOroSnC7RPPF+33YzQ13TwB
   4FZnJs8gDCTFpWOeCtXGYLgJBlc+O2xT8rLSF+VJwifRxB5G3B+TxKwhj
   g==;
IronPort-SDR: io8ckJG/muLi815GzgwaSMPFP3kwwhDLR4MVvM+DVp2TzWpxMVZ3tvywJRtYgDaVUnSmPdaRo1
 R6N3Z+DKTEiLVWZ/6uz0kpKu2mJdyLQfjcH0rfEkWeAckR3chJPPxollwEHrJxKvElpZN1MNiG
 K6JzP8BLtWHq3iXayw9Nmqz5x7PnrUQwTb83JNtdcUQhfUbafONC1Hqa2T4OpMpEtMk0pi/gdA
 4pbi8RbCEi7NRY8d/OeFEyZ5zVO1OUZ2nfX6bCRCl06iwHckvNwFte7KFKgA0trVAktw+T6ojV
 GsxKugVkiTSWAwhrnUKc12es
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="141915742"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2021 03:57:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 2 Nov 2021 03:57:13 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 2 Nov 2021 03:57:12 -0700
Subject: Re: [GIT PULL] clk: at91: clk changes for 5.16
To:     Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>
CC:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
References: <20211021122248.33261-1-nicolas.ferre@microchip.com>
 <163529819030.15791.7009809622910069319@swboyd.mtv.corp.google.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <23f15e48-319d-646d-5b7f-bd812be1d4b4@microchip.com>
Date:   Tue, 2 Nov 2021 11:57:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <163529819030.15791.7009809622910069319@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

On 27/10/2021 at 03:29, Stephen Boyd wrote:
> Quoting nicolas.ferre@microchip.com (2021-10-21 05:22:48)
>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>
>> Stephen,
>>
>> Here are the clk changes for 5.16. I took the initiative to create a
>> Pull-Request for it as it's surely more convenient, as I proposed in my
>> reply to Claudiu's cover letter.
> 
> Thanks. I didn't pick it up this time but I can pick it up next time. I
> wanted to take the clk.c patch via a different branch.

Perfect for me. I'll send Pull-Requests for at91 on the model of other 
silicon vendors.
Don't hesitate to tell me if you want special arrangement for some of 
the development cycles.

Best regards,
   Nicolas


-- 
Nicolas Ferre
