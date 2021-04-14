Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C835F196
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhDNKli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhDNKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:41:35 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608CCC061574;
        Wed, 14 Apr 2021 03:41:10 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lWcxC-0000vp-4h; Wed, 14 Apr 2021 12:41:02 +0200
To:     w4v3 <vv4v3@protonmail.com>, "corbet@lwn.net" <corbet@lwn.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <vaWPnw1Txo_MD5Sf-BnMmq3pBTkITza0W5p_jAi8JIy3hBAbCsKPXZ5g5IHKYGqK6zLjzUNgJ59xMCHvhREBUq6Vc1105b8yCIVDgaPABqE=@protonmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: "Reporting issues" document feedback
Message-ID: <dff6badf-58f5-98c8-871c-94d901ac6919@leemhuis.info>
Date:   Wed, 14 Apr 2021 12:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <vaWPnw1Txo_MD5Sf-BnMmq3pBTkITza0W5p_jAi8JIy3hBAbCsKPXZ5g5IHKYGqK6zLjzUNgJ59xMCHvhREBUq6Vc1105b8yCIVDgaPABqE=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1618396872;41536736;
X-HE-SMSGID: 1lWcxC-0000vp-4h
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[CCing Rafael]

Beforehand: many thx for your feedback and for reporting the bug you
faced, much appreciated.

On 13.04.21 23:18, w4v3 wrote:

> I would like to make some suggestions regarding the "Reporting
> issues" document 
> (https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> <https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html>).
>
>  I recently tried to submit a bug report, and since that was my
> first time of doing so I closely read through said document.

Glad to see it being read :-D

> Now it
> makes it very clear that one should consult the maintainers file on
> how to proceed and that in most cases, bugzilla is not the right
> place to submit a bug. It does however say that if the entry contains
> a line starting with "bugs:", then I should file my issue with the
> indicated bug tracker.
> 
> My problem was ACPI-related, and the corresponding entry in the 
> maintainers file does have a line with "bugs:" pointing to bugzilla.
> I concluded that it would be sufficient to file the bug there (after
> all, bugzilla asks you identify the subsystem and seemingly forwards
> the issue to the appropriate email address), but I don't think it was
> since I didn't receive any response, and after looking into the
> archive of the mailing list of the subsystem I could see that
> meanwhile, 

Links to your bug report and the thread on the mailing list would have
helped here to understand better what's going on, but whatever, they are
not that important.

> the same bug had been reported (and dealt with) on that list.
> Admittedly, it does say in the document that if there is no "bugs:"
> line and "in many other cases", one should write an email to the
> maintainer and the mailing list, but I don't think it's very clear.
> To make it even more fool(like me)proof, it'd be worth pointing out
> that the existence of a "bugs:" line does not imply that simply
> submitting the bug there is enough to call attention to it.

But it should, otherwise the subsystem should remove the line starting
with B: ("bugs:" in the webview).

Rafael might be able to clarify things.

But afais it's appropriate there is a B: line: just a few weeks ago I
took a quick look at bugzilla and ACPI bugs in particular, and back then
most of the bug reports there got handled by the maintainers. That's why
I assume you were just unlucky and your report fall through the cracks
(but obviously I might be wrong here). And maybe your report even did
help: the developer that fixed the issue might have seen both the bug
entry and the mailed report, but simply forget to close the former.

Things like that can not be prevented completely, as all of us are just
humans. :-/

> Conversely, I'm surprised that despite the ACPI subsystem having 
> bugzilla as designated bug tracker, the issue was only reported on
> the mailing list

If there is a B: entry in MAINTAINERS, then afaik that's the preferred
way to report bugs. But kernel development is driven by mail, hence
there will always be someone to report an issue by mail. That's not
ideal, but that's how it is. :-/ That's mainly an issue for the few
subsystems that have a B: entry, as they need to watch two areas.

> and not on bugzilla (except by me). This makes it
> seem like all the "bugs:" line indicates is that the given bug
> tracker has a section for that subsystem, which may be neither
> necessary nor sufficient for bug reporting. If this is the case then
> stating this could clarify how to understand the maintainers file.

Let's see what Rafael says.

But your mail showed me that indeed there is one aspect that
reporting-issues currently does not cover: in cases like yours reporters
are better off checking both the mailing list archives and the bug
tracker before reporting a bug.

Again, thx for your feedback! Have a nice day!

Ciao, Thorsten
