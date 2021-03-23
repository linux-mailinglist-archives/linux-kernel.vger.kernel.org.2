Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC732345393
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhCWAEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhCWADq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:03:46 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA39C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:03:46 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id y17so4898030ila.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OwTS27lmdu1IYVtfbP6cul5sYprN6Y0AzhhQLQ6dKzs=;
        b=vXZF9RCKjPousn00RfXby2OHMFqI6CWIZ5uvJuzY2rF85yWRPF+Scujn49PlX5zLng
         EGVucFBSXnJDnDrH7X+XdZCCArX2/ZUw4bMwvh/1XOTmFZF3UiitqlLdazkfTn/Tj70e
         8BFtdUKewkrB1cKg4sJ/prWVn5HBhgdYl928hW+YG9XgNKR3u/tCa7YuQKBDMoQfTAx4
         B8PSFe0DpqtCRVCDUZpJsVWq2ZjXOh18jygs/Bz5XvNmXRiGqIyxF3GCxD78/yC9Yx5v
         AOJ2HliW1umV6qVfNnYbbmvrWcmlrAwbSpVWT6E72Y7RCQpv2yHoYOxfHBLmj2VaYx3s
         PbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OwTS27lmdu1IYVtfbP6cul5sYprN6Y0AzhhQLQ6dKzs=;
        b=ngMej/l5532aoN9WD555FB3/MAClYLKzG8i4l5WMythRvfldxqKCebY73+r/IiT7Gk
         AyYWUI67D3R4xgtTapTNNbA6JuzfG/vadX+UCsMIWaCfGN/0bgGuwTxXN2+S2yfCABL7
         xXCh3Ltu0r3UzGgSQgfo0Ag7lJDpujmhHZ/2hu8tSt7tJe0iZpx1qeUvw+hEXiaylNKC
         JBrdJHIi+zuKSa6/Hfc9InZUWSO+idy6fFBDZ+9IPENVzDRN5QVg/R+QBcxq9xya2wzI
         SxBXjXG/zNFEHDSwo4NFmBH/6qI+Poa+UPHUuFlYdzz9fAzN7i7IzHaN8RXSwP6mkqhm
         nNuQ==
X-Gm-Message-State: AOAM533dgQumOGZc8KmybcQPo73ViJ8SWOeJ6WGPYb9apUUwpV3iwpIn
        wXS1VFO/pK7pjfgOIIotudvGjuBB2exsPv0F
X-Google-Smtp-Source: ABdhPJy+gtujtGv55KnZhN7pqmjC0X5LL4xK9I4liITDzlvYnOOp1msEbt5i8Dgj0jqRcnUH/uYQEg==
X-Received: by 2002:a05:6e02:1a02:: with SMTP id s2mr2284719ild.48.1616457825182;
        Mon, 22 Mar 2021 17:03:45 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id b9sm8409627iof.54.2021.03.22.17.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 17:03:44 -0700 (PDT)
Subject: Re: [PATCH net-next v2 2/2] net: ipa: fix IPA validation
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Leon Romanovsky <leon@kernel.org>, davem@davemloft.net,
        kuba@kernel.org, bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210320141729.1956732-1-elder@linaro.org>
 <20210320141729.1956732-3-elder@linaro.org> <YFcCAr19ZXJ9vFQ5@unreal>
 <dd4619e2-f96a-122f-2cf6-ec19445c6a5c@linaro.org> <YFdO6UnWsm4DAkwc@unreal>
 <7bc3e7d7-d32f-1454-eecc-661b5dc61aeb@linaro.org> <YFg7yHUeYvQZt+/Z@unreal>
 <f152c274-6fe0-37a1-3723-330b7bfe249a@linaro.org> <YFkgsHfldCNkaLSB@lunn.ch>
From:   Alex Elder <elder@linaro.org>
Message-ID: <b24adfcd-1dac-581a-93bb-0ce38133bc0f@linaro.org>
Date:   Mon, 22 Mar 2021 19:03:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFkgsHfldCNkaLSB@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 5:56 PM, Andrew Lunn wrote:
>> The solution is to create a user space tool inside the
>> drivers/net/ipa directory that will link with the kernel
>> source files and will perform all the basic one-time checks
>> I want to make.
> 
> Hi Alex
> 
> Have you found any other driver doing this?  Where do they keep there
> code?
> 
> Could this be a selftest, put somewhere in tools/testing/selftests.
> 
> Or can this be a test kernel module. Eg. we have crypt/testmsg.c which
> runs a number of tests on the crypto subsystem,
> ./kernel/time/test_udelay.c which runs times on udelay.
> 
> Rather than inventing something new, please follow other examples
> already in the kernel.

I will.  I did see the tools/testing directory and I'll
look at how people have done things there.

I need to try to get it working first, then I'll figure
out where it belongs.  I think I'll be able to do a user
space test, but it's a little tricky to be sure it's
actually testing what I want.  If that ends up being
too hard, I'll look into kernel test module.

Thanks for the suggestions.

					-Alex

>         Andrew
> 

