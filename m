Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513C4391AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhEZPBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbhEZPBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:01:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE0C06175F;
        Wed, 26 May 2021 07:59:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e17so2430073lfb.2;
        Wed, 26 May 2021 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZY7DhgR7U8XkxVmzEn49jSM7lk9MFuhyv4pYW51zRhA=;
        b=aDK/E9dacgoOIeG1hvE5q1kzKOilz3uUHWG1utNNC59UNB2DScz7Jl1wfbFrAjlOpP
         5/or25q+F47pu+epN3TFvCn6hYqOW1WAZd9vnA1rARQRXe0ZiGIrJd0K2zv0SBdjLfla
         vn4kZkZ0VhZZhBjwsFwbnO9UvjH8A0QXVt3qEwAjY/MXuGVjG77YO/LjS6myeXp1vHll
         Rw1+Iy/umXi9uJo6MgRebxKP+bSN2Ni6n5XCMLlZFAwhEIwiNpr6l3xRhJMEJOiWajm6
         zi/Grv1BwpHY37rc2pL5Hy2hEP8tldpObFFLM6rs1nC58R1SgAE0drtT5X9tYj3RbISC
         qlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZY7DhgR7U8XkxVmzEn49jSM7lk9MFuhyv4pYW51zRhA=;
        b=EY7pp71oinudjVogwJLndiSordZ6rFWAx9zxOTy2qoIE1H1KTPffS41oCnQsJDRTM5
         +kr9SHuxcLhbLU4iVWm/ju32CbeZTr67sJ4y78X86JfqUGSSqRfxh2PM8W4zyDw3xsvA
         rej1nZHn7gtit/KCy9qSroDsViWH/UxMBjiIQy8A7XCtF5K5vnhAt9S0L7+8mrpcCoNr
         P8WBP+bQu+FibocLPnIpAciNj80iZsoqPS4nCLPrJBfRZvJQipwYYWlgpleCvV1RUYXd
         X9Nv2KzCQLX6VmHzmt9W3UJnlYMkHSfgv0pgBeNMHur6Re9ivSLMFxAJecUqRzr55Ksg
         LV3w==
X-Gm-Message-State: AOAM533826n/NDzTsvEaclea4zRTrDAb4MphMyoAyVmJ+dFMC9NpL4+R
        LVZwtEtUmu9tTjA8qjEulCBsry1iknM=
X-Google-Smtp-Source: ABdhPJyAbq4DU0NxKcpVU0EnUa9g+n2S873i3+6ey+jt2Wo/SXyGU4f9OPP/6k2M3VhVLlYRw+w5uw==
X-Received: by 2002:a05:6512:1392:: with SMTP id p18mr723015lfa.294.1622041175071;
        Wed, 26 May 2021 07:59:35 -0700 (PDT)
Received: from [192.168.1.102] ([178.176.73.49])
        by smtp.gmail.com with ESMTPSA id p6sm2057655lfr.163.2021.05.26.07.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 07:59:34 -0700 (PDT)
Subject: Re: [PATCH 21/24] usb: host: xhci: Move array of structs from the
 stack onto the heap
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-22-lee.jones@linaro.org>
 <8551978f-27b0-767e-f92b-e96ab3064b33@gmail.com>
 <20210526144451.GB543307@dell>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <ad5d3a04-c065-675e-c53f-5d48b6367c89@gmail.com>
Date:   Wed, 26 May 2021 17:59:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210526144451.GB543307@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 5:44 PM, Lee Jones wrote:

[...]
>>> Fixes the following W=1 kernel build warning(s):
>>>
>>>  drivers/usb/host/xhci.c: In function ‘xhci_reserve_bandwidth’:
>>>  drivers/usb/host/xhci.c:2859:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>>
>>> Cc: Mathias Nyman <mathias.nyman@intel.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: linux-usb@vger.kernel.org
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>  drivers/usb/host/xhci.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>>> index ac2a7d4288883..40ce4b4eb12ad 100644
>>> --- a/drivers/usb/host/xhci.c
>>> +++ b/drivers/usb/host/xhci.c
>> [...]
>>> @@ -2788,6 +2788,10 @@ static int xhci_reserve_bandwidth(struct xhci_hcd *xhci,
>>>  		return -ENOMEM;
>>>  	}
>>>  
>>> +	ep_bw_info = kzalloc(sizeof(*ep_bw_info) * 31, GFP_KERNEL);
>>
>>    Why not kcalloc()?
> 
> No particular reason.  Muscle memory I guess.
> 
> Happy either way.

    kcalloc( is designed for allocatiung arrays and clearing them, like calloc(),
so let's stick wuth it...

MBR, Sergei
