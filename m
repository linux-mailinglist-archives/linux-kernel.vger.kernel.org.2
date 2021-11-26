Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4672F45F2E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbhKZRbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhKZR3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:29:17 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB84EC061D70
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:00:29 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i6so9728394ila.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tQtthRCNnYrfJcVMMnWDbVVhagpc5qS2XN1hQdvDB7I=;
        b=yWHdl+l1h/mRXF3EF3cPuFDiDPXhK4MZqA0f5Yl75S2QiKo1WaTdZBePyIgsY77JwX
         2+W8vBofz6cMKRtnz7QH4ec2Q3ok8ID1EA1U9g0L3+uCi4RPfyIRnHbwMj9ba1WBybAf
         n2MCqc4WZZ39Jb+emMJOP2wWyE81FM5YpVCZu7JGl5JSeGOMEhxIHbBkgIxF7TPCjgGG
         sXOyBnwhSD+9YjVRloTBdVEJEl8rlDc0sWnsv/OE+j07iDiq4Sb34Q3rArwS8s8xkpCe
         6/H0ZF5UgdKqTQ1s/2FvvqjYPGcJEDariQnrnHXS1oyl53Mk7QCfv2H4GPjfGCpBtYA3
         zvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tQtthRCNnYrfJcVMMnWDbVVhagpc5qS2XN1hQdvDB7I=;
        b=lCk+jqdgwj6EzWAOTsw2Rk3vUuBe6N2rfITIgQ/rFTRV8+wrOq9HZcmMPvPHWAhF1H
         5eVZo47ehrcnLgcRL7IfOBt5z5f6KZMADWedi8OcRsIFqO2YADUF6heDYD06Gnplg8c7
         Q0qk6i4ZxDD0i61UFnX1KzeoPI/d4DYU+S96uFZcN9Osx8g4ADLE89NMsjgpwnykHPlm
         Sc7Pn8Y2u8fvpJoDcRM20zh2wmfgxI9qvGT8FPUnjxySnKeMsmyiOJrYh1C3QJj7FUIx
         y8RTEK7izfF9xjCxbh6hqhrBe3qFMROeG/c5SstRoXwdJhYQkx5cMA/WyVboTOeK5X+7
         DzAA==
X-Gm-Message-State: AOAM530R2QbyU8p48MnCu+rIPRmkYoeGdQkzXZmxpGe34L724X5gYThq
        xlPHT8/FXTpXYIDLBeYx6Srydg==
X-Google-Smtp-Source: ABdhPJzLiJVxgsef9VGHmpWZT7frZYjg0y8TnFVgfy3+K1aJ7l4YRfHKMVIv5jPWR/SOjefaOKnXQg==
X-Received: by 2002:a05:6e02:1a47:: with SMTP id u7mr18310859ilv.258.1637946029295;
        Fri, 26 Nov 2021 09:00:29 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b3sm3745498ile.26.2021.11.26.09.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 09:00:28 -0800 (PST)
Subject: Re: drivers/block/zram/zram_drv.c:1824:45: warning: unused variable
 'zram_wb_devops'
To:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <202111261614.gCJMqcyh-lkp@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1761b548-0d05-a5b6-f5c6-8529f8e531a2@kernel.dk>
Date:   Fri, 26 Nov 2021 10:00:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202111261614.gCJMqcyh-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/21 1:54 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a4849f6000e29235a2707f22e39da6b897bb9543
> commit: a8b456d01cd6b37191f14248f3e2bdbe5ce3a89e bdi: remove BDI_CAP_SYNCHRONOUS_IO
> date:   1 year, 2 months ago
> config: x86_64-buildonly-randconfig-r003-20211116 (https://download.01.org/0day-ci/archive/20211126/202111261614.gCJMqcyh-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project fbe72e41b99dc7994daac300d208a955be3e4a0a)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a8b456d01cd6b37191f14248f3e2bdbe5ce3a89e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a8b456d01cd6b37191f14248f3e2bdbe5ce3a89e
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/block/zram/zram_drv.c:1824:45: warning: unused variable 'zram_wb_devops' [-Wunused-const-variable]
>    static const struct block_device_operations zram_wb_devops = {
>                                                ^
>    1 warning generated.

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.16&id=d422f40163087408b56290156ba233fc5ada53e4

-- 
Jens Axboe

