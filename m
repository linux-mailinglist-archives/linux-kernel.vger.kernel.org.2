Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820E0342630
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhCST2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhCST1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:27:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B396EC061763;
        Fri, 19 Mar 2021 12:27:53 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lNKml-0003Lu-2A; Fri, 19 Mar 2021 20:27:51 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] docs: reporting-issues.rst: improved process esp. for stable regressions
Date:   Fri, 19 Mar 2021 20:27:49 +0100
Message-Id: <d934c15e536bceeff5c40a126930ddf803548e08.1616181657.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616181657.git.linux@leemhuis.info>
References: <cover.1616181657.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616182073;048012f6;
X-HE-SMSGID: 1lNKml-0003Lu-2A
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a shorter and easier process for users that deal with
regressions in stable and longterm kernels, as those should be reported
quickly.

To realize this in the least-confusing way and without having steps
multiple times in different places, split the 'search for existing
reports' into two. That has the additinal benefit that users will search
for them quickly when going through the step by step guide and thus will
save them trouble if the find reports.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
CC: Randy Dunlap <rdunlap@infradead.org>
---
v3
* s/head over/scroll down/, as suggested by Jon
* reduce the amount of repeated text, as suggested by Jon. This lead to
  quite a bit of churn, but it's worth it, as the structure is clearer
  and easier to follow for readers. There is one small downside: the
  'search for existing reports' section in the main part got split in
  two; but there is benefit in this, too, as the readers are now told to
  search for reports way earlier. And I don't really like the "Perform
  the first three steps in the section..." thing, but it seems like the
  cleanest solution here.

v2 https://lore.kernel.org/linux-doc/148a84de8d109ebbc01a337fb93cb246410c4351.1615116592.git.linux@leemhuis.info/
* revist, lots of small improvements in various places

v1 https://lore.kernel.org/linux-doc/20210214145454.357392-1-linux@leemhuis.info/
* initial version
---
 .../admin-guide/reporting-issues.rst          | 435 +++++++-----------
 1 file changed, 168 insertions(+), 267 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 17e889bb3cfd..1fc98276160e 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -100,6 +100,11 @@ process won't feel wasted in the end:
    willing to install the latest Linux version yourself. Be aware the latter
    will often be needed anyway to hunt down and fix issues.
 
+ * Perform a rough search for existing reports with your favorite internet
+   search engine; additionally, check the archives of the Linux Kernel Mailing
+   List (LKML). If you find matching reports, join the discussion instead of
+   sending a new one.
+
  * See if the issue you are dealing with qualifies as regression, security
    issue, or a really severe problem: those are 'issues of high priority' that
    need special handling in some steps that are about to follow.
@@ -122,16 +127,18 @@ process won't feel wasted in the end:
    needs to get reported to the kernel developers separately, unless they are
    strongly entangled.
 
+ * If you are facing a regression within a stable or longterm version line
+   (say something broke when updating from 5.10.4 to 5.10.5), scroll down to
+   'Dealing with regressions within a stable and longterm kernel line'.
+
  * Locate the driver or kernel subsystem that seems to be causing the issue.
    Find out how and where its developers expect reports. Note: most of the
    time this won't be bugzilla.kernel.org, as issues typically need to be sent
    by mail to a maintainer and a public mailing list.
 
  * Search the archives of the bug tracker or mailing list in question
-   thoroughly for reports that might match your issue. Also check if you find
-   something with your favorite internet search engine or in the Linux Kernel
-   Mailing List (LKML) archives. If you find anything, join the discussion
-   instead of sending a new report.
+   thoroughly for reports that might match your issue. If you find anything,
+   join the discussion instead of sending a new report.
 
 After these preparations you'll now enter the main part:
 
@@ -187,17 +194,15 @@ After these preparations you'll now enter the main part:
    help yourself, if you don't get any help or if it's unsatisfying.
 
 
-Reporting issues only occurring in older kernel version lines
--------------------------------------------------------------
+Reporting regressions within a stable and longterm kernel line
+--------------------------------------------------------------
 
