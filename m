Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197FD3AC697
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhFRI5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:57:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5399 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhFRI5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:57:13 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5t2b4Sf1z713v;
        Fri, 18 Jun 2021 16:51:51 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 16:55:02 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 dggema761-chm.china.huawei.com (10.1.198.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 16:55:02 +0800
Subject: Re: [PATCH v2] mtd: mtd_blkdevs: Initialize
 rq.limits.discard_granularity
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20210615093905.3473709-1-chengzhihao1@huawei.com>
 <20210618095207.0bec4fde@xps13>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <258a2366-0042-dc2b-0589-fe3a99851ded@huawei.com>
Date:   Fri, 18 Jun 2021 16:55:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210618095207.0bec4fde@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/6/18 15:52, Miquel Raynal 写道:
> Hi Zhihao,
> 
> Zhihao Cheng <chengzhihao1@huawei.com> wrote on Tue, 15 Jun 2021
> 17:39:05 +0800:
> 
>> Since commit b35fd7422c2f8("block: check queue's limits.discard_granularity
>> in __blkdev_issue_discard()") checks rq.limits.discard_granularity in
>> __blkdev_issue_discard(), we may get following warnings on formatted ftl:
>>
>>    WARNING: CPU: 2 PID: 7313 at block/blk-lib.c:51
>>    __blkdev_issue_discard+0x2a7/0x390
>>
>> Reproducer:
>>    1. ftl_format /dev/mtd0
>>    2. modprobe ftl
>>    3. mkfs.vfat /dev/ftla
>>    4. mount -odiscard /dev/ftla temp
>>    5. dd if=/dev/zero of=temp/tst bs=1M count=10 oflag=direct
>>    6. dd if=/dev/zero of=temp/tst bs=1M count=10 oflag=direct
>>
>> Fix it by initializing rq.limits.discard_granularity if device supports
>> discard operation.
> 
> Can you please verify that this is still needed after Christoph's
> additional fix:
> https://patchwork.kernel.org/project/xen-devel/patch/20210602065345.355274-10-hch@lst.de/
> 
Hi, Miquel,
I can still reproduce the problem after [1] applied.
I look through this series patches and I didn't find out 
'rq.limits.discard_granularity' has been initialized somewhere. The 
patchset is aming at reconstructing to avoid boilerplate code in drivers?
So 'rq.limits.discard_granularity' still need to be initialized in 
mtdblock driver.

[1] 
https://patchwork.kernel.org/project/xen-devel/patch/20210602065345.355274-10-hch@lst.de/

> 

