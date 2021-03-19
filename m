Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E11D34278B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCSVSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhCSVSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:18:35 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297CCC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 14:18:35 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h1so9294932ilr.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 14:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mQFv/geOslVz2uujpq+8Xn/0LPq2Rss0/mm6QMdsBuE=;
        b=N3H5U7HbJ2jS50+bkazi/6XK6CivZBiZovEdStgi0vrBS3pu66XOnMQr0+KtNS+ivo
         +KUn6nhIomS4GPkZAUGdTfo0IJUGlLDEXKOFqdhazmmrDEkL8e+pFFmIPhvQBxQoYcCA
         rIiag9k4qlDeoL78H37IN1uVSSbAxypOWKVefa88RplYC7HGQ6Xmrpme9hQWDb2gp3LN
         yrwaYV4sLP8aGct0XKHGYNrGfJFOXV4kjzCPCEMA1AKzwUc4Qyyu3004abyy0TFiCyFo
         h9cFe4En/BlBCsMguy0kkVyPfb9FT75OO3wJikSNF8aZPDhB0z32xISlsuBiLVWcvAog
         rlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mQFv/geOslVz2uujpq+8Xn/0LPq2Rss0/mm6QMdsBuE=;
        b=XMfa6vJiiqLJ975NqMHbIZIBRIWZI8EQ3JToxjfrTfghnP9w3K5CHpBedOD2EdAu6k
         tRr00FMEV/UbI52btTwDEP2lflxBjvuN+mQ26OUU7jo1Iegjhdre2tmSNucnX49x0kUe
         4F8ZBAVWIEbFlAxee1OX8jugiMoojMMqS1E+mvbtKnKOH9MB0oYBGzqd2yuPTRCnFqEU
         M3lFxFujwmUgSSbu/6IvTPcXEgeDpUEZA1YN9wLZAwoXIwHdKXgn0Q57XAsOieBTev/m
         iTiBrrQcq879YNeKgVtL2KKtrzGRk233Nnj1Ns5kmaGdvCkzyDtOTzrTCeeAHG/MA/pH
         AgqQ==
X-Gm-Message-State: AOAM531tH5Xi6PR+QoKHkagOrVexwz6ku8Oq/J1O9MYyzv7umuWjuVGr
        6NR/UuSvsddAm29xXzKLhF6BYqgZcRa2K+gx
X-Google-Smtp-Source: ABdhPJw9bBLndeJ7NQGqtPlQhLLd/IXScIEALjBKVZeawjwYO0vZqUocLJPRmZYZ7pxIEGx2t/Yh2Q==
X-Received: by 2002:a05:6e02:8e6:: with SMTP id n6mr4102803ilt.74.1616188714149;
        Fri, 19 Mar 2021 14:18:34 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id u15sm3100128iln.84.2021.03.19.14.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 14:18:33 -0700 (PDT)
Subject: Re: [PATCH net-next 4/4] net: ipa: activate some commented assertions
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210319042923.1584593-1-elder@linaro.org>
 <20210319042923.1584593-5-elder@linaro.org> <YFTuP7NbUFPoPoCb@lunn.ch>
From:   Alex Elder <elder@linaro.org>
Message-ID: <7068152e-5e1b-94b2-bcb2-c66e622bd127@linaro.org>
Date:   Fri, 19 Mar 2021 16:18:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFTuP7NbUFPoPoCb@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 1:32 PM, Andrew Lunn wrote:
>> @@ -212,7 +213,7 @@ static inline u32 ipa_reg_bcr_val(enum ipa_version version)
>>   			BCR_HOLB_DROP_L2_IRQ_FMASK |
>>   			BCR_DUAL_TX_FMASK;
>>   
>> -	/* assert(version != IPA_VERSION_4_5); */
>> +	ipa_assert(NULL, version != IPA_VERSION_4_5);
> 
> Hi Alex
> 
> It is impossible to see just looking what the NULL means. And given
> its the first parameter, it should be quite important. I find this API
> pretty bad.

I actually don't like the first argument.  I would have
supplied the main IPA pointer, but that isn't always
visible or available (the GSI code doesn't have the
IPA pointer definition).  So I thought instead I could
at least supply the underlying device if available,
and use dev_err().

But I wouldn't mind just getting rid of the first
argument and having a failed assertion always call
pr_err() and not dev_err().

The thing of most value to me the asserted condition.

Thoughts?

					-Alex
