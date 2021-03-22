Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A57344F51
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhCVSzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhCVSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:55:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD795C061574;
        Mon, 22 Mar 2021 11:55:36 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lOPi6-0003ws-TQ; Mon, 22 Mar 2021 19:55:31 +0100
To:     Eric Wong <e@80x24.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <20210322171636.fkep2lby6gnve4su@chatter.i7.local>
 <e93ad98a34828a4140fa59c1fb5b01f03c6f4245.camel@HansenPartnership.com>
 <20210322183427.GA1195@dcvr>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: RFC: create mailing list "linux-issues" focussed on issues/bugs
 and regressions
Message-ID: <09a6256e-0015-d360-9347-f025a7d5adfd@leemhuis.info>
Date:   Mon, 22 Mar 2021 19:55:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210322183427.GA1195@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BW
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616439337;49c397b1;
X-HE-SMSGID: 1lOPi6-0003ws-TQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.21 19:34, Eric Wong wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>> On Mon, 2021-03-22 at 13:16 -0400, Konstantin Ryabitsev wrote:
>>> On Mon, Mar 22, 2021 at 04:18:14PM +0100, Thorsten Leemhuis wrote:
>>>> Note, there is a second reason why ksummit-discuss is CCed: another
>>>> reason why I want to create this new list is making it easier to
>>>> find and track regressions reported to our various mailing lists
>>>> (often without LKML in CC, as for some subsystems it's seems to be
>>>> custom to not CC it). 
>>>
>>> FYI, there will soon be a unified "search all of lore.kernel.org
>>> regardless of the list/feed source" capability

Ahh, nice, thx to everyone working on that!

> [...]
>>> Once we have this ability, we should be able to plug in multiple
>>> sources beyond just mailing lists, including a feed of all
>>> bugzilla.kernel.org changes.

Out of curiosity: will that work for other bug trackers as well? Like
the gitlab instance used by the drm developers? It's not really
important and I guess the answer will be "no", but the question came up
while at it...

>>> This should allow someone an easy way to
>>> query specific bugs and may not require the creation of a separate
>>> list.
>>>
>>> I'm not opposed to the creation of a new list, of course -- just want
>>> to make sure it's aligned with the improvements we are working to
>>> make available.
>>
>> I suspect the problem is that there's no known useful search string to
>> find a bug report even given a searchable set of lists,

Exactly. Due to my work on reporting-issues.rst I try to look at it from
the users point of view. And they currently have no easy way to search
for existing reports without getting lots of other stuff mixed into the
results they are not interested in. That makes it hard. :-/

>> so the main
>> purpose of this list would be "if it's on here, it's a bug report" and
>> the triage team

If one exists ;-)

>> can cc additional lists as appropriate.  Then we simply
>> tell everyone to send kernel bugs to this list and ask maintainers to
>> cc it if a bug report shows up on their list?
> 
> It seems having "bug" or "regression" in the subject could be sufficient?
>
> "s:Regression" or "s:Bug" can be used to query messages reasonably
> quickly:

Could, but I fear it might fail, as modifying the subject is a little
unusual to the normal working style; but "adding people and appropriate
mailing lists to the CC" OTOH is something that people do every day.

And that's why I still think having a separate list is the best idea.
But using tags is totally fine for me, if that the general consensus.

Ciao, Thorsten
