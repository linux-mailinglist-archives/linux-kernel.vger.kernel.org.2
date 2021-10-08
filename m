Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89B7426AE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbhJHMhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbhJHMhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:37:00 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F9C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 05:35:04 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id i189so2805712ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 05:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4f6OPaQNUld3iX7UyOBvg+SAumqKW6RB3FzD97GdP8U=;
        b=VeokEPy8MWtJwleIvL/ptjG29znO0KfRtROFAxmEOfHisk13hrmcvWSaHWyozXHyYf
         mNnClGVDc875PffpSKF9vWNaBdrno667JwklIWIhViHcz+fN1SNsO2y/S0Yg0BYrBjN5
         9a/cXAyOyCsYYX0ag+LvbAF0Bu8zJSxlViN7rzPI4tYmwHD804ND8Za0YvZcGoBg76oj
         ODLwbHne2IvkdkpSyQiXW0hT7MzpBGuZjtgN7K4KpHjvTUNT595in2sCHbSpgBJNB9uf
         RLZckL95F5Lvq2GLHQa1zCt8eQg/eWXSeucWLw67qHJJf3lA4IBn5DWh7Xwq2ySl5rDy
         GlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4f6OPaQNUld3iX7UyOBvg+SAumqKW6RB3FzD97GdP8U=;
        b=mJTznDYOEPfGAWY/MnUcNA1JlWFMiBkftYtHXBASevY9hSsAiGxY99SlmASAEagI4U
         lxkCzHk96TnYNZbQQGWSvmOI/eNBHwexdvQV/VyS/k2Sek2bbHhDKpmyGJEWx9+R4I+k
         UesN8JVw5Vr03RqTfp/Y4/E8Ft3ae5Jgwy+EyjDMBXuxKoQ7QgRVcyquaq0zhiTGQYdQ
         KyD0lUxNY/WdADkqLC5OLtJUR3vGZMKSlxy3hTJgmLL4Bw/b0MkCr+a17Gf4UN1C3ASo
         Mzr8+u1xPRVANfw5lhVCtMOmSIoGKaM3Mrb3DXscVZ0/U5xCEokLZz7x8lXP6OFz23Xp
         bWYA==
X-Gm-Message-State: AOAM531lLbS8exnFdX6cQrJcJ3GhgEXlLCmAGQ8blEs0tsx8hlVzRHuP
        WVy+MH5W6hPctffdOZWMJzZMww==
X-Google-Smtp-Source: ABdhPJyJrGQLcVOFBGvofr+v4rWhnngY8MN9mbTREl84ectL2T+p2Br+ZYdoDY52GNUf3h5XG+20ig==
X-Received: by 2002:a05:6602:240d:: with SMTP id s13mr7256250ioa.94.1633696503995;
        Fri, 08 Oct 2021 05:35:03 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n4sm1035273ili.63.2021.10.08.05.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 05:35:03 -0700 (PDT)
Subject: Re: [axboe-block:nvme-passthru-wip 10/19]
 drivers/nvme/host/ioctl.c:47:19: error: cast to pointer from integer of
 different size
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anuj Gupta <anuj20.g@samsung.com>
References: <202110080434.YH6r4WZv-lkp@intel.com>
 <CAMuHMdUoh0PbLDU1_Drce=cQorv6M47i4pLDE9DtSOmsYOD9AQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c2115b49-f0ae-3c38-464b-5f99a572e681@kernel.dk>
Date:   Fri, 8 Oct 2021 06:35:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUoh0PbLDU1_Drce=cQorv6M47i4pLDE9DtSOmsYOD9AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 2:19 AM, Geert Uytterhoeven wrote:
> On Fri, Oct 8, 2021 at 12:12 AM kernel test robot <lkp@intel.com> wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git nvme-passthru-wip
>> head:   9c18980ac90053bcdb21594eae48935d89bf389c
>> commit: 5cc445dd8df6e06f3482711aa590170450364393 [10/19] nvme: wire-up support for async-passthru on char-device.
>> config: m68k-allmodconfig (attached as .config)
>> compiler: m68k-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=5cc445dd8df6e06f3482711aa590170450364393
>>         git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>         git fetch --no-tags axboe-block nvme-passthru-wip
>>         git checkout 5cc445dd8df6e06f3482711aa590170450364393
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=m68k
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers/nvme/host/ioctl.c: In function 'nvme_pt_task_cb':
>>>> drivers/nvme/host/ioctl.c:47:19: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>       47 |         ptcmd64 = (void __user *) bcmd->unused2[0];
>>          |                   ^
>>    drivers/nvme/host/ioctl.c:62:58: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>       62 |                 struct nvme_passthru_cmd __user *ptcmd = (void *)bcmd->unused2[0];
>>          |                                                          ^
>>    drivers/nvme/host/ioctl.c: In function 'nvme_ns_async_ioctl':
>>    drivers/nvme/host/ioctl.c:472:29: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>      472 |         void __user *argp = (void __user *) bcmd->unused2[0];
>>          |                             ^
>>    cc1: all warnings being treated as errors
>>
>>
>> vim +47 drivers/nvme/host/ioctl.c
>>
>>     39
>>     40  static void nvme_pt_task_cb(struct io_uring_cmd *ioucmd)
>>     41  {
>>     42          struct uring_cmd_data *ucd;
>>     43          struct nvme_passthru_cmd64 __user *ptcmd64 = NULL;
>>     44          struct block_uring_cmd *bcmd;
>>     45
>>     46          bcmd = (struct block_uring_cmd *) &ioucmd->pdu;
>>   > 47          ptcmd64 = (void __user *) bcmd->unused2[0];
> 
> Casts from u64 to a pointer on 32-bit need an intermediate cast to uintptr_t:
> 
>     ptcmd64 = (void __user *)(uintptr_t)bcmd->unused2[0];
> 
> Note that you can improve on the naming, as people may be surprised
> discovering "unused2" is actually used ;-)

There's a reason the branch is called -wip, it's just a hodge podge of
stuff. Not sure why the kernel test robot bothers reporting failures
publicly for that...

-- 
Jens Axboe

