Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EC2382AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhEQL0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:26:06 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:38398 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbhEQL0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:26:04 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d66 with ME
        id 5nQi2500A21Fzsu03nQi5b; Mon, 17 May 2021 13:24:47 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 May 2021 13:24:47 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH 1/2] misc/pvpanic: Fix error handling in
 'pvpanic_pci_probe()'
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, pizhenwei@bytedance.com,
        pbonzini@redhat.com, linqiheng@huawei.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <7efa7b4b9867ac44f398783b89f3a21deac4ce8b.1621175108.git.christophe.jaillet@wanadoo.fr>
 <YKIi1hljnjvqMCVA@smile.fi.intel.com>
 <ada55e25-5eb3-9b6b-5783-d2303db9bf83@wanadoo.fr>
 <YKJGrGTHz+DzfiHN@smile.fi.intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <a5759f89-0617-29a1-26bd-0ed9a4bc41b8@wanadoo.fr>
Date:   Mon, 17 May 2021 13:24:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKJGrGTHz+DzfiHN@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/05/2021 à 12:34, Andy Shevchenko a écrit :
> On Mon, May 17, 2021 at 12:02:24PM +0200, Christophe JAILLET wrote:
>> Le 17/05/2021 à 10:01, Andy Shevchenko a écrit :
>>> On Sun, May 16, 2021 at 04:36:55PM +0200, Christophe JAILLET wrote:
>>>> There is no error handling path in the probe function.
>>>> Switch to managed resource so that errors in the probe are handled easily
>>>> and simplify the remove function accordingly.
>>>
>>> Yes, that's what I suggested earlier to another contributor.
>>>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>
>>> Thanks!
>>>
>>> P.S. You may consider the following things as well:
>>>    1) converting to use pci_set_drvdata() / pci_get_drvdata()
>>
>> I can send a patch for that if you want.
>> But it looks really low value for a driver that is already very short and
>> clean.
> 
> Yep, that's why 2) below came to my mind (then you will remove drvdata call).
> 
>>>    2) providing devm_pvpanic_probe() [via devm_add_action() /
>>>       devm_add_action_or_reset()]
>>
>> I don't follow you here.
>> The goal would be to avoid the remove function and "record" the needed
>> action directly in the probe?
>>
>> If this is it, I would only see an unusual pattern and a harder to follow
>> logic.
> 
>> Did I miss something?
>> What would be the benefit?
> 
> First of all it's a usual pattern when one, often used in ->probe(), function
> gains its devm variant. See, for example, `return devm_gpiochip_add_data(...);`
> used in the code.
> 
> Benefit is to have everything under managed resources and yes, no ->remove()
> will be needed in the individual drivers.
> 
> But it's up to you. It was just a proposal that you may simply refuse to follow,
> it's fine.
> 

Ok, I'll propose something when/if my first patches reach -next.

I now better see your point. I first read devm_pvpanic_pci_probe (i.e. 
with pci inside), instead of devm_pvpanic_probe.

CJ
