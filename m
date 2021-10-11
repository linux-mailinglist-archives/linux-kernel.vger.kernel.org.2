Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED72428C67
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhJKL6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbhJKL6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:58:23 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EBBC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 04:56:23 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i11so16797570ila.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZEugahXpo5w1DzOsb6wG+kq/vzEbN2oMh+u7Yf1mJkw=;
        b=1PI1J/co13ikw9zUNEp4W17we3SyYOEgmqXA3wg7ydaY2KV5QnLNpryMrR0fiXyM+u
         0TIPxRqPyWebI2BSEggcgoXcl/cV0N+iIZzcK1QI/BZMMPTrM4OsMsKdeILtiQYOqn62
         1dh+lmNFvS/lEVzRASL0BaLN6GQ5OraVMW7zzr1SjVbQB/oBjhbysSzSxFoWxUxGFwTe
         MjZhYWYC/2YN4IOUAiHtL/pQPpy9HAovXAXDNj/ky4NkbV5j3b3VHSKuFNT5cUNx001L
         RgzA1jRCWmdY7nLh9FkyajX6lEiHPUJqv8CEwMvAOC45n9j5ahjs+3ePCbwQjS029Pqg
         an2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZEugahXpo5w1DzOsb6wG+kq/vzEbN2oMh+u7Yf1mJkw=;
        b=QoQooZuDq+DK8tCDii9FkfnJWfIFOuGxEICuNat1OjSoTquWPCG1GUFR/sHTpY/mzU
         MNNHZRa8lgfQdzroDeYeP3ZXe6O7OLHRJFlLCvant0Oc9dJ6nyc8MN7rPSKpF3kPl9Dr
         guzpsOqjY1EHaqVOVwbGp+qemD2TQKCnmzOfjqxyoU6Jn0EOoXIXq7BhpZMYz49mze5/
         DWqDM545e6Gi1N91pLCZUMtw640YNNvMVa24AHhZGTRpHnG/K9+G5dnM/HSFvuC8O2Gb
         6xKWL2fkMym7yNNbYCBYGYPXbiJ6apTy+oWuiAhke8AyCEQX4JJ14VBAW3jMQrOx8eNJ
         G2kQ==
X-Gm-Message-State: AOAM531Xuc7w/woyBuEvHsfNM+Hbff1aKOYGE9tPivHMwEnsr0gBYuSH
        MGsu8yIIY42NIEO9kch23pNQ8GQQeX/agA==
X-Google-Smtp-Source: ABdhPJz3t23d0NC6vUAuZK4EODkd0UFNUMCVeeuGbOKq8wuHpGN1osCI8PTUYCJnL8MigKalK13jFw==
X-Received: by 2002:a92:1a43:: with SMTP id z3mr19162689ill.46.1633953382554;
        Mon, 11 Oct 2021 04:56:22 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id e9sm3909969iob.52.2021.10.11.04.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 04:56:22 -0700 (PDT)
Subject: Re: [axboe-block:perf-wip 13/20]
 drivers/block/rnbd/rnbd-clt.c:1226:27: error: initialization of 'int
 (*)(struct blk_mq_hw_ctx *, struct io_batch *)' from incompatible pointer
 type 'int (*)(struct blk_mq_hw_ctx *)'
To:     Gioh Kim <gi-oh.kim@ionos.com>, Jinpu Wang <jinpu.wang@ionos.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <202110082349.Bb8M3OPU-lkp@intel.com>
 <CAJX1YtbZTNn8Y3zLnBvnBNX_1b14Y-RDnJovcHtGmLhiPV2xxw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d863deb3-64fd-16b7-e626-711262269c0b@kernel.dk>
Date:   Mon, 11 Oct 2021 05:56:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJX1YtbZTNn8Y3zLnBvnBNX_1b14Y-RDnJovcHtGmLhiPV2xxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 2:58 AM, Gioh Kim wrote:
> On Fri, Oct 8, 2021 at 5:14 PM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git perf-wip
>> head:   ba7751cd7411b7aaffd07728bd7cd6eeb890865d
>> commit: c5b891d342f43c8e486be3aeacd5ee61298d3561 [13/20] block: add a struct io_batch argument to fops->iopoll()
>> config: h8300-randconfig-r004-20211008 (attached as .config)
>> compiler: h8300-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=c5b891d342f43c8e486be3aeacd5ee61298d3561
>>         git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>         git fetch --no-tags axboe-block perf-wip
>>         git checkout c5b891d342f43c8e486be3aeacd5ee61298d3561
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=h8300
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> drivers/block/rnbd/rnbd-clt.c:1226:27: error: initialization of 'int (*)(struct blk_mq_hw_ctx *, struct io_batch *)' from incompatible pointer type 'int (*)(struct blk_mq_hw_ctx *)' [-Werror=incompatible-pointer-types]
>>     1226 |         .poll           = rnbd_rdma_poll,
>>          |                           ^~~~~~~~~~~~~~
>>    drivers/block/rnbd/rnbd-clt.c:1226:27: note: (near initialization for 'rnbd_mq_ops.poll')
>>    cc1: some warnings being treated as errors
>> --
>>>> drivers/nvme/host/tcp.c:2457:27: error: initialization of 'int (*)(struct blk_mq_hw_ctx *, struct io_batch *)' from incompatible pointer type 'int (*)(struct blk_mq_hw_ctx *)' [-Werror=incompatible-pointer-types]
>>     2457 |         .poll           = nvme_tcp_poll,
>>          |                           ^~~~~~~~~~~~~
>>    drivers/nvme/host/tcp.c:2457:27: note: (near initialization for 'nvme_tcp_mq_ops.poll')
>>    cc1: some warnings being treated as errors
>>
>>
>> vim +1226 drivers/block/rnbd/rnbd-clt.c
>>
>> 2958a995edc946 Gioh Kim  2021-04-19  1221
>> f7a7a5c228d45e Jack Wang 2020-05-11  1222  static struct blk_mq_ops rnbd_mq_ops = {
>> f7a7a5c228d45e Jack Wang 2020-05-11  1223       .queue_rq       = rnbd_queue_rq,
>> f7a7a5c228d45e Jack Wang 2020-05-11  1224       .complete       = rnbd_softirq_done_fn,
>> 2958a995edc946 Gioh Kim  2021-04-19  1225       .map_queues     = rnbd_rdma_map_queues,
>> 2958a995edc946 Gioh Kim  2021-04-19 @1226       .poll           = rnbd_rdma_poll,
>> f7a7a5c228d45e Jack Wang 2020-05-11  1227  };
>> f7a7a5c228d45e Jack Wang 2020-05-11  1228
>>
>> :::::: The code at line 1226 was first introduced by commit
>> :::::: 2958a995edc94654df690318df7b9b49e5a3ef88 block/rnbd-clt: Support polling mode for IO latency optimization
>>
>> :::::: TO: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>> :::::: CC: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> Hi Jens,
> 
> Regarding the warning email from the Kernel test robot as above,
> you might be able to fix it with the patch below.

I just missed this one originally, it's been fixed for a while in the
current tree.

-- 
Jens Axboe

