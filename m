Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE0A34EA0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhC3ONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhC3ONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:13:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B566C061764;
        Tue, 30 Mar 2021 07:13:21 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lRF7H-0000jw-RZ; Tue, 30 Mar 2021 16:13:11 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/4] docs: make reporting-issues.rst official and delete reporting-bugs.rst
Date:   Tue, 30 Mar 2021 16:13:04 +0200
Message-Id: <49c674c2d304d87e6259063580fda05267e8c348.1617113469.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617113469.git.linux@leemhuis.info>
References: <cover.1617113469.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617113602;38c5c4bd;
X-HE-SMSGID: 1lRF7H-0000jw-RZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the WIP and two FIXME notes in the text to make it official, as
it's now considered fully ready for consumption. To make sure this
step is okay for people the intent of this change and the latest version
of the text were posted to ksummit-discuss; nobody complained, thus
lets move ahead.

Add a footer to point out people can contact Thorsten directly in case
they find something to improve in the text.

Dear reporting-bugs.rst, I'm sorry to tell you, but that makes you fully
obsolete and we thus have to let you go now. Thank you very much for
your service, you in one form or another have been around for a long
time. I'm sure over the years you got read a lot and helped quite a few
people. But it's time to retire now. Rest in peace.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
CC: Harry Wei <harryxiyou@gmail.com>
CC: Alex Shi <alex.shi@linux.alibaba.com>
CC: Federico Vaga <federico.vaga@vaga.pv.it>
CC: Greg KH <gregkh@linuxfoundation.org>
---
Removing Documentation/admin-guide/reporting-bugs.rst will break links
in some of the translations. I was unsure if simply changing them to
Documentation/admin-guide/reporting-issue.rst was wise, so I didn't
touch anything for now and CCed the maintainers for the Chinese and
Italian translation. I couldn't find one for the Japanse translation.

Please advice. For completeness, this are the places where things will
break afaics:

$ grep -ri 'reporting-bugs.rst' Documentation/
Documentation/translations/zh_CN/SecurityBugs:是有帮助的信息，那就请重温一下admin-guide/reporting-bugs.rst文件中的概述过程。任
Documentation/translations/zh_CN/process/howto.rst:内核源码主目录中的:ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
Documentation/translations/zh_CN/admin-guide/reporting-issues.rst:   本文档将取代“Documentation/admin-guide/reporting-bugs.rst”。主要的工作
Documentation/translations/zh_CN/admin-guide/reporting-issues.rst:   “Documentation/admin-guide/reporting-bugs.rst”中的旧文字非常相似。它和它
Documentation/translations/it_IT/process/howto.rst:Il file admin-guide/reporting-bugs.rst nella cartella principale del kernel
Documentation/translations/ja_JP/howto.rst:admin-guide/reporting-bugs.rstはカーネルバグらしいものについてどうレポー

Ciao, Thorsten
---
 Documentation/admin-guide/index.rst           |   1 -
 Documentation/admin-guide/reporting-bugs.rst  | 187 ------------------
 .../admin-guide/reporting-issues.rst          |  64 +-----
 3 files changed, 10 insertions(+), 242 deletions(-)
 delete mode 100644 Documentation/admin-guide/reporting-bugs.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 423116c4e787..dc00afcabb95 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -35,7 +35,6 @@ problems and bugs in particular.
    :maxdepth: 1
 
    reporting-issues
-   Reporting bugs (obsolete) <reporting-bugs>
    security-bugs
    bug-hunting
    bug-bisect
diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
deleted file mode 100644
index 409fa91d7495..000000000000
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ /dev/null
@@ -1,187 +0,0 @@
-.. _reportingbugs:
-
-.. note::
-
-   This document is obsolete, and will be replaced by
-   'Documentation/admin-guide/reporting-issues.rst' in the near future.
-
-Reporting bugs
-++++++++++++++
-
-Background
-==========
-
-The upstream Linux kernel maintainers only fix bugs for specific kernel
-versions.  Those versions include the current "release candidate" (or -rc)
-kernel, any "stable" kernel versions, and any "long term" kernels.
-
-Please see https://www.kernel.org/ for a list of supported kernels.  Any
-kernel marked with [EOL] is "end of life" and will not have any fixes
-backported to it.
-
-If you've found a bug on a kernel version that isn't listed on kernel.org,
-contact your Linux distribution or embedded vendor for support.
-Alternatively, you can attempt to run one of the supported stable or -rc
-kernels, and see if you can reproduce the bug on that.  It's preferable
-to reproduce the bug on the latest -rc kernel.
-
-
-How to report Linux kernel bugs
-===============================
-
-
-Identify the problematic subsystem
-----------------------------------
-
-Identifying which part of the Linux kernel might be causing your issue
-increases your chances of getting your bug fixed. Simply posting to the
-generic linux-kernel mailing list (LKML) may cause your bug report to be
-lost in the noise of a mailing list that gets 1000+ emails a day.
-
-Instead, try to figure out which kernel subsystem is causing the issue,
-and email that subsystem's maintainer and mailing list.  If the subsystem
-maintainer doesn't answer, then expand your scope to mailing lists like
-LKML.
-
-
-Identify who to notify
-----------------------
-
-Once you know the subsystem that is causing the issue, you should send a
-bug report.  Some maintainers prefer bugs to be reported via bugzilla
-(https://bugzilla.kernel.org), while others prefer that bugs be reported
-via the subsystem mailing list.
-
-To find out where to send an emailed bug report, find your subsystem or
-device driver in the MAINTAINERS file.  Search in the file for relevant
-entries, and send your bug report to the person(s) listed in the "M:"
-lines, making sure to Cc the mailing list(s) in the "L:" lines.  When the
-maintainer replies to you, make sure to 'Reply-all' in order to keep the
-public mailing list(s) in the email thread.
-
-If you know which driver is causing issues, you can pass one of the driver
-files to the get_maintainer.pl script::
-
-     perl scripts/get_maintainer.pl -f <filename>
-
-If it is a security bug, please copy the Security Contact listed in the
-MAINTAINERS file.  They can help coordinate bugfix and disclosure.  See
-:ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>` for more information.
-
-If you can't figure out which subsystem caused the issue, you should file
-a bug in kernel.org bugzilla and send email to
-linux-kernel@vger.kernel.org, referencing the bugzilla URL.  (For more
-information on the linux-kernel mailing list see
-http://vger.kernel.org/lkml/).
-
-
-Tips for reporting bugs
------------------------
-
-If you haven't reported a bug before, please read:
-
-	https://www.chiark.greenend.org.uk/~sgtatham/bugs.html
-
-	http://www.catb.org/esr/faqs/smart-questions.html
-
-It's REALLY important to report bugs that seem unrelated as separate email
-threads or separate bugzilla entries.  If you report several unrelated
-bugs at once, it's difficult for maintainers to tease apart the relevant
-data.
-
-
-Gather information
-------------------
-
-The most important information in a bug report is how to reproduce the
-bug.  This includes system information, and (most importantly)
-step-by-step instructions for how a user can trigger the bug.
-
-If the failure includes an "OOPS:", take a picture of the screen, capture
-a netconsole trace, or type the message from your screen into the bug
-report.  Please read "Documentation/admin-guide/bug-hunting.rst" before posting your
-bug report. This explains what you should do with the "Oops" information
-to make it useful to the recipient.
-
-This is a suggested format for a bug report sent via email or bugzilla.
-Having a standardized bug report form makes it easier for you not to
-overlook things, and easier for the developers to find the pieces of
-information they're really interested in.  If some information is not
-relevant to your bug, feel free to exclude it.
-
-First run the ver_linux script included as scripts/ver_linux, which
-reports the version of some important subsystems.  Run this script with
-the command ``awk -f scripts/ver_linux``.
-
-Use that information to fill in all fields of the bug report form, and
-post it to the mailing list with a subject of "PROBLEM: <one line
-summary from [1.]>" for easy identification by the developers::
-
-  [1.] One line summary of the problem:
-  [2.] Full description of the problem/report:
-  [3.] Keywords (i.e., modules, networking, kernel):
-  [4.] Kernel information
-  [4.1.] Kernel version (from /proc/version):
-  [4.2.] Kernel .config file:
-  [5.] Most recent kernel version which did not have the bug:
-  [6.] Output of Oops.. message (if applicable) with symbolic information
-       resolved (see Documentation/admin-guide/bug-hunting.rst)
-  [7.] A small shell script or example program which triggers the
-       problem (if possible)
-  [8.] Environment
-  [8.1.] Software (add the output of the ver_linux script here)
-  [8.2.] Processor information (from /proc/cpuinfo):
-  [8.3.] Module information (from /proc/modules):
-  [8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
-  [8.5.] PCI information ('lspci -vvv' as root)
-  [8.6.] SCSI information (from /proc/scsi/scsi)
-  [8.7.] Other information that might be relevant to the problem
-         (please look in /proc and include all information that you
-         think to be relevant):
-  [X.] Other notes, patches, fixes, workarounds:
-
-
-Follow up
-=========
-
-Expectations for bug reporters
-------------------------------
-
-Linux kernel maintainers expect bug reporters to be able to follow up on
-bug reports.  That may include running new tests, applying patches,
-recompiling your kernel, and/or re-triggering your bug.  The most
-frustrating thing for maintainers is for someone to report a bug, and then
-never follow up on a request to try out a fix.
-
-That said, it's still useful for a kernel maintainer to know a bug exists
-on a supported kernel, even if you can't follow up with retests.  Follow
-up reports, such as replying to the email thread with "I tried the latest
-kernel and I can't reproduce my bug anymore" are also helpful, because
-maintainers have to assume silence means things are still broken.
-
-Expectations for kernel maintainers
------------------------------------
-
-Linux kernel maintainers are busy, overworked human beings.  Some times
-they may not be able to address your bug in a day, a week, or two weeks.
-If they don't answer your email, they may be on vacation, or at a Linux
-conference.  Check the conference schedule at https://LWN.net for more info:
-
-	https://lwn.net/Calendar/
-
-In general, kernel maintainers take 1 to 5 business days to respond to
-bugs.  The majority of kernel maintainers are employed to work on the
-kernel, and they may not work on the weekends.  Maintainers are scattered
-around the world, and they may not work in your time zone.  Unless you
-have a high priority bug, please wait at least a week after the first bug
-report before sending the maintainer a reminder email.
-
-The exceptions to this rule are regressions, kernel crashes, security holes,
-or userspace breakage caused by new kernel behavior.  Those bugs should be
-addressed by the maintainers ASAP.  If you suspect a maintainer is not
-responding to these types of bugs in a timely manner (especially during a
-merge window), escalate the bug to LKML and Linus Torvalds.
-
-Thank you!
-
-[Some of this is taken from Frohwalt Egerer's original linux-kernel FAQ]
diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 1fc98276160e..ca809a4be620 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -9,25 +9,6 @@
    (for example by the kernel's build system) might contain content taken from
    files which use a more restrictive license.
 
-.. important::
-
-   This document is being prepared to replace
-   'Documentation/admin-guide/reporting-bugs.rst'. The main work is done and
-   you are already free to follow its instructions when reporting issues to the
-   Linux kernel developers. But keep in mind, below text still needs a few
-   finishing touches and review. It was merged to the Linux kernel sources at
-   this stage to make this process easier and increase the text's visibility.
-
-   Any improvements for the text or other feedback is thus very much welcome.
-   Please send it to 'Thorsten Leemhuis <linux@leemhuis.info>' and 'Jonathan
-   Corbet <corbet@lwn.net>', ideally with 'Linux kernel mailing list (LKML)
-   <linux-kernel@vger.kernel.org>' and the 'Linux Kernel Documentation List
-   <linux-doc@vger.kernel.org>' in CC.
-
-   Areas in the text that still need work or discussion contain a hint like this
-   which point out the remaining issues; all of them start with the word "FIXME"
-   to make them easy to find.
-
 
 Reporting issues
 ++++++++++++++++
@@ -710,26 +691,6 @@ example above does not have such a line. That is the case for most sections, as
 Linux kernel development is completely driven by mail. Very few subsystems use
 a bug tracker, and only some of those rely on bugzilla.kernel.org.
 
-
-.. note::
-
-   FIXME: The old text took a totally different approach to bugzilla.kernel.org,
-   as it mentions it as the place to file issue for people that don't known how
-   to contact the appropriate people. The new one mentions it rarely; and when
-   it does like here, it warns users that it's often the wrong place to go.
-
-   This approach was chosen as the main author of this document noticed quite a
-   few users (or even a lot?) get no reply to the bugs they file in bugzilla.
-   That's kind of expected, as quite a few (many? most?) of the maintainers
-   don't even get notified when reports for their subsystem get filed there. And
-   not getting a single reply to report is something that is just annoying for
-   users and might make them angry. Improving bugzilla.k.o would be an option,
-   but on the kernel and maintainers summit 2017 it was agreed on to first go
-   this route (sorry it took so long): it's easier to achieve and less
-   controversial, as putting additional burden on already overworked maintainers
-   is unlikely to get well received.
-
-
 In this and many other cases you thus have to look for lines starting with
 'Mail:' instead. Those mention the name and the email addresses for the
 maintainers of the particular code. Also look for a line starting with 'Mailing
@@ -742,21 +703,6 @@ and might leave some work for other developers on the subsystem specific list;
 and LKML is important to have one place where all issue reports can be found.
 
 
-.. note::
-
-   FIXME: Above section tells users to always CC LKML. These days it's a kind of
-   "catch-all" list anyway, which nearly nobody seems to follow closely. So it
-   seems appropriate to go "all in" and make people send their reports here,
-   too, as everything (reports, fixes, ...) then can be found in one place (at
-   least for all reports sent by mail and all subsystems that CC LKML).
-
-   Related: Should we create mailing list like 'linux-issues@vger.kernel.org'
-   and tell users above to always CC it when reporting issues? Then there would
-   be one central place reporters could search for existing reports (at least
-   for issues reported by mail) without getting regular LKML traffic mixed into
-   the results.
-
-
 Finding the maintainers with the help of a script
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -1776,3 +1722,13 @@ issues to the Linux kernel developers: the length and complexity of this
 document and the implications between the lines illustrate that. But that's how
 it is for now. The main author of this text hopes documenting the state of the
 art will lay some groundwork to improve the situation over time.
+
+
+..
+   This text is maintained by Thorsten Leemhuis <linux@leemhuis.info>. If you
+   spot a typo or small mistake, feel free to let him know directly and he'll
+   fix it. You are free to do the same in a mostly informal way if you want
+   to contribute changes to the text, but for copyright reasons please CC
+   linux-doc@vger.kernel.org and "sign-off" your contribution as
+   Documentation/process/submitting-patches.rst outlines in the section "Sign
+   your work - the Developer's Certificate of Origin".
-- 
2.30.2

