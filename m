Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E819233D916
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbhCPQVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:21:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52927 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbhCPQVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:21:11 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lMCR8-0001pq-Sk
        for linux-kernel@vger.kernel.org; Tue, 16 Mar 2021 16:20:50 +0000
Received: by mail-ej1-f72.google.com with SMTP id bg7so7841585ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VknwmHw+mafFAf+N/kI7g0yn7Vs0AliFHe5HjOF0pmE=;
        b=pMHP7tcM60I6pUGLYOZuYWQamxmpQ1yUC8JNcs66lXSj5DbuankuILxMYHZwxs2vVJ
         j5En/Ax2rAFJ9e3XxsngHsHATWMqsGr+bIeJk/SzOfvw4QaQMW5YjskT8Tumb4Pms+t5
         nvby81j/sgqqMjPIjbCF9SIG/EV62GB48q72T5xji63iNbRFZCDfjCWJpy6KN4Ky9y1H
         62vg6YyNg90itr1Z9iTuDq5cC2L+hgR6cj+3fE7LOsHR9VS/y0dxgpuj9paRd8baFcH6
         OyV/YW0W+Af5Nr5CiYGq6EldlKVSTEBcJ6VgyGTBBHh1r4OGs1Ijm62BSLL8cSfLfq22
         oumw==
X-Gm-Message-State: AOAM531CYsNia8VW849YTYRDAEWeAi/Ky8D+LSnwCRL/okVAHNFYEXn+
        JJ6QlRzu7dG2UBOF7ikqmt6i+PSvO3r18jtHxXsiao8xYMECLdulzfi+VMPSVhyuHMEeoTw70ix
        3DpSBSRMjN3D+zK7PWt6HzOeYrhjZH7OL8pRPB1gojA==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr23741586edd.258.1615911650617;
        Tue, 16 Mar 2021 09:20:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpZeCcRfGYZrR3Un/ccY9m3ltyvSDI2VewZd/JxmPKV6ZsHbXKVwP308doM2rw+/5RVmvs2A==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr23741572edd.258.1615911650452;
        Tue, 16 Mar 2021 09:20:50 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id gj26sm9629395ejb.67.2021.03.16.09.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 09:20:50 -0700 (PDT)
Subject: Re: [PATCH v2] phy: tegra: depend on COMMON_CLK to fix compile tests
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20210316075551.10259-1-krzysztof.kozlowski@canonical.com>
 <0e52e932-e5d7-8116-710a-50956caaf87c@gmail.com>
 <CA+Eumj5c2i30Xh2oBGeR5R_9JkPGiAXRGNYc4hKt9s8XuHjGdA@mail.gmail.com>
 <CA+Eumj4WirHRgr3si=nkQpNdUBcCwqLXvs-ihSi2nuJokxg=Xw@mail.gmail.com>
 <d280c555-5ee4-7803-ada1-88257f809816@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f0fbc7eb-f180-453c-de64-64c3d00958f8@canonical.com>
Date:   Tue, 16 Mar 2021 17:20:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d280c555-5ee4-7803-ada1-88257f809816@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2021 17:14, Dmitry Osipenko wrote:
> 16.03.2021 18:51, Krzysztof Kozlowski пишет:
>>>>
>>>> But if COMMON_CLK is disabled, then include/linux/clk.h provides a stub
>>>> for clk_get_parent(), meaning that MIPS has its own COMMON_CLK, no?
>>>
>>> Hi,
>>>
>>> It depends on the platform. Not all of them implement every clk API,
>>> so you can have failures:
>>> https://lore.kernel.org/lkml/202102170017.MgPVy7aZ-lkp@intel.com/
>>
>> Ah, you mentioned the stub, so let me clarify more. The common clk
>> stubs are not used for cases like !COMMON_CLK && HAVE_LEGACY_CLK (or
>> HAVE_CLK, I don't remember). This is why you can have a MIPS platform
>> defining some of the clock operations thus not using COMMON_CLK at all
>> (and neither the stubs).
> 
> I see now that the stubs depend on CONFIG_HAVE_CLK and not COMMON_CLK,
> thanks.
> 
> This raises question about why those platforms select CONFIG_HAVE_CLK,
> while not implementing it fully. Sounds like a better fix should be to
> add the missing stubs to the MIPS clk implementation, which should avoid
> the need to patch each driver individually.
> 
> https://elixir.bootlin.com/linux/v5.12-rc3/source/arch/mips/ar7/clock.c#L489

If such stubs as pointed by you are accepted, then indeed it would be
better approach.

Best regards,
Krzysztof
