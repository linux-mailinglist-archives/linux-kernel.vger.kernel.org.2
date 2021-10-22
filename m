Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3015437BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhJVRVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhJVRVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:21:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E32C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:18:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t11so3180488plq.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IbuYUzyzR2NfoAmhq9teREBRNFXaM5sLqZfNr1gDcCw=;
        b=TrcFljLQlJUA71rdwkk+ukFi5+yijWlbu5qUDqlIdRpyn+eCuE1Vn5xUwiyo3YdBTx
         z8eCaEbLvlvv6qY+bcbiypwaBkhPPfcI+sfCgfpzw1pim9mnJNuf22pbTx1ejD6js961
         w5rxEUyN3ZaLBOir+0hEdmGj2KLQ/QW8DMkjYFXsPJMzylU4fcZLd76MaOYaRyLEPpWg
         6AJwG0rt6nOKR+9D9Iw3l8S2yPel0/BIsCg2LC3lHs8fQKq6CvwHCAB7qFhuioHc2V+9
         u+zy3FBu0DwgM6O6iX9olTW+UEk9RqK4CxDuL7Oy7NwEBDYJyVjwEX7BDN6mYyOcfRJw
         ibag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IbuYUzyzR2NfoAmhq9teREBRNFXaM5sLqZfNr1gDcCw=;
        b=Dy7Sl+kHZj5CYWonj44eZvFKY7l8tw7NActvNO9uYYhzHvX+q9mE181XKa3H6n+r4h
         K6RX5h5joBtF1MnlAtvN2vHmCr5c+hPzbrudZICWnO/5b0f04GeBOoXfTV47G/F00KrD
         BL+ceI/2f896MhMAmLkNTU/wDqOfswCR+hePiGhoW/lPpokDFTv8LfugvQSG/sgUTY2n
         aNsm6I3bLGn/nB3XQ6bgpNGMf8I5qB4CmY6fs8DNRrCzrfofmiYADNdIJrRl9j6fTLJF
         +pQmz2STmHtAPGQgN+uF0A79btXxPfaMup0y+C8PJvXU0e0Wl5k1fexa8QsVnZVER6Pv
         aaPg==
X-Gm-Message-State: AOAM533bg6Lojm+jpj62CYyLMJCOWPcmizgCBXhZKRQ1cEzVD0j3yN34
        /yVYGQhUGoPicHvGESfg01LiILt8Mug=
X-Google-Smtp-Source: ABdhPJw5xdH8peKLPo6OE8Ox5LwLBxRYV8iAsWiT2BqOcAoP9wINrxn/voQXypOvcvOmKVZcSjqntw==
X-Received: by 2002:a17:90b:1c81:: with SMTP id oo1mr1272557pjb.97.1634923137614;
        Fri, 22 Oct 2021 10:18:57 -0700 (PDT)
Received: from ?IPV6:2001:4490:4409:eb7d:758a:6a46:39c:b254? ([2001:4490:4409:eb7d:758a:6a46:39c:b254])
        by smtp.gmail.com with ESMTPSA id t28sm10301594pfq.158.2021.10.22.10.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 10:18:57 -0700 (PDT)
Message-ID: <4354b890-28df-6f0e-d206-9b31307e48dd@gmail.com>
Date:   Fri, 22 Oct 2021 22:48:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v3] staging: rtl8723bs: os_dep: simplify the return
 statement
Content-Language: en-GB
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YWhBQF4yUH0/r53A@Sauravs-MacBook-Air.local>
 <13289545.LovHZTAFgE@localhost.localdomain>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <13289545.LovHZTAFgE@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/10/21 2:45 pm, Fabio M. De Francesco wrote:
> On Thursday, October 14, 2021 4:40:00 PM CEST Saurav Girepunje wrote:
>> Remove goto statement where function simply return value without doing
>> any cleanup action.
>>
>> Simplify the return using goto label to avoid unneeded 'if' condition
>> check.
>>
>> Remove the unneeded and redundant check of variable on goto.
>>
>> Remove the assignment of NULL on local variable.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>
>> ChangeLog V3:
>>
>> 	-Remove goto statement where function simply return value
>> 	 without doing any cleanup action.
>> 	-Remove the assignment of NULL on local variable.
>> 	-Replace the goto statement added after the memcpy on V2.
>> 	 with return 0 statement.
>>
>> ChangeLog V2:
>>
>> 	-Add goto out after the memcpy for no error case return with
>> 	 ret only. On V1 doing free, which was not required for no error
>> 	 case.
> 
> You still don't explain why you changed v1. You had freed resources on 
> success path. 
"On V1 doing free" I will add more information on changelog.
That was not allowed because you introduced a change in the 
> logic and a huge bug. Therefore, in v2, you are not merely changing something 
> that "was not required". Instead you are changing something that is not 
> permitted.
> 
> Thanks,
> 
> Fabio
> 
> 
> 
Thanks Fabio for review.

Regards,
Saurav
