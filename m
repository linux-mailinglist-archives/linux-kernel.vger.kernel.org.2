Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9A33EB21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhCQIMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:12:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46780 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCQIMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:12:23 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lMRHx-0008Ls-RZ
        for linux-kernel@vger.kernel.org; Wed, 17 Mar 2021 08:12:21 +0000
Received: by mail-ej1-f71.google.com with SMTP id fy8so14815831ejb.19
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1VvKlCveGwcZ25kRarfsxCT9mmwVZ4FTdcU1BjBinAw=;
        b=YJWvXsj9zmXZGZguSB9CfCBtnhQJFpCUEEob5z+tCNPJP8pJ4ILzU5v/utH0d2suVD
         nU0DxerJcG7sfAnCfvnHYoAQLFy5fR76DGALWREr3JQqqwg//oH5DpoNSrEFveQoLkAQ
         pAaBAVJ7F/thoSYxtWBf88BhlwRBIirvVu/cG+8txoMf86UNgthFswDE4mspemV9A3bu
         ETZmX73KUH2eqO1R2NCZnvym/+HkNkx5uoYu82TTQjny6Icr0ll1m5a2+RIC2cco5rUC
         wO2aYFevR/4vxPhttGSYV6ArmgsBoNu6HbPyESkLmMYL+q2WFhT/C1nm2kchmjN3bSYX
         hF2A==
X-Gm-Message-State: AOAM532zV3JmAeH7uCYPywIh7yEK+jPiqjimJQQ39Tmpa63Xngz8npA2
        x/cBlY0reON5doUMrblOktUY7+79xVGQX991jkyZzURhurbDhPOuEpO58rPMKryogTsSFcTscBv
        0ysiexG8v9YN9IHqQbJ9eUP6R67WtIKg0qXc8oc4jVw==
X-Received: by 2002:a17:907:72d5:: with SMTP id du21mr34989279ejc.167.1615968741619;
        Wed, 17 Mar 2021 01:12:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfdK25HRyfJGFbH9Zn4GBP2a8sNgOSuRwM5ntCkc+NnnmuNWd0fYtbppm2eQgwuYdu3rmn+g==
X-Received: by 2002:a17:907:72d5:: with SMTP id du21mr34989266ejc.167.1615968741491;
        Wed, 17 Mar 2021 01:12:21 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id u24sm7343334edt.85.2021.03.17.01.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 01:12:20 -0700 (PDT)
Subject: Re: [PATCH] MIPS: ralink: define stubs for clk_set_parent to fix
 compile testing
To:     Dmitry Osipenko <digetx@gmail.com>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20210316175725.79981-1-krzysztof.kozlowski@canonical.com>
 <44ce8a32-91ff-bb6c-adba-f85c2edf3c18@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ecbcbeae-1eb8-d20e-04b6-2c65f136799f@canonical.com>
Date:   Wed, 17 Mar 2021 09:12:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <44ce8a32-91ff-bb6c-adba-f85c2edf3c18@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2021 01:10, Dmitry Osipenko wrote:
> 16.03.2021 20:57, Krzysztof Kozlowski пишет:
>> The Ralink MIPS platform does not use Common Clock Framework and does
>> not define certain clock operations leading to compile test failures:
>>
>>     /usr/bin/mips-linux-gnu-ld: drivers/usb/phy/phy-tegra-usb.o: in function `tegra_usb_phy_init':
>>     phy-tegra-usb.c:(.text+0x1dd4): undefined reference to `clk_get_parent'
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  arch/mips/ralink/clk.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
>> index 2f9d5acb38ea..8387177a47ef 100644
>> --- a/arch/mips/ralink/clk.c
>> +++ b/arch/mips/ralink/clk.c
>> @@ -70,6 +70,20 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
>>  }
>>  EXPORT_SYMBOL_GPL(clk_round_rate);
>>  
>> +int clk_set_parent(struct clk *clk, struct clk *parent)
>> +{
>> +	WARN_ON(clk);
>> +	return -1;
>> +}
>> +EXPORT_SYMBOL(clk_set_parent);
>> +
>> +struct clk *clk_get_parent(struct clk *clk)
>> +{
>> +	WARN_ON(clk);
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL(clk_get_parent);
> 
> I'm wondering whether symbols should be GPL or it doesn't matter in this
> case. Otherwise this looks good to me.

The ones in arch/mips/ar7/clock.c were not GPL but other stubs already
defined here are, so indeed I'll make them GPL for consistency.

> 
> Also, I guess it should be possible to create a generic clk stubs that
> will use weak functions, allowing platforms to override only the wanted
> stubs and then we won't need to worry about the missing stubs for each
> platform individually. But of course that will be a much bigger change.
> Just wanted to share my thoughts.

Yes, it would be a good idea but also a bigger task. I am not sure if
these platforms are alive enough to get that attention.

Best regards,
Krzysztof
