Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E273A942C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhFPHjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:39:53 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7301 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhFPHjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:39:52 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G4cND5QtVz1BN6w;
        Wed, 16 Jun 2021 15:32:44 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 15:37:45 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 15:37:45 +0800
Subject: Re: [PATCH v2 1/1] mcb: Use DEFINE_RES_MEM() to simplify code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210616015509.672-1-thunder.leizhen@huawei.com>
 <20210616015509.672-2-thunder.leizhen@huawei.com>
 <YMmdAQtPN7QRfcNO@kroah.com>
 <8bd6946b-b3f5-35c7-2cbe-51f4c4841d20@huawei.com>
 <YMmlkmnEWetYVXdg@kroah.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8a2ab451-4a82-7e7b-9801-30d39cffceab@huawei.com>
Date:   Wed, 16 Jun 2021 15:37:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YMmlkmnEWetYVXdg@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/16 15:17, Greg Kroah-Hartman wrote:
> On Wed, Jun 16, 2021 at 02:57:14PM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/6/16 14:41, Greg Kroah-Hartman wrote:
>>> On Wed, Jun 16, 2021 at 09:55:09AM +0800, Zhen Lei wrote:
>>>> Use DEFINE_RES_MEM() to save a couple of lines of code, which makes the
>>>> code a bit shorter and easier to read. The start address does not need to
>>>> appear twice.
>>>>
>>>> By the way, the value of '.end' should be "start + size - 1". So the
>>>> previous writing should have omitted subtracted 1.
>>>
>>> Does that mean the current code is wrong and this is a bugfix?  If so,
>>> what commit id does this fix?
>>
>> OK, I'll add Fixes.
>>
>> However, some people think that only functional fixes need to add "Fixes".
> 
> If this is not a "fix" then that is fine, I can take it as-is, it just
> was not obvious.

Sorry, I didn't read the email in time. I just post v3.

Yes, this patch just avoids wasting a bit of memory. There's no need to go to
an earlier version.

> 
> greg k-h
> 
> .
> 

