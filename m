Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4938BC67
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbhEUCYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:24:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4706 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbhEUCYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:24:40 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FmVgx0sJhz16PtQ;
        Fri, 21 May 2021 10:20:29 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 10:23:16 +0800
Received: from [127.0.0.1] (10.40.192.162) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 21 May
 2021 10:23:16 +0800
Subject: Re: [PATCH 6/9] tty: hvc_console: Fix coding style issues of block
 comments
To:     Johan Hovold <johan@kernel.org>
References: <1621233433-27094-1-git-send-email-tanxiaofei@huawei.com>
 <1621233433-27094-7-git-send-email-tanxiaofei@huawei.com>
 <YKJ6ZjT8o5xJmBCr@hovoldconsulting.com>
 <e88b6fcd-bfe1-9812-905a-862825f420ce@huawei.com>
 <YKYcFfKiHT39Gyey@hovoldconsulting.com>
 <7e63a708-64c4-b369-066b-7f83d65bf178@huawei.com>
 <YKZpi8cmH3mtXT99@hovoldconsulting.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <07453180-0aa4-e260-a50d-23d27973907b@huawei.com>
Date:   Fri, 21 May 2021 10:23:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YKZpi8cmH3mtXT99@hovoldconsulting.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Johan,

On 2021/5/20 21:52, Johan Hovold wrote:
> On Thu, May 20, 2021 at 09:21:25PM +0800, Xiaofei Tan wrote:
>
>>> Checkpatch already has too many checks IMO and I'm a bit surprised that
>>> it doesn't check this already. Perhaps it's because you used the -f to
>>> run checkpatch on in-kernel code, which you should not.
>>>
>>>>> Second, that sentence is not capitalised so why do add a period?
>>>>>
>>>>
>>>> How about capitalize the sentence, or just remove the period ?
>>>
>>> How about just leaving this unchanged?
>>
>> OK
>> And I will keep the patch 8/9, and combine space issues into
>> one new patch, and remove the others.
>
> Yeah, 8/9 is arguably a fix even if it's for a very minor issue
> (repeated words in a comment).
>
> It doesn't look like any of the white space issues are worth fixing,
> though. Such pedantry can usually be addressed when the code in question
> is being modified for other reasons.
>

OK, it is reasonable. thanks.

> Johan
>
> .
>

