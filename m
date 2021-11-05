Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD4F4465D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhKEPfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhKEPf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:35:29 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD6EC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 08:32:49 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so13614649ott.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YVIRwV+dgobH2/mqNGsVU9B7mFmuEmWkRfrXtFWjzSE=;
        b=pbPivp5GfZ0EdYWIcqB7KGG0uxElz6lrN2v9fvMmXxJi02OEyaKGTbIRh5VyzIU/jz
         BmH+HTI5kwYPD/nNolIFVTnYLonwRjvT5M+6qTpKMPJq+/z0shW4Tbt8fGHsnBnk9oHz
         xOXvWHwQzDXqPAfx9vGOhhbPi77O9OuDC+YPYC9Mz0Yf3uHveFtGURduP6lW+igub2yH
         JrY1nBdDZs7dIiKmm9ZmXZzTxtl2Q0zQFutAULIdhl10kfwl1fmFT3omBFao4QkjNpow
         UHDRYZE0ydHHlOem33odG6L1s+8ul04Q+F1J9q29fV05FHRKzKrR2MB3kZvKs6QbHeyC
         IJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YVIRwV+dgobH2/mqNGsVU9B7mFmuEmWkRfrXtFWjzSE=;
        b=PNIQQ6N45rttfE4INZVmDuCJRG+PuSbtlhVMbnHR+28WzGmNZdDAoqlQJw5s887yqT
         dRlYhBS+ZqFGyZY5ow0JOX3FU6nj7+qYhc9/5HLoG0w5h4f//3r7Sgaaxv3Lk/V7Kvxu
         6gj/lhlUSAeVU20+NldAzvw5OxlC+uxPT3fmQRPHbwfy4fGsoMBuFtEjCXkctO3BoHG9
         MwQJmluGPpTW0Km8W5WGF4BsqWVIhcSVHrSU3+Z+Te52k0a14oT9tw10Y5uRuZRr6AhN
         QhMTu7x8Bvp/WLkZ396KIGBhSf11pqyAlhBOhwwN19JQy05cp8HCnM2BZrMGzctsaPte
         IK2Q==
X-Gm-Message-State: AOAM531QU+r0+3Qm4EyWBRNON+4KpVA4A0GL2HBixoeLGhD4xF5jw+uY
        h47NM28LbrarxXxToz4e9sCtdJnAQhDVBw==
X-Google-Smtp-Source: ABdhPJzMPijy24hHwxpFXbr/w6x76FBlr110KhkHAuAgG5oo/PhIMJ5XU0Wow7PMQKjC0vLZxBXBFQ==
X-Received: by 2002:a9d:76d1:: with SMTP id p17mr35000577otl.328.1636126368945;
        Fri, 05 Nov 2021 08:32:48 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g15sm2642061oiy.8.2021.11.05.08.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 08:32:48 -0700 (PDT)
Subject: Re: fs/io_uring.c:10086:24: warning: Value stored to 'sqe' during its
 initialization is never read [clang-analyzer-deadcode.DeadStores]
To:     kernel test robot <yujie.liu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202111051137.alSoelJV-lkp@intel.com>
 <dc06f6d0-b7d1-c6cf-bb3a-569af600e9e5@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4582de8b-962c-1173-88bb-a18b3753876c@kernel.dk>
Date:   Fri, 5 Nov 2021 09:32:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dc06f6d0-b7d1-c6cf-bb3a-569af600e9e5@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 12:42 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
> commit: f75d118349be055d47407b4ba4ceb98e6437e472 io_uring: harder fdinfo sq/cq ring iterating
> date:   7 days ago
> config: arm-randconfig-c002-20211031 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 82ed106567063ea269c6d5669278b733e173a42f)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install arm cross compiling tool for clang build
>          # apt-get install binutils-arm-linux-gnueabi
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f75d118349be055d47407b4ba4ceb98e6437e472
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout f75d118349be055d47407b4ba4ceb98e6437e472
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> clang-analyzer warnings: (new ones prefixed by >>)
> 
>  >> fs/io_uring.c:10086:24: warning: Value stored to 'sqe' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
>                     struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
>                                          ^~~   ~~~~~~~~~~~~~~~~~~~~~

Thanks, now fixed:

https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.16&id=a19577808fd33d9e64e015808fbca2769a96721b

-- 
Jens Axboe

