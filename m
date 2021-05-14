Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9325238040B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhENHNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhENHNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:13:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A46E161221;
        Fri, 14 May 2021 07:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620976353;
        bh=QqdCFuLkw9HqiWLBqf1BMhrJfMvdesvkwhgenRv4SSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Coc4Gx2+/36PMdCoeHMZPRxFV02rZOiaUqh4tiCUmqmyzzRzk4bcvmBAYVCbz24Ah
         SEBN0O5QGIHvw4fAorqzNvEwyPPi1YicqmmsHggG+uUR+TMYhunay0WrjqvOtuzULQ
         MpAWYkzhkvByOZyrNWIfTcm4M36iKH8SQTHjwxCK1fX6piiXtr7y+bk4OSkL1KKxEY
         CwpX8MfMUJ4K0MBCnmcR61ZkdoskJug44ioDJZQGywXjnT/9Nsk4nfrYK3N98aPGJS
         FI+YiVNENWJNcR+0r6mKjFMyXzxYaxUEvfZJw910dX471zjZIc6OFT3a/0WFHzLBQq
         dq8/7w1+B31mw==
Date:   Fri, 14 May 2021 09:12:29 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] module: check for exit sections in layout_sections()
 instead of module_init_section()
Message-ID: <YJ4i3XNa3V7ifCih@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
References: <20210512144653.3726-1-jeyu@kernel.org>
 <20210512160651.GP1336@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210512160651.GP1336@shell.armlinux.org.uk>
urom:   Jessica Yu <jeyu@kernel.org>
X-OS:   Linux p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de
 5.12.0-2-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Russell King - ARM Linux admin [12/05/21 17:06 +0100]:
>Hi,
>
>On Wed, May 12, 2021 at 04:46:53PM +0200, Jessica Yu wrote:
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 173a09175511..a5c9842371b1 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -2430,6 +2430,9 @@ static void layout_sections(struct module *mod, struct load_info *info)
>>  			if ((s->sh_flags & masks[m][0]) != masks[m][0]
>>  			    || (s->sh_flags & masks[m][1])
>>  			    || s->sh_entsize != ~0UL
>> +#ifndef CONFIG_MODULE_UNLOAD
>> +			    || module_exit_section(sname)
>> +#endif
>>  			    || module_init_section(sname))
>
>How about a helper to make this a bit easier in both these places to
>make the code more undertsandable? I think the great value comes from
>the resulting change in the second hunk.
>
>static bool module_evictable_section(const char *sname)
>{
>#ifndef CONFIG_MODULE_UNLOAD
>	if (module_exit_section(sname))
>		return true;
>#endif
>	return module_init_section(sname);
>}
>
>and then just use that above?
>
>>  				continue;
>>  			s->sh_entsize = get_offset(mod, &mod->core_layout.size, s, i);
>> @@ -2463,7 +2466,11 @@ static void layout_sections(struct module *mod, struct load_info *info)
>>  			if ((s->sh_flags & masks[m][0]) != masks[m][0]
>>  			    || (s->sh_flags & masks[m][1])
>>  			    || s->sh_entsize != ~0UL
>> +#ifndef CONFIG_MODULE_UNLOAD
>> +			    || (!module_init_section(sname) && !module_exit_section(sname)))
>> +#else
>>  			    || !module_init_section(sname))
>> +#endif
>
>I find this a tad confusing, and this is the reason for my suggestion
>above. With that, this becomes:
>
>			    || !module_evictable_section(sname))
>
>which can be clearly seen is the opposite condition from the above
>without doing mental logic gymnastics.

Thanks Russell for the feedback! Yeah, agreed that it could be made
easier to read - will respin with a helper function.

Jessica
