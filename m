Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FF632044B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 08:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBTHD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 02:03:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12984 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhBTHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 02:03:45 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DjK9k2V7BzjQLY;
        Sat, 20 Feb 2021 15:01:30 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Feb 2021 15:02:54 +0800
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Scott Branden <scott.branden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        PEIXIN HOU <PEIXIN.HOU@huawei.com>,
        Yanjin <yanjin.yan@huawei.com>,
        "Zhangdianfang (Dianfang, OS Lab)" <zhangdianfang@huawei.com>,
        Zhaohongjiang <zhaohongjiang@huawei.com>,
        Huxinwei <huxinwei@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <595affb4-36e8-0a63-ebb3-a4fd0e3c243a@huawei.com>
 <YC+AEcuXhPXXtmRB@kroah.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <a0e56fe4-8e85-d8c7-ed63-7a96c0944aaf@huawei.com>
Date:   Sat, 20 Feb 2021 15:02:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YC+AEcuXhPXXtmRB@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/19 17:08, Greg Kroah-Hartman wrote:
> On Fri, Feb 19, 2021 at 04:54:24PM +0800, Hanjun Guo wrote:
>> Hi Greg,
>>
>> On 2021/1/26 15:29, Greg Kroah-Hartman wrote:
>> [...]
>>>
>>> I want to see companies _using_ the kernel, and most importantly,
>>> _updating_ their devices with it, to know if it is worth to keep around
>>> for longer than 2 years.  I also, hopefully, want to see how those
>>> companies will help me out in the testing and maintenance of that kernel
>>> version in order to make supporting it for 6 years actually possible.
>>>
>>> So, are you planning on using 5.10?  Will you will be willing to help
>>> out in testing the -rc releases I make to let me know if there are any
>>> problems, and to help in pointing out and backporting any specific
>>> patches that your platforms need for that kernel release?
>>
>> We(Huawei) are willing to commit resources to help out in testing the
>> stable -rc releases, and to help to backport patches for stable kernels.
> 
> Wonderful!
> 
>> 5.10 stable kernel will be used for openEuler [1] kernel and also inside
>> Huawei. From customer's feedback, it's very important to see the stable
>> kernel we used to be maintained for 6 years in the community, and we
>> will use 5.10 kernel for at least 6 years, so we are willing to help
>> you and help ourselves :)
>>
>> In specific, we will start from the testing work, using HULK robot
>> (reports lots of bugs to mainline kernel) testing framework to test
>> compile, reboot, functional testing, and will extend to basic
>> performance regression testing in the future.
> 
> Great!  Do you all need an email notification when the -rc releases come
> out for the stable trees, or can you trigger off of the -rc stable git
> tree?  Different CI systems work in different ways :)

We can trigger the test when you updated the -rc stable git tree,
by monitoring new commits for the stable branches. So if you push
all the commits at once for -rc stable branches, then our CI system
can work well.

> 
> And if you can reply to the -rc release emails with a "Tested-by:" tag,
> I will be glad to add that to the release commit when that happens to
> show that you all have tested the release.

Thanks, will reply "Tested-by:" with -rc releases. We are working on
setting up the test farm and will report the test results in a week.

> 
>> And we will start from ARM64 and X86 architecture first, and then extend
>> to other platforms.
> 
> That's a good start, the useful ones :)
> 
>> For patch backporting, will send the bugfix patches (from mainline)
>> we spotted, but I think this work may not doing in regular but will
>> be triggered as needed.
> 
> That's fine, it is not something that happens at a regular interval.
> 
>> Does this sound good to you?
> 
> Yes it does, thank you so much.
> 
> greg k-h

Thanks
Hanjun
