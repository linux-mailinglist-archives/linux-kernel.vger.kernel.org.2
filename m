Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1FE35B6D2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 21:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhDKTxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 15:53:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34632 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhDKTxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 15:53:21 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618170784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pLj4iEVWjEfoLen81vZfMShrSTB9qSmLODc6mlQpPts=;
        b=O/8j5zxzfsEoacpfhIMlDwyDAz7fG7rq7z9JL6tjjONsrnRrZK3LmpvKG7f5vrbfj2osqG
        /kxV++4YLHFHu4vYFOnWVqgqX7k/WbXnLpnRJlSWMbeLsp+PTY7z4b7M1Ew0/Um7A+lIIS
        S39G86Niw50FPBAFqTqr9IKWMvYumjXG5PN4auJCHTEVklilcXagfJUsudNyIQXu9rPSEW
        tv+qFSubOPggachPQ8Z3aqPneHg80AGBMXlPrGnFds10/51LSSOYFTt8zdXnyHHpn2LycM
        jB8fj1VvhOpsPWz1lBmV6SdKTwpHnsEkG/4LxXPe95kvcwa2BR1g088OnA2OnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618170784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pLj4iEVWjEfoLen81vZfMShrSTB9qSmLODc6mlQpPts=;
        b=2Y4rHV+3K/SSU3S87el+srxsqJ4vYV/VrqXTNMHSIIHaTf73PBDwsjK0DVnA+RWITyCh2u
        7T7KRgT74c07zcCw==
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
References: <20210410211152.1938-1-amonakov@ispras.ru>
        <e884200f-55a4-59b5-4311-964e6ddc94d1@molgen.mpg.de>
        <alpine.LNX.2.20.13.2104111410340.11104@monopod.intra.ispras.ru>
Date:   Sun, 11 Apr 2021 21:52:59 +0200
In-Reply-To: <alpine.LNX.2.20.13.2104111410340.11104@monopod.intra.ispras.ru>
        (Alexander Monakov's message of "Sun, 11 Apr 2021 14:22:14 +0300
        (MSK)")
Message-ID: <87o8ekioo4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-11, Alexander Monakov <amonakov@ispras.ru> wrote:
>>> The second line is emitted via 'pr_cont', which causes it to have a
>>> different ('warn') loglevel compared to the previous line ('info').
>>> 
>>> Commit 9a295ff0ffc9 attempted to rectify this by removing the newline
>>> from the pci_info format string, but this doesn't work, as pci_info
>>> calls implicitly append a newline anyway.
>> 
>> Hmm, did I really screw that up during my testing? I am sorry about that.
>> 
>> I tried to wrap my head around, where the newline is implicitly appended, and
>> only found the definitions below.
>> 
>>     include/linux/pci.h:#define pci_info(pdev, fmt, arg...)
>> dev_info(&(pdev)->dev, fmt, ##arg)
>> 
>>     include/linux/dev_printk.h:#define dev_info(dev, fmt, ...)
>> \
>>     include/linux/dev_printk.h:     _dev_info(dev, dev_fmt(fmt),
>> ##__VA_ARGS__)
>> 
>>     include/linux/dev_printk.h:__printf(2, 3) __cold
>>     include/linux/dev_printk.h:void _dev_info(const struct device *dev, const
>> char *fmt, ...);
>> 
>>     include/linux/compiler_attributes.h:#define __printf(a, b)
>> __attribute__((__format__(printf, a, b)))
>
> Yeah, it's not obvious: it happens in kernel/printk/printk.c:vprintk_store
> where it does
>
> 	if (dev_info)
> 		lflags |= LOG_NEWLINE;
>
> It doesn't seem to be documented; I think it prevents using pr_cont with
> "rich" printk facilities that go via _dev_info.
>
> I suspect it quietly changed in commit c313af145b9bc ("printk() - isolate
> KERN_CONT users from ordinary complete lines").

Yes, this behavior has been around for a while. I see no reason why it
should be that way. These days printk does not care if there is dev_info
included or not.

>> In the discussion *smpboot: CPU numbers printed as warning* [1] John wrote:
>> 
>>> It is supported to provide loglevels for CONT messages. The loglevel is
>>> then only used if the append fails:
>>> 
>>>     pr_cont(KERN_INFO "message part");
>>> 
>>> I don't know if we want to go down that path. But it is supported.
>
> Yeah, I saw that, but decided to go with the 'pr_info("")' solution, because
> it is less magic, and already used in two other drivers.

Note that what I was suggesting was to fix a different issue: If the
pr_cont() caller is interrupted by another printk user, then the
following pr_cont() calls will use the default loglevel. By explicitly
specifying the loglevel in pr_cont(), you can be sure that those pieces
get the desired loglevel, even if those pieces get separated off because
of an interrupting printk user.

So even if we fix dev_info to allow pr_cont continuation, it still may
be desirable to specify the loglevel in the pr_cont pieces.

> pr_info("") will also prepend 'AMD-Vi:' to the feature list, which is
> nice.

I'd rather fix dev_info callers to allow pr_cont and then fix any code
that is using this workaround.

And if the print maintainers agree it is OK to encourage
pr_cont(LOGLEVEL "...") usage, then people should really start using
that if the loglevel on those pieces is important.

John Ogness
