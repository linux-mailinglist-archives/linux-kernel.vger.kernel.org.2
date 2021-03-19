Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7483420FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCSPdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhCSPcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:32:52 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA86C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:32:52 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id f19so6513693ion.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/d8jBikz4p9w6ETospv3vL+NArFRppIkKIX3Ap4QrNQ=;
        b=M7GvJw0+1b/2/mB1jBTYbZyw7RZbfQ+UqcGnDKQI91bupJHSY2Ka+q0sEGwY/Dk6On
         Xlbf42NJ0mm6OZDJmUwAQofbv6ydTBFZ0VvQWbVARELURPIqzi3btWye/Bp9JLsOAENl
         PWAWL24u6NynXFoTEuhQfV4WpvLdWA9vv3q9ozIFARZsHlS70v3Sesm1rytu5fc2s+ri
         Kx7ZE/PWHhE4tiILYiZrfNPBLLnPvOjwdM27DYk/rELk5YVWUnFUaiSkCG9mk8hgzq++
         q6cWIdiVNFLt6WRn2KmJBMX84YxCpmPfVcDLDXi7eRW+zkM7CEpKoiOSMTcybRpD1cGK
         ZQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/d8jBikz4p9w6ETospv3vL+NArFRppIkKIX3Ap4QrNQ=;
        b=uetrpuS3LgQ8Ni0NBf1NA2q0EFnc5dhCTgOWwxmr0TNJL9Xv0m0Kz7qbl4moKScbjy
         zPU4aS6hgVRIQd4SdEnyockCgaCay/xOVzZ+pCEkPk4MdQMGwV4R66pRe6PL4r38gzK8
         QIaO6fHLQrhIl41hZZad5S4tPQedmFcmYzfBR7dXnFVgJ8pMuLba4JiPi6Ltq3seImbX
         t4jAfN6jd/HL6c224WeIU9vY2BRg4AO8h8aMUfryAm8JPdDN2clg5B1AFzunH/BRgDpo
         imNO73OdT6c0rUmjdMzEAqBUh6dqG9bUJzdxNNxFJLI9/2l4e2w/JfwSez4HpvIxlBBs
         XVOg==
X-Gm-Message-State: AOAM531kekiIeAWW4fmdL1UXKMSG8mtdTs8A3OQMusuiwITn/GeZLWi1
        rQi95iyELZhmvyNsAus2af0AZf3Dn8kJVqKb
X-Google-Smtp-Source: ABdhPJz4qNqmvLX7BgQZdVkCbdxOELKmhNIBBtsd+kcg5a5qZPfq0mcbtVaEBZ/OrRGFKJtaf85Dcw==
X-Received: by 2002:a5e:cb4b:: with SMTP id h11mr3259993iok.108.1616167971664;
        Fri, 19 Mar 2021 08:32:51 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id c18sm2815457ild.37.2021.03.19.08.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 08:32:51 -0700 (PDT)
Subject: Re: [PATCH net-next 4/4] net: ipa: activate some commented assertions
To:     Leon Romanovsky <leon@kernel.org>
Cc:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210319042923.1584593-1-elder@linaro.org>
 <20210319042923.1584593-5-elder@linaro.org> <YFQwAYL15nEkfNf7@unreal>
 <7520639c-f08b-cb25-1a62-7e3d69981f95@linaro.org> <YFTAn7tHBAG2PO78@unreal>
From:   Alex Elder <elder@linaro.org>
Message-ID: <69647805-7ace-442d-2268-aa7c4800ab6e@linaro.org>
Date:   Fri, 19 Mar 2021 10:32:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFTAn7tHBAG2PO78@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 10:17 AM, Leon Romanovsky wrote:
>>>> @@ -212,7 +213,7 @@ static inline u32 ipa_reg_bcr_val(enum ipa_version version)
>>>>    			BCR_HOLB_DROP_L2_IRQ_FMASK |
>>>>    			BCR_DUAL_TX_FMASK;
>>>> -	/* assert(version != IPA_VERSION_4_5); */
>>>> +	ipa_assert(NULL, version != IPA_VERSION_4_5);
>>> This assert will fire for IPA_VERSION_4_2, I doubt that this is
>>> something you want.
>> No, it will only fail if version == IPA_VERSION_4_5.
>> The logic of an assertion is the opposite of BUG_ON().
>> It fails only if the asserted condition yields false.
> ok, this ipa_reg_bcr_val() is called in only one place and has a
> protection from IPA_VERSION_4_5, why don't you code it at the same
> .c file instead of adding useless assert?

As I mentioned in my other message, the purpose of an
assertion is *communicating with the reader*.  The
fact that an assertion may expand to code that ensures
the assertion is true is secondary.

This particular assertion says that the version will never
be 4.5.  While looking at this function, you don't need to
see if the caller ensures that, the assertion *tells* you.

Whether an assertion is warranted is really subjective.
You may not appreciate the value of that, but I do.

					-Alex
