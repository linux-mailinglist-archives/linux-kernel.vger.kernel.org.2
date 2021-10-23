Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B663C438229
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 09:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhJWHOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 03:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhJWHN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 03:13:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A00C061764;
        Sat, 23 Oct 2021 00:11:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z14so948976wrg.6;
        Sat, 23 Oct 2021 00:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cit7CANo53Mf5nvrRXQ4bn4rZuA1vpmTZTS6Z2yKuT4=;
        b=gAMg8zjE3CEbfqLZz8rq8rJlOS0Dw7A+O5dbtcHcaHtNqeSCmJ8/aNwP11aCzAdpWq
         ILQQZBgnQToKFiXK6kHQ1cHYPEwnSZOrNzuPPlfFHvGNxd8wwAxligtTVPWiVb6X7hor
         IhJlm35++YvIN4L10XfHEQITWoR14VTQ9JUoPljIx0DLRB+ZeH0dXpWIt1rQqmA2RnM3
         Om+EbBdyXDWzy9zQjT00wlm7OIonv5RdH/CKQM5qtmRKousZ6MiS7esNC5ZY0XAjltSB
         wgqgsu5op7RmZFE9op2HIDs6EF0iOWWj4ndHNUMwGzeyfObccFxobPg72WWed+0Z6dk5
         LgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cit7CANo53Mf5nvrRXQ4bn4rZuA1vpmTZTS6Z2yKuT4=;
        b=eW5IJInHQikeUWYwDhB3/NPfU5azXBRzZ4e55PlenlXDmembj6hyGyx9B2lZk4ltiV
         pw8JwuEnpEndvwE3vUWTz1ohLWHFJh4rODwfRcwBRsxC7XMBNN3NChlkYqlNM3vju+Sg
         Drd4Lek/xn5Eba2RPIFru4eUA+VovXs1nMISUg3TL2nSuLf2xfw4JkoLm/Jw1XE2Obtm
         b66ou6hYJGqzLxAb/FA6Y/L8qtOtwU9gqwyK0OhGrwtdp7RjwaNeJFOuAsJm6X4ZH/hq
         PWwH8W2X+gU5uxlYZS87L/lbf89h/rPhJwLc08odBRe7JwdMmb2bdr24jVoO3BQfLZNq
         JSKA==
X-Gm-Message-State: AOAM5324yTcjB8fJFIGHdqeFqhL0Xn2r+i2nNz1B8xRWnBnJ/4/yAMp5
        VvHS93aKNvUJwOmYRy/oMOhwwfsW3Ww=
X-Google-Smtp-Source: ABdhPJxfJgIwfEaVyjfdtet1JTHgH67fjFQF6txwHkHlVOYul+BwIdiDBykoI+FTVFa0Caph4YK2Dg==
X-Received: by 2002:adf:a30c:: with SMTP id c12mr5920826wrb.366.1634973099039;
        Sat, 23 Oct 2021 00:11:39 -0700 (PDT)
Received: from ?IPv6:2003:c7:8f4e:684:ec38:3d1d:224c:e07d? (p200300c78f4e0684ec383d1d224ce07d.dip0.t-ipconnect.de. [2003:c7:8f4e:684:ec38:3d1d:224c:e07d])
        by smtp.gmail.com with ESMTPSA id f6sm9245475wmj.28.2021.10.23.00.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 00:11:38 -0700 (PDT)
Subject: Re: [PATCH] usb: usb-skeleton: Add hint to find __init and __exit
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
References: <20211023052538.GA5141@matrix-ESPRIMO-P710>
 <YXOwA6N2ffVIcA7L@kroah.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
Message-ID: <7ae5d5c1-4121-65b1-8a91-95513b945823@gmail.com>
Date:   Sat, 23 Oct 2021 09:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXOwA6N2ffVIcA7L@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/21 8:47 AM, Greg KH wrote:
> On Sat, Oct 23, 2021 at 07:25:38AM +0200, Philipp Hortmann wrote:
>> Comment to find __init and __exit.
>>
>> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
>> ---
>>   drivers/usb/usb-skeleton.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
>> index 2dc58766273a..80338a50dcde 100644
>> --- a/drivers/usb/usb-skeleton.c
>> +++ b/drivers/usb/usb-skeleton.c
>> @@ -641,6 +641,7 @@ static struct usb_driver skel_driver = {
>>   	.supports_autosuspend = 1,
>>   };
>>   
>> +/* __init and __exit */
>>   module_usb_driver(skel_driver);
> 
> This comment makes no sense, sorry.  __init and __exit are things that
> the linker uses, why would you need to "find" them?
> 
> thanks,
> 
> greg k-h
> 

When I want to add something to the __init function (debug comment for 
example), how to do this without knowing that it is in module_usb_driver?

thanks,

Philipp
