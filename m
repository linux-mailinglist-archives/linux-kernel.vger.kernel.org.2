Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F283B3F757F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbhHYNDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhHYNDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:03:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59478C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:02:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id i28so43490946ljm.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VJdIN+/yLxKd2dK6G+lnQvHGiAbSkLC1a8lGdr9xSoo=;
        b=QoUXBQmHDkselc7MwEDy9wVldlkzLU9KQBqyiKw9vRGPfNhZd60CC0WgcCtJ2Rk3ex
         GFJSJoXuTwNelBiRUqrSA5wf1/fe8E/rKXteAy6dhZT1vZb8PuM9bGecFxonwVpkBwhP
         yJDjjhC7Esir8Kz78HkXSn7JBfZJ++vqw7DQia1YRyhjlmADbXAA9gekmJ+Xpl2cwtKB
         Wfj/0aEuJ0Jpq8sP1KmDnAlV1tsteXa+uGig2T9x8k5OlwPLE7Dfd9Oj++92Wr/kNM0I
         C0S0p4BHN2kwcAgqhE6vvZqC+Sa9iJwRLbGVb/yIlbWJfnOC1r4nEpcRmNpiD+7xh/e2
         kDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VJdIN+/yLxKd2dK6G+lnQvHGiAbSkLC1a8lGdr9xSoo=;
        b=GVpwEujS0vCHgfIt+C/5tPn4rt11n0kFNQbpx5fEDu42WXooPLQ+w7eoM+os+dnwoo
         +Nn6mrpH9Rdn0djrkU5GXfAwEpSg4m+ll5C5bY5gKHMsfegoo2fbBCjLNiPyysA9UWUD
         PtFyMrqdKhZScXmhkSSn4YH+jJOCnEUTaXRFTlznjoDgP35FcwAKW6nyAiR2aSnw1Y/u
         SDEyvLlxUmbcSGseCamdaOU9wY/DCuD5Bod1zK8sDPPD2MD4pls2dlzwEFEvq66vaYno
         lxf+yahRdMe5Zl671fzMEXzlTV5qMjdRT+tI3sR+cpcocYULWzOwfRYoSFiczM7chB/E
         kpMQ==
X-Gm-Message-State: AOAM532dJm5clTmSMQAlVTeXEd8ap7oOH4dxYG2WrqSJvfF6fsV6JedS
        ijW54Bq/kjJzjmJ3mUZ11B4Eb+x5apujgg==
X-Google-Smtp-Source: ABdhPJyQRw3ly1HjrgANgceo9/zpMs/y2r9pUOkj8tWleeaoyfVsJXodSurbOiSugQJ2Q1jgHymy7g==
X-Received: by 2002:a2e:bc26:: with SMTP id b38mr10172228ljf.497.1629896551014;
        Wed, 25 Aug 2021 06:02:31 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id t69sm238994lff.27.2021.08.25.06.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 06:02:29 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] staging: r8188eu: add error handling of rtw_read8
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kernel test robot <lkp@intel.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
 <202108251911.Vwmzl4rI-lkp@intel.com>
 <9743e1ee-75f4-6231-427b-8c7f659fb252@gmail.com>
 <20210825125159.GU1931@kadam>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <bd50c00e-1814-dc32-36cf-73cf58123201@gmail.com>
Date:   Wed, 25 Aug 2021 16:02:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825125159.GU1931@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 3:51 PM, Dan Carpenter wrote:
> On Wed, Aug 25, 2021 at 03:17:06PM +0300, Pavel Skripkin wrote:
>> On 8/25/21 3:05 PM, kernel test robot wrote:
>> > Hi Pavel,
>> > 
>> > Thank you for the patch! Yet something to improve:
>> > 
>> > [auto build test ERROR on staging/staging-testing]
>> > 
>> > url:    https://github.com/0day-ci/linux/commits/Pavel-Skripkin/staging-r8188eu-remove-read-write-_macreg/20210824-162756
>> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 093991aaadf0fbb34184fa37a46e7a157da3f386
>> > config: arm-buildonly-randconfig-r001-20210825 (attached as .config)
>> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project ea08c4cd1c0869ec5024a8bb3f5cdf06ab03ae83)
>> > reproduce (this is a W=1 build):
>> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>> >          chmod +x ~/bin/make.cross
>> >          # install arm cross compiling tool for clang build
>> >          # apt-get install 11.1.1
>> >          # https://github.com/0day-ci/linux/commit/d4e4bbed4e59df37967086f60fe92cb1b4504d37
>> >          git remote add linux-review https://github.com/0day-ci/linux
>> >          git fetch --no-tags linux-review Pavel-Skripkin/staging-r8188eu-remove-read-write-_macreg/20210824-162756
>> >          git checkout d4e4bbed4e59df37967086f60fe92cb1b4504d37
>> >          # save the attached .config to linux build tree
>> >          mkdir build_dir
>> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/staging/r8188eu/
>> > 
>> > If you fix the issue, kindly add following tag as appropriate
>> > Reported-by: kernel test robot <lkp@intel.com>
>> > 
>> > All errors (new ones prefixed by >>):
>> > 
>> > > > drivers/staging/r8188eu/hal/usb_halinit.c:2022:3: error: expected expression
>> >                     u8 tmp;
>> >                     ^
>> >     1 error generated.
>> > 
>> > Kconfig warnings: (for reference only)
>> >     WARNING: unmet direct dependencies detected for QCOM_SCM
>> >     Depends on (ARM || ARM64) && HAVE_ARM_SMCCC
>> >     Selected by
>> >     - ARM_QCOM_SPM_CPUIDLE && CPU_IDLE && (ARM || ARM64) && (ARCH_QCOM || COMPILE_TEST && !ARM64 && MMU
>> > 
>> > 
>> 
>> We need to fix Kconfig, ok, I will take a look at it later
>> 
> 
> This is not related to your patch.  Ignore it.
> 
> 
>> > vim +2022 drivers/staging/r8188eu/hal/usb_halinit.c
>> > 
>> 
>> >    2020		case HW_VAR_BCN_VALID:
>> >    2021			/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
>> > > 2022				u8 tmp;
>> 
>> Hm, I don't know anything about ARM compilers, so should I wrap this code
>> block with {}?
> 
> Yep.
> 
>> 
>> My local gcc 11.1.1 (x86_64) does not produce any warnings/errors
>> 
> 
> You should figure out whats up with that because it shouldn't compile
> with the gcc options that the kernel uses.
> 

AFAIK, at least 2 guys except me in this CC list compiled my series 
without errors/warnings. Maybe, staging tree is missing some Makefile 
updates?


I'll resend series this evening anyway, but this is strange....



With regards,
Pavel Skripkin
