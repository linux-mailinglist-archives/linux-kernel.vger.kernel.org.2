Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E42D34A1AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCZGTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhCZGTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:19:08 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD0EC0613AA;
        Thu, 25 Mar 2021 23:19:07 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lPfoI-000699-86; Fri, 26 Mar 2021 07:19:06 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
Subject: [4/5] reporting-issues: reference section, stable and longterm
 sub-processes
Message-ID: <35d0c21d-1983-c197-f2e7-eea4ae17ddb2@leemhuis.info>
Date:   Fri, 26 Mar 2021 07:19:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616739548;d519915c;
X-HE-SMSGID: 1lPfoI-000699-86
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.21 07:13, Thorsten Leemhuis wrote:
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


Reference for "Reporting issues only occurring in older kernel version lines"

-----------------------------------------------------------------------------



This subsection provides details for step you need to perform if you face a

regression within a stable and longterm kernel line.



Make sure the particular version line still gets support

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



    *Check if the kernel developers still maintain the Linux kernel version

    line you care about: go to the front page of kernel.org and make sure it

    mentions the latest release of the particular version line without an

    '[EOL]' tag.*



Most kernel version lines only get supported for about three months, as

maintaining them longer is quite a lot of work. Hence, only one per year is

chosen and gets supported for at least two years (often six). That's why you

need to check if the kernel developers still support the version line you care

for.



Note, if kernel.org lists two 'stable' version lines on the front page, you

should consider switching to the newer one and forget about the older one:

support for it is likely to be abandoned soon. Then it will get a "end-of-life"

(EOL) stamp. Version lines that reached that point still get mentioned on the

kernel.org front page for a week or two, but are unsuitable for testing and

reporting.



Search stable mailing list

~~~~~~~~~~~~~~~~~~~~~~~~~~



    *Check the archives of the Linux stable mailing list for existing reports.*



Maybe the issue you face is already known and was fixed or is about to. Hence,

`search the archives of the Linux stable mailing list

<https://lore.kernel.org/stable/>`_ for reports about an issue like yours. If

you find any matches, consider joining the discussion, unless the fix is

already finished and scheduled to get applied soon.



Reproduce issue with the newest release

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



    *Install the latest release from the particular version line as a vanilla

    kernel. Ensure this kernel is not tainted and still shows the problem, as

    the issue might have already been fixed there.*



Before investing any more time in this process you want to check if the issue

was already fixed in the latest release of version line you're interested in.

This kernel needs to be vanilla and shouldn't be tainted before the issue

happens, as detailed outlined already above in the section "Install a fresh

kernel for testing".



Report the regression

~~~~~~~~~~~~~~~~~~~~~



    *Send a short problem report by mail to the people and mailing lists the

    :ref:`MAINTAINERS <maintainers>` file specifies in the section 'STABLE

    BRANCH'. Roughly describe the issue and ideally explain how to reproduce

    it. Mention the first version that shows the problem and the last version

    that's working fine. Then wait for further instructions.*



When reporting a regression that happens within a stable or longterm kernel

line (say when updating from 5.10.4 to 5.10.5) a brief report is enough for

the start to get the issue reported quickly. Hence a rough description is all

it takes.



But note, it helps developers a great deal if you can specify the exact version

that introduced the problem. Hence if possible within a reasonable time frame,

try to find that version using vanilla kernels. Lets assume something broke when

your distributor released a update from Linux kernel 5.10.5 to 5.10.8. Then as

instructed above go and check the latest kernel from that version line, say

5.10.9. If it shows the problem, try a vanilla 5.10.5 to ensure that no patches

the distributor applied interfere. If the issue doesn't manifest itself there,

try 5.10.7 and then (depending on the outcome) 5.10.8 or 5.10.6 to find the

first version where things broke. Mention it in the report and state that 5.10.9

is still broken.



What the previous paragraph outlines is basically a rough manual 'bisection'.

Once your report is out your might get asked to do a proper one, as it allows to

pinpoint the exact change that causes the issue (which then can easily get

reverted to fix the issue quickly). Hence consider to do a proper bisection

right away if time permits. See the section 'Special care for regressions' and

the document 'Documentation/admin-guide/bug-bisect.rst' for details how to

perform one.





Reference for "Reporting regressions within a stable and longterm kernel line"

