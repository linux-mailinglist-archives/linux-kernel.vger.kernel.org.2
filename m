Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DFE345FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhCWNko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhCWNkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:40:25 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C55C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:40:24 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id t14so8307992ilu.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BDLBUMGQcuT53tWnulg5VAGeYmglp65rO3igDVXqL/w=;
        b=0lT3wqbStCK6jiefxOJVIyibb/NPyQflxMsYqisUbyRwgNg5NPJYkuOinMndivCL+E
         hlOp8bKDGG0h3YmSGlX7y7Z2C223cdgXNCGbfHTq9Fek3lTvhnJ2KzZTXsl5cVTV+DaJ
         YQvJmsF6PqE+E6b5t+LFN2COHPXk5STrCetiEAWVsVNwChOdNyhfEMG/HgTR/ykrsLpI
         kcMI2zH2czrQILPIeouo42qupAHiiD9jDCtPN5Oi1gzF7tfLiIeHr5zEYmDtxX7sIV6z
         6NO1qzyZIeuDm3dsi20iv54nQuWbBWI1auS1Sd/ED6mCa8sQtslCU6CdoI0tk1OAnkOB
         ryuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BDLBUMGQcuT53tWnulg5VAGeYmglp65rO3igDVXqL/w=;
        b=VGWGAuUFfOpeuQ4+vfqRdPyifvmLr6zp9adUOSREAAjHV0/x3VzLH3WtyGP87gLIKd
         /tjZP7lBsaIHTRRbmZcg+WwzwAe8YgxPcLzv9KVjASbzDLkqj/BvxQVf55Wj31rl/qkZ
         3aTkXDVLgTrI/xCN23JZkt6zRNI63j3fBYHF4zZckNr8aocyFT/WOczJm9lIaSmyzE2P
         9q9u1VbndKZDqBiDVT5yDVmcqsiSNRfG2E7SxjhVk5Jgg94NHUNRuCY+z/MKw+zoUhQS
         /C1SucYbFUmZKNqb+Ua3tVSQfc84saRVizURtEa7GakM4b8aTyQfmd5JfoFJZOG9ZJLb
         QptA==
X-Gm-Message-State: AOAM531jiJYZ+CNNmZxGJD03RVCngvE0Hy34AaAy0HGCshp7SGnLqxyt
        OHx7KZ1A1UcmspSRfPqSHftWP+pDwZvfNw==
X-Google-Smtp-Source: ABdhPJw3WzvJtrMjKRSMf/RiutrnZAtWPICrWQLCCYLzy/BkOlKzhB5ZJobqUe6JJ5QaMKJyLgWA4A==
X-Received: by 2002:a92:194b:: with SMTP id e11mr4884099ilm.184.1616506824042;
        Tue, 23 Mar 2021 06:40:24 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 23sm9481779iog.45.2021.03.23.06.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 06:40:23 -0700 (PDT)
Subject: Re: fs/io_uring.c:6920:12: warning: stack frame size of 1040 bytes in
 function 'io_submit_sqes'
To:     Pavel Begunkov <asml.silence@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <202103231939.qtWh2L33-lkp@intel.com>
 <a8a053dd-5ba1-5c03-8915-f84c7938adf9@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <741263a9-2c59-c503-8fe3-0f80351890c5@kernel.dk>
Date:   Tue, 23 Mar 2021 07:40:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a8a053dd-5ba1-5c03-8915-f84c7938adf9@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 6:51 AM, Pavel Begunkov wrote:
> On 23/03/2021 11:31, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   84196390620ac0e5070ae36af84c137c6216a7dc
>> commit: e5d1bc0a91f16959aa279aa3ee9fdc246d4bb382 io_uring: defer flushing cached reqs
>> date:   6 weeks ago
>> config: powerpc64-randconfig-r023-20210323 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 14696baaf4c43fe53f738bc292bbe169eed93d5d)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install powerpc64 cross compiling tool for clang build
>>         # apt-get install binutils-powerpc64-linux-gnu
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5d1bc0a91f16959aa279aa3ee9fdc246d4bb382
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout e5d1bc0a91f16959aa279aa3ee9fdc246d4bb382
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> fs/io_uring.c:6920:12: warning: stack frame size of 1040 bytes in function 'io_submit_sqes' [-Wframe-larger-than=]
>>    static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr)
>>               ^
>>    1 warning generated. b
> 
> I don't know, for up-to-date code all submission functions are under
> 128 bytes for me, including io_submit_sqes with everything heavily
> inlined into it. I believe it's just a strange config keeping
> everything on stack for some reason (too under optimised?).

Must be the powerpc compiler doing something weird, it's probably
inlining io_submit_sqe() and all opcode handlers. And then you get
there pretty quick, eg io_recvmsg() uses 768 bytes of stack here.

-- 
Jens Axboe

