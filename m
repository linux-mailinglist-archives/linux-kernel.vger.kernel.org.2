Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675224467AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhKERVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhKERVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:21:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC668C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:18:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so3846127pje.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wzufjbDqGxDa2/k86ie4tw8Pdx0MnDOAPtjEE+yOjpY=;
        b=dQ9hk9G7njRsxD1PZLshA+qzst9HtFIjOrwfqVOpZkhjgpbH3ZJ15Wa2K3G+FvZceL
         hf9sPs/iug5gJ3B9H67sqfOaURp09a7LS2rrhl4ggSk+Br7zwF/uGsygQNe1d8ZVeTif
         H6iSveVskAIqdwAyK/IZZXBAqjTxcutW6bTlXsqQXBYOWEw8r/SX/f84SW9LiXyKEJRj
         0jTKQFwP0OqkOUvWJbtwbG4fNqX+gXZBd2s3f7E5c0a3OTPRe/8Gg5gjWwdZoighFEc0
         pRfCo9ZaDYlIGw26xPbQ0Lq8+xl58P9AyLd2TgQwNYDaZ5wdrn3MsFPMLE9EY6n4ZmUY
         pBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wzufjbDqGxDa2/k86ie4tw8Pdx0MnDOAPtjEE+yOjpY=;
        b=qe7/3IoAKL481TjCiCJVJZZTETOjkMxOLJ6OKrd6DQ/lJljQU6hauhn4U9AhRnybmg
         s2ulGjvZIAA8IWtYMHE71Q4dIcrhXaruB8ZcJDqvD0LzsT0//GSX4JWFZVpueF2/dru0
         vViB7Dn1rE45//7ui1Op8ChvBJhi1uiUL/uAWFNnYLWuHiZVkHFfgdy1x+3c3HT7ml5Y
         ptY42IB/+/mrFXd7iBoJZ9sXuZLqDauq6+Fgt+eZK6Ohk3JcMyvx0RvLUaVQcrbmqDq5
         Z2OZz2ZQMb95SlKamCKFgX13RUD5iPsnHRJaC2/MU1Dmzcoez6ZLt72L+R1hf7s6qjqG
         4dzA==
X-Gm-Message-State: AOAM5332g/H2j/hR1W3G5A/njFhclA8kXTc7YAyhnHDq+UFuntbFFNQS
        K0w5oaLHANhMDTv+pocZ5tY=
X-Google-Smtp-Source: ABdhPJytey5AouVICCVDk82iHij/AVBq1i2JZ5+cq79HqLAUse2Ke4aYg8gr5O0k/fTERlBtekAIKw==
X-Received: by 2002:a17:90a:be10:: with SMTP id a16mr30954933pjs.133.1636132723242;
        Fri, 05 Nov 2021 10:18:43 -0700 (PDT)
Received: from [192.168.1.2] ([59.95.82.141])
        by smtp.gmail.com with ESMTPSA id l1sm7758035pff.125.2021.11.05.10.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 10:18:42 -0700 (PDT)
Message-ID: <9bc5a088-2cdc-1bbd-6459-d1b95e25aa9c@gmail.com>
Date:   Fri, 5 Nov 2021 22:48:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v2] staging: r8188eu: os_dep: remove the goto statement
Content-Language: en-GB
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
References: <YYKvWeyqd71pYSqM@Sauravs-MacBook-Air.local>
 <YYT/LibxFzssNUJN@kroah.com> <ecf6ba8e-8273-0d77-5ceb-3ad44179d3a3@gmail.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <ecf6ba8e-8273-0d77-5ceb-3ad44179d3a3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/21 4:06 pm, Pavel Skripkin wrote:
> On 11/5/21 12:53, Greg KH wrote:
>> Right after this, ret8 is set, but never checked, which looks like a bug
>> to me.  Can you work on fixing that after I take this patch?
Yes, I will send a patch removing a local variable for return value and changing 
the return type of function rtw_init_default_value . As rtw_init_default_value always return 
success and the return value of this function is not checked.
>>
>> thanks,
>>
>> greg k-h
>>
> 
> ret8 is returned from this function, but as I said [1] it can be just removed. It will be always set to _SUCCESS.
> 
> 
> 
> [1] https://lore.kernel.org/linux-staging/f26b4aec-c0a1-8c93-b34e-8b1a36ac81b3@gmail.com/
> 
> 
Pavel also mentioned to remove the local variable ret8.
> With regards,
> Pavel Skripkin

Thanks,
Saurav
