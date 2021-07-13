Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F8D3C738D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhGMP4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbhGMPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:55:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB23C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:53:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p8so31113108wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9VK3zYj7KAcX3VkDmk3HajnLmQ/7F6UzbJJALrCeO9s=;
        b=jVy56SpSpjEEFw/F6TCv07V2BDQiA7Gs3E1NN79skntxIokby+W/y0Oq6qsraXVOKG
         qqu6SPTIg7vGH7pna9L8xfB/2d8pmZuVxd4SjoQub5fyV3egUekPgnHR4YQcqqS/bsNx
         0ca4R0DmcScWassVUo/4Sp265V8rj8e+UXn8PiSormXTKVMVLpFDLph7bG/OJsHoiCK8
         xOd9GgZsq18KgIymiTB/ZeMz3O1MyuaavNOTPap7GDy15wezvRlYw60BshdBvHC2hoBU
         JTuzk7VBYgIn5E2KFhB4W636pr4HBNBC5Mjg+pgR0ywKKmKNaWf5jmjgoMiobEOtcBEo
         p9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9VK3zYj7KAcX3VkDmk3HajnLmQ/7F6UzbJJALrCeO9s=;
        b=GBuHqCI4VpYVLJ2jTO3UeN1paGLmeVoidKr9ORcnTrS1h23xLVFNfggHiGx3nOyybQ
         jDgEIwvSS1y8lYcM1jC12wh+G6elVJh2oGGcY4PndDrn/GEhvh2J2Hxe5Z1FHViPq7g5
         RjsW3qoE6SDEmoa4h51hFKUPhp3DBRhNRTXVM96tY1uWCd9+PrctpyIRaz+3QmCqPC3g
         WMqGy2dh6WXtPsiEB1umWQvmP/n05O53eQUiOxR3BebkYTLopuPTs8iQe3YGSgPw+Q1n
         igpfGeNW815WaS8CFGBaBAYCMVPtpRXulLFwkrsp0wUvw4M/hsG3IGZGnbus03KDEoB+
         sbXw==
X-Gm-Message-State: AOAM533oVsp7ngDMEfehgw8QJZqLWOkTIatTWN6aSkkEa1ozO5SRORCA
        MFZLOjGXmA9KrKVB018RtwJUsQ==
X-Google-Smtp-Source: ABdhPJyNhaqWJuUzhjdyh6zAxmiGvUgGFjvx0P9iHM4p3kS9jyIHt0wReUeQ2r3Lr23AV4tICt0RTg==
X-Received: by 2002:adf:9bd7:: with SMTP id e23mr6694018wrc.349.1626191588021;
        Tue, 13 Jul 2021 08:53:08 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id r9sm15907812wmq.25.2021.07.13.08.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 08:53:07 -0700 (PDT)
Subject: Re: ia64-linux-ld: wcd938x.c:undefined reference to
 `__devm_regmap_init_sdw'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <202107132322.nTixp2uM-lkp@intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c327f238-55ae-831b-5092-6a3f577135ed@linaro.org>
Date:   Tue, 13 Jul 2021 16:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202107132322.nTixp2uM-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/2021 16:32, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7fef2edf7cc753b51f7ccc74993971b0a9c81eca
> commit: b90d9398d6ff6f518f352c39176450dbaf99e276 ASoC: codecs: wcd938x: remove incorrect module interdependency
> date:   4 weeks ago
> config: ia64-randconfig-c004-20210713 (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b90d9398d6ff6f518f352c39176450dbaf99e276
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout b90d9398d6ff6f518f352c39176450dbaf99e276
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 

Thanks for reporting this,

I already send out a fix for this issue.

--srini
> All errors (new ones prefixed by >>):
> 
>     ia64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_codec_free':
>     wcd938x.c:(.text+0x762): undefined reference to `wcd938x_sdw_free'
>     ia64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_codec_hw_params':
>     wcd938x.c:(.text+0x7f2): undefined reference to `wcd938x_sdw_hw_params'
>     ia64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_codec_set_sdw_stream':
>     wcd938x.c:(.text+0x882): undefined reference to `wcd938x_sdw_set_sdw_stream'
>     ia64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_tx_swr_ctrl':
>     wcd938x.c:(.text+0x2a32): undefined reference to `wcd938x_swr_get_current_bank'
>     ia64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_bind':
>     wcd938x.c:(.text+0x4ff2): undefined reference to `wcd938x_sdw_device_get'
>     ia64-linux-ld: wcd938x.c:(.text+0x50b2): undefined reference to `wcd938x_sdw_device_get'
>>> ia64-linux-ld: wcd938x.c:(.text+0x5292): undefined reference to `__devm_regmap_init_sdw'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
