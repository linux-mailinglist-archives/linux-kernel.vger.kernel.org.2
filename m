Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3345C735
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbhKXO2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352387AbhKXO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:28:06 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36766C08EC3D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:52:31 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mprlF-0004DR-BH; Wed, 24 Nov 2021 13:52:29 +0100
Message-ID: <4f03875f-36ad-bbdb-2948-976af6bdcdc2@leemhuis.info>
Date:   Wed, 24 Nov 2021 13:52:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Linux regressions report for mainline [2021-11-24]
Content-Language: en-BS
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <163774583541.221636.5062449110647587402@leemhuis.info>
 <ed60649f-db15-db1d-f7b5-a0878f639d64@leemhuis.info>
 <YZ4b7N4OTjypAtc7@kroah.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YZ4b7N4OTjypAtc7@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1637758351;de8f5a43;
X-HE-SMSGID: 1mprlF-0004DR-BH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.11.21 12:03, Greg KH wrote:
> On Wed, Nov 24, 2021 at 11:01:52AM +0100, Thorsten Leemhuis wrote:
>> Lo! This was the first report sent by regzbot, my Linux kernel
>> regression tracking bot, so I guess it might be a good idea to highlight
>> a few of it's aspects:
>>
>> On 24.11.21 10:25, Regzbot (on behalf of Thorsten Leemhuis) wrote:
>>> From: Regzbot (for Thorsten Leemhuis) <regressions@leemhuis.info>
>>>
>>> Hi, this is regzbot, the Linux kernel regression tracking bot.
>>>
>>> Currently I'm aware of 15 regressions in linux-mainline. Find the
>>> current status below and the latest on the web:
>>>
>>> https://linux-regtracking.leemhuis.info/regzbot/mainline/
>>>
>>> Bye bye, hope to see you soon for the next report.
>>>    Regzbot (on behalf of Thorsten Leemhuis)
>>
>> >From now on I plan to make regzbot send such reports on Monday mornings,
>> e.g. usually a few hours after Linus released a new RC.
>>
>> Let me know what you think about the format.
>>
>> A few random thoughts and explanations about the current format:
>>
>> - next weeks report will highlight regressions that get added to regzbot
>> over the next few days
>>
>> - I chose to categorize the regressions by identification status and by
>> version line. Those where the culprit is identified come first, as they
>> are the ones which most of the time can be solved by reverting the culprit
>>
>> - the entries in each section are ordered by time of last activity,
>> which makes it easy to spot those where nothing happened recently, as
>> they are near the end of a section.
>>
>> - the webui (https://linux-regtracking.leemhuis.info/regzbot/mainline/ )
>> links to the latest five activities regzbot noticed (an activity most of
>> the time will be a mail send in reply to the report or a related thread
>> that regzbot monitors). I for now chose to not do that in the report, as
>> it would make it much longer and might be something that spam filters
>> consider suspicious.
>>
>> That's it from my side. Let me know what you think.
> 
> I like it,

Glad to hear. Many thx for the feedback!

> but as a maintainer, I find this hard to know what to do with
> it.

Well, I designed this a bit more for the tree maintainer, so Linus can:

(1) see when things are not moving forward as quickly as he'd like to
and get involved in the discussions or revert a commit

(2) decide if he wants to release another rc or the final

> As a maintainer, I want to be reminded of what regressions have been
> reported for my subsystem, so I know what to do and who to go poke about
> them.
> 
> I could dig through the list and try to see if these are relevant to me,
> but it's not always obvious.

Yeah, that true. :-/

> How about something like "one email per issue" as a response from the
> first report, that would cc: the needed maintainers (or people from
> MAINTAINERS, you should be able to get that automatically from
> get_maintainer.pl) and the subsystem mailing list (again from
> get_maintainers.pl), so that I am constantly reminded that "you need to
> get this fixed!".

I'll keep this idea in mind. But that would result in a lot of mails.
That's something I like to avoid, as we all get enough mails already: if
regzbot starts to spam people, then some people might set up a mental or
procmail filter to ignore all of them.

That's why I settled on a different strategy:

> Pester me, it's my job as a maintainer to get regressions resolved.

I'm pestering developers and maintainers already, but I do it only when
it seems to be needed. And I do it manually for now; I intend to make
regzbot do it automatically sooner or later, but first I want to get a
better feeling when it's appropriate to pester people without getting
them quickly annoyed -- e.g. after what time and in which situations.

Here for example I asked why a patch didn't proceed, and got a reply
from the maintainer:
https://lore.kernel.org/regressions/cfac5f5c-83d7-e0d9-5368-07ca041ebaed@leemhuis.info/
Seems the patch still didn't get any farther, so I guess it soon time
for me to poke again.

In another thread two pokes both helped to get things rolling again, but
seems I soon need to send a third one, as it seems no one really feels
responsible:
https://lore.kernel.org/lkml/40550C00-4EE5-480F-AFD4-A2ACA01F9DBB@live.com/

Those are just two examples, I poked a few more discussions already and
it most of the time helped.

IOW: for now I'm trying the strategy "only send mails when its needed".

But this made me aware that I should teach regzbot one thing: if the
culprit is known, it should check if everyone in the SOB chain of the
change is CCed to the discussion on the regression.

>  If
> I see a long list with no names on it, It's easier for me to just ignore
> :)>
> Anyway, I know that's more work for you, don't do it if you don't want
> to, but as you have individual items in your database already, maybe it
> is easy to do,

Not really, as for now regzbot doesn't assign regressions to a
subsystem. I could add that, but how to fill and maintain that
association? When the culprit is known, regzbot should be able to fill
it automatically using the SOB chain or the path of the merge. But if
it's not, it becomes something that some human would need to do
manually. I really tried hard to avoid anything that requires manual
work, as it always hard to make people do it :-/

That being said: I'm pretty sure I sooner or later will make regzbot
store a association to a subsystem.

> I don't know.  Thanks again for doing this work, it's
> great to see happen.

thx again!

Ciao, Thorsten
