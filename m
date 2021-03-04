Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4F32D36B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhCDMm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhCDMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:42:11 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C55C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 04:41:30 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id f12so23684641wrx.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 04:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E6GCI19Zx79Up+MyTNmAWldPWN/2JegMjMID49ZpRnQ=;
        b=pGXEh8gcQ7KQtvRKjnTaKd3pYO0YZk/iQ0vlSDZU/KmqNg7sQt5DzlYQfYrTUyFrKg
         avycEFbbpBmyT5eSJt28wZ6g2bTwlGvFEcEkKyidnNf5KkuALHsgFZfKEw8IJj1Shua1
         6DAoFgpjxALPjf1TflsZk0oFmmTHJ4qG7pgj7kQvJzhC7zhoTVIEGg04wodLzXsWfUH0
         RjANQO1YAlyNMCJXHXa5x+3As0MBcazCMusnOu7VVHY0uYjRWxZuvlTmnDFMJD1sdlaU
         Wj4+HcE/7n4TkLKoUhg855gYxug0P3/1JoDxuK18gGgnPipJb4kZEizuPr680cCzI8Ph
         nizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E6GCI19Zx79Up+MyTNmAWldPWN/2JegMjMID49ZpRnQ=;
        b=CZOKhCeLQJTqj6jRex9YszRrbU3Lc7K3t/lVUAuAKq2gTXgwcoRytlL4h9Vwg+hHTa
         EaHmgg4X4lYe7desa24dsLNsOJXHUipV/LFl3Yf9YH1OE7LL4cpoQ/+vDMF4k+qU2oCJ
         H8T9cn0UKG15V0Sadp5FaWCQ+IgSiOez66XYwj8YKBO4JkWJV4uHjmeTAskmyhgA7UtS
         kKA8dfjt2A3LNJwLFYaM+gk4R4H60J9/4i5NnCYhmz6AweIOrXFYuhIOtTqcRBUxObVv
         IZb4U5ByiBHrDWS9y4XXCW+PmOH07EHWLwsC2hIVVVvBuLb1W3iVFAyE1WyB3N2VcO1m
         pY2w==
X-Gm-Message-State: AOAM530mZuFGZrlLRJWE/hnsF7Q8GxvZmMN8dY5I7dhjaaCWObHG5sSp
        vtx9u5jEwMBVLFn2KpIOWW7cOfxPO8j4jg==
X-Google-Smtp-Source: ABdhPJwyeYM/k/ZCCDJ1m8OrVVCxXxMSXRVF7e/IPgAc6L8V81HGLKHf9tfvf0EIjKLY+/CmvGQOUQ==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr3913196wrp.230.1614861689385;
        Thu, 04 Mar 2021 04:41:29 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id o3sm9035740wmq.46.2021.03.04.04.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 04:41:28 -0800 (PST)
Subject: Re: [PATCH 1/2] units: Add the HZ_PER_KHZ macro
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210223203004.7219-1-daniel.lezcano@linaro.org>
 <CAHp75VcJwoye5KOYXF3Fs1F-82JPP-7VaU4z5OqBrYDr+AGQ5w@mail.gmail.com>
 <CAHp75Vcqug9qC_ejHE03YguiSy-XpsZV6g36-pe3VOFgTS2-tA@mail.gmail.com>
 <20210303163125.dcc0a086a939a58ed30750e8@linux-foundation.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3ffdd3de-c30e-f237-7bd7-2700d426e53a@linaro.org>
Date:   Thu, 4 Mar 2021 13:41:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210303163125.dcc0a086a939a58ed30750e8@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

On 04/03/2021 01:31, Andrew Morton wrote:
> On Wed, 24 Feb 2021 10:39:36 +0200 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>> On Wednesday, February 24, 2021, Andy Shevchenko <andy.shevchenko@gmail.com>
>> wrote:
>>
>>>
>>>
>>> On Tuesday, February 23, 2021, Daniel Lezcano <daniel.lezcano@linaro.org>
>>> wrote:
>>>
>>>> The macro for the unit conversion for frequency is duplicated in
>>>> different places.
>>>>
>>>> Provide this macro in the 'units' header, so it can be reused.
>>>>
>>>>
>>>
>>> Thanks! That was the idea behind my reviews to add those definitions
>>> explicitly in the users. I just want to be sure you covered them all. Also
>>> there are few non-standard names for above in some drivers (they can be
>>> fixed on per driver basis in separate patches though).
>>>
>>>
>>
>> Seems you introduced a common macro and forget about dropping it elsewhere.
>>
>> https://elixir.bootlin.com/linux/latest/A/ident/HZ_PER_MHZ
> 
> Yes.  And HZ_PER_KHZ.

Thanks for the review, it is fixed it in the v2.

> Also, why make them signed types?  Negative Hz is physically
> nonsensical.  If that upsets some code somewhere because it was dealing
> with signed types then, well, that code needed fixing anyway.
> 
> Ditto MILLIWATT_PER_WATT and friends, sigh.

At the first glance converting to unsigned long should not hurt the
users of this macro.

The current series introduces the macro and its usage but by converting
the existing type.

Is it ok if I send a separate series to change the units from L to UL?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
