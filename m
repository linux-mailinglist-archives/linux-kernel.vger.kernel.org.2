Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC73EC4FF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 22:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhHNUVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 16:21:04 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:27917 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhHNUVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 16:21:03 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d21 with ME
        id hYLR250073riaq203YLSxi; Sat, 14 Aug 2021 22:20:32 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Aug 2021 22:20:32 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Leon Romanovsky <leon@kernel.org>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
References: <20210805104353.GD26417@kili>
 <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
 <YRfYr0fsM1R7O5x6@zeniv-ca.linux.org.uk>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <ac38ab19-bfab-0d83-079c-adc9fe6d4924@wanadoo.fr>
Date:   Sat, 14 Aug 2021 22:20:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRfYr0fsM1R7O5x6@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/08/2021 à 16:52, Al Viro a écrit :
> On Sat, Aug 14, 2021 at 03:59:22PM +0200, Christophe JAILLET wrote:
> 
>>> +# prefer = {}; to = {0};
>>> +		if ($line =~ /= \{ *0 *\}/) {
>>> +			WARN("ZERO_INITIALIZER",
>>> +			     "= {} is preferred over = {0}\n" . $herecurr);
> 
> Sigh...  "is preferred over" by whom?  Use the active voice, would you?
> 
>> [1] and [2] state that {} and {0} don't have the same effect. So if correct,
>> this is not only a matter of style.
>>
>> When testing with gcc 10.3.0, I arrived at the conclusion that both {} and
>> {0} HAVE the same behavior (i.e the whole structure and included structures
>> are completely zeroed) and I don't have a C standard to check what the rules
>> are.
>> gcc online doc didn't help me either.
> 
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf, but empty
> initializer-list is gccism anyway.
> 
> Section 6.7.8 is the one to look through there.
> 
>> Can someone provide some rational or compiler output that confirms that {}
>> and {0} are not the same?
> 
> Easily: compare
> 	int x[] = {0};
> and
> 	int x[] = {};
> 
> For more obscure example,
> 	int x = {0};
> is valid, if pointless, but
> 	int x = {};
> will be rejected even by gcc.
> 
> Incidentally, do *NOT* assume that initializer will do anything with padding
> in a structure, no matter how you spell it.  Neither {} nor {0} nor explicit
> initializer for each member of struct do anything to the padding.  memset()
> does, but anything short of that leaves the padding contents unspecified.
> 

Thanks for the explanations and exemples.

IIUC, code like [1] may leak some data (1 char) because of the layout of 
'struct atyclk' and we have the erroneous feeling that it is fully 
initialized, because of the "{ 0 }".

Correct?

CJ

[1]: 
https://elixir.bootlin.com/linux/v5.14-rc5/source/drivers/video/fbdev/aty/atyfb_base.c#L1859