------------------------------------------------------------------------------



This section provides details for steps you need to take if you could not

reproduce your issue with a mainline kernel, but want to see it fixed in older

version lines (aka stable and longterm kernels).



Some fixes are too complex

~~~~~~~~~~~~~~~~~~~~~~~~~~



    *Prepare yourself for the possibility that going through the next few steps

    might not get the issue solved in older releases: the fix might be too big

    or risky to get backported there.*



Even small and seemingly obvious code-changes sometimes introduce new and

totally unexpected problems. The maintainers of the stable and longterm kernels

are very aware of that and thus only apply changes to these kernels that are

within rules outlined in 'Documentation/process/stable-kernel-rules.rst'.



Complex or risky changes for example do not qualify and thus only get applied

to mainline. Other fixes are easy to get backported to the newest stable and

longterm kernels, but too risky to integrate into older ones. So be aware the

fix you are hoping for might be one of those that won't be backported to the

version line your care about. In that case you'll have no other choice then to

live with the issue or switch to a newer Linux version, unless you want to

patch the fix into your kernels yourself.



Common preparations

~~~~~~~~~~~~~~~~~~~



    *Perform the first three steps in the section "Reporting issues only

    occurring in older kernel version lines" above.*



You need to carry out a few steps already described in another section of this

guide. Those steps will let you:



 * Check if the kernel developers still maintain the Linux kernel version line

   you care about.



 * Search the Linux stable mailing list for exiting reports.



 * Check with the latest release.





Check code history and search for existing discussions

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



    *Search the Linux kernel version control system for the change that fixed

    the issue in mainline, as its commit message might tell you if the fix is

    scheduled for backporting already. If you don't find anything that way,

    search the appropriate mailing lists for posts that discuss such an issue

    or peer-review possible fixes; then check the discussions if the fix was

    deemed unsuitable for backporting. If backporting was not considered at

    all, join the newest discussion, asking if it's in the cards.*



In a lot of cases the issue you deal with will have happened with mainline, but

got fixed there. The commit that fixed it would need to get backported as well

to get the issue solved. That's why you want to search for it or any

discussions abound it.



 * First try to find the fix in the Git repository that holds the Linux kernel

   sources. You can do this with the web interfaces `on kernel.org

   <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_

   or its mirror `on GitHub <https://github.com/torvalds/linux>`_; if you have

   a local clone you alternatively can search on the command line with ``git

   log --grep=<pattern>``.



   If you find the fix, look if the commit message near the end contains a

   'stable tag' that looks like this:



          Cc: <stable@vger.kernel.org> # 5.4+



   If that's case the developer marked the fix safe for backporting to version

   line 5.4 and later. Most of the time it's getting applied there within two

   weeks, but sometimes it takes a bit longer.



 * If the commit doesn't tell you anything or if you can't find the fix, look

   again for discussions about the issue. Search the net with your favorite

   internet search engine as well as the archives for the `Linux kernel

   developers mailing list <https://lore.kernel.org/lkml/>`_. Also read the

   section `Locate kernel area that causes the issue` above and follow the

   instructions to find the subsystem in question: its bug tracker or mailing

   list archive might have the answer you are looking for.



 * If you see a proposed fix, search for it in the version control system as

   outlined above, as the commit might tell you if a backport can be expected.



   * Check the discussions for any indicators the fix might be too risky to get

     backported to the version line you care about. If that's the case you have

     to live with the issue or switch to the kernel version line where the fix

     got applied.



   * If the fix doesn't contain a stable tag and backporting was not discussed,

     join the discussion: mention the version where you face the issue and that

     you would like to see it fixed, if suitable.





Ask for advice

~~~~~~~~~~~~~~



    *One of the former steps should lead to a solution. If that doesn't work

    out, ask the maintainers for the subsystem that seems to be causing the

    issue for advice; CC the mailing list for the particular subsystem as well

    as the stable mailing list.*



If the previous three steps didn't get you closer to a solution there is only

one option left: ask for advice. Do that in a mail you sent to the maintainers

for the subsystem where the issue seems to have its roots; CC the mailing list

for the subsystem as well as the stable mailing list the :ref:`MAINTAINERS

<maintainers>` file mention in the section "STABLE BRANCH".



