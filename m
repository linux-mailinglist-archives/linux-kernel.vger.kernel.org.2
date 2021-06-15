Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351C33A789C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhFOH7d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Jun 2021 03:59:33 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:59151 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230460AbhFOH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:59:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UcUgtJN_1623743838;
Received: from smtpclient.apple(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0UcUgtJN_1623743838)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Jun 2021 15:57:18 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [RFC] virtio-mem: virtio_mem_init: Access bb_size just in BBM
 mode
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <7fd8bf39-642d-1cdf-bc5d-c19630045013@redhat.com>
Date:   Tue, 15 Jun 2021 15:57:17 +0800
Cc:     Hui Zhu <teawater@gmail.com>, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E11CAA85-B9A5-4D6F-85C6-505AFEFA9A7E@linux.alibaba.com>
References: <20210615065948.23493-1-teawater@gmail.com>
 <7fd8bf39-642d-1cdf-bc5d-c19630045013@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2021年6月15日 15:43，David Hildenbrand <david@redhat.com> 写道：
> 
> On 15.06.21 08:59, Hui Zhu wrote:
>> From: Hui Zhu <teawaterz@linux.alibaba.com>
>> /* In BBM, we also want at least two big blocks. */
>> vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
>> 			      vm->offline_threshold);
>> This line does not modify vm->offline_threshold depending on the data in
>> vm->sbm that shares this address is 0 in SBM mode.
>> I think it might be difficult to make sure when we change this in the
>> future.
>> This commit adds an if to make sure that this line just be executed in
>> BBM mode.
>> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>> ---
>>  drivers/virtio/virtio_mem.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index 10ec60d..8185916 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -2472,8 +2472,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
>>  	vm->offline_threshold = max_t(uint64_t, 2 * memory_block_size_bytes(),
>>  				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
>>  	/* In BBM, we also want at least two big blocks. */
>> -	vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
>> -				      vm->offline_threshold);
>> +	if (!vm->in_sbm)
>> +		vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
>> +					      vm->offline_threshold);
>>    	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
>>  	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
> 
> Good that you also spotted it, I already have a fix pending for that :)
> 
> https://lkml.kernel.org/r/20210602185720.31821-2-david@redhat.com

Oops!  Please ignore this RFC.

Best,
Hui

> 
> -- 
> Thanks,
> 
> David / dhildenb