-This section is for you, if you tried the latest mainline kernel as outlined
-above, but failed to reproduce your issue there; at the same time you want to
-see the issue fixed in older version lines or a vendor kernel that's regularly
-rebased on new stable or longterm releases. If that case follow these steps:
-
- * Prepare yourself for the possibility that going through the next few steps
-   might not get the issue solved in older releases: the fix might be too big
-   or risky to get backported there.
+This subsection is for you, if you followed above process and got sent here at
+the point about regression within a stable or longterm kernel version line. You
+face one of those if something breaks when updating from 5.10.4 to 5.10.5 (a
+switch from 5.9.15 to 5.10.5 does not qualify). The developers want to fix such
+regressions as quickly as possible, hence there is a streamlined process to
+report them:
 
  * Check if the kernel developers still maintain the Linux kernel version
    line you care about: go to the front page of kernel.org and make sure it
@@ -210,6 +215,30 @@ rebased on new stable or longterm releases. If that case follow these steps:
    kernel. Ensure this kernel is not tainted and still shows the problem, as
    the issue might have already been fixed there.
 
+ * Send a short problem report by mail to the people and mailing lists the
+   :ref:`MAINTAINERS <maintainers>` file specifies in the section 'STABLE
+   BRANCH'. Roughly describe the issue and ideally explain how to reproduce
+   it. Mention the first version that shows the problem and the last version
+   that's working fine. Then wait for further instructions.
+
+The reference section below explains each of these steps in more detail.
+
+
+Reporting issues only occurring in older kernel version lines
+-------------------------------------------------------------
+
+This subsection is for you, if you tried the latest mainline kernel as outlined
+above, but failed to reproduce your issue there; at the same time you want to
+see the issue fixed in older version lines or a vendor kernel that's regularly
+rebased on new stable or longterm releases. If that case follow these steps:
+
+ * Prepare yourself for the possibility that going through the next few steps
+   might not get the issue solved in older releases: the fix might be too big
+   or risky to get backported there.
+
+ * Perform the first three steps in the section "Dealing with regressions
+   within a stable and longterm kernel line" above.
+
  * Search the Linux kernel version control system for the change that fixed
    the issue in mainline, as its commit message might tell you if the fix is
    scheduled for backporting already. If you don't find anything that way,
@@ -218,22 +247,13 @@ rebased on new stable or longterm releases. If that case follow these steps:
    deemed unsuitable for backporting. If backporting was not considered at
    all, join the newest discussion, asking if it's in the cards.
 
- * Check if you're dealing with a regression that was never present in
-   mainline by installing the first release of the version line you care
-   about. If the issue doesn't show up with it, you basically need to report
-   the issue with this version like you would report a problem with mainline
-   (see above). This ideally includes a bisection followed by a search for
-   existing reports on the net; with the help of the subject and the two
-   relevant commit-ids. If that doesn't turn up anything, write the report; CC
-   or forward the report to the stable maintainers, the stable mailing list,
-   and those who authored the change. Include the shortened commit-id if you
-   found the change that causes it.
-
  * One of the former steps should lead to a solution. If that doesn't work
    out, ask the maintainers for the subsystem that seems to be causing the
    issue for advice; CC the mailing list for the particular subsystem as well
    as the stable mailing list.
 
+The reference section below explains each of these steps in more detail.
+
 
 Reference section: Reporting issues to the kernel maintainers
 =============================================================
@@ -329,44 +349,25 @@ better than not reporting the issue at all: sometimes such reports directly or
 indirectly will help to get the issue fixed over time.
 
 
-Search for existing reports
----------------------------
+Search for existing reports, first run
+--------------------------------------
 
