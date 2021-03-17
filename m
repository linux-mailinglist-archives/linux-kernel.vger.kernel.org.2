Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478FF33EB37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhCQIQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:16:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46915 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhCQIQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:16:13 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lMRLg-0000CA-4W
        for linux-kernel@vger.kernel.org; Wed, 17 Mar 2021 08:16:12 +0000
Received: by mail-ej1-f71.google.com with SMTP id 11so14809282ejz.20
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h7RuThKGVeD8HpXasnQO91ZFAcbdaCJWKNu1ufXCr2w=;
        b=T7KOvpOA0ajTX58oYLo7qiT3lP8W4SF48hbGF8c1Q56pkUi648gXctLNSWabtm1fSd
         ejbVdE4hWjqqDAzOoyHQwUzLwCJEIS+LGLNTV5Sx28Fe8q0qzCKq9eqb6tICoOlRp0lC
         J36q5gpVRknunp3IJ6EcElrKK3IlbT48bAnf7ZfGI44YUOKTiSxCUlu6Vm9AyXvwG7w3
         DYYkVH63eZBCOg38Jlup8XQgEJZkiBiHLnDjWLJ9Owj+sVRkPX90LVOaua2SuWEaPnZf
         8Ed2O3qIJfAfrstUkpkKjraxBcGCZve1ENqh+k0eTNXMcgM32GiLdLHHjagc56f9K9kS
         +vXQ==
X-Gm-Message-State: AOAM532DK5p5cKidvKIdpujKs1t4zEJSDEWYYu1y/UH0Y2d0ZS87GUfE
        69qFqnyfzA/cobd9RZuG2Y1uE6NLl0ZNcRNjKRntB2LJAN42W7FmiY0K+LCN9RJwjn7Kv9FWrOy
        R1TqkgBHizf8rl5lP8N5IPcFv26IhAhcVZEwQzh0nUg==
X-Received: by 2002:a17:906:75a:: with SMTP id z26mr33965990ejb.22.1615968971921;
        Wed, 17 Mar 2021 01:16:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPcCO5sSi1eo5a3askTdA/AAtRTlKM87h4YwdmFP5QiRbC3VpupLgHfc3JdAdM/y1VwLMscA==
X-Received: by 2002:a17:906:75a:: with SMTP id z26mr33965971ejb.22.1615968971762;
        Wed, 17 Mar 2021 01:16:11 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id jv19sm10845827ejc.74.2021.03.17.01.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 01:16:11 -0700 (PDT)
Subject: Re: [PATCH] MIPS: ralink: define stubs for clk_set_parent to fix
 compile testing
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, digetx@gmail.com,
        kernel test robot <lkp@intel.com>
References: <20210316175725.79981-1-krzysztof.kozlowski@canonical.com>
 <20210316215820.GA18064@alpha.franken.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <804bb73f-7de0-e91b-ed57-a3b26de78fce@canonical.com>
Date:   Wed, 17 Mar 2021 09:16:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316215820.GA18064@alpha.franken.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2021 22:58, Thomas Bogendoerfer wrote:
> On Tue, Mar 16, 2021 at 06:57:25PM +0100, Krzysztof Kozlowski wrote:
>> The Ralink MIPS platform does not use Common Clock Framework and does
>> not define certain clock operations leading to compile test failures:
>>
>>     /usr/bin/mips-linux-gnu-ld: drivers/usb/phy/phy-tegra-usb.o: in function `tegra_usb_phy_init':
>>     phy-tegra-usb.c:(.text+0x1dd4): undefined reference to `clk_get_parent'
> 
> hmm, why not make it use common clock framework ? And shouldn't 
> include/linux/clk.h provide what you need, if CONFIG_HAVE_CLK is not set ?

Converting entire Ralink machine to the CCF is quite a task requiring
testing and basic knowledge about this platform. I am just trying to
plug the build failure reported some months ago [1][2]. The CCF does not
provide stubs if platform provides its own clocks.

[1] https://lore.kernel.org/lkml/202102170017.MgPVy7aZ-lkp@intel.com/
[2]
https://lore.kernel.org/lkml/20210316075551.10259-1-krzysztof.kozlowski@canonical.com/

Best regards,
Krzysztof
