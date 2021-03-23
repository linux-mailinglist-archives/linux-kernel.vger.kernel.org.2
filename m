Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FDF346896
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhCWTKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbhCWTJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:09:59 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28114C061574;
        Tue, 23 Mar 2021 12:09:58 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lOmPa-0005x5-Uy; Tue, 23 Mar 2021 20:09:54 +0100
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
 <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
 <YFkSqIN90S4a3HiF@mit.edu>
 <54aeb1f7-ffc7-74e1-a731-8970d44ff852@leemhuis.info>
 <CAMwyc-Sqbkg=VxCWcfRazkGG7vkwEQ43m9Dov_Nawia5MN_oUQ@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [Ksummit-discuss] RFC: create mailing list "linux-issues"
 focussed on issues/bugs and regressions
Message-ID: <f5df1023-eabb-9f46-fe30-dd90851b65f9@leemhuis.info>
Date:   Tue, 23 Mar 2021 20:09:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMwyc-Sqbkg=VxCWcfRazkGG7vkwEQ43m9Dov_Nawia5MN_oUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616526598;f34c7120;
X-HE-SMSGID: 1lOmPa-0005x5-Uy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.21 16:01, Konstantin Ryabitsev wrote:
> On Tue, 23 Mar 2021 at 04:58, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>  If we can
>>> actually get users to *read* it, I think it's going to save kernel
>>> developers a huge amount of time and frustration.
>> And users hopefully as well. But yes, making them read it is the
>> problem. :-/
> I've added a very visible admonition on the front of
> bugzilla.kernel.org. Hopefully, it will help direct some users to
> their distro bug trackers first.

Ahh, great, thx!

>>> I wonder if it might be useful to have a form which users could be
>>> encouraged to fill out so that (a) the information is available in a
>>> structured format so it's easier for developers to find the relevant
>>> information, (b) so it is easier for programs to parse, for easier
>>> reporting or indexing, and (c) as a nudge so that users remember to
>>> report critical bits of information such as the hardware
>>> configuration, the exact kernel version, which distribution userspace
>>> was in use, etc.
>>>
>>> There could also be something in the text form which would make it
>>> easier for lore.kernel.org searches to identify bug reports.  (e.g.,
>>> "LINUX KERNEL BUG REPORTER TEMPLATE")
>>
>> Hmmm, yeah, I like that idea. I'll keep it in mind for later: I would
>> prefer to get reporting-issues.rst officially blessed and
>> reporting-bugs.rst gone before working on further enhancements.
> 
> To my knowledge, git project uses a tool for that:
> https://git-scm.com/docs/git-bugreport
> 
> Theoretically, a similar tool could exist for the kernel.

Wasn't aware of that tool, thx for pointing it out, will take a closer look.

Ciao, Thorsten
