Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FEB393B53
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 04:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbhE1COy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 22:14:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47805 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhE1COw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 22:14:52 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (fmdmzpr04-ext.fm.intel.com [192.55.55.39])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14S2Cqai1217795
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 27 May 2021 19:12:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14S2Cqai1217795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1622167974;
        bh=FOpZQZWIKm4fpWEVe6TLHGEjmvOF63tMJaRYeEveBSM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l5QhUJ97oAQc2Lrbrozgh+UVrvgUWNPBAhjHpk2HMB1L+cn4Ayb7L+1U/0Sy8YnRT
         0XfnaVYG6JYG9ikpkQw8doOkamNqNPN+6ZzRrPXOtluH/3iwj4MmvG2ZWF9IlnjXR3
         zQV19QRlY5JBksMzApO9tlc9FZ1rxozewJS6ddeNWGY82N7iFc4qWJ+VOQtMkaK/ce
         LJvaPCpBXg5jHecRfA5lQpnn9yQBd0tyuilagG+z0VUVgWk0e1lV90fvns1FXYR3yC
         kKLB52C3wwb9kqEZItgUvKW7U+8R25vgrUpiQzGnrAP4sIqq3OYG8kEA31GGsCFkqC
         emqYI3XVy7ZOg==
Subject: Re: [PATCH] x86/Kconfig: decrease maximum of X86_RESERVE_LOW to 512K
To:     Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        untaintableangel@hotmail.co.uk, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210526081100.12239-1-rppt@kernel.org>
 <YK4LGUDWXJWOp7IR@zn.tnic> <YK53kWHb4cPeeHsd@kernel.org>
 <YK6QFLUoPZ7btQfH@zn.tnic>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <f7525409-3987-f79d-9f52-71f6c0231491@zytor.com>
Date:   Thu, 27 May 2021 19:12:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YK6QFLUoPZ7btQfH@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 11:14 AM, Borislav Petkov wrote:
> On Wed, May 26, 2021 at 07:30:09PM +0300, Mike Rapoport wrote:
>> We can restore that behaviour, but it feels like cheating to me. We let
>> user say "Hey, don't touch low memory at all", even though we know we must
>> use at least some of it. And then we sneak in an allocation under 640K
>> despite user's request not to use it.
> 
> Sure but how are we going to tell the user that if we don't sneak that
> allocation, we won't boot at all. I believe user would kinda like the
> box to boot still, no? :-)
> 
> Yeah, you have that now:
> 
> +         Note, that a part of the low memory range is still required for
> +         kernel to boot properly.
> 
> but then why is 512 ok? And why was 640K the upper limit?
> 
> Looking at:
> 
> d0cd7425fab7 ("x86, bios: By default, reserve the low 64K for all BIOSes")
> 
> and reading that bugzilla
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=16661
> 
> it sounds like it is the amount of memory where BIOS could put crap in.
> 
> Long story short, we reserve the first 64K by default so if someone
> reserves the total range of 640K the early code could probably say
> something like
> 
> "adjusting upper reserve limit to X for the real-time trampoline"
> 
> when the upper limit is too high so that a trampoline can't fit...
> 
> Which is basically what your solution does...
> 
> But then the previous behavior used to work everywhere so if it is only
> cheating, I don't mind doing that as long as boxes keep on booting.
> 
> Or am I missing an aspect?
> 

BIOSes have been known to clobber more than 64K. They aren't supposed to
clobber any.

640K is the limit because that is the address of the EGA/VGA frame
buffer. In the words of Bill Gates "640K ought to be enough for anyone."

	-hpa
