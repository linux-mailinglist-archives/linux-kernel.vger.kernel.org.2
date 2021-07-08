Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388D13BFAA0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhGHMwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:52:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6769 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhGHMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:52:16 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GLGFG1fSgzXqfx;
        Thu,  8 Jul 2021 20:44:02 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Jul 2021 20:49:32 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Jul 2021 20:49:32 +0800
Subject: Re: [PATCH] driver core: Make probe_type of driver accessible via
 sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>,
        Wu Bo <wubo40@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
References: <20210708122010.262510-1-haowenchao@huawei.com>
 <YObvYiPxQC7lk3NT@kroah.com>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <d2a5f7f3-f68f-9420-b7ee-43102adf514f@huawei.com>
Date:   Thu, 8 Jul 2021 20:49:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YObvYiPxQC7lk3NT@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some scenarios, you need to know whether the probe() callback in struct
driver which triggered by device_add() or driver_register() is called
synchronous or not, and modify this mode according to user requirements.

While kernel now does not open an interface for users to query or
modify, so I add this interface.

I ignored updates to ABI document due to no previous experience with ABI 
change,
and I will bring updates to the ABI in next submission.

On 2021/7/8 20:28, Greg Kroah-Hartman wrote:
> On Thu, Jul 08, 2021 at 08:20:10PM +0800, Wenchao Hao wrote:
>> Like drivers_autoprobe of bus, make probe_type of driver
>> accessible via sysfs, so we can get and set a driver's probe_type
>> happily.
> Why is this needed?  Who will use it?  And where is the
> Documentation/ABI/ file update for this new sysfs file which is required
> for all sysfs files?
>
> thanks,
>
> greg k-h
> .
