Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0125D38BC57
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhEUCTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:19:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3608 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhEUCTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:19:30 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FmVY55S5jzQpy7;
        Fri, 21 May 2021 10:14:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 10:18:05 +0800
Received: from [127.0.0.1] (10.40.192.162) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 21 May
 2021 10:18:05 +0800
Subject: Re: [PATCH 0/9] tty: hvc_console: Fix some coding style issues
To:     Greg KH <gregkh@linuxfoundation.org>
References: <1621233433-27094-1-git-send-email-tanxiaofei@huawei.com>
 <YKZ8M8j5/bUJxLq5@kroah.com>
CC:     <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <ee765bed-f060-a31a-882f-4a8270366831@huawei.com>
Date:   Fri, 21 May 2021 10:18:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YKZ8M8j5/bUJxLq5@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2021/5/20 23:11, Greg KH wrote:
> On Mon, May 17, 2021 at 02:37:04PM +0800, Xiaofei Tan wrote:
>> Fix some issues reported by checkpatch.pl. All of them are
>> coding style issues, no function changes.
>>
>> Xiaofei Tan (9):
>>   tty: hvc_console: Fix spaces required around that '='
>>   tty: hvc_console: Fix "foo * bar" should be "foo *bar"
>>   tty: hvc_console: Remove trailing whitespace
>>   tty: hvc_console: Fix issues of code indent should use tabs
>>   tty: hvc_console: Delete spaces prohibited around open parenthesis '('
>>     and ')'
>>   tty: hvc_console: Fix coding style issues of block comments
>>   tty: hvc_console: Add a blank line after declarations
>>   tty: hvc_console: Remove the repeated words 'no' and 'from'
>>   tty: hvc_console: Move open brace { on the previous line
>>
>>  drivers/tty/hvc/hvc_console.c | 37 ++++++++++++++++++++++---------------
>>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> Do you use this driver?

No, i don't use it.

  If so, great, I'm sure there are other "real"
> issues in it that need some work.  But as Johan points out, doing
> drive-by checkpatch cleanups on random files that you do not use, isn't
> the best thing to do.
>

Sure

> If you just want to do this type of work, please do so in
> drivers/staging/ as it is most welcome there if you wish to get involved
> in kernel work to get experience before doing "real" stuff.
>

OK, thanks.

> thanks,
> g
> reg k-h
>
> .
>

