Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125B5354AA0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhDFBxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:53:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14694 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242237AbhDFBxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:53:54 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FDr8j0lwcznXsy;
        Tue,  6 Apr 2021 09:51:01 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 09:53:40 +0800
Subject: Re: [PATCH -next] staging/speakup: Switch to kmemdup_nul()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <speakup@linux-speakup.org>
References: <20210402092111.2443601-1-yangyingliang@huawei.com>
 <YGcYYPhjd/ej3NaP@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <67d012fa-cd4e-ba88-5a3d-f5e5ed544419@huawei.com>
Date:   Tue, 6 Apr 2021 09:53:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YGcYYPhjd/ej3NaP@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/4/2 21:13, Greg KH wrote:
> On Fri, Apr 02, 2021 at 05:21:11PM +0800, Yang Yingliang wrote:
>> Use kmemdup_nul() helper instead of open-coding to
>> simplify the code.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/accessibility/speakup/i18n.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
> Your subject line is very odd, why does it have "staging"?
I check git log of this file and use prefix of the history title, 
obviously I was wrong,
I will send a v2 later.

Thanks,
Yang
>
> Your robot is not doing well these days...
>
> greg k-h
> .
