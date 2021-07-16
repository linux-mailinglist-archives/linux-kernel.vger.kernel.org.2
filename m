Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7BE3CBC41
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhGPTUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:20:07 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:21940 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGPTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626463030; x=1657999030;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=F3qFxoWuttwrIoU5MmfRCmTy007uSOQOuWxMKEt4HP0=;
  b=Rt0erlNJUnUVD9rrU8i/jHEcs1mQmh9TAUPxAzVaGbngQa0P3nUj08d2
   lTRRKWqGd+WBRP5j3vmURR2n97Qqtv105R6T3dlavxWYh6eHj5UNckMvB
   rpy4MBNPiFjjlKpNlr7rEsrWUDA/6s62UDKOKzxPCbOzrLn/rTkRSE+ia
   3mbqj4WlJC2XC9/KtQcWya4YZ0rTODr0aejOXtFAoDcQvidccZfEYO0cG
   tqsmVEVy9q1aPMdYDRG08DN6Fm/fC8istIWNTnwHQipOZ7/0rxvTRJGGD
   Ms2EpHttzD1DU7zTZvyrv0v5mtCNXYZ9mCY5dYNlOtZoiGE7Qiw8qqNFm
   w==;
IronPort-SDR: Y+Tu3euWzPOM0Dp3/IZ/fHkfQpfauDc2+EcaTM5GKlgAdMj4Bs4uzJXVmHF45XT/zJTtvo1hjQ
 d3T/MQoyNDwK/Ifvy6oHb//EdCXNytD2U1xhuwfGU1Z/YFB0wi24EMluxyTy/jXA8O4w5mr37h
 0HpC3i3ZnlYHb1C7qcjlitpabNkrc1rdscdzeT7QAwqu2lAVFSD5/WmkoeS29HEId8kFd6V5+F
 gU0MlTLQsZ2RKSCI4I/fUTyhTXRErF3v2/4l57CPVl/EKMWL+CSeyV5t3JIWWVRPLGIq3xrriA
 fRMCoCvd2F2ZkCpUjLnUTQp9
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="136229222"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2021 12:17:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 12:17:09 -0700
Received: from [10.12.72.255] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 16 Jul 2021 12:17:07 -0700
Subject: Re: [PATCH] clk: at91: clk-generated: Limit the requested rate to our
 range
To:     Codrin Ciubotariu - M19940 <Codrin.Ciubotariu@microchip.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Ludovic Desroches - M43218 <Ludovic.Desroches@microchip.com>,
        Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>
References: <20210707131213.3283509-1-codrin.ciubotariu@microchip.com>
 <7586cf33-078a-cb85-98c8-9969baa0f19d@microchip.com>
 <25631072-d9a3-0d84-fd47-4d2414f079f6@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <4393ec64-3891-a875-b948-516efd08817c@microchip.com>
Date:   Fri, 16 Jul 2021 21:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <25631072-d9a3-0d84-fd47-4d2414f079f6@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2021 at 11:59, Codrin Ciubotariu - M19940 wrote:
> On 09.07.2021 12:21, Nicolas Ferre wrote:
>> On 07/07/2021 at 15:12, Codrin Ciubotariu wrote:
>>> On clk_generated_determine_rate(), the requested rate could be outside
>>> of clk's range. Limit the rate to the clock's range to not return an
>>> error.
>>
>> Isn't it saner for the user to return an error code instead of
>> automatically restrain the dynamics requested without notice?
>>
>> Can you elaborate the use case where returning an error is not convenient?
> 
> The way I see it, if the user requests a rate that is out of clock's
> range, the driver's determine_rate() should return min/max, not an
> error. That is actually the closest rate supported by the clock, which
> is what determine_rate() should accomplish. The user has no clk API to
> get clock's range, so there is no way to call clk_round_rate() only for
> values within our range.
> 
> The use cause is with sam9x60's I2S driver, which has to try different
> rates to get the closest one to what it needs. There is no 'perfect'
> rate, because there is no AUDIO PLL and we have to try different values
> for our internal dividers to find the closest one.
> 
> https://elixir.bootlin.com/linux/latest/source/sound/soc/atmel/mchp-i2s-mcc.c#L416

Sure, makes sense:

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Regards,
   Nicolas

-- 
Nicolas Ferre
