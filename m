Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300A93EC316
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 16:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbhHNOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 10:06:18 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:60256 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbhHNOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 10:06:16 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d27 with ME
        id hS5m2500A3riaq203S5nHk; Sat, 14 Aug 2021 16:05:47 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Aug 2021 16:05:47 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
References: <20210805104353.GD26417@kili>
 <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
Message-ID: <a427b32e-f513-f1ed-5b28-581326f22ad4@wanadoo.fr>
Date:   Sat, 14 Aug 2021 16:05:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy paste error, see below :/

Le 14/08/2021 à 15:59, Christophe JAILLET a écrit :
> Hi all,
> 
> Le 05/08/2021 à 12:43, Dan Carpenter a écrit :
>> The "= {};" style empty struct initializer is preferred over = {0}.
>> It avoids the situation where the first struct member is a pointer and
>> that generates a Sparse warning about assigning using zero instead of
>> NULL.  Also it's just nicer to look at.
>>
>> Some people complain that {} is less portable but the kernel has
>> different portability requirements from userspace so this is not a
>> issue that we care about.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>   scripts/checkpatch.pl | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 461d4221e4a4..32c8a0ca6fd0 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -4029,6 +4029,12 @@ sub process {
>>                    "Using $1 is unnecessary\n" . $herecurr);
>>           }
>> +# prefer = {}; to = {0};
>> +        if ($line =~ /= \{ *0 *\}/) {
>> +            WARN("ZERO_INITIALIZER",
>> +                 "= {} is preferred over = {0}\n" . $herecurr);
>> +        }
>> +
>>   # Check for potential 'bare' types
>>           my ($stat, $cond, $line_nr_next, $remain_next, $off_next,
>>               $realline_next);
>>
> 
> [1] and [2] state that {} and {0} don't have the same effect. So if 
> correct, this is not only a matter of style.
> 
> When testing with gcc 10.3.0, I arrived at the conclusion that both {} 
> and {0} HAVE the same behavior (i.e the whole structure and included 
> structures are completely zeroed) and I don't have a C standard to check 
> what the rules are.
> gcc online doc didn't help me either.
> 
> To test, I wrote a trivial C program, compiled it with gcc -S and looked 
> at the assembly files.
> 
> 
> Maybe, if it is an undefined behavior, other compilers behave 
> differently than gcc.
> 
> 
> However, the 2 persons listed bellow have a much better Linux and C 
> background than me. So it is likely that my testings were too naive.
> 
> 
> Can someone provide some rational or compiler output that confirms that 
> {} and {0} are not the same?
> 
> Because if confirmed, I guess that there is some clean-up work to do all 
> over the code, not only to please Sparse!
> 
> 
> Thanks in advance.
> CJ
> 
> 
> 
> [1]: Russell King - 
> https://lore.kernel.org/netdev/YRFGxxkNyJDxoGWu@shredder/T/#efe1b6c7862b7ca9588c2734f04be5ef94e03d446 
> 
> 
> [2]: Leon Romanovsky - 
> https://lore.kernel.org/netdev/YRFGxxkNyJDxoGWu@shredder/T/#efe1b6c7862b7ca9588c2734f04be5ef94e03d446 
https://lore.kernel.org/netdev/162894660670.3097.4150652110351873021.git-patchwork-notify@kernel.org/T/#m3424d6e97ef0f0ddd429cce3369a6da0ea9af276

