Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F15452F10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhKPKaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:30:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234106AbhKPK37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637058422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zzfJFFs1yOAsVs8rA5VCSt3swVTOoJ3a9p/d2W4NYtA=;
        b=BdhkZOFmqdYUhvSqyI/e7yQJnM0RmLgFofqHQTqEi1CXqQ88h45fvyuHC5qk9kWmK6SPEM
        0Z2g/mgejyYeTz4gQHxHPeNQnLQIO57ZyWo1bAUP9Tv2ZXaHS7Cr74iHwXA9LO6Qal+Cec
        jQ5gOnCvKlRxt+7JDs6o/ymyue1BQt4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-QjMrVoJIMmKIS_A6x9-JCg-1; Tue, 16 Nov 2021 05:26:51 -0500
X-MC-Unique: QjMrVoJIMmKIS_A6x9-JCg-1
Received: by mail-ed1-f71.google.com with SMTP id i19-20020a05640242d300b003e7d13ebeedso4267576edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zzfJFFs1yOAsVs8rA5VCSt3swVTOoJ3a9p/d2W4NYtA=;
        b=nPE9xy9m9kJNlRqv7tZn3dQZ1Ly0FIamAuVywCKnOKd0itnsC7VuisBF7tMoRBMC/L
         iUQjEFQf5wxitOvgwkzKC/9hWQJwV3JWA674Z9Z6EM1/Psv0jUVKq/G5DUBKO6YPiJhj
         iHfFQPhgBXMCqB2GGM+aBQ06CZnmlxxBB4RKnGJ6K1vCZJCQjfbclg5n4lU2uMAK/IKR
         YLNuQuCN4d0sOB0BvfNDlbSx7cq8DarltQr2ulbW8OIuQKXm4bS9Nxp8SZt35Iv5Rko7
         KYUzmREVPujL8f+xe0P4YbgZ7CPKPWBqGxgjr3WF/E+UICLEzfiHSBMDuT2w7WpGIkzW
         9wmg==
X-Gm-Message-State: AOAM5305QnwmWP8n6jU5+xUeCzAjApSa3KwHVOO2kr6xrnPExev844ZY
        dNolcMQBcw3pA9R0gTyeVcRG99rhd+CJsylO5Hs1KB1x+PFQQ2G6goDS7wT16eYdXVTDSCXevHV
        RsrVYJXobGB4Hrf27Aluaw9nx
X-Received: by 2002:a05:6402:2753:: with SMTP id z19mr8678686edd.143.1637058409880;
        Tue, 16 Nov 2021 02:26:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJze7G27h6q4hHPzijH2DQOjmRBhIvl8m2KOckBL3/bxl/7qDqMgG0oYB+v+0OuZPnwC8PE2gA==
X-Received: by 2002:a05:6402:2753:: with SMTP id z19mr8678666edd.143.1637058409713;
        Tue, 16 Nov 2021 02:26:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id hv17sm8177026ejc.66.2021.11.16.02.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:26:49 -0800 (PST)
Message-ID: <009706db-230a-1e49-0a42-447a0ff97fbb@redhat.com>
Date:   Tue, 16 Nov 2021 11:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: drivers/platform/x86/thinkpad_acpi.c:4475:35: error: unused
 variable 'fwbug_cards_ids'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <202111141153.mtggZgGq-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202111141153.mtggZgGq-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/14/21 04:10, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c8c109546a19613d323a319d0c921cb1f317e629
> commit: fd96e35ea7b95f1e216277805be89d66e4ae962d platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning
> date:   4 weeks ago
> config: i386-buildonly-randconfig-r005-20211114 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c3dddeeafb529e769cde87bd29ef6271ac6bfa5c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fd96e35ea7b95f1e216277805be89d66e4ae962d
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout fd96e35ea7b95f1e216277805be89d66e4ae962d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/platform/x86/thinkpad_acpi.c:4475:35: error: unused variable 'fwbug_cards_ids' [-Werror,-Wunused-const-variable]
>    static const struct pci_device_id fwbug_cards_ids[] __initconst = {
>                                      ^
>    1 error generated.

So this *again* has absolutely nothing to do with the:

"platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning"

commit, the problem is that:

1. the .config does not have CONFIG_PCI set; combined with:
2. include/pci.h using a #define instead of a
   static inline for pci_dev_present() when this is the case
3. This is a clang WERROR build

I'll submit a fix for 2. upstream which should also fix
similar errors in a lot of other drivers.

Again I must say that as a maintainer I'm unhappy about the amount
of noise being generated by clang WERROR builds here though,
is it really necessary for the kernel test robot to do builds
of this type ?

Regards,

Hans


> 
> 
> vim +/fwbug_cards_ids +4475 drivers/platform/x86/thinkpad_acpi.c
> 
> f7db839fccf087 Jiaxun Yang 2019-03-07  4474  
> f7db839fccf087 Jiaxun Yang 2019-03-07 @4475  static const struct pci_device_id fwbug_cards_ids[] __initconst = {
> f7db839fccf087 Jiaxun Yang 2019-03-07  4476  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x24F3) },
> f7db839fccf087 Jiaxun Yang 2019-03-07  4477  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x24FD) },
> f7db839fccf087 Jiaxun Yang 2019-03-07  4478  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2526) },
> f7db839fccf087 Jiaxun Yang 2019-03-07  4479  	{}
> f7db839fccf087 Jiaxun Yang 2019-03-07  4480  };
> f7db839fccf087 Jiaxun Yang 2019-03-07  4481  
> f7db839fccf087 Jiaxun Yang 2019-03-07  4482  
> 
> :::::: The code at line 4475 was first introduced by commit
> :::::: f7db839fccf087664e5587966220821289b6a9cb platform/x86: thinkpad_acpi: Disable Bluetooth for some machines
> 
> :::::: TO: Jiaxun Yang <jiaxun.yang@flygoat.com>
> :::::: CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

