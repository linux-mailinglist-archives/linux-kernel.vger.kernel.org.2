Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD53369094
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242210AbhDWKuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhDWKuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:50:05 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF80C061574;
        Fri, 23 Apr 2021 03:49:29 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lZtNG-0000is-Iv; Fri, 23 Apr 2021 12:49:26 +0200
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        regressions@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        ksummit@lists.linux.dev, workflows@vger.kernel.org
References: <268a3049-7c0b-8a33-1ff6-5a2d35fcba16@leemhuis.info>
 <YIKdQKJNZOSfdL9B@kroah.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: RFC: building a regression tracking bot for Linux kernel
 development
Message-ID: <8a44e6b3-fff4-ea6f-2643-bb2a15ff990a@leemhuis.info>
Date:   Fri, 23 Apr 2021 12:49:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YIKdQKJNZOSfdL9B@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1619174969;57bf2832;
X-HE-SMSGID: 1lZtNG-0000is-Iv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.04.21 12:11, Greg KH wrote:
> On Thu, Apr 22, 2021 at 09:16:40AM +0200, Thorsten Leemhuis wrote:
>> Lo! As mentioned a few times recently I'm staring to build a bot for
>> semi-automatic Linux kernel regressions tracking. Find below a rough
>> description of how I imagine it's going to work. That way I want to give
>> everyone a chance to influence things before I'm starting to code for
>> real. Early feedback will help to build something that's acceptable for
>> the Linux kernel developer community and used in practice in the long
>> run, and that's what I aim for.
>>
>> I know, I know, "Talk is cheap. Show me the code.". But I had to think
>> things through and write some of it down anyway, so no harm done in
>> posting it as RFC. I CCed ksummit, as many maintainers hang out there
>> and because this is a follow up to my former regression tracking work we
>> discussed on both kernel and maintainers summit 2017; it fact it
>> hopefully might be something for this year as well, we'll see, too early
>> to tell.
>>
>> So how will the "regzbot" work? The ideal case is simple:
>>
>> Someone reports a regression to the recently created regressions mailing
>> list(regressions@lists.linux.dev). There the user includes a tag like this:
>>> #regzb introduced: 94a632d91ad1 ("usc: xhbi-foo: check bar_params earlier")
> 
> That's great, but the ability for most people to track stuff down to the
> commit id feels very low.  I would think that the "this no longer works"
> is the bug report / regression, and eventually that can be tracked down
> to "commit XXXX caused this" which is what you want to see above.
> 
> Or am I confused?

Sorry, I should have made it more obvious that I leave some stuff out
initially and get to aspect like that later. :-/

[…]
>> That can't be all
>> -----------------
>>
>> Of course the world is more complicated than the simple example scenario
>> above, as the devil is always in the details. The three most obvious
>> problems the initial ideal scenario left aside:
>>
>> * The reporter doesn't specify the #regzb tag at all. Regzbot can't do
>> anything about it, it sadly won't have visionary power and a AI engine
>> any time soon. Some human (for a while that often will be me) thus needs
>> to reply with the tag with a proper reply-to to the report to make
>> regboz track it.
> 
> Any specific format/tag we can use to help make this easier?  Or is that
> just something that you are going to do "by hand" to start with?

For now making sure regressions@lists.linux.dev is added to the CCed of
any replies to regression reports would be a really big help to already
establish it as central place where they are all visible. Then no human
or bot needs to monitor hundreds of mailing list to find them -- which
obviously is doomed to fail and was one of the pain points when I
tracked regressions manually years ago.

And in the long run of course everyone is free to use those tags
(obviously they won't help before I get that bot running), but for in
the beginning it will be mainly "me doing it by hand"...

>>  * regression in stable and longterm kernels sometimes affect multiple
>> versions, for example if a patch that works fine in mainline was
>> backported to the longterm kernel 5.10 and 5.4 – but causes problems in
>> both, as something required by the patch is missing in those lines. How
>> this will be solved exactly remains to be seen, maybe like this:
>>> #regzb Introduced: c39667ddcfd6 e39667ddcfd1 ("usc: xhbi-foo: check bar_params a little later again")
>>
>>  Then regzbot can look those commits up and from that determine the
>> affected versions. Obviously the reporter will likely not be aware of
>> it, hence it's likely that the stable maintainer or the developer need
>> to send a mail to make regzbot aware that this regression affects
>> multiple versions.
> 
> This shouldn't be that big of an issue, as the stable maintainers have
> simple tools that can show "what releases was this commit in" today,
> which is what we use to track what commits need to be backported where.
> 
> I can give you a copy of my tools off-line if you are curious about this
> and think it's worth adding to your tool.

Guess I might get back to that sooner or later, but if you already have
something to handle that I might ignore that case initially and focus on
other aspects to make sure that stuff gets properly off the ground.

> Oh, and many thanks for doing this, I think this looks great.

Thx for taking a look. Feels good to hear that, as I really don't want
to build something which in the end doesn't get used.

Ciao, Thorsten

P.S.: There is one thing I forgot to mention: regzbot will obviously in
the long run also be able to generate reports in text form and send them
to Linus or LKML occasionally (likely once a week before or after a new rc).
