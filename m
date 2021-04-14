Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7E35F77C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351878AbhDNPSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:18:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41331 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350422AbhDNPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:18:04 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWhGw-0002im-KX
        for linux-kernel@vger.kernel.org; Wed, 14 Apr 2021 15:17:42 +0000
Received: by mail-ej1-f70.google.com with SMTP id l25so538173ejr.16
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kfcPhmhTdK2FMhaZokOecDc4Tx+X+Ot5TvToWRx2lBk=;
        b=XYRoi+F59+88LEm8+ux2sAhL48H5pFVi3PH0prnb5EwplSfDK10OwhXpjJ71ODQuDV
         ABDfLleH1yi3QUTaFIiFIJ9tq3RNp9tQ8z6ot+NA2KB4nuXWsfS+J0Y5bnRhLYIYFWtP
         28kkIybvs5ilgELJ16QRaSN+9HNsd3i48LDpWgj9XwfcNNOOmZ0ovq9/m/aEIky6IFsg
         KKUg+JLiSq3qJsRQWksb/VMQTZUFv5BgMvV2WXfAVddDy4RHuYh7Xo0pqWV9alJC0Sn7
         BF2vDgSerVXCPWSqGiEX2WqAMHzN4dA9FZBF6YGwbaF+cmJS57bIdFx9T6lHgDu2qo5R
         ou6A==
X-Gm-Message-State: AOAM533YdNUaSNtriG2+cWjsZ2V9nOSmglgpqbddA3IaZJj3tUveVOxe
        p6oCXMTcKKPwElUTQx1Zq6TzHgpn1i5TvIZHEC6EBmtf/w2oQwredLJ6Gj4bZbJrNlDohsEb122
        2BsWBAP6Zwx8b/UONW1cpDKCBFbRaWqWDTf4mhfsBXQ==
X-Received: by 2002:a17:906:c7ca:: with SMTP id dc10mr18984214ejb.294.1618413462003;
        Wed, 14 Apr 2021 08:17:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJww4LZWkop8/QH04cQnq21mbuppuNTF7N1mSZTl9IH3GDtIqGlSU0aYkEzPKTWpEM0YEVziJA==
X-Received: by 2002:a17:906:c7ca:: with SMTP id dc10mr18984195ejb.294.1618413461861;
        Wed, 14 Apr 2021 08:17:41 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id p3sm6376513ejd.65.2021.04.14.08.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:17:41 -0700 (PDT)
Subject: Re: drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:306:26:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
References: <202104140604.hH9CHHBR-lkp@intel.com>
 <CAHp75VdRNGNscyONgVsMqw9F_DQ_noK5dE4d8mexq=4t_2xTXg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <36cae99e-6a23-ab6f-62a7-5fca4ffc040d@canonical.com>
Date:   Wed, 14 Apr 2021 17:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VdRNGNscyONgVsMqw9F_DQ_noK5dE4d8mexq=4t_2xTXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2021 16:53, Andy Shevchenko wrote:
> On Wed, Apr 14, 2021 at 10:21 AM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   eebe426d32e1a10ac7c35f8ffab5f818c32a2454
>> commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
>> date:   8 months ago
>> config: alpha-randconfig-s032-20210414 (attached as .config)
>> compiler: alpha-linux-gcc (GCC) 9.3.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # apt-get install sparse
>>         # sparse version: v0.6.3-280-g2cd6d34e-dirty
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f28ca6bd8211214faf717677bbffe375c2a6072
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout 8f28ca6bd8211214faf717677bbffe375c2a6072
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> I believe after my patch series [1] at least part of this will be
> gone. Can you confirm?

Have in mind that the warnings were there since beginning. My patch only
changed the warning contents (-> const) thus robot sees it as a new issue.

> [1]: https://lore.kernel.org/netdev/20210325173412.82911-1-andriy.shevchenko@linux.intel.com/T/#u

You convert the reg to "iomem", so it seems that yes, your series should
fix it.


Best regards,
Krzysztof
