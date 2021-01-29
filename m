Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A20308312
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhA2BOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:14:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11470 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhA2BOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:14:11 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DRfT64SfszjCt2;
        Fri, 29 Jan 2021 09:12:26 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 29 Jan
 2021 09:13:25 +0800
Subject: Re: [f2fs-dev] [PATCH v3 1/5] f2fs: compress: add compress_inode to
 cache compressed blocks
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Chao Yu <chao@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <abc09f9f-561d-df8a-b835-6b5d7a15232c@huawei.com>
 <X/8UtJU9Dy30kC7I@google.com>
 <37ba41db-2589-e155-c416-d0c8832026cb@huawei.com>
 <X//DPI10+ZXvHkYH@google.com>
 <8e88b1e2-0176-9487-b925-9c7a31a7e5cd@huawei.com>
 <YAGt0i244dWXym4H@google.com>
 <20a1dbd3-808e-e62a-53f3-7f1e2a316b3c@kernel.org>
 <YAdSTzYF8Hvxdcqy@google.com>
 <068da0d3-18c9-53f7-0f24-63b07e1af272@huawei.com>
 <9b982458-57e1-a04d-c5d4-f5ca775af1e7@huawei.com>
 <YBLifNK5EXedfhbs@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <eb25281b-a40e-8965-cdf5-b7c461fbe195@huawei.com>
Date:   Fri, 29 Jan 2021 09:13:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YBLifNK5EXedfhbs@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/29 0:12, Jaegeuk Kim wrote:
> On 01/28, Chao Yu wrote:
>> On 2021/1/22 10:17, Chao Yu wrote:
>>>> No, it seems this is not the case.
>>> Oops, could you please help to remove all below codes and do the test again
>>> to check whether they are the buggy codes? as I doubt there is use-after-free
>>> bug.
>>
>> Any test result? :)
> 
> It seems I don't see the errors anymore. Will you post another version?

No, your test result only indicate that bug was caused by race condition
of that line with high possibility, however I've no idea how that happen
after several round code review. Still struggling in troubleshooting this
issue.

Thanks,

> 
>>
>> Thanks,
> .
> 
