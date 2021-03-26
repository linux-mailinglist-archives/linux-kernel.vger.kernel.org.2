Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F5134A1AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhCZGUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhCZGTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:19:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0001C0613AA;
        Thu, 25 Mar 2021 23:19:54 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lPfp3-0003VY-BD; Fri, 26 Mar 2021 07:19:53 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
Subject: [5/5] reporting-issues: addendum
Message-ID: <5ec1b7b0-08d5-e9b8-394f-e03b65534ade@leemhuis.info>
Date:   Fri, 26 Mar 2021 07:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616739594;bc4b8056;
X-HE-SMSGID: 1lPfp3-0003VY-BD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.21 07:13, Thorsten Leemhuis wrote:
> 
> Lo! Since a few months mainline in
> Documentation/admin-guide/reporting-issues.rst contains a text written
> to obsolete the good old reporting-bugs text. For now, the new document
> still contains a warning at the top that basically says "this is WIP".
> But I'd like to remove that warning and delete reporting-bugs.rst in the
> next merge window to make reporting-issues.rst fully official. With this
> mail I want to give everyone a chance to take a look at the text and
> speak up if you don't want me to move ahead for now.
> 
> For easier review I'll post the text of reporting-issues.rst in reply to
> this mail. I'll do that in a few chunks, as if this was a cover letter
> for a patch-set. 



Why some issues won't get any reaction or remain unfixed after being reported

=============================================================================



When reporting a problem to the Linux developers, be aware only 'issues of high

priority' (regressions, security issues, severe problems) are definitely going

to get resolved. The maintainers or if all else fails Linus Torvalds himself

will make sure of that. They and the other kernel developers will fix a lot of

other issues as well. But be aware that sometimes they can't or won't help; and

sometimes there isn't even anyone to send a report to.



This is best explained with kernel developers that contribute to the Linux

kernel in their spare time. Quite a few of the drivers in the kernel were

written by such programmers, often because they simply wanted to make their

hardware usable on their favorite operating system.



These programmers most of the time will happily fix problems other people

report. But nobody can force them to do, as they are contributing voluntarily.



Then there are situations where such developers really want to fix an issue,

but can't: sometimes they lack hardware programming documentation to do so.

This often happens when the publicly available docs are superficial or the

driver was written with the help of reverse engineering.



Sooner or later spare time developers will also stop caring for the driver.

Maybe their test hardware broke, got replaced by something more fancy, or is so

old that it's something you don't find much outside of computer museums

anymore. Sometimes developer stops caring for their code and Linux at all, as

something different in their life became way more important. In some cases

nobody is willing to take over the job as maintainer – and nobody can be forced

to, as contributing to the Linux kernel is done on a voluntary basis. Abandoned

drivers nevertheless remain in the kernel: they are still useful for people and

removing would be a regression.



The situation is not that different with developers that are paid for their

work on the Linux kernel. Those contribute most changes these days. But their

employers sooner or later also stop caring for their code or make its

programmer focus on other things. Hardware vendors for example earn their money

mainly by selling new hardware; quite a few of them hence are not investing

much time and energy in maintaining a Linux kernel driver for something they

stopped selling years ago. Enterprise Linux distributors often care for a

longer time period, but in new versions often leave support for old and rare

hardware aside to limit the scope. Often spare time contributors take over once

a company orphans some code, but as mentioned above: sooner or later they will

leave the code behind, too.



Priorities are another reason why some issues are not fixed, as maintainers

quite often are forced to set those, as time to work on Linux is limited.

That's true for spare time or the time employers grant their developers to

spend on maintenance work on the upstream kernel. Sometimes maintainers also

get overwhelmed with reports, even if a driver is working nearly perfectly. To

not get completely stuck, the programmer thus might have no other choice than

to prioritize issue reports and reject some of them.



But don't worry too much about all of this, a lot of drivers have active

maintainers who are quite interested in fixing as many issues as possible.





Closing words

=============



Compared with other Free/Libre & Open Source Software it's hard to report

issues to the Linux kernel developers: the length and complexity of this

document and the implications between the lines illustrate that. But that's how

it is for now. The main author of this text hopes documenting the state of the

art will lay some groundwork to improve the situation over time.
