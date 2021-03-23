Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3A2345A34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhCWI6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhCWI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:58:03 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7411C061574;
        Tue, 23 Mar 2021 01:58:02 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lOcrO-0004PS-Hi; Tue, 23 Mar 2021 09:57:58 +0100
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
 <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
 <YFkSqIN90S4a3HiF@mit.edu>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [Ksummit-discuss] RFC: create mailing list "linux-issues"
 focussed on issues/bugs and regressions
Message-ID: <54aeb1f7-ffc7-74e1-a731-8970d44ff852@leemhuis.info>
Date:   Tue, 23 Mar 2021 09:57:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YFkSqIN90S4a3HiF@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616489882;d35cf563;
X-HE-SMSGID: 1lOcrO-0004PS-Hi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.21 22:56, Theodore Ts'o wrote:
> On Mon, Mar 22, 2021 at 08:25:15PM +0100, Thorsten Leemhuis wrote:
>> I agree to the last point and yeah, maybe regressions are the more
>> important problem we should work on – at least from the perspective of
>> kernel development.  But from the users perspective (and
>> reporting-issues.rst is written for that perspective) it feel a bit
>> unsatisfying to not have a solution to query for existing report,
>> regressions or not. Hmmmm...
> First of all, thanks for working on reporting-issues.rst.

Thx, very glad to hear that. I didn't get much feedback on it, which
made me wonder if anybody besides docs folks actually looked at it...

>  If we can
> actually get users to *read* it, I think it's going to save kernel
> developers a huge amount of time and frustration.

And users hopefully as well. But yes, making them read it is the
problem. :-/

> I wonder if it might be useful to have a form which users could be
> encouraged to fill out so that (a) the information is available in a
> structured format so it's easier for developers to find the relevant
> information, (b) so it is easier for programs to parse, for easier
> reporting or indexing, and (c) as a nudge so that users remember to
> report critical bits of information such as the hardware
> configuration, the exact kernel version, which distribution userspace
> was in use, etc.
> 
> There could also be something in the text form which would make it
> easier for lore.kernel.org searches to identify bug reports.  (e.g.,
> "LINUX KERNEL BUG REPORTER TEMPLATE")

Hmmm, yeah, I like that idea. I'll keep it in mind for later: I would
prefer to get reporting-issues.rst officially blessed and
reporting-bugs.rst gone before working on further enhancements.

Maybe the best idea would be to have a script and/or webpage that helps
people creating the proper text form (which they then could simply
copy-and-paste into their mailer). I had such a script/webpage in mind
already to help with one of the IMHO biggest pain points when it comes
to reporting issues: finding where the report needs to go, as decoding
MAINTAINERS requires that you have a at least a vague idea which
component might be causing the issue – which afaics is hard even for
people that known a thing or two about the kernel. :-/

Ciao, Thorsten
