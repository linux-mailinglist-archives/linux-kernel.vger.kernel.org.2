Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2798E3B31AA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhFXOpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhFXOpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:45:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC27BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:42:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id i4so3054910plt.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jpLKG7EX/DpF/rCxDLo63s+UUOl3uRoWTd6EMjgdS+s=;
        b=bLBkOcqrvice1PQ1fSWBYJQjYhzLfzzegg6BCJE00Sk9C+B2/1x0g8gsLyinP6IOTc
         /cQj95YpY/JA+9y+bvFHE1BJLWdSsg4bemuAqGF+mnPZHWHGvkJtnitIOIGsRe3iN9nw
         dkKHOotQgmn3PXgSXij4l26Hvnl0XEkdEeqa1NF126YWWAG4qT+IUxMbnFwwJA6uc07I
         xZ2gKnafqSMY4mPvjPEz963Ur4pwSFjoKfxqhGQq1nC/TC2ZKzSmeDMc4BRGgJmxBlj8
         jwVAVD2MygxX7to2zYIyu3tZntCCBHJfKJ8hVIhZuwsyVIz+1BXzIUj47pxKi9MnTgvk
         +MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jpLKG7EX/DpF/rCxDLo63s+UUOl3uRoWTd6EMjgdS+s=;
        b=pE7sVpzlKyhwA+nSW379rUj8ptEr3DIPv/P6EjLuVO6PF6TgI+XP5Usnp10+xPZcZ4
         4PwkOIV17jekgRrKSyfKQM5jYD0xb54Fgt0oPkkxsnhtC3lGgdtrV1DC/9PI/0vev9Hj
         po8wdYtXa3lzfquJK4dRpXRcX9nMLAnT/a3K5pZYBAkATuM94J7lmIAVTGQ+t0dt3f/M
         kKkjY8+3Y5jxBrn9hmPZnJDMWos5hpjQ/xfWHQoVmqTgygROt3ctVKu2afcMQDqECNeW
         wMed2+4BgaoZvr57BDsgZ75QAf5YD4w7HkTPNXp7y4wg0ygkZI2VUeG17YwP4PSrEB0N
         ULbg==
X-Gm-Message-State: AOAM532zV3junDVhRfDVWx5vBtckJnn+u2lFCjwwnNSnfW41UFBzR2Oc
        dddSEZAvUfe32Cc21klJq0GARo1/bCVw+6FI
X-Google-Smtp-Source: ABdhPJxlaUFjqZH5QlPS4uxjAgbTWQUIwUi3KOvyml8TAI4pMrx1s7cRrU2gvO2mSmzrSSjWrXb7fg==
X-Received: by 2002:a17:90a:db16:: with SMTP id g22mr5815750pjv.111.1624545768974;
        Thu, 24 Jun 2021 07:42:48 -0700 (PDT)
Received: from [192.168.1.153] (163.128.178.217.shared.user.transix.jp. [217.178.128.163])
        by smtp.gmail.com with ESMTPSA id i27sm2660453pgl.78.2021.06.24.07.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 07:42:48 -0700 (PDT)
Subject: Re: [RFC PATCH 0/1] Adding jh7100 SoC to defconfig
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <f22f6d7e-97ab-85db-5448-c2bcef0ea0e7@gmail.com>
 <20210623185043.GA493015@x1>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <d707ceab-c59a-1b90-bd15-f875a5fe59c1@gmail.com>
Date:   Thu, 24 Jun 2021 23:42:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623185043.GA493015@x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2021 3:50 AM, Drew Fustini wrote:
> On Wed, Jun 23, 2021 at 09:45:52PM +0900, Akira Tsukamoto wrote:
>>
>> Would like to have comments for adding jh7100 SoC to defconfig.
> 
> Thanks for preparing this defconfig.
> 
> Let's refer to the SoC as StarFive JH7100 SoC [1] which is used in the
> BeagleV Starlight JH7100 board [2].
> 
>> To make the upstream friendly, try to add as minimum as possible in
>> arch/riscv/configs/defconfig required for beaglev-beta against the
> 
> Please use "BeagleV Starlight JH7100" instead of beaglev-beta.
> 
>> upstream defconfig. I might have added too much configs.
>>
>> Then the distro vendors could use:
>> make defconfig beablev-fedora.config
>> or
>> make defconfig beablev-debian.config
>>
>> while distro vendors keeping beablev-fedora.config and
>> beablev-debian.config in their own repositories to make one binary kernel
>> which boots for all riscv boards.
> 
> Note about naming, BeagleV refers to any RISC-V board produced by
> BeagleBoard.org and likely in the future will include other SoC
> families.

No problem, I will rename them all to "StarFive JH7100 SoC" and
"BeagleV Starlight JH7100 board". 

> 
>>
>> Probably, it is not good practice to add a different defconfig file under
>> arch/riscv/configs/ when each new riscv board comes out.
> 
> We currently have:
> 
>   defconfig
>   nommu_k210_defconfig
>   nommu_k210_sdcard_defconfig
>   nommu_virt_defconfig
>   rv32_defconfig
> 
> It seems like 'defconfig' supports the SiFive Unleashed board which
> makes sense as it was the only board for a longtime:
> 
>   $ git grep -i sifive
>   defconfig:CONFIG_SOC_SIFIVE=y
>   defconfig:CONFIG_SPI_SIFIVE=y
>   defconfig:CONFIG_GPIO_SIFIVE=y
> 
> I suppose the kconfig options needed for BeagleV Starlight JH7100 could
> be added to 'defconfig' as long as there were no incompatibilities.  I
> assume the k210 versions were added because that is a rather odd SoC
> that has a non-supported MMU and thus runs in m-mode.

By adding configs for BeagleV Starlight JH7100 booting fine on the current
defconfig which were SiFive Unleashed. Would like to have comments from
the users of Unleashed when this patch starts to settle down.

Akira

> 
> Thanks,
> Drew
> 
> [1] https://github.com/starfive-tech/beaglev_doc/
> [2] https://github.com/beagleboard/beaglev-starlight
> 
