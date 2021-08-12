Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1242E3E9C21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 04:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhHLCIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 22:08:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8400 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHLCIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 22:08:17 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GlVNS1Kwvz86Nx;
        Thu, 12 Aug 2021 10:03:52 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 12 Aug 2021 10:07:48 +0800
Received: from [10.174.176.127] (10.174.176.127) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 12 Aug 2021 10:07:47 +0800
Subject: Re: [PATCH 0/5] block: replace incorrect uses of GENHD_FL_UP
To:     Christoph Hellwig <hch@infradead.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>, <axboe@kernel.dk>,
        <hare@suse.de>, <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <jack@suse.cz>, <osandov@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
 <051ab019-5163-e691-43ed-052401b6b95a@huawei.com>
 <YRNd4O1uV1auj/pK@infradead.org>
From:   luomeng <luomeng12@huawei.com>
Message-ID: <200816d2-4cfe-a26d-88c8-a0cde0b8614b@huawei.com>
Date:   Thu, 12 Aug 2021 10:07:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <YRNd4O1uV1auj/pK@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2021/8/11 13:19, Christoph Hellwig д��:
> On Wed, Aug 11, 2021 at 10:42:20AM +0800, luomeng wrote:
>> Hi:
>>     When the fuzz test injected memory allocation failed, I had this BUG_ON:
>> kernel BUG at fs/sysfs/group.c:116.
>>    The cause of the bug_ON is that the add_disk memory fails to be allocated
>> but no error processing is performed.
>>    I find your patches add error processing. So what is your next step with
>> these patches.
> I have one more pending series on top of this one I need to submit here:
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/alloc_disk
> 
> to make sure the disk always has a valid queue reference.  After that
> Luis work to return an error from add_disk should be much easier bause
> we not have defined state.
> .
Thanks.

So how about this series, when this series will merge into linux master?

And do you submit these patches ( 
http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/alloc_disk) 
on liunx?

Luo Meng
