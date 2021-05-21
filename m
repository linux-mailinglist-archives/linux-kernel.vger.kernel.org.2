Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B33C38C6B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhEUMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:42:52 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:36453 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbhEUMmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:42:44 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d78 with ME
        id 7QhH2500721Fzsu03QhHSe; Fri, 21 May 2021 14:41:20 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 May 2021 14:41:20 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH 1/2] misc/pvpanic: Fix error handling in
 'pvpanic_pci_probe()'
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, mihai.carabas@oracle.com,
        andriy.shevchenko@linux.intel.com, pizhenwei@bytedance.com,
        pbonzini@redhat.com, linqiheng@huawei.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <7efa7b4b9867ac44f398783b89f3a21deac4ce8b.1621175108.git.christophe.jaillet@wanadoo.fr>
 <YKepSQpLUc5V17tz@kroah.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <694c162e-cbd4-5c51-9b20-b66006594d75@wanadoo.fr>
Date:   Fri, 21 May 2021 14:41:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKepSQpLUc5V17tz@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/05/2021 à 14:36, Greg KH a écrit :
> On Sun, May 16, 2021 at 04:36:55PM +0200, Christophe JAILLET wrote:
>> There is no error handling path in the probe function.
>> Switch to managed resource so that errors in the probe are handled easily
>> and simplify the remove function accordingly.
>>
>> Fixes: db3a4f0abefd ("misc/pvpanic: add PCI driver")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/misc/pvpanic/pvpanic-pci.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> I see two different series for these patches, so I don't know which to
> take :(
> 
> Please fix up and send a v2 series so that I have a clue...
> 
> thanks,
> 
> greg k-h
> 

Both have to be taken. One is for -pci.c and one is for -mmio.c.

I'll resend both with a more complete subject and will include Andy 
Shevchenko's comments.

CJ