-    *Search the archives of the bug tracker or mailing list in question
-    thoroughly for reports that might match your issue. Also check if you find
-    something with your favorite internet search engine or in the Linux Kernel
-    Mailing List (LKML) archives. If you find anything, join the discussion
-    instead of sending a new report.*
-
-Reporting an issue that someone else already brought forward is often a waste
-of time for everyone involved, especially you as the reporter. So it's in your
-own interest to thoroughly check if somebody reported the issue already. Thus
-do not hurry with this step of the reporting process. Spending 30 to 60 minutes
-or even more time can save you and others quite a lot of time and trouble.
+   *Perform a rough search for existing reports with your favorite internet
+   search engine; additionally, check the archives of the Linux Kernel Mailing
+   List (LKML). If you find matching reports, join the discussion instead of
+   sending a new one.*
 
-The best place to search is the bug tracker or the mailing list where your
-report needs to be filed. You'll find quite a few of those lists on
-`lore.kernel.org <https://lore.kernel.org/>`_, but some are hosted in
-different places. That for example is the case for the ath10k WiFi driver used
-as example in the previous step. But you'll often find the archives for these
-lists easily on the net. Searching for 'archive ath10k@lists.infradead.org' for
-example will quickly lead you to the `Info page for the ath10k mailing list
-<https://lists.infradead.org/mailman/listinfo/ath10k>`_, which at the top links
-to its `list archives <https://lists.infradead.org/pipermail/ath10k/>`_.
-
-Sadly this and quite a few other lists miss a way to search the archives. In
-those cases use a regular internet search engine and add something like
-'site:lists.infradead.org/pipermail/ath10k/' to your search terms, which limits
-the results to the archives at that URL.
+Reporting an issue that someone else already brought forward is often a waste of
+time for everyone involved, especially you as the reporter. So it's in your own
+interest to thoroughly check if somebody reported the issue already. At this
+step of the process it's okay to just perform a rough search: a later step will
+tell you to perform a more detailed search once you know where your issue needs
+to be reported to. Nevertheless, do not hurry with this step of the reporting
+process, it can save you time and trouble.
 
-Additionally, search the internet and the `Linux Kernel Mailing List (LKML)
-archives <https://lore.kernel.org/lkml/>`_, as maybe the real culprit might be
-in some other subsystem. Searching in `bugzilla.kernel.org
-<https://bugzilla.kernel.org/>`_ might also be a good idea, but if you find
-anything there keep in mind: most subsystems expect reports in different
-places, hence those you find there might have not even reached the people
-responsible for the subsystem in question. Nevertheless, the data there might
-provide valuable insights.
+Simply search the internet with your favorite search engine first. Afterwards,
+search the `Linux Kernel Mailing List (LKML) archives
+<https://lore.kernel.org/lkml/>`_.
 
 If you get flooded with results consider telling your search engine to limit
 search timeframe to the past month or year. And wherever you search, make sure
@@ -387,6 +388,15 @@ developers might look for people that can provide additional information or
 test a proposed fix. Jump to the section 'Duties after the report went out' for
 details on how to get properly involved.
 
