Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55E0368964
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 01:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbhDVXds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 19:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbhDVXdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 19:33:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FADC061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 16:33:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619134388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+fylNxYaH0JYwbKxI3stgAYDYkyGd6MoaR6dJPTbGpQ=;
        b=jUTQP7LnAosuDNecCUqhZ0cblr5qPeVzpXA7zYERk5LWh2AlSTWHSInmZOXTCThBPE4Dqc
        +7Q8mGMnNlswSJoua8pWwfZ9ysiptSpGnLXzDnQyyLz9aWj4RcABPy/4vKya3oAwg3X8I9
        SMbfmtKZcNy/DvxNoOVQO64IylfpG8gfVmMxs8bOPDahJ/GJpULn1Egir8IQJNDgSkd1Za
        fxfD0+KuJI29bWnjdmoBDQwrQ3schNwZPZMkvACHXbtZqpVIKVPMDq2Msd8Uf3EY7XqtRj
        MH1mJPvA74J8WEzr+iAqQh/7/Zv5hGVZj4J1uFv61zxJfIKfqVJz3e2ZrTVnKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619134388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+fylNxYaH0JYwbKxI3stgAYDYkyGd6MoaR6dJPTbGpQ=;
        b=p2qtviVpJrJrZF+kWsQu1d6pbK77d3cEMBxTb/iel8PnmHSXVngqdk/jwrqnQwvRW+khqY
        /Ez1q/RzaqdRJFBg==
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        kjlu@umn.edu, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>,
        Nicolai Stange <nstange@suse.de>,
        Roland Dreier <roland@purestorage.com>
Subject: Re: [PATCH 113/190] Revert "x86/hpet: Prevent potential NULL pointer dereference"
In-Reply-To: <202104211245.F5FEC8D15D@keescook>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-114-gregkh@linuxfoundation.org> <202104211245.F5FEC8D15D@keescook>
Date:   Fri, 23 Apr 2021 01:33:07 +0200
Message-ID: <87im4dx5cc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21 2021 at 12:49, Kees Cook wrote:
> On Wed, Apr 21, 2021 at 02:59:48PM +0200, Greg Kroah-Hartman wrote:
>> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
>> index 08651a4e6aa0..0515a97bf6f5 100644
>> --- a/arch/x86/kernel/hpet.c
>> +++ b/arch/x86/kernel/hpet.c
>> @@ -930,8 +930,6 @@ int __init hpet_enable(void)
>>  		return 0;
>>  
>>  	hpet_set_mapping();
>> -	if (!hpet_virt_address)
>> -		return 0;
>>  
>>  	/* Validate that the config register is working */
>>  	if (!hpet_cfg_working())
>
> FWIW, this patch looks harmless. It is checking for a failure in
> hpet_set_mapping(), and avoids the following code from performing
> 0-offset reads. hpet_set_mapping() is likely to never fail in real-world
> situations. *shrug*

'likely never to fail' is clearly a receipe for disaster and you should
know that.

> I think it would make more sense for the check to live in
> hpet_cfg_working(), though.

No. That does not make any sense at all.

The proper change would have been to make hpet_set_mapping() return
an error/success code and act on that.

But that does _NOT_ make the patch invalid.

I'm pretty sure that I looked at it and thought about the proper
solution (see above) and then shrugged it off because of overload...

Thanks,

        tglx




