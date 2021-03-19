Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EAD342650
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhCSTeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhCSTeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:34:13 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F6FC06174A;
        Fri, 19 Mar 2021 12:34:13 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lNKst-0004ZE-M5; Fri, 19 Mar 2021 20:34:11 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210310072858.231776-1-linux@leemhuis.info>
 <874khc1844.fsf@meer.lwn.net>
 <72d42b6c-e7d3-0243-d547-b5270dc00ef0@leemhuis.info>
Subject: Re: [PATCH v1, RFC] docs: reporting-issues.rst: tone down 'test
 vanilla mainline' a little
Message-ID: <ec08039a-a7b9-717f-2b7e-fddb453d2ae6@leemhuis.info>
Date:   Fri, 19 Mar 2021 20:34:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <72d42b6c-e7d3-0243-d547-b5270dc00ef0@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616182453;1da37deb;
X-HE-SMSGID: 1lNKst-0004ZE-M5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.21 18:56, Thorsten Leemhuis wrote:
> On 15.03.21 21:20, Jonathan Corbet wrote:
>> Thorsten Leemhuis <linux@leemhuis.info> writes:
>
>>  Anything that could be done to
>> make it more concise going forward would be more than welcome.
> Yeah, will think about it, especially WRT to the other patch you looked
> at. Maybe I can come up with something. But no promises, I put a lot of
> thought into the problem already.

FWIW, just sent out a new series that IMHO at least is a small step in
the right direction:

https://lore.kernel.org/linux-doc/cover.1616181657.git.linux@leemhuis.info/

Hard to see in the diffs, might be wise to look at the end result.

I added this patch to the series as things otherwise might get hard to
handle.

>> Also, I would stop quoting terms like "mainline", "stable" and "vanilla"
>> throughout.  It makes the reading experience a bit stranger without
>> (IMO) adding anything.
> Yeah, let me provide a patch to reduce the quoting. If it's okay for you
> I'd like to leave the quotes in the section that round about explains
> the terms mainline, stable, and longterm. I think it's wise there to
> point out that these are terms that have a special meaning in kernel
> context. That's why I quoted them in a lot of places – especially those
> where the reader might see them for the first time, as "stable" is kind
> of ambiguous, which I wanted to avoid somehow.

In the latest patch (
https://lore.kernel.org/linux-doc/652ee20eb36228f5d7ca842299faa4cb472feedb.1616181657.git.linux@leemhuis.info/
) I removed most of the quoting. I didn't touch other parts of the file
for now. Waiting for an option on this and then will address it in a
septate patch in one go.

> Which brings me to another, but related issue. That patch could also fix
> an inconsistency I recently noticed: how to spell panic, oops, bug,
> warning? I sometimes quoted them  because in kernel context they have
> special meaning, as a BUG() is not some random bug... And is it Oops or
> oops (I recently noticed I used both spellings, but I found both when I
> grepped Documentation/)? Here are some options:
> 
> 1) panic, oops, bug, warning
> 2a) 'panic', 'oops', 'bug', 'warning',
> 2b) *panic*, *oops*, *bug*, *warning*,
> 3) panic, Oops, BUG, WARNING,
> 4) panic, Oops, BUG(), WARN()
> 
> The problem there is similar with the term 'stable': the words bug and
> warning are ambiguous for people that are not familiar with the terms
> used by the kernel community. Putting them in quotes at least give a
> subtle hint like "this term might have a special meaning". It works for
> my subconscious, but I guess won't for many others.
> 
> Nevertheless I'd go option 2a or 2b above: doesn't look to ugly (like 3
> and 4) and avoids being ambiguous (like 1, which I for one don't like at
> all).
> 
> What's your opinion on this? Or do you say "ohh, you are overthinking
> it, just go with option 1!". :-D

Ciao, Thorsten