+Note, searching `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_ might also
+be a good idea, as that might provide valuable insights or turn up matching
+reports. If you find the latter, just keep in mind: most subsystems expect
+reports in different places, as described below in the section "Check where you
+need to report your issue". The developers that should take care of the issue
+thus might not even be aware of the bugzilla ticket. Hence, check the ticket if
+the issue already got reported as outlined in this document and if not consider
+doing so.
+
 
 Issue of high priority?
 -----------------------
@@ -591,9 +601,25 @@ due to faulty hardware apart from a kernel issue that rarely happens and thus
 is hard to reproduce.
 
 
-Locate kernel area that causes the issue
+Regression in stable or longterm kernel?
 ----------------------------------------
 
+    *If you are facing a regression within a stable or longterm version line
+    (say something broke when updating from 5.10.4 to 5.10.5), scroll down to
+    'Dealing with regressions within a stable and longterm kernel line'.*
+
+Regression within a stable and longterm kernel version line are something the
+Linux developers want to fix badly, as such issues are even more unwanted than
+regression in the main development branch, as they can quickly affect a lot of
+people. The developers thus want to learn about such issues as quickly as
+possible, hence there is a streamlined process to report them. Note,
+regressions with newer kernel version line (say something broke when switching
+from 5.9.15 to 5.10.5) do not qualify.
+
+
+Check where you need to report your issue
+-----------------------------------------
+
     *Locate the driver or kernel subsystem that seems to be causing the issue.
     Find out how and where its developers expect reports. Note: most of the
     time this won't be bugzilla.kernel.org, as issues typically need to be sent
@@ -769,63 +795,39 @@ modified during tree-wide cleanups by developers that do not care about the
 particular driver at all.
 
 
-Search for existing reports
----------------------------
+Search for existing reports, second run
+---------------------------------------
 
     *Search the archives of the bug tracker or mailing list in question
-    thoroughly for reports that might match your issue. Also check if you find
-    something with your favorite internet search engine or in the Linux Kernel
-    Mailing List (LKML) archives. If you find anything, join the discussion
-    instead of sending a new report.*
-
-Reporting an issue that someone else already brought forward is often a waste
-of time for everyone involved, especially you as the reporter. So it's in your
-own interest to thoroughly check if somebody reported the issue already. Thus
-do not hurry with this step of the reporting process. Spending 30 to 60 minutes
-or even more time can save you and others quite a lot of time and trouble.
-
-The best place to search is the bug tracker or the mailing list where your
-report needs to be filed. You'll find quite a few of those lists on
-`lore.kernel.org <https://lore.kernel.org/>`_, but some are hosted in
-different places. That for example is the case for the ath10k WiFi driver used
-as example in the previous step. But you'll often find the archives for these
-lists easily on the net. Searching for 'archive ath10k@lists.infradead.org' for
-example will quickly lead you to the `Info page for the ath10k mailing list
-<https://lists.infradead.org/mailman/listinfo/ath10k>`_, which at the top links
-to its `list archives <https://lists.infradead.org/pipermail/ath10k/>`_.
-
-Sadly this and quite a few other lists miss a way to search the archives. In
-those cases use a regular internet search engine and add something like
+    thoroughly for reports that might match your issue. If you find anything,
+    join the discussion instead of sending a new report.*
+
+As mentioned earlier already: reporting an issue that someone else already
+brought forward is often a waste of time for everyone involved, especially you
+as the reporter. That's why you should search for existing report again, now
+that you know where they need to be reported to. If it's mailing list, you will
+often find its archives on `lore.kernel.org <https://lore.kernel.org/>`_.
+
+But some list are hosted in different places. That for example is the case for
+the ath10k WiFi driver used as example in the previous step. But you'll often
+find the archives for these lists easily on the net. Searching for 'archive
+ath10k@lists.infradead.org' for example will lead you to the `Info page for the
+ath10k mailing list <https://lists.infradead.org/mailman/listinfo/ath10k>`_,
+which at the top links to its
+`list archives <https://lists.infradead.org/pipermail/ath10k/>`_. Sadly this and
+quite a few other lists miss a way to search the archives. In those cases use a
+regular internet search engine and add something like
 'site:lists.infradead.org/pipermail/ath10k/' to your search terms, which limits
 the results to the archives at that URL.
 
-Additionally, search the internet and the `Linux Kernel Mailing List (LKML)
-archives <https://lore.kernel.org/lkml/>`_, as maybe the real culprit might be
-in some other subsystem. Searching in `bugzilla.kernel.org
-<https://bugzilla.kernel.org/>`_ might also be a good idea, but if you find
-anything there keep in mind: most subsystems expect reports in different
-places, hence those you find there might have not even reached the people
-responsible for the subsystem in question. Nevertheless, the data there might
-provide valuable insights.
+It's also wise to check the internet, LKML and maybe bugzilla.kernel.org again
+at this point.
 
