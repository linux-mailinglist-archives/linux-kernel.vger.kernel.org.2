Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA70035921B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhDICnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:43:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16103 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:42:59 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGj6T4F9qz19Ks2;
        Fri,  9 Apr 2021 10:40:33 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 10:42:36 +0800
Subject: Re: [PATCH v2 0/2] USB:ehci:fix the no SRBN register problem
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <liudongdong3@huawei.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kong.kongxinwei@hisilicon.com>,
        <yisen.zhuang@huawei.com>
References: <1617889760-17733-1-git-send-email-liulongfang@huawei.com>
 <20210408145332.GA1296449@rowland.harvard.edu>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <f5eb92ab-9d28-d4a9-a3a0-6a759656ad37@huawei.com>
Date:   Fri, 9 Apr 2021 10:42:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210408145332.GA1296449@rowland.harvard.edu>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/8 22:53, Alan Stern wrote:
> On Thu, Apr 08, 2021 at 09:49:18PM +0800, Longfang Liu wrote:
>> (1) Add a whitelist for EHCI devices without SBRN registers.
>> (2) Add Kunpeng920's EHCI device to the whitelist.
>>
>> Changes in v2:
>> 	- Fix some code style issues.
>> 	- Update function name.
>>
>> Longfang Liu (2):
>>   USB:ehci:Add a whitelist for EHCI controllers
>>   USB:ehci:fix Kunpeng920 ehci hardware problem
>>
>>  drivers/usb/host/ehci-pci.c | 30 ++++++++++++++++++++++++++----
>>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> I don't think we need a whole list, along with an associated lookup 
> routine, when there are only two entries.  The total amount of code will 
> be smaller if you just add a check for the Kunpeng920 controller to
> the existing check for the STMICRO controller.
> 
> Alan Stern
> .
> 
Now there are two EHCI controllers that do not have SBRN registers,
and there may be more in the future. This list is added for subsequent
compatibility if there are such controllers, instead of a series of if-else.
Thanks.
Longfang.
