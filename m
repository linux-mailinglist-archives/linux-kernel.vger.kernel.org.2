Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9942E4412CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 05:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhKAEwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 00:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhKAEwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 00:52:17 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59764C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 21:49:44 -0700 (PDT)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mhPGP-0007bs-00; Mon, 01 Nov 2021 05:49:41 +0100
Message-ID: <a365ffb9-a4d2-b1d7-7cd7-dd9d7039e04e@leemhuis.info>
Date:   Mon, 1 Nov 2021 05:49:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Thorsten is tracking regression again and could need a little help
 (was: Re: Linux 5.15)
Content-Language: en-BS
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1635742184;1bad6e4a;
X-HE-SMSGID: 1mhPGP-0007bs-00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.21 22:09, Linus Torvalds wrote:
> It's been calm, and I have no excuse to add an extra rc, so here we
> are, with v5.15 pushed out, and the merge window starting tomorrow.

TLDR: Please tell me directly (by CC or forward) or via regzbot (see
below) about any regression reports you stumble upon, as I'm giving
regression tracking another shot. This time I'm doing it with the help
of a bot, which really could need a lot to chew on for a proper test-run.

Hi everyone! Years ago I did regression tracking for the Linux kernel
for a while. Back then tracking and writing weekly reports was a manual
and quite exhausting effort. Nevertheless, I'm giving regression
tracking another shot. But this time I'll leave the hard work to a bot I
wrote just for this purpose, which is specifically tailored to the needs
of Linux kernel development. I tested this 'regzbot' a little in the
past few weeks, but I need more regression reports now to shake out bugs
and see where things might need big adjustments or fine-tuning.

Hence, if you see any regression reports, please tell be about them, for
example by simply forwarding the mail to regressions@leemhuis.info or
CCing that address on a reply. I'll handle everything else then and tell
regzbot about it. But if you feel adventurous, you can also skip me as
the man-in-the-middle and tell the bot directly. To do that, just send a
reply to the report to the regressions mailing list
(regressions@lists.linux.dev) either directly or by CCing it on a reply
you would have written anyway; when doing so, place something like
'#regzbot ^introduced v5.15..' (separated by blank lines) somewhere in
the text, as outlined in regzbot's 'getting started guide' or its
reference documentation:
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

That's it, regzbot then on its next run will add the report to the list
of tracked regression. I'll keep an eye on things and try to fix any
problems I notice, as there likely will be a few. But then doesn't need
to bother you.

There is one thing that would really help: if one or two subsystem
maintainers could give regzbot a shot for all the regression reports
they get, even for easy fixes, as the bot really needs something to chew
on. Any volunteers?

As years ago I'll send weekly regression reports, but this time they
will get generated directly from regzbot. But thx to the bot there is
now also a web-view which provides an always up2date view into the data
gathered by regzbot:
https://linux-regtracking.leemhuis.info/regzbot/mainline/

Ciao, Thorsten