-If you get flooded with results consider telling your search engine to limit
-search timeframe to the past month or year. And wherever you search, make sure
-to use good search terms; vary them a few times, too. While doing so try to
-look at the issue from the perspective of someone else: that will help you to
-come up with other words to use as search terms. Also make sure not to use too
-many search terms at once. Remember to search with and without information like
-the name of the kernel driver or the name of the affected hardware component.
-But its exact brand name (say 'ASUS Red Devil Radeon RX 5700 XT Gaming OC')
-often is not much helpful, as it is too specific. Instead try search terms like
-the model line (Radeon 5700 or Radeon 5000) and the code name of the main chip
-('Navi' or 'Navi10') with and without its manufacturer ('AMD').
+For details how to search and what to do if you find matching reports see
+"Search for existing reports, first run" above.
 
-In case you find an existing report about your issue, join the discussion, as
-you might be able to provide valuable additional information. That can be
-important even when a fix is prepared or in its final stages already, as
-developers might look for people that can provide additional information or
-test a proposed fix. Jump to the section 'Duties after the report went out' for
-details on how to get properly involved.
+Do not hurry with this step of the reporting process: spending 30 to 60 minutes
+or even more time can save you and others quite a lot of time and trouble.
 
 
 Install a fresh kernel for testing
@@ -1512,32 +1514,11 @@ easier. And with a bit of luck there might be someone in the team that knows a
 bit about programming and might be able to write a fix.
 
 
-Details about reporting issues only occurring in older kernel version lines
----------------------------------------------------------------------------
+Reference for "Reporting issues only occurring in older kernel version lines"
+-----------------------------------------------------------------------------
 
-This subsection provides details for steps you need to take if you could not
-reproduce your issue with a mainline kernel, but want to see it fixed in older
-version lines (aka stable and longterm kernels).
-
-Some fixes are too complex
-~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-    *Prepare yourself for the possibility that going through the next few steps
-    might not get the issue solved in older releases: the fix might be too big
-    or risky to get backported there.*
-
-Even small and seemingly obvious code-changes sometimes introduce new and
-totally unexpected problems. The maintainers of the stable and longterm kernels
-are very aware of that and thus only apply changes to these kernels that are
-within rules outlined in 'Documentation/process/stable-kernel-rules.rst'.
-
-Complex or risky changes for example do not qualify and thus only get applied
-to mainline. Other fixes are easy to get backported to the newest stable and
-longterm kernels, but too risky to integrate into older ones. So be aware the
-fix you are hoping for might be one of those that won't be backported to the
-version line your care about. In that case you'll have no other choice then to
-live with the issue or switch to a newer Linux version, unless you want to
-patch the fix into your kernels yourself.
+This subsection provides details for step you need to perform if you face a
+regression within a stable and longterm kernel line.
 
 Make sure the particular version line still gets support
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -1581,65 +1562,47 @@ Reproduce issue with the newest release
 Before investing any more time in this process you want to check if the issue
 was already fixed in the latest release of version line you're interested in.
 This kernel needs to be vanilla and shouldn't be tainted before the issue
