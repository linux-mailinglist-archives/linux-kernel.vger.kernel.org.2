Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC796347F36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbhCXRVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbhCXRV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:21:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100EC061763;
        Wed, 24 Mar 2021 10:21:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kt15so24715242ejb.12;
        Wed, 24 Mar 2021 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ROVD6p8uWXCEzUfy6fJv/Vx954JFE0p8W73iVJQaYSI=;
        b=ccRE/yRezGAfcVnuNAQV8LBeXvGefdRC+zrTt4K87lxDa3E/cMLXKP38ThihsYN3+u
         1O+pWkGWKMokC+ym3AdANZrogKxGBXQLxxFqxJ5xac5R5KmNAKwUIjHZwuv9pHgCQMr7
         6eyHO6/6HQYossBzEEtfGg1KnLBMEQDUK8lO9AQeV3x1nCqPDv/X80ACGW2LX5NjcLqU
         1rys515irZv5F+38Sl/3T7s/ETabI2lD79sc78+zRMAiEZatopH2G+ouKDqcDjPJoSlX
         xbcAheWhx6kv9ZygaCwdgQ7pIkh1k92vCQjkMKn8dGPkoHuTKHHRZniEzTonhx4paYc/
         tG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ROVD6p8uWXCEzUfy6fJv/Vx954JFE0p8W73iVJQaYSI=;
        b=Aaq+Wr2RlBLU7ELuVbE07gMUczCDVZiGHNQ30urxLw8Cu22+bcApmdYkZ18+kxnmx7
         E5o/I4QdMsZZ7nIBB17QyU++dy/OV53U3GjsOLVMVFJB2+LHkjaoGr2VgooX8yOAu+IK
         lI81qMB8j+C4nrxaIMNntqFz6x4GeGkb3OFokM8iijv6Ft2bdza2CcycS9qU60BvJU+q
         0u0wMxQs6MsN/dARAUXKg6XWRaSFRijyxoEWhgB7EtLo9phszRVyjSyru1Y4rXpIt2MP
         WEYEM+YleI/vZDxOgBHXQdWDitk1F6dLh+duUAlF/uAYlZdyKYksRdtwO8WuTIx/dCML
         HnSQ==
X-Gm-Message-State: AOAM5314uareFNzG893qcwN/eZ9LGGLMvSTQ5XF4crKUCSNsAPrOb+zv
        1I8D4us467Rl8eef6eT7xguToqxIt4zU1w==
X-Google-Smtp-Source: ABdhPJxXPXyXb5CpO8/df0wLucEXxyD42Eyw+KiYYQEpFqg0f1nkj759Nev3X7z9xcQeMhl8TZohCQ==
X-Received: by 2002:a17:906:c9c2:: with SMTP id hk2mr4928118ejb.244.1616606484688;
        Wed, 24 Mar 2021 10:21:24 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w6sm1205140eje.107.2021.03.24.10.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 10:21:24 -0700 (PDT)
Subject: Re: [PATCH v5 2/8] usb: dwc3: of-simple: bail probe if no dwc3 child
 node
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        gregkh@linuxfoundation.org, balbi@kernel.org
Cc:     robh+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210209192350.7130-1-jbx6244@gmail.com>
 <20210209192350.7130-2-jbx6244@gmail.com> <1861638.PYKUYFuaPT@diego>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <919d24be-69e5-72be-8627-8ebabd1d693d@gmail.com>
Date:   Wed, 24 Mar 2021 18:21:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1861638.PYKUYFuaPT@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 5:41 PM, Heiko Stübner wrote:
> Hi Greg, Felipe,
> 
> Am Dienstag, 9. Februar 2021, 20:23:44 CET schrieb Johan Jonker:
>> For some of the dwc3-of-simple compatible SoCs we
>> don't want to bind this driver to a dwc3 node,
>> but bind that node to the 'snps,dwc3' driver instead.
>> The kernel has no logic to decide which driver to bind
>> to if there are 2 matching drivers, so bail probe if no
>> dwc3 child node.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
> It looks like this patch fell through the cracks?
> 
> I.e. I can see patches 1+6 adding the devicetree bindings
> in 5.12-rc but haven't found this patch there.
> 
> And looking at
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/log/drivers/usb/dwc3/dwc3-of-simple.c?h=usb-next
> I also didn't find it.
> 
> From what I gathered that was somehow mandated from the Devicetree side
> as the dwc3-subnode system merely is some Linux-specific thingy
> and should not be enforced if not explicitly needed.
> 

> I guess Johan can provide pointers to the previous discussion.

Comment by Rob in version 3:
Presumably you are getting lucky here (with link order). The kernel
has no logic to decide which driver to bind to if there are 2 matching
drivers. If we did, it would probably be the opposite of what you want
here as we'd pick the most specific match. This driver should probably
bail probe if no dwc3 child node.

https://lore.kernel.org/linux-rockchip/20210205114011.10381-6-jbx6244@gmail.com/

https://lore.kernel.org/linux-rockchip/CAL_JsqJwNdUfoYM8SZmOgMG9iAyZkJ4-kzjjiDDm_mdmghTEOA@mail.gmail.com/

> 
> So could you look at applying this patch to some usb-tree?
> 
> 
> Thanks
> Heiko
> 
> 
>> ---
>>  drivers/usb/dwc3/dwc3-of-simple.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
>> index e62ecd22b..347b4d384 100644
>> --- a/drivers/usb/dwc3/dwc3-of-simple.c
>> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>> @@ -38,6 +38,10 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>>  
>>  	int			ret;
>>  
>> +	/* Bail probe if no dwc3 child node. */
>> +	if (!of_get_compatible_child(dev->of_node, "snps,dwc3"))
>> +		return -ENODEV;
>> +
>>  	simple = devm_kzalloc(dev, sizeof(*simple), GFP_KERNEL);
>>  	if (!simple)
>>  		return -ENOMEM;
>>
> 
> 
> 
> 

