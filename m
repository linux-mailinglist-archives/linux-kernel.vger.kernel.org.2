Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1524071D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbhIJT1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:27:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48253 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhIJT1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:27:03 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 18AJPdHj511727
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 10 Sep 2021 12:25:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 18AJPdHj511727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631301939;
        bh=YFAQh7YL0Zd1LWre2EQ6VQmqRzlfVaJSwblMnsJBijY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RUPQiAq13rtgPyFNAZ5sFR4c6uxMOi8t8VtZkAJLFA8IcXSn8NzOr1pFPsiePkCkE
         OCK98IBKF5T7qgivnjIrPQFimlJuavtW/g1I6GqBMMYphzwrzqZi/IIItKqDleOgl0
         6aUJJ5q8WIg61TmLqtSUhp4UhLv2VbMuuxCXICyacamSdjnXe+pOkbrlFlxzHgZrgZ
         cAlKhGIYP8jVN0o8qbPP1gPFoOQ+5k2g5gTBTywqWZirdckmtgT3UvcjMJuVZ3Q84g
         fCvm4eVhDjEjfXIW35sCA1c5DjRkQNPd2WBYzvtQcgvqJUFhs3+TZZx3ess2Fj/RtK
         OzRokVTB+IszA==
Subject: Re: [PATCH] x86/asm: pessimize the pre-initialization case in
 static_cpu_has()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210908171716.3340120-1-hpa@zytor.com>
 <YTo92+0ruBlkcaDf@zn.tnic> <1a73e0c2-8efe-fee9-5141-f7e9a95c748d@zytor.com>
 <f59dbeee-8d2f-0964-90db-bf9c3c176763@zytor.com> <YTsh7kdH+eGHgK7U@zn.tnic>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <b90675c5-d004-d90c-7890-48a81ed52414@zytor.com>
Date:   Fri, 10 Sep 2021 12:25:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTsh7kdH+eGHgK7U@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/21 2:14 AM, Borislav Petkov wrote:
> On Thu, Sep 09, 2021 at 03:17:14PM -0700, H. Peter Anvin wrote:
>> ... into the visible part of the subject line, that was supposed to say.
>> This is rather important when browsing logs, e.g. using gitk.
> 
> So you resize your gitk window. It's not like there are no other commits
> with a bit longer commit titles.
> 
> The important part is that our commit messages should be readable months
> and years from now - I don't have to explain this to you, of all people.
> 
> "pessimize" is not even a word:
> 
> https://www.merriam-webster.com/dictionary/pessimize:
> 
> “pessimize”
> 
>    The word you've entered isn't in the dictionary. Click on a spelling
>    suggestion below or try again using the search bar above.
> 

Depends on which dictionary you use.

	https://www.yourdictionary.com/pessimize

> So while I have an idea what you mean, I'm sure that "what" can be
> formulated in a better way.
> 

OK, no worries.  I'll resubmit.

	-hpa
