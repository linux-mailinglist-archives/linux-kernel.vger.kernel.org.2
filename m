Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2923E3A3EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhFKJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:13:29 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35810 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhFKJNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:13:19 -0400
Received: by mail-wm1-f51.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so8263105wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UCyqJxa2ptGmbWYqz7h96pJFnrXHEh3gpyYiFvSGHQg=;
        b=HmJ1PoVZsawe9vUpeCp9PiefT2WJK9j6LZ7/80MeHzkZam+lUkGLHI0jFlXpyHbtDx
         /3glziia+0ek5VhmFbMKXwOFYoSveyPkiJPrVBZD6aK3Y17Y3s/8qUO1ceRVt+7qv/iy
         3WHXqBS29//LGYSkuLKVuSxIJlWTV6dSIORgt6cXbnLTR7pCze2d+cb2gbleyUpLxUD3
         UhHep6y9+1EC8Rg7BG1H6CNtGjiHFTeWeujzR85YlKCgkiasqj0A2lWO1UECgNmSz9n9
         cv/KZwBm6xvS9TzpSsIIlVlVmdwEAGRd/u187Cmit1etLZjozTCDXwzbc0kG0BFAH1yW
         N+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UCyqJxa2ptGmbWYqz7h96pJFnrXHEh3gpyYiFvSGHQg=;
        b=HYGBs7vpUaV1UvGSWGijERrtca2LtAv594hGLWCUDkW8gorTz/67Il4lEbaBSC5kT2
         0NC7FcvkGpUGL9XQDaMV0oXIbcWt3s6zx5h25WqAisBd5ll6bBZ4utW2sTgavNDJWOkJ
         A3E19G4jGTPNQav1WwRsspzGN/6+TK1wPbU3imFKiDclOshRVfm5oaZnJrmJs80AWF1b
         GNnQwZV6tjY7m+jLoHsp2M8zvOaR7tFoiLyL81cS8sgsIe6cBwb/95T6aDzId15CqbrT
         3tXwc+kCbLIvbywSy2qB2t1f49adH/8ynNKygWtnFhcCHIr9Bl+bv1tiVWX3Ra/ASYcD
         gRzQ==
X-Gm-Message-State: AOAM532HUTNRIlMvY8MIM8NEvh8C/GHI44qcybtozH89k+5EQqsmuXVy
        K4bgTHSoyVDm6NgXms+rYv00Tw==
X-Google-Smtp-Source: ABdhPJws50mqqalmdm9WgCFuopdj8A61pKqF+xG+juKy8yrRXqT52ZTvDbBKbacdr8LyrvfaMM5iuw==
X-Received: by 2002:a05:600c:3514:: with SMTP id h20mr6724864wmq.70.1623402620987;
        Fri, 11 Jun 2021 02:10:20 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id g10sm6406754wrq.12.2021.06.11.02.10.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:10:20 -0700 (PDT)
Subject: Re: [PATCH 5/9] nvmem: core: add a missing of_node_put
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-6-srinivas.kandagatla@linaro.org>
 <YMMlalfdeIW4W1RC@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <16dfb294-0f3b-7375-e1f6-38c83d88cb93@linaro.org>
Date:   Fri, 11 Jun 2021 10:10:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YMMlalfdeIW4W1RC@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2021 09:57, Greg KH wrote:
> On Fri, Jun 11, 2021 at 09:33:44AM +0100, Srinivas Kandagatla wrote:
>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
>> 'for_each_child_of_node' performs an of_node_get on each iteration, so a
>> return from the middle of the loop requires an of_node_put.
>>
>> Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/nvmem/core.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Looks like this needs to go to the stable kernel trees, so when your
> resend this series, please add the proper "cc: stable" line to the
> signed-off-by area as is documented.

I agree, I missed that, will resend this one out with cc: Stable


--srini
> 
> thanks,
> 
> greg k-h
> 
