Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48619357F9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhDHJpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:45:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16044 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhDHJpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:45:02 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGGWH49tdzPnsX;
        Thu,  8 Apr 2021 17:42:03 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 17:44:40 +0800
Subject: Re: [PATCH 1/2] USB:ehci:Add a whitelist for EHCI controllers
To:     Oliver Neukum <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        <mathias.nyman@intel.com>, <stern@rowland.harvard.edu>,
        <liudongdong3@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kong.kongxinwei@hisilicon.com>, <yisen.zhuang@huawei.com>
References: <1617873073-37371-1-git-send-email-liulongfang@huawei.com>
 <1617873073-37371-2-git-send-email-liulongfang@huawei.com>
 <a14fcaffd6e26081c07bcfa36a81ded38dcf88b2.camel@suse.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <0d5963d0-9e25-5411-67df-146bf924fc17@huawei.com>
Date:   Thu, 8 Apr 2021 17:44:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a14fcaffd6e26081c07bcfa36a81ded38dcf88b2.camel@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/8 17:33, Oliver Neukum wrote:
> Am Donnerstag, den 08.04.2021, 17:11 +0800 schrieb Longfang Liu:
>> Some types of EHCI controllers do not have SBRN registers.
>> By comparing the white list, the operation of reading the SBRN
>> registers is skipped.
>>
>> Subsequent EHCI controller types without SBRN registers can be
>> directly added to the white list.
> 
> Hi,
> 
> shouldn't this set a flag for a missing functionality?
> 
> 	Regards
> 		Oliver
> 
> 
> .
> 
This flag is ehci->sbrn.
Thanks,
Longfang
