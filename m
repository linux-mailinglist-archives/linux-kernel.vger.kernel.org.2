Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B37394C48
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 14:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhE2Mzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 08:55:49 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2540 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhE2Mzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 08:55:45 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FshJG1Rk5zYrdp;
        Sat, 29 May 2021 20:51:26 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 20:54:07 +0800
Received: from [10.174.179.215] (10.174.179.215) by
 dggema769-chm.china.huawei.com (10.1.198.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 29 May 2021 20:54:07 +0800
Subject: Re: [PATCH -next] USB: gadget: f_fs: Remove unneed cast in
 ffs_prepare_buffer()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210529120408.23456-1-yuehaibing@huawei.com>
 <YLIveGTHK5RjxtS+@kroah.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <91983b80-1818-536d-5ea3-5a38c1cb5443@huawei.com>
Date:   Sat, 29 May 2021 20:54:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YLIveGTHK5RjxtS+@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/29 20:11, Greg KH wrote:
> On Sat, May 29, 2021 at 08:04:08PM +0800, YueHaibing wrote:
>> A coccicheck run provided information like the following.
>>
>> ./drivers/usb/gadget/function/f_fs.c:3832:9-16:
>>  WARNING: ERR_CAST can be used with data
>>
>> ffs_prepare_buffer() should return an ERR_PTR() encoded error
>> code on failure.
> 
> It does return such a pointer today, so this statement does not make
> much sense :(

Yes, it does. This is just to remove explicit casts.

> 
> And is this a v2 patch?  What changed from the previous version?

Sorry, I forget to add version info.

> 
> thanks,
> 
> greg k-h
> .
> 
