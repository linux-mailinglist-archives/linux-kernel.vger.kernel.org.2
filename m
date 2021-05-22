Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6404D38D5A4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 13:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhEVLc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 07:32:26 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:30058 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhEVLcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 07:32:24 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d44 with ME
        id 7nWx2500821Fzsu03nWxNf; Sat, 22 May 2021 13:30:57 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 May 2021 13:30:57 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH v2 5/5] misc/pvpanic: Make 'pvpanic_probe()' resource
 managed
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        pizhenwei@bytedance.com, Paolo Bonzini <pbonzini@redhat.com>,
        bobo.shaobowang@huawei.com, linqiheng@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
References: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
 <9212cdc8c1e5c187a2f1129a6190085c2a10d28a.1621665058.git.christophe.jaillet@wanadoo.fr>
 <CAHp75VdhgEEeOoJZNXu9RMR0QppDv7HZ-_Lmy4PC=ptXHaz_Lw@mail.gmail.com>
 <CAHp75Vct5cHgSDU4oQ8ScEoKviiZZgYCKN62AEy0MS=V4oGTiQ@mail.gmail.com>
 <1217b537-57ea-dcf2-06d8-5b5bd7bcbd5f@wanadoo.fr>
 <CAHp75VfQHEU9C41Jrv-a4Vw9OHBtmOStrBMNtPCh-74mj1k9dA@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <0a3baf12-0255-70a6-bbb5-a96902516cf3@wanadoo.fr>
Date:   Sat, 22 May 2021 13:30:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VfQHEU9C41Jrv-a4Vw9OHBtmOStrBMNtPCh-74mj1k9dA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/05/2021 à 13:06, Andy Shevchenko a écrit :
> On Sat, May 22, 2021 at 1:57 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>> Le 22/05/2021 à 12:09, Andy Shevchenko a écrit :
> 
> ...
> 
>> I'll send a v3, but my turn to nitpick now:
>>
>>      Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>      Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Which one, should I use?
>> I guess the later.
> 
> Both. They have different meanings.
> 

I was meaning gmail.com or intel.com

CJ
