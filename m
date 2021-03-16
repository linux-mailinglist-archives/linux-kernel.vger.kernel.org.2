Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3600233DBB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbhCPR55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbhCPR4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:56:35 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A166EC06174A;
        Tue, 16 Mar 2021 10:56:33 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lMDvg-00089h-6R; Tue, 16 Mar 2021 18:56:28 +0100
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210310072858.231776-1-linux@leemhuis.info>
 <874khc1844.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v1, RFC] docs: reporting-issues.rst: tone down 'test
 vanilla mainline' a little
Message-ID: <72d42b6c-e7d3-0243-d547-b5270dc00ef0@leemhuis.info>
Date:   Tue, 16 Mar 2021 18:56:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <874khc1844.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1615917393;45c58f66;
X-HE-SMSGID: 1lMDvg-00089h-6R
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.21 21:20, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
>> Tell users that reporting bugs with vendor kernels which are only
>> slightly patched can be okay in some situations, but point out there's a
>> risk in doing so.
>>
>> Adjust some related sections to make them compatible and a bit clearer.
>> At the same time make them less daunting: we want users to report bugs,
>> even if they can't test vanilla mainline kernel.
>>
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> CC: Randy Dunlap <rdunlap@infradead.org>
>>
>> ---
>> With this I try to get rid of the last remaining parts that have a
>> 'this needs discussion' box that's in the text. I hope I've found a
>> middle ground that everybody can live with.
> 
> For the most part it seems OK to me.

Thx for looking at it!

> I *really* worry, though, that this file is getting so big that few
> people will work their way through it.

Yeah, this is a problem, definitely, but the document was written to
make sure that nobody has to work their way through it, as the "step by
step" guide tells all the important things already – and that guide
(even with this patch and the other one that you looked at yesterday)
should still be shorter (and clearer) then the old "reporting bugs" text
(I hope, I didn't verify...).

>  Anything that could be done to
> make it more concise going forward would be more than welcome.

Yeah, will think about it, especially WRT to the other patch you looked
at. Maybe I can come up with something. But no promises, I put a lot of
thought into the problem already.

The real solution for the problem IMHO looks totally different anyway:
provide pre-compiled kernels somewhere that users can install and even
bisect without installing a compiler at all (sure, there is a the
problem with the configuration, but whatever, just pick one and see how
things work out). Would be a fun project I'd really like to work on
sooner or later, but for now I have different priorities...

> [...]
>> +   suspend your efforts for a few days anyway. Whatever version you choose,
>> +   ideally use a 'vanilla' built. Ignoring these advices will dramatically
>> +   increase the risk you report will be rejected or ignored.
> s/built/build/

Argh, thx for pointing it out.

> Also, I would stop quoting terms like "mainline", "stable" and "vanilla"
> throughout.  It makes the reading experience a bit stranger without
> (IMO) adding anything.

Yeah, let me provide a patch to reduce the quoting. If it's okay for you
I'd like to leave the quotes in the section that round about explains
the terms mainline, stable, and longterm. I think it's wise there to
point out that these are terms that have a special meaning in kernel
context. That's why I quoted them in a lot of places – especially those
where the reader might see them for the first time, as "stable" is kind
of ambiguous, which I wanted to avoid somehow.

Which brings me to another, but related issue. That patch could also fix
an inconsistency I recently noticed: how to spell panic, oops, bug,
warning? I sometimes quoted them  because in kernel context they have
special meaning, as a BUG() is not some random bug... And is it Oops or
oops (I recently noticed I used both spellings, but I found both when I
grepped Documentation/)? Here are some options:

1) panic, oops, bug, warning
2a) 'panic', 'oops', 'bug', 'warning',
2b) *panic*, *oops*, *bug*, *warning*,
3) panic, Oops, BUG, WARNING,
4) panic, Oops, BUG(), WARN()

The problem there is similar with the term 'stable': the words bug and
warning are ambiguous for people that are not familiar with the terms
used by the kernel community. Putting them in quotes at least give a
subtle hint like "this term might have a special meaning". It works for
my subconscious, but I guess won't for many others.

Nevertheless I'd go option 2a or 2b above: doesn't look to ugly (like 3
and 4) and avoids being ambiguous (like 1, which I for one don't like at
all).

What's your opinion on this? Or do you say "ohh, you are overthinking
it, just go with option 1!". :-D

Ciao, Thorsten