-happens, as detailed outlined already above in the process of testing mainline.
-
-
-Check code history and search for existing discussions
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-    *Search the Linux kernel version control system for the change that fixed
-    the issue in mainline, as its commit message might tell you if the fix is
-    scheduled for backporting already. If you don't find anything that way,
-    search the appropriate mailing lists for posts that discuss such an issue
-    or peer-review possible fixes; then check the discussions if the fix was
-    deemed unsuitable for backporting. If backporting was not considered at
-    all, join the newest discussion, asking if it's in the cards.*
-
-In a lot of cases the issue you deal with will have happened with mainline, but
-got fixed there. The commit that fixed it would need to get backported as well
-to get the issue solved. That's why you want to search for it or any
-discussions abound it.
-
- * First try to find the fix in the Git repository that holds the Linux kernel
-   sources. You can do this with the web interfaces `on kernel.org
-   <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_
-   or its mirror `on GitHub <https://github.com/torvalds/linux>`_; if you have
-   a local clone you alternatively can search on the command line with ``git
-   log --grep=<pattern>``.
-
-   If you find the fix, look if the commit message near the end contains a
-   'stable tag' that looks like this:
-
-          Cc: <stable@vger.kernel.org> # 5.4+
-
-   If that's case the developer marked the fix safe for backporting to version
-   line 5.4 and later. Most of the time it's getting applied there within two
-   weeks, but sometimes it takes a bit longer.
-
- * If the commit doesn't tell you anything or if you can't find the fix, look
-   again for discussions about the issue. Search the net with your favorite
-   internet search engine as well as the archives for the `Linux kernel
-   developers mailing list <https://lore.kernel.org/lkml/>`_. Also read the
-   section `Locate kernel area that causes the issue` above and follow the
-   instructions to find the subsystem in question: its bug tracker or mailing
-   list archive might have the answer you are looking for.
-
- * If you see a proposed fix, search for it in the version control system as
-   outlined above, as the commit might tell you if a backport can be expected.
-
-   * Check the discussions for any indicators the fix might be too risky to get
-     backported to the version line you care about. If that's the case you have
-     to live with the issue or switch to the kernel version line where the fix
-     got applied.
-
-   * If the fix doesn't contain a stable tag and backporting was not discussed,
-     join the discussion: mention the version where you face the issue and that
-     you would like to see it fixed, if suitable.
-
-Details about reporting issues only occurring in older kernel version lines
----------------------------------------------------------------------------
-
-This subsection provides details for steps you need to take if you could not
+happens, as detailed outlined already above in the section "Install a fresh
+kernel for testing".
+
+Report the regression
+~~~~~~~~~~~~~~~~~~~~~
+
+    *Send a short problem report by mail to the people and mailing lists the
+    :ref:`MAINTAINERS <maintainers>` file specifies in the section 'STABLE
+    BRANCH'. Roughly describe the issue and ideally explain how to reproduce
+    it. Mention the first version that shows the problem and the last version
+    that's working fine. Then wait for further instructions.*
+
+When reporting a regression that happens within a stable or longterm kernel
+line (say when updating from 5.10.4 to 5.10.5) a brief report is enough for
+the start to get the issue reported quickly. Hence a rough description is all
+it takes.
+
+But note, it helps developers a great deal if you can specify the exact version
+that introduced the problem. Hence if possible within a reasonable time frame,
+try to find that version using vanilla kernels. Lets assume something broke when
+your distributor released a update from Linux kernel 5.10.5 to 5.10.8. Then as
+instructed above go and check the latest kernel from that version line, say
+5.10.9. If it shows the problem, try a vanilla 5.10.5 to ensure that no patches
+the distributor applied interfere. If the issue doesn't manifest itself there,
+try 5.10.7 and then (depending on the outcome) 5.10.8 or 5.10.6 to find the
+first version where things broke. Mention it in the report and state that 5.10.9
+is still broken.
+
+What the previous paragraph outlines is basically a rough manual 'bisection'.
+Once your report is out your might get asked to do a proper one, as it allows to
+pinpoint the exact change that causes the issue (which then can easily get
+reverted to fix the issue quickly). Hence consider to do a proper bisection
+right away if time permits. See the section 'Special care for regressions' and
+the document 'Documentation/admin-guide/bug-bisect.rst' for details how to
+perform one.
+
+
+Reference for "Reporting regressions within a stable and longterm kernel line"
+------------------------------------------------------------------------------
+
+This section provides details for steps you need to take if you could not
 reproduce your issue with a mainline kernel, but want to see it fixed in older
 version lines (aka stable and longterm kernels).
 
@@ -1663,49 +1626,22 @@ version line your care about. In that case you'll have no other choice then to
 live with the issue or switch to a newer Linux version, unless you want to
 patch the fix into your kernels yourself.
 
