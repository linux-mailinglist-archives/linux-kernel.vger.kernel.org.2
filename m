Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F325B441BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhKANg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhKANg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:36:56 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9692C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 06:34:23 -0700 (PDT)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mhXSA-0002hd-AR; Mon, 01 Nov 2021 14:34:22 +0100
Message-ID: <d757b7c0-9d6d-a3ad-8bd0-748396db5861@leemhuis.info>
Date:   Mon, 1 Nov 2021 14:34:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Thorsten is tracking regression again and could need a little
 help (was: Re: Linux 5.15)
Content-Language: en-BS
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
 <a365ffb9-a4d2-b1d7-7cd7-dd9d7039e04e@leemhuis.info>
 <YX/ekB+9F9xvHCB7@kroah.com>
 <da21322a-95e8-40f9-a718-fa1e56eb203f@leemhuis.info>
 <YX/lnI5gX4TAF5Ea@kroah.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YX/lnI5gX4TAF5Ea@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1635773663;d3256abc;
X-HE-SMSGID: 1mhXSA-0002hd-AR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.11.21 14:03, Greg KH wrote:
> On Mon, Nov 01, 2021 at 01:44:01PM +0100, Thorsten Leemhuis wrote:
>> On 01.11.21 13:33, Greg KH wrote:
>>> On Mon, Nov 01, 2021 at 05:49:40AM +0100, Thorsten Leemhuis wrote:
>>>> example by simply forwarding the mail to regressions@leemhuis.info or
>>>> CCing that address on a reply. I'll handle everything else then and tell
>>>> regzbot about it. But if you feel adventurous, you can also skip me as
>>>> the man-in-the-middle and tell the bot directly. To do that, just send a
>>>> reply to the report to the regressions mailing list
>>>> (regressions@lists.linux.dev) either directly or by CCing it on a reply
>>>> you would have written anyway; when doing so, place something like
>>>> '#regzbot ^introduced v5.15..' (separated by blank lines) somewhere in
>>>> the text, as outlined in regzbot's 'getting started guide' or its
>>>> reference documentation:
>>>> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
>>>> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
>>>>
>>>> That's it, regzbot then on its next run will add the report to the list
>>>> of tracked regression. I'll keep an eye on things and try to fix any
>>>> problems I notice, as there likely will be a few. But then doesn't need
>>>> to bother you.
>>>>
>>>> There is one thing that would really help: if one or two subsystem
>>>> maintainers could give regzbot a shot for all the regression reports
>>>> they get, even for easy fixes, as the bot really needs something to chew
>>>> on. Any volunteers?
>>>
>>> I'll try it for the USB subsystem this merge cycle. 
>>
>> That will be a great help, many thx.
>>
>>> Do you want a bug
>>> report email redirected to that address or will a simple forward work
>>> well enough?
>>
>> Redirecting will make it a little easier for me, but a simple forward is
>> fine, too.
> 
> Ok, I did that now for a USB bug report, hopefully that worked.  If not,
> I can forward it on.

Got it, but I could need some advice on it if you have a minute.

Does that report really look like a regression from your point of view?
The part "The code has been this way in the kernel for a very long time,
which suggests that it has been working, [...]" sounds like it is, but
OTOH it's quite vague.

I'm asking, because with my regression tracking work and regzbot I focus
on regressions and ignore things that were always broken, as I (at least
for now) don't want it to become yet another bug tracker (and I guess I
would quickly drown in bugs as well).

But if you think this case looks like a regression, I'll add it. Guess I
just need to be creative then how to tell regzbot when it got
introduced. Guess I'll settle on v2.6.13..v5.15", that should indicate
there is something strange here. It's a use-case I hadn't expected. But
well, that's why I wanted to something for testing. :-D

Ciao, Thorsten
