Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2941338FDD9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhEYJbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:31:02 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:60417 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhEYJas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1621934959; x=1653470959;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PNtSVoFGvQfnAIpiiUi+iXcvVNJqpwQgjDgGgtw17jA=;
  b=nxfTFbSpGpasvZ5edpqn25hZemTEVjIeKP0se91AcyLxpXNxdyoNqCSh
   YMoTuK8aMemnUq5zdo4jvwERus7rtGYOKY1LjIAiC7OpzrzDKMZP4hT+e
   Zv/YEoT2fdDz+gCmaT8xUdd0T45d2jDIwNIDo825xgmsaFij9KeyjQPV2
   OGMODWjVeHnQWXyPy8YzGqFljxqaJpX8hsYvEhrjAuYihEnePjg7QN7mK
   xgPP//OOOw1qiV6bxTI0pkVw/ipdJaaSeGAsuJsFhBcHv7IOmqYYXKE1K
   aPKrKr6378D8Gp1V3uF1cM2ArXvpu7k93e/y8QDxzcBbe1fmVaNN9PWkr
   g==;
IronPort-SDR: oVFErXGWnMpgDMPxjuargxQbDAEdCErqM7QMOzVj2hFdWabAee0XBW4ltcKoUhBJC3cGmXnhRI
 6pDuIxd6W+3v2kfcjmkJ7Eta8ka63okHwmDsu4zK0sgaZS8UXka8tQzSHM8aBEmhE1C2A8JNmb
 WxGRLO0T+7n2/m4NPHdcC4E6ESVcKwphaoOATPDaD5oKZXJ6Dh/i5uzkcBxxmyoamfDziNF7xx
 sTXEd0u81tEMT7L/VjHcLLnez6S8rRciHZULmgbASWFrIXmOiW5U7LRwB7qGzMTKBja9f2rD+z
 XB4=
X-IronPort-AV: E=Sophos;i="5.82,328,1613458800"; 
   d="scan'208";a="129362978"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2021 02:29:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 02:29:18 -0700
Received: from [10.12.74.7] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 25 May 2021 02:29:16 -0700
Subject: Re: [PATCH] drm/atmel-hlcdc: Allow async page flips
To:     Sam Ravnborg <sam@ravnborg.org>,
        Dan Sneddon - C50748 <Dan.Sneddon@microchip.com>
CC:     Ludovic Desroches - M43218 <Ludovic.Desroches@microchip.com>,
        "Boris Brezillon" <bbrezillon@kernel.org>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210330151721.6616-1-dan.sneddon@microchip.com>
 <20210409105816.cfffdr3edzi4yntm@sekiro>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <088b0446-85c2-2d87-0439-a0cc14772c6a@microchip.com>
Date:   Tue, 25 May 2021 11:29:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210409105816.cfffdr3edzi4yntm@sekiro>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2021 at 12:58, Ludovic Desroches - M43218 wrote:
> On Tue, Mar 30, 2021 at 08:17:20AM -0700, Dan Sneddon wrote:
>> The driver is capable of doing async page flips so we need to tell the
>> core to allow them.
>>
>> Signed-off-by: Dan Sneddon <dan.sneddon@microchip.com>
> Tested-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Sam,

Do you need more from us or can you queue this patch (aka "ping")?

Best regards,
   Nicolas

>> ---
>>
>>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> index 871293d1aeeb..f6c3d8809fd8 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> @@ -686,6 +686,7 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
>>   	dev->mode_config.max_width = dc->desc->max_width;
>>   	dev->mode_config.max_height = dc->desc->max_height;
>>   	dev->mode_config.funcs = &mode_config_funcs;
>> +	dev->mode_config.async_page_flip = true;
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.17.1
>>


-- 
Nicolas Ferre