-Make sure the particular version line still gets support
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-    *Check if the kernel developers still maintain the Linux kernel version
-    line you care about: go to the front page of kernel.org and make sure it
-    mentions the latest release of the particular version line without an
-    '[EOL]' tag.*
-
-Most kernel version lines only get supported for about three months, as
-maintaining them longer is quite a lot of work. Hence, only one per year is
-chosen and gets supported for at least two years (often six). That's why you
-need to check if the kernel developers still support the version line you care
-for.
-
-Note, if kernel.org lists two 'stable' version lines on the front page, you
-should consider switching to the newer one and forget about the older one:
-support for it is likely to be abandoned soon. Then it will get a "end-of-life"
-(EOL) stamp. Version lines that reached that point still get mentioned on the
-kernel.org front page for a week or two, but are unsuitable for testing and
-reporting.
+Common preparations
+~~~~~~~~~~~~~~~~~~~
 
-Search stable mailing list
-~~~~~~~~~~~~~~~~~~~~~~~~~~
+    *Perform the first three steps in the section "Reporting issues only
+    occurring in older kernel version lines" above.*
 
-    *Check the archives of the Linux stable mailing list for existing reports.*
+You need to carry out a few steps already described in another section of this
+guide. Those steps will let you:
 
-Maybe the issue you face is already known and was fixed or is about to. Hence,
-`search the archives of the Linux stable mailing list
-<https://lore.kernel.org/stable/>`_ for reports about an issue like yours. If
-you find any matches, consider joining the discussion, unless the fix is
-already finished and scheduled to get applied soon.
+ * Check if the kernel developers still maintain the Linux kernel version line
+   you care about.
 
-Reproduce issue with the newest release
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * Search the Linux stable mailing list for exiting reports.
 
-    *Install the latest release from the particular version line as a vanilla
-    kernel. Ensure this kernel is not tainted and still shows the problem, as
-    the issue might have already been fixed there.*
+ * Check with the latest release.
 
-Before investing any more time in this process you want to check if the issue
-was already fixed in the latest release of version line you're interested in.
-This kernel needs to be vanilla and shouldn't be tainted before the issue
-happens, as detailed outlined already above in the process of testing mainline.
 
 Check code history and search for existing discussions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -1759,41 +1695,6 @@ discussions abound it.
      join the discussion: mention the version where you face the issue and that
      you would like to see it fixed, if suitable.
 
-Check if it's a regression specific to stable or longterm kernels
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-    *Check if you're dealing with a regression that was never present in
-    mainline by installing the first release of the version line you care
-    about. If the issue doesn't show up with it, you basically need to report
-    the issue with this version like you would report a problem with mainline
-    (see above). This ideally includes a bisection followed by a search for
-    existing reports on the net; with the help of the subject and the two
-    relevant commit-ids. If that doesn't turn up anything, write the report; CC
-    or forward the report to the stable maintainers, the stable mailing list,
-    and those who authored the change. Include the shortened commit-id if you
-    found the change that causes it.*
-
-Sometimes you won't find anything in the previous step: the issue you face
-might have never occurred in mainline, as it is caused by some change that is
-incomplete or not correctly applied. To check this, install the first release
-from version line you care about, e.g., if you care about 5.4.x, install 5.4.
-
-If the issue doesn't show itself there, it's a regression specific to the
-particular version line. In that case you need to report it like an issue
-happening in mainline, like the last few steps in the main section in the above
-outline.
-
-One of them suggests doing a bisection, which you are strongly advised to do in
-this case. After finding the culprit, search the net for existing reports
-again: not only search for the exact subject and the commit-id (proper and
-shortened to twelve characters) of the change, but also for the commit-id
-(proper and shortened) mentioned as 'Upstream commit' in the commit message.
-
-Write the report; just keep a few specialties in mind: CC or forward the report
-to the stable maintainers, the stable mailing list, which the :ref:`MAINTAINERS
-<maintainers>` file mentions in the section "STABLE BRANCH". If you performed a
-successful bisection, CC the author of the change and include its subject and
-the shortened commit-id.
 
 Ask for advice
 ~~~~~~~~~~~~~~
-- 
2.30.2

