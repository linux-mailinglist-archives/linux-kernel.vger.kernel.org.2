Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC61356B07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242977AbhDGLVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhDGLVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:21:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB72FC061756;
        Wed,  7 Apr 2021 04:21:30 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lU6FV-0005Vi-1f; Wed, 07 Apr 2021 13:21:29 +0200
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1617786974.git.linux@leemhuis.info>
 <813fc7b082a4b47ec6d34542971e9bba74fd4a51.1617786974.git.linux@leemhuis.info>
 <YG2CztxS4jTia8wM@kroah.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 2/2] docs: reporting-issues: make everyone CC the
 regressions list
Message-ID: <3df9566e-bb08-f1e2-7afb-a14a28d2d64f@leemhuis.info>
Date:   Wed, 7 Apr 2021 13:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YG2CztxS4jTia8wM@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617794491;ee3826e7;
X-HE-SMSGID: 1lU6FV-0005Vi-1f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.04.21 12:00, Greg KH wrote:
> On Wed, Apr 07, 2021 at 11:21:56AM +0200, Thorsten Leemhuis wrote:
>> Make people CC the recently created mailing list dedicated to Linux
>> kernel regressions when reporting one. Some paragraphs had to be
>> reshuffled and slightly rewritten during the process, as the text
>> otherwise would have gotten unnecessarily hard to follow.
>>
>> The new text also makes reporters include a line useful for automatic
>> regression tracking solution which does not exist yet, but is planned.
>> The term "#regzb" (short for regression bot) is inspired by the "#syz"
>> which can be used to communicate with syszbot (see
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md).
> 
> While I understand the wish to automate things like this, the #syz
> marking will actually cause something to go off and do some work, and is
> only relevant for a very small number of developers, all of whom know to
> look up the instructions before doing so.  But the #regzb marking will
> be requested to be added by random users who never have submitted a
> problem report before, OR from long-time kernel developers who are lucky
> to ever remember to read the documentation as they "know" how to do
> this.
> 
> So this increased workload by people on the two ends of experience is
> going to be rough, I predict a very low rate of adoption :(

Yup, I'm aware of that. And also well aware that I will need to keep an
eye on things and jump in and reply with mails to add such tags every
time they are missing.
But I think that direction it the best shot, as tying putting all the
burden on one person (me) is likely to fail, as our history with
regression tracking showed. And I think such tags with some bot in the
background
(as outlined roughly in
https://linux-regtracking.leemhuis.info/post/hello-world/ ) have at
least the best chance, as things are not out-of-band like tracking them
in bugzilla would be – or do you think that would be a better approach
together with its email-interface?

> What is the tag going to be good for?  The reports will need to be
> handled by a person anyway and classified and tracked out-of-band from
> the list somehow.  Will a tag do all that much here?

I think is has, as then a good regression report will make the
still-to-be-written regression-bot create and entry that links to the
report and send a reply with a unique ID; then that ID needs to end up
in the commit that fixes the regression later (similar to how the IDs
for issues found by syzbot are mentioned there, which afaics works quite
well for people) and the regression-bot can close the entry automatically.

At least in this ideal scenario the regression tracker (me) wouldn't
need to do a single thing.

Obviously that ideal scenario will be rare, especially in the beginning.
But with some hand-holding from my side (by mailing tags) I hope it will
work at least sometimes (and over time more often).

But I'm open for other approaches, as I didn't start to work on the bot
yet(¹), so it's easy to go into a different direction if someone comes
up with one that looks more promising.

Ciao, Thorsten

(¹) still unsure if I should take Go code from syzbot as a base or
better go with python, as that's what the kernel.org admins iirc prefer
(or am I wrong there? I wanted to ask Konstantin about this soon anyway)
