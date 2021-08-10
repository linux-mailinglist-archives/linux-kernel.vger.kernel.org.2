Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0514F3E3D6A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhHIBLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:11:32 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13298 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhHIBL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:11:28 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GjdFH25Hwz84D3;
        Mon,  9 Aug 2021 09:06:11 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 09:11:07 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 9 Aug 2021 09:11:05 +0800
Subject: Re: [PATCH 1/2] blk-mq: add two interfaces to lock/unlock
 blk_mq_tags->lock
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <josef@toxicpanda.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yi.zhang@huawei.com>
References: <20210808031752.579882-1-yukuai3@huawei.com>
 <20210808031752.579882-2-yukuai3@huawei.com>
 <1e6b1a1e-eb45-f6c7-a8ce-e534b8cda710@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <115d97bf-8c7f-44e5-7665-9f7f2c8c3c2b@huawei.com>
Date:   Mon, 9 Aug 2021 09:11:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1e6b1a1e-eb45-f6c7-a8ce-e534b8cda710@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/08/09 0:44, Bart Van Assche wrote:
> On 8/7/21 8:17 PM, Yu Kuai wrote:
>> +void blk_mq_tags_lock(struct blk_mq_tags *tags, unsigned long *flags)
>> +{
>> +	spin_lock_irqsave(&tags->lock, *flags);
>> +}
>> +EXPORT_SYMBOL(blk_mq_tags_lock);
>> +
>> +void blk_mq_tags_unlock(struct blk_mq_tags *tags, unsigned long *flags)
>> +{
>> +	spin_unlock_irqrestore(&tags->lock, *flags);
>> +}
>> +EXPORT_SYMBOL(blk_mq_tags_unlock);
> 
> The tag map lock is an implementation detail and hence this lock must
> not be used directly by block drivers. I propose to introduce and export
> a new function to block drivers that does the following:
> * Lock tags->lock.
> * Call blk_mq_tag_to_rq().
> * Check whether the request is in the started state. If so, increment
> its reference count.
> * Unlock tags->lock.

Hi, Bart

Thanks for your advice, will do this in next iteration.

Best regards
Kuai

