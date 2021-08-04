Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122D93E0957
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 22:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbhHDU1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 16:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239264AbhHDU1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 16:27:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E75160EEA;
        Wed,  4 Aug 2021 20:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628108829;
        bh=OFuHzIx1yeS+oBkNtoPi2t+wD1xasUaIy6nbSaVVH9U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LrTk2EPP54RSKJ1w1msnV6aIhI9o8cb3L/oTfhzGDQcR5u22D3YKxYvE+sFqZoXVN
         hTcQcIfFOPCgZ+RX4RPWwQ1pCdPdePc180RiFI2L+lcg9gFlomcMtmqfRPG0vI1Ctm
         Y5z/X1IpUEO6p1OgaC34VQJtRLxfeiHDCKeWC/QWabIidooGI/EUV8aduLa0lh3+vY
         xal7vt2oYC9gN4D0w+R7driM39NtfFtMsjePAbQaGNyc6Guo6odCfH1Utsh0xVEHRe
         Zq5XY5NFmKVDCqxh1G1HgT7KCi3wwQoc6OZGOd81cq8QqMJu8RAC4zoEIk0FQbVHZh
         0om1ewoNr6INA==
Subject: Re: [PATCH v3] ucounts: add missing data type changes
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210730062854.3601635-1-svens@linux.ibm.com>
 <YQn+GomdRCoYc/E8@Ryzen-9-3900X.localdomain> <875ywlat5e.fsf@disp2133>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <94478003-8259-4b57-6d93-5a07e0750946@kernel.org>
Date:   Wed, 4 Aug 2021 13:27:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <875ywlat5e.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 8/4/2021 12:47 PM, Eric W. Biederman wrote:
> Nathan Chancellor <nathan@kernel.org> writes:
> 
>> On Fri, Jul 30, 2021 at 08:28:54AM +0200, Sven Schnelle wrote:
>>> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
>>> changed the data type of ucounts/ucounts_max to long, but missed to
>>> adjust a few other places. This is noticeable on big endian platforms
>>> from user space because the /proc/sys/user/max_*_names files all
>>> contain 0.
>>>
>>> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
>>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>>
>> This patch in -next as commit e43fc41d1f7f ("ucounts: add missing data type
>> changes") causes Windows Subsystem for Linux to fail to start:
>>
>> [error 0x8007010b when launching `wsl.exe -d Arch'] Could not access starting
>> directory "\\wsl$\Arch\home\nathan"
>>
>> Specifically, it is the change to max_user_watches in
>> fs/notify/inotify/inotify_user.c, as the below diff gets me back to working.
>> Unfortunately, I have no additional information to offer beyond that as WSL's
>> init is custom and closed source (as far as I am aware) and there are no real
>> debugging utilities.
> 
> Could you try this patch and tell us what value is being set?
> 
> The only think I can imagine is that someone wants unlimited watches and
> sets the value to a ridiculously large value and the interpretation of
> that value winds up being different between int and long.
> 
> This should allow you to read either dmesg or the kernel's log as it
> boots up and see what value is being written.  From there it should
> be relatively straight forward to figure out what is going on.

I applied this diff on top of mine and running 'dmesg |& grep intvec' shows:

[    0.282500] intvec: dmesg_restrict <- 0
[    0.282510] intvec: max_user_watches <- 524288

This seems much smaller than INT_MAX so I am not sure how the value 
could be different between int and long but I am not at all familiar 
with the sysctl code.

More than happy to continue to test debug patches or provide any 
additional information as I can.

Cheers,
Nathan

> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 272f4a272f8c..733c4cfa1f60 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -975,6 +975,14 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
>   		.min = (int *) table->extra1,
>   		.max = (int *) table->extra2,
>   	};
> +#if 1
> +	size_t lenv = *lenp;
> +	if (write && (lenv > 0) && (lenv < INT_MAX)) {
> +		int len = lenv;
> +		printk(KERN_EMERG "intvec: %s <- %*.*s\n",
> +			table->procname, len, len, (char *)buffer);
> +	}
> +#endif
>   	return do_proc_dointvec(table, write, buffer, lenp, ppos,
>   				do_proc_dointvec_minmax_conv, &param);
>   }
> 
