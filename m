Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6033E8817
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhHKCnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:43:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8396 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhHKCm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:42:57 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GkvC03dnTz85nV;
        Wed, 11 Aug 2021 10:38:36 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 10:42:21 +0800
Received: from [10.174.176.127] (10.174.176.127) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 10:42:21 +0800
Subject: Re: [PATCH 0/5] block: replace incorrect uses of GENHD_FL_UP
To:     Luis Chamberlain <mcgrof@kernel.org>, <axboe@kernel.dk>
CC:     <hare@suse.de>, <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <hch@infradead.org>, <jack@suse.cz>, <osandov@fb.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
From:   luomeng <luomeng12@huawei.com>
Message-ID: <051ab019-5163-e691-43ed-052401b6b95a@huawei.com>
Date:   Wed, 11 Aug 2021 10:42:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20210720182048.1906526-1-mcgrof@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.127]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
    When the fuzz test injected memory allocation failed, I had this 
BUG_ON: kernel BUG at fs/sysfs/group.c:116.
   The cause of the bug_ON is that the add_disk memory fails to be 
allocated but no error processing is performed.
   I find your patches add error processing. So what is your next step 
with these patches.
Thanks.

Luo Meng

�� 2021/7/21 2:20, Luis Chamberlain д��:
> I've bumped this from RFC to PATCH form as request by Christoph,
> as it seems to line up with what he wants to do. As per Hannes
> I also stuck to one form of naming, so went with blk_disk_added()
> instead of blk_disk_registered() and used that instead of open
> coding the flag check.
> 
> This is rebased onto next-20210720 and I've made the patch series
> independent of my *add_disk*() error handling series. This goes
> compile and boot tested.
> 
> Luis Chamberlain (5):
>    block: add flag for add_disk() completion notation
>    md: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED on is_mddev_broken()
>    mmc/core/block: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
>    nvme: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
>    fs/block_dev: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
> 
>   block/genhd.c                 |  8 ++++++++
>   drivers/md/md.h               |  4 +---
>   drivers/mmc/core/block.c      |  2 +-
>   drivers/nvme/host/core.c      |  4 ++--
>   drivers/nvme/host/multipath.c |  2 +-
>   fs/block_dev.c                |  5 +++--
>   include/linux/genhd.h         | 11 ++++++++++-
>   7 files changed, 26 insertions(+), 10 deletions(-)
> 
