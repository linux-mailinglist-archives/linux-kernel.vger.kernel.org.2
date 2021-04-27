Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4FD36C9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbhD0Qvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237939AbhD0Qv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:51:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492C5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:50:43 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a12so1963380pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QI4cizAfWNN+jlJ9xJUZkr7kuecj524Yzqqxf7DPu7M=;
        b=ukk9gR0NLajnrkhI9K2bu/yKB26mZH7CSri2aYnfPnm22UvS9cgEuEydZZOlBWXX4O
         IGdnOFnvmoaQ37hD9qa+07U7OyVf2KCg3YHCzioX1ZkkZCvzvlzypG1qTrZ6PGS6difo
         LRiKYD4kkFx5MM5c1eGudDCyNC7Hn/3UEAkj1Pn+k1P+CUD1GKBDeD1Z+yu3BbtDv3NZ
         t2qy6JoSiqs8chWTszIR/oMFlL+BdX/x9aMlRTZvtztrDwXbxxoUAdMyV92OWS5hNpWN
         6lRy2O+IFe48F833Fmrt6Lnt65TFU01vgg3G98heEnYs4VBrtZISMBvUYk2AW2uIqapS
         +55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QI4cizAfWNN+jlJ9xJUZkr7kuecj524Yzqqxf7DPu7M=;
        b=Fnbv8ywRwlxY+M4XReeVBX2V80cmFiW59Pug32Nf1Gmy2IZkNHGVYgCxGj9w8jP9NO
         twnql2Nbkvs+jf/KmmeH8d82KFftdwVjhbbhF91vWAGkFfmeK3KBO12O+w0s/d7jAiVS
         /M/hL7gwRIi0DcgRg5ObqtldGKX/YEmHWtT3b6QeBLMIKEuXFcs5HY+BYxPWC6FxtxIi
         IsBbNS4+OOaHaF2mYmRdQgSfrKXUdySB+Ys58qlMIBcelkTUZm8Z5EwXu0BdJbCgehoB
         LkSsV+7si3XiPIGlN6xObF5bXCchAtRewgowqcOk7zJm3mKjqQJ+gU63yKTG1HbQo5di
         nmpA==
X-Gm-Message-State: AOAM530ThN6JSroDQNYCf6R/5EM0rz9E0ThkybRAiynsuG0KslCrTWKZ
        nqxFEwwWEsg7Wpp4uFZn5ROm6xfjL8k=
X-Google-Smtp-Source: ABdhPJwlMz6sM+ZPIQQS9nLzU4ThEw7xPiuMwuI29Vohj0e/iPR/xUy7TYAERTT4cSZjfKNg3wZ/dg==
X-Received: by 2002:a65:6095:: with SMTP id t21mr22722064pgu.383.1619542242471;
        Tue, 27 Apr 2021 09:50:42 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d18sm2680410pjs.7.2021.04.27.09.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 09:50:42 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by
 default""
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com>
 <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
 <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
 <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com>
 <20210427074807.GI43717@e120937-lin>
 <CA+-6iNz_kL0DnbRb0A=WSSLK0mnqw35S47TDXq5rhwXL_VWdPg@mail.gmail.com>
 <20210427141116.GJ43717@e120937-lin> <20210427151042.j7hku7pxqz56uyt6@bogus>
 <0887ce92-e9d8-47ec-0077-4c1f2fd46f87@gmail.com>
 <20210427163913.svx2w2mxo4w3is32@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1e4b602d-5ed8-19a3-2cd1-b3fe27e7ff8d@gmail.com>
Date:   Tue, 27 Apr 2021 09:50:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427163913.svx2w2mxo4w3is32@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/2021 9:39 AM, Sudeep Holla wrote:
> On Tue, Apr 27, 2021 at 09:24:55AM -0700, Florian Fainelli wrote:
> 
> [...]
> 
>> This is a self inflicted problem that we have in that the bootloader
>> provides a Device Tree to the kernel which is massaged in different ways
>> and intends to stay backwards compatible as much as possible. And indeed
>> after removing the 'mboxes' property gets us going with fw_devlink=on.
>>
> 
> I assume the bootloader checks the presence of SMC support and modifies
> the DT node accordingly. Can't it remove the mbox properties as it make
> no sense with SMC compatible ? However ...

The bootloader has always assumed the SMC support was there from the day
we introduced it because it was. What changed is the way we advertised
to Linux that support. We used to have a custom mailbox driver that
would be pretty much what the ARM SMC transport eventually came to be.

Since we still support earlier kernels that were deployed with the old
mailbox we cannot arbitrarily break that setup, especially as our
customers tend to be slow in picking up new kernel versions, fortunately
before they get to 5.13 we can mandate a new bootloader that may not be
compatible with their 4.1 kernel anymore, or at least not without some
backporting of the ARM SMC transport, that's all fair IMHO.

> 
>>>
>>> 2. IIUC, the fw_devlink might use information from DT to establish the
>>>    dependency and having mailbox information in this context may be
>>>    considered wrong as there is no dependency if it is using SMC.
>>
>> Right, unfortunately, short of having some special casing for SCMI and
>> checking that if we have both an "arm,smc-id" and "mboxes" phandle we
>> should prefer the former, there is not probably much that can be done
>> here. Do we want to do that?
> 
> I *think* we could do that in the SCMI drivers, but:
> 1. I am not sure if that helps fw_devlinks if they are deriving the info
>    purely based on DT
> 2. I am also afraid that someone might come up with exactly opposite
>    requirement that let us prefer mailbox over SMC as they would use
>    SMC only if h/w lacks proper mailbox support. I fear that we will get
>    into rabbit hole trying to do something like that.

That is true, and to get to the SCMI driver, even the base protocol you
must have been probed, so we have a nice chicken and egg problem. I
highly appreciate your time understanding the context and trying to find
a solution it is pretty clear that we must fix our FDT now.
-- 
Florian
