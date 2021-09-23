Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EC9416023
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhIWNlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:41:04 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9916 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbhIWNlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:41:02 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HFbkR1TvCz8yjf;
        Thu, 23 Sep 2021 21:34:55 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 21:39:28 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 dggema761-chm.china.huawei.com (10.1.198.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 23 Sep 2021 21:39:27 +0800
Subject: Re: [PATCH] blktrace: Fix uaf in blk_trace access after removing by
 sysfs
To:     Christoph Hellwig <hch@infradead.org>
CC:     <axboe@kernel.dk>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <acme@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>
References: <20210910092120.182270-1-chengzhihao1@huawei.com>
 <YUq9X2dHG+LkMvQ6@infradead.org>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <94c819d1-4c3d-fb8d-c32c-c09c84a6108f@huawei.com>
Date:   Thu, 23 Sep 2021 21:39:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <YUq9X2dHG+LkMvQ6@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/9/22 13:21, Christoph Hellwig 写道:
Hi Christoph,
> On Fri, Sep 10, 2021 at 05:21:20PM +0800, Zhihao Cheng wrote:
>> +		else {
>> +			/*
>> +			 * Don't remove blk_trace under running state, in
>> +			 * case triggering use-after-free in function
>> +			 * __blk_add_trace().
>> +			 */
>> +			if (bt->trace_state != Blktrace_running)
>> +				ret = blk_trace_remove_queue(q);
>> +			else
>> +				ret = -EBUSY;
>> +		}
>>   		goto out_unlock_bdev;
> So who is going to eventually call blk_trace_free in this case?
Agree. How about removing blk_trace from running_list and stopping it 
before calling blk_trace_free()?
>
> Also Having the check in blk_trace_remove_queue would seem a little
> cleaner.
Oh right, will move the check in v2.
