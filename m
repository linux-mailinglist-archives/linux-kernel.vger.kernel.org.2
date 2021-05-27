Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C280393252
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbhE0PVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:21:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40799 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbhE0PVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:21:10 -0400
Received: from mail-ua1-f71.google.com ([209.85.222.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmHnM-00072I-6w
        for linux-kernel@vger.kernel.org; Thu, 27 May 2021 15:19:36 +0000
Received: by mail-ua1-f71.google.com with SMTP id t19-20020ab021530000b029020bc458f62fso289022ual.20
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uXb9U1EWQMliqtXlM34yyHbBKyh1FDQ1fOOYQ6KfE2o=;
        b=WcBBQmurYYvVcMmyNdyNHzS5FcAGa1t4/RI8vjv+hR1wtBAfO9+NEvCZ5q6RPwm42L
         SW5yZ3VVGlZ5UAZcyosS6G9LpPYXQda3BQjMdV976PEBat3l4HZIyd7OiKAtCKJiybHN
         XlOdOvcrX/gMDauSoZDzcq2dXP9oppceM+jI977RLSd8gPHRlHBNNATAkp7vauE19q8W
         e1Nb2gBJi8hOYgwMGk6GL69IY0F8KdiLFUKxMNSpJlTNLn9nwBzGF8q7u18tWTrmZAxD
         u9wxibg3zeb4eCDik9jJukjm3/hgKwxnf/WQ9Pp7n6MiCuVxbTu3/7cLeq4PdUoBvpWV
         CQRA==
X-Gm-Message-State: AOAM532gm/wKXX+N+rLjo9tI6Sw9kYTUtq3XDNAIR/ylKL5w396rax++
        HGTXy7PUJrn9D8u5VBhcnNQcWWg/h6vr68fP8kvk2SaghK9S9bprQYa9qxqZJ50NBJtUb8+mRHK
        rquqCQr2W8W/6u9W3Vpm/E5nbc/i5okmCQ4XnC6GiSw==
X-Received: by 2002:a05:6102:735:: with SMTP id u21mr2677322vsg.0.1622128775336;
        Thu, 27 May 2021 08:19:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVW2qNE2bt8n7nGR3evP9hORE28uejcO+zC5hdsLJ8WXvcdMrgtWTYEO1l1X0cHJVXBBzUiQ==
X-Received: by 2002:a05:6102:735:: with SMTP id u21mr2677289vsg.0.1622128775168;
        Thu, 27 May 2021 08:19:35 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id y142sm331347vsc.32.2021.05.27.08.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 08:19:34 -0700 (PDT)
Subject: Re: [RFT PATCH 2/2] memory: fsl_ifc: fix leak of private memory on
 probe failure
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Liu Shuo <b35362@freescale.com>,
        Prabhakar Kushwaha <prabhakar@freescale.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dipen Dudhat <Dipen.Dudhat@freescale.com>,
        linux-kernel@vger.kernel.org, Raghav Dogra <raghav.dogra@nxp.com>
References: <20210527144240.56365-1-krzysztof.kozlowski@canonical.com>
 <20210527144240.56365-2-krzysztof.kozlowski@canonical.com>
 <20210527150109.GO24442@kadam>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e1f9d072-872b-3301-5a3e-b40c2150f10d@canonical.com>
Date:   Thu, 27 May 2021 11:19:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527150109.GO24442@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2021 11:01, Dan Carpenter wrote:
> On Thu, May 27, 2021 at 10:42:40AM -0400, Krzysztof Kozlowski wrote:
>> On probe error the driver should free the memory allocated for private
>> structure.  Fix this by using resource-managed allocation.
>>
>> Fixes: a20cbdeffce2 ("powerpc/fsl: Add support for Integrated Flash Controller")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> ---
>>
>> Only build tested.
>> ---
>>  drivers/memory/fsl_ifc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
>> index a6324044a085..3ee7183b20fb 100644
>> --- a/drivers/memory/fsl_ifc.c
>> +++ b/drivers/memory/fsl_ifc.c
>> @@ -209,7 +209,8 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
>>  
>>  	dev_info(&dev->dev, "Freescale Integrated Flash Controller\n");
>>  
>> -	fsl_ifc_ctrl_dev = kzalloc(sizeof(*fsl_ifc_ctrl_dev), GFP_KERNEL);
>> +	fsl_ifc_ctrl_dev = devm_kzalloc(&dev->dev, sizeof(*fsl_ifc_ctrl_dev),
>> +					GFP_KERNEL);
>>  	if (!fsl_ifc_ctrl_dev)
>>  		return -ENOMEM;
> 
> You'd need to remove the kfree(ctrl) in the remove function as well or
> it will lead to a double free.

Yeah, thanks, I spotted it now also looking for more leaks.
> 
> Unrelated to your patch but related to Smatch.  The Smatch check for
> resource leaks which I mentioned check_unwind.c doesn't look for
> kmalloc() leaks because those are quite complicated to deal with.
> kmalloc() allocations are so much more common and that if you have a 5%
> false positive rate, then it's just overwhelming.  There is a separate
> Smatch check for that but it's garbage and I need to re-write it.

Indeed I was thinking about this kmalloc. It should be the last one -
the IRQs seem to be handled.



Best regards,
Krzysztof
