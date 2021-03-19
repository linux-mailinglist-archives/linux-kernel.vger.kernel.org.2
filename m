Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C1034262F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCST2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhCST1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:27:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6300DC061762;
        Fri, 19 Mar 2021 12:27:53 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lNKmk-0003Lu-Qo; Fri, 19 Mar 2021 20:27:50 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] docs: reporting-issues.rst: duplicate sections for reviewing purposes
Date:   Fri, 19 Mar 2021 20:27:48 +0100
Message-Id: <ef85edc8466f035eb243dd6629429ad4fd0565d8.1616181657.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616181657.git.linux@leemhuis.info>
References: <cover.1616181657.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616182073;048012f6;
X-HE-SMSGID: 1lNKmk-0003Lu-Qo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This duplicates two section to make the diff in the next patch a bit
easier to gasp for humans.

Straight copy, no content changes.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 184 ++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 6234741caca8..17e889bb3cfd 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -328,6 +328,66 @@ those often get rejected or ignored, so consider yourself warned. But it's still
 better than not reporting the issue at all: sometimes such reports directly or
 indirectly will help to get the issue fixed over time.
 
+
+Search for existing reports
+---------------------------
+
+    *Search the archives of the bug tracker or mailing list in question
+    thoroughly for reports that might match your issue. Also check if you find
+    something with your favorite internet search engine or in the Linux Kernel
+    Mailing List (LKML) archives. If you find anything, join the discussion
+    instead of sending a new report.*
+
+Reporting an issue that someone else already brought forward is often a waste
+of time for everyone involved, especially you as the reporter. So it's in your
+own interest to thoroughly check if somebody reported the issue already. Thus
+do not hurry with this step of the reporting process. Spending 30 to 60 minutes
+or even more time can save you and others quite a lot of time and trouble.
+
+The best place to search is the bug tracker or the mailing list where your
+report needs to be filed. You'll find quite a few of those lists on
+`lore.kernel.org <https://lore.kernel.org/>`_, but some are hosted in
+different places. That for example is the case for the ath10k WiFi driver used
+as example in the previous step. But you'll often find the archives for these
+lists easily on the net. Searching for 'archive ath10k@lists.infradead.org' for
+example will quickly lead you to the `Info page for the ath10k mailing list
+<https://lists.infradead.org/mailman/listinfo/ath10k>`_, which at the top links
+to its `list archives <https://lists.infradead.org/pipermail/ath10k/>`_.
+
+Sadly this and quite a few other lists miss a way to search the archives. In
+those cases use a regular internet search engine and add something like
+'site:lists.infradead.org/pipermail/ath10k/' to your search terms, which limits
+the results to the archives at that URL.
+
+Additionally, search the internet and the `Linux Kernel Mailing List (LKML)
+archives <https://lore.kernel.org/lkml/>`_, as maybe the real culprit might be
+in some other subsystem. Searching in `bugzilla.kernel.org
+<https://bugzilla.kernel.org/>`_ might also be a good idea, but if you find
+anything there keep in mind: most subsystems expect reports in different
+places, hence those you find there might have not even reached the people
+responsible for the subsystem in question. Nevertheless, the data there might
+provide valuable insights.
+
+If you get flooded with results consider telling your search engine to limit
+search timeframe to the past month or year. And wherever you search, make sure
+to use good search terms; vary them a few times, too. While doing so try to
+look at the issue from the perspective of someone else: that will help you to
+come up with other words to use as search terms. Also make sure not to use too
+many search terms at once. Remember to search with and without information like
+the name of the kernel driver or the name of the affected hardware component.
+But its exact brand name (say 'ASUS Red Devil Radeon RX 5700 XT Gaming OC')
+often is not much helpful, as it is too specific. Instead try search terms like
+the model line (Radeon 5700 or Radeon 5000) and the code name of the main chip
+('Navi' or 'Navi10') with and without its manufacturer ('AMD').
+
+In case you find an existing report about your issue, join the discussion, as
+you might be able to provide valuable additional information. That can be
+important even when a fix is prepared or in its final stages already, as
+developers might look for people that can provide additional information or
+test a proposed fix. Jump to the section 'Duties after the report went out' for
+details on how to get properly involved.
+
+
 Issue of high priority?
 -----------------------
 
@@ -1523,6 +1583,130 @@ was already fixed in the latest release of version line you're interested in.
 This kernel needs to be vanilla and shouldn't be tainted before the issue
 happens, as detailed outlined already above in the process of testing mainline.
 
