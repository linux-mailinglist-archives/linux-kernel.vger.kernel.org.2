Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20C9382B77
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbhEQLu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:50:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3009 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhEQLu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:50:56 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkHRv6Z7lzmWYB;
        Mon, 17 May 2021 19:47:23 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 19:49:38 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 19:49:37 +0800
Subject: Re: [PATCH] uacce: use sysfs_emit instead of sprintf
To:     Greg KH <gregkh@linuxfoundation.org>
References: <1621247137-42693-1-git-send-email-yekai13@huawei.com>
 <YKJHGP9LTnCRfIx6@kroah.com>
CC:     <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <e5290000-5481-c662-974f-85eea7660953@huawei.com>
Date:   Mon, 17 May 2021 19:49:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YKJHGP9LTnCRfIx6@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/17 18:36, Greg KH wrote:
> On Mon, May 17, 2021 at 06:25:37PM +0800, Kai Ye wrote:
>> Use the sysfs_emit to replace sprintf.
>
> That says _what_ you did, not _why_ you are doing this.  What problem
> are you solving with this change?
>
> thanks,
>
> greg k-h
> .
>
sprintf is not safe, and it not recommended to use.
sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length. so used sysfs_emit that  knows that the size
of the call situations that also ensures that no overrun is done. so use 
sysfs_emit to replace sprintf maybe better.

thanks,
Kai Ye
