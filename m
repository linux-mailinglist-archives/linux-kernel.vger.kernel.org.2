Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E565351192
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhDAJKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:10:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15567 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhDAJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:10:26 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9y5Z2dY2z17PVn;
        Thu,  1 Apr 2021 17:08:18 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 17:10:22 +0800
Subject: Re: [PATCH -next v2] staging: greybus: camera: Switch to
 memdup_user_nul()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <johan@kernel.org>, <elder@kernel.org>
References: <20210401031752.2861248-1-yangyingliang@huawei.com>
 <YGVhLiV1EeqIJQnM@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <36473834-c62b-c6a7-0d36-ff9a8cd867ac@huawei.com>
Date:   Thu, 1 Apr 2021 17:10:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YGVhLiV1EeqIJQnM@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/4/1 13:59, Greg KH wrote:
> On Thu, Apr 01, 2021 at 11:17:52AM +0800, Yang Yingliang wrote:
>> Use memdup_user_nul() helper instead of open-coding to
>> simplify the code.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/staging/greybus/camera.c | 13 +++----------
>>   1 file changed, 3 insertions(+), 10 deletions(-)
> What changed from v1?
>
> Always put that below the --- line like the documentation asks you to.
> Please fix up and send a v3.

OK, I will add the changelog and send a v3 later

Thanks,

Yang

>
> thanks,
>
> greg k-h
> .
