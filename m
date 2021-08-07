Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B24B3E34FF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhHGKvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhHGKtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:49:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2214EC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:48:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b128so7194048wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NH7LZiVsTX4jYfg6zE84YTrVG+vR/4RBWt0hrJzYcu8=;
        b=x3hiRGrxj1KkJpxMXDI1Ey2aFvy6P1y1DTovvoKtuvxLN44xrcXbEoPjFiQy2har3o
         PG7kJSvRU6QEEZcTih51py/s4wfNkSPoglm7yVj3qjrkKuiy2Ob7hA/uu45GR1GzY/PA
         RmVLNpmIHTm4EnnJnr/wX9NAjBgqE/lOSTmiUC9RyS66+5AT1rx3mNxCTjCod8OESsuO
         ju0VSGAVbdTOCcrp1JmQVJWgveXlS6kjW9y4AcvGy0HVMgCjtefjad67rligyc2jClgR
         pxYuJFEz/0q9q6+u35CSIUGnrfwE7/rQvD3n0fIlURir9IkPOtt1/dAcsaEKV6U2RNyr
         xcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NH7LZiVsTX4jYfg6zE84YTrVG+vR/4RBWt0hrJzYcu8=;
        b=TvdgHjmR15yJkdmTVg/9ZQZ8/hZX5rTISOM/TQ5DNT4W8wCwVpiGZxrXFehMkGPl+2
         r6u+EKazvSpBFoujqBPY/XIdWf7reoLL423MhJrfc+abmD89tn0JEEJK+myA9NJci0xH
         1PZ/FBH0cqjHNEP79CgAo4A7I1RIRLR8UBcraRbw+AMgtnv/6EJ7CRnorgA0m3p5bdEi
         pcjFW/xy+RG20L7Gmo/ljDyHKQVTLd/VgrPMkVxr4HT/LO0wSmv8p1ConDvfecky0K7A
         FDc9FRzHvL68k0B5hjtx/yItNF8bJdB5NU4lA2BD2hChXJ8L70Mf8hnwRGYwXd/z4/BB
         0Z6w==
X-Gm-Message-State: AOAM533syIeKE39on6OXbWzU87c1EWcHP23bL0X2J6mHunoa/IRDDUBj
        nEltvEkQqpIj1Jk3qUx3wmtFgKfyui3FTQ==
X-Google-Smtp-Source: ABdhPJzAJXV4KNvd7otU83voBOJTAwUvFo7CmtSdep2rWfRmXzrElnbWN+JymVM5Kr7iGylhbUQUWQ==
X-Received: by 2002:a05:600c:1986:: with SMTP id t6mr2242031wmq.49.1628333330322;
        Sat, 07 Aug 2021 03:48:50 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id i18sm8510366wmb.17.2021.08.07.03.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 03:48:49 -0700 (PDT)
Subject: Re: [PATCH 0/4] slimbus: patches (set 1) for 5.15
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
 <YQ03FPyxF8DFlwI7@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <71200533-db05-157f-480a-d64812e1d9c2@linaro.org>
Date:   Sat, 7 Aug 2021 11:48:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQ03FPyxF8DFlwI7@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/08/2021 14:20, Greg KH wrote:
> On Fri, Aug 06, 2021 at 10:16:35AM +0100, Srinivas Kandagatla wrote:
>> Hi Greg,
>>
>> Recently runtime pm testing on slimbus reveled that its
>> totally broken on SlimBus ngd drivers.
>>
>> Below are the fixes to get it back working.
>>
>> - One of the reason begin incorrect device pointer used for
>> runtime pm and in some places
>>
>> - Second one was to do with unable to validate transaction id
>>   which resulted in negative runtime pm count.
>>
>> - Other fix was to do with resetting dma addresses once ngd
>> controller is power-cycled.
>>
>> With all these fixed runtime pm is now fully functional on NGD
>> controllers.
>>
>> Currently I marked them all with Cc: <stable@vger.kernel.org>
>> as these all patches are required to fix runtime pm on SlimBus
>> NGD controller.
>>
>> Can you please queue them up for 5.15.
> 
> Why do you want these for 5.15-rc1 when you need them to fix problems in
> 5.14?  Shouldn't they go into 5.14-final?

Yes, these should go to other stable trees aswell.
I assumed that Fixes tag will automatically backport those patches.

> 
> confused,
Sorry if I confused you.

--srini

> 
> greg k-h
> 
