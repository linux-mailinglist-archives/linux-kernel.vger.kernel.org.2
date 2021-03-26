Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B407A34A196
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhCZGPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhCZGPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:15:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9226AC0613AA;
        Thu, 25 Mar 2021 23:15:20 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lPfkc-0001k7-7n; Fri, 26 Mar 2021 07:15:18 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
Subject: [1/5] reporting-issues: header and TLDR
Message-ID: <6a220d2c-568e-2e41-53a4-0800e206d0a6@leemhuis.info>
Date:   Fri, 26 Mar 2021 07:15:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616739320;e5502eab;
X-HE-SMSGID: 1lPfkc-0001k7-7n
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

Here we go:

.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)

..

   If you want to distribute this text under CC-BY-4.0 only, please use 'The

   Linux kernel developers' for author attribution and link this as source:

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-issues.rst

..

   Note: Only the content of this RST file as found in the Linux kernel sources

   is available under CC-BY-4.0, as versions of this text that were processed

   (for example by the kernel's build system) might contain content taken from

   files which use a more restrictive license.





Reporting issues

++++++++++++++++





The short guide (aka TL;DR)

===========================



If you're facing multiple issues with the Linux kernel at once, report each

separately to its developers. Try your best guess which kernel part might be

causing the issue. Check the :ref:`MAINTAINERS <maintainers>` file for how its

developers expect to be told about issues. Note, it's rarely

`bugzilla.kernel.org <https://bugzilla.kernel.org/>`_, as in almost all cases

the report needs to be sent by email!



Check the destination thoroughly for existing reports; also search the LKML

archives and the web. Join existing discussion if you find matches. If you

don't find any, install `the latest Linux mainline kernel

<https://kernel.org/>`_. Make sure it's vanilla, thus is not patched or using

add-on kernel modules. Also ensure the kernel is running in a healthy

environment and is not already tainted before the issue occurs.



If you can reproduce your issue with the mainline kernel, send a report to the

destination you determined earlier. Make sure it includes all relevant

information, which in case of a regression should mention the change that's

causing it which can often can be found with a bisection. Also ensure the

report reaches all people that need to know about it, for example the security

team, the stable maintainers or the developers of the patch that causes a

regression. Once the report is out, answer any questions that might be raised

and help where you can. That includes keeping the ball rolling: every time a

new rc1 mainline kernel is released, check if the issue is still happening

there and attach a status update to your initial report.



If you can not reproduce the issue with the mainline kernel, consider sticking

with it; if you'd like to use an older version line and want to see it fixed

there, first make sure it's still supported. Install its latest release as

vanilla kernel. If you cannot reproduce the issue there, try to find the commit

that fixed it in mainline or any discussion preceding it: those will often

mention if backporting is planed or considered too complex. If backporting was

not discussed, ask if it's in the cards. In case you don't find any commits or

a preceding discussion, see the Linux-stable mailing list archives for existing

reports, as it might be a regression specific to the version line. If it is,

report it like you would report a problem in mainline (including the

bisection).



If you reached this point without a solution, ask for advice one the

subsystem's mailing list.