+
+Check code history and search for existing discussions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *Search the Linux kernel version control system for the change that fixed
+    the issue in mainline, as its commit message might tell you if the fix is
+    scheduled for backporting already. If you don't find anything that way,
+    search the appropriate mailing lists for posts that discuss such an issue
+    or peer-review possible fixes; then check the discussions if the fix was
+    deemed unsuitable for backporting. If backporting was not considered at
+    all, join the newest discussion, asking if it's in the cards.*
+
+In a lot of cases the issue you deal with will have happened with mainline, but
+got fixed there. The commit that fixed it would need to get backported as well
+to get the issue solved. That's why you want to search for it or any
+discussions abound it.
+
+ * First try to find the fix in the Git repository that holds the Linux kernel
+   sources. You can do this with the web interfaces `on kernel.org
+   <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_
+   or its mirror `on GitHub <https://github.com/torvalds/linux>`_; if you have
+   a local clone you alternatively can search on the command line with ``git
+   log --grep=<pattern>``.
+
+   If you find the fix, look if the commit message near the end contains a
+   'stable tag' that looks like this:
+
+          Cc: <stable@vger.kernel.org> # 5.4+
+
+   If that's case the developer marked the fix safe for backporting to version
+   line 5.4 and later. Most of the time it's getting applied there within two
+   weeks, but sometimes it takes a bit longer.
+
+ * If the commit doesn't tell you anything or if you can't find the fix, look
+   again for discussions about the issue. Search the net with your favorite
+   internet search engine as well as the archives for the `Linux kernel
+   developers mailing list <https://lore.kernel.org/lkml/>`_. Also read the
+   section `Locate kernel area that causes the issue` above and follow the
+   instructions to find the subsystem in question: its bug tracker or mailing
+   list archive might have the answer you are looking for.
+
+ * If you see a proposed fix, search for it in the version control system as
+   outlined above, as the commit might tell you if a backport can be expected.
+
+   * Check the discussions for any indicators the fix might be too risky to get
+     backported to the version line you care about. If that's the case you have
+     to live with the issue or switch to the kernel version line where the fix
+     got applied.
+
+   * If the fix doesn't contain a stable tag and backporting was not discussed,
+     join the discussion: mention the version where you face the issue and that
+     you would like to see it fixed, if suitable.
+
+Details about reporting issues only occurring in older kernel version lines
+---------------------------------------------------------------------------
+
+This subsection provides details for steps you need to take if you could not
+reproduce your issue with a mainline kernel, but want to see it fixed in older
+version lines (aka stable and longterm kernels).
+
+Some fixes are too complex
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *Prepare yourself for the possibility that going through the next few steps
+    might not get the issue solved in older releases: the fix might be too big
+    or risky to get backported there.*
+
+Even small and seemingly obvious code-changes sometimes introduce new and
+totally unexpected problems. The maintainers of the stable and longterm kernels
+are very aware of that and thus only apply changes to these kernels that are
+within rules outlined in 'Documentation/process/stable-kernel-rules.rst'.
+
+Complex or risky changes for example do not qualify and thus only get applied
+to mainline. Other fixes are easy to get backported to the newest stable and
+longterm kernels, but too risky to integrate into older ones. So be aware the
+fix you are hoping for might be one of those that won't be backported to the
+version line your care about. In that case you'll have no other choice then to
+live with the issue or switch to a newer Linux version, unless you want to
+patch the fix into your kernels yourself.
+
+Make sure the particular version line still gets support
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *Check if the kernel developers still maintain the Linux kernel version
+    line you care about: go to the front page of kernel.org and make sure it
+    mentions the latest release of the particular version line without an
+    '[EOL]' tag.*
+
+Most kernel version lines only get supported for about three months, as
+maintaining them longer is quite a lot of work. Hence, only one per year is
+chosen and gets supported for at least two years (often six). That's why you
+need to check if the kernel developers still support the version line you care
+for.
+
+Note, if kernel.org lists two 'stable' version lines on the front page, you
+should consider switching to the newer one and forget about the older one:
+support for it is likely to be abandoned soon. Then it will get a "end-of-life"
+(EOL) stamp. Version lines that reached that point still get mentioned on the
+kernel.org front page for a week or two, but are unsuitable for testing and
+reporting.
+
+Search stable mailing list
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *Check the archives of the Linux stable mailing list for existing reports.*
+
+Maybe the issue you face is already known and was fixed or is about to. Hence,
+`search the archives of the Linux stable mailing list
+<https://lore.kernel.org/stable/>`_ for reports about an issue like yours. If
+you find any matches, consider joining the discussion, unless the fix is
+already finished and scheduled to get applied soon.
+
+Reproduce issue with the newest release
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *Install the latest release from the particular version line as a vanilla
+    kernel. Ensure this kernel is not tainted and still shows the problem, as
+    the issue might have already been fixed there.*
+
+Before investing any more time in this process you want to check if the issue
+was already fixed in the latest release of version line you're interested in.
+This kernel needs to be vanilla and shouldn't be tainted before the issue
+happens, as detailed outlined already above in the process of testing mainline.
+
 Check code history and search for existing discussions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.30.2

