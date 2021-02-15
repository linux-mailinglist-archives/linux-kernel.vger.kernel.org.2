Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2FD31BADD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBOOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhBOOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:20:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 06:19:55 -0800 (PST)
Received: from zn.tnic (p200300ec2f043400c4db7402f90f0bee.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:3400:c4db:7402:f90f:bee])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 404D01EC0521;
        Mon, 15 Feb 2021 15:19:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613398792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6bvkc1xgd09yvB3hbFh73PwazLv4WCVUMzuzPCEt3Hg=;
        b=iHgIMKgpkvHF2v5s9cs8zLVwEPUOe4+KKTBLh1gezzcoEpkdBxnYTB/W4LOgHTNcllkOal
        Pp9S/smL6ZAZXniDRu+gn/xzLeh7ywY9xI6GiqoUoDT2EvIfrizUs5D5VWMYFXRvZGgDR1
        WxCdpSAg7YmJ2+2hGCnw0tZezn2rO1M=
Date:   Mon, 15 Feb 2021 15:19:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation/submitting-patches: Extend commit message
 layout description
Message-ID: <20210215141949.GB21734@zn.tnic>
References: <20201217183756.GE23634@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201217183756.GE23634@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>
Subject: [PATCH] Documentation/submitting-patches: Extend commit message layout description

Add more blurb about the level of detail that should be contained in a
patch's commit message. Extend and make more explicit what text should
be added under the --- line. Extend examples and split into more easily
palatable paragraphs.

This has been partially carved out from a tip subsystem handbook
patchset by Thomas Gleixner:

  https://lkml.kernel.org/r/20181107171010.421878737@linutronix.de

and incorporates follow-on comments.

Signed-off-by: Borislav Petkov <bp@suse.de>
---

/me sends the next generic topic blurb.

 Documentation/process/submitting-patches.rst | 89 ++++++++++++--------
 1 file changed, 56 insertions(+), 33 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 5ca072f9ecb7..403784aca1f2 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -623,16 +623,19 @@ not considered part of the summary phrase, but describe how the patch
 should be treated.  Common tags might include a version descriptor if
 the multiple versions of the patch have been sent out in response to
 comments (i.e., "v1, v2, v3"), or "RFC" to indicate a request for
-comments.  If there are four patches in a patch series the individual
-patches may be numbered like this: 1/4, 2/4, 3/4, 4/4.  This assures
-that developers understand the order in which the patches should be
-applied and that they have reviewed or applied all of the patches in
-the patch series.
+comments.
+
+If there are four patches in a patch series the individual patches may
+be numbered like this: 1/4, 2/4, 3/4, 4/4. This assures that developers
+understand the order in which the patches should be applied and that
+they have reviewed or applied all of the patches in the patch series.
 
 A couple of example Subjects::
 
     Subject: [PATCH 2/5] ext2: improve scalability of bitmap searching
     Subject: [PATCH v2 01/27] x86: fix eflags tracking
+    Subject: [PATCH v2] sub/sys: Condensed patch summary
+    Subject: [PATCH v2 M/N] sub/sys: Condensed patch summary
 
 The ``from`` line must be the very first line in the message body,
 and has the form:
@@ -645,34 +648,54 @@ then the ``From:`` line from the email header will be used to determine
 the patch author in the changelog.
 
 The explanation body will be committed to the permanent source
-changelog, so should make sense to a competent reader who has long
-since forgotten the immediate details of the discussion that might
-have led to this patch.  Including symptoms of the failure which the
-patch addresses (kernel log messages, oops messages, etc.) is
-especially useful for people who might be searching the commit logs
-looking for the applicable patch.  If a patch fixes a compile failure,
-it may not be necessary to include _all_ of the compile failures; just
-enough that it is likely that someone searching for the patch can find
-it.  As in the ``summary phrase``, it is important to be both succinct as
-well as descriptive.
-
-The ``---`` marker line serves the essential purpose of marking for patch
-handling tools where the changelog message ends.
-
-One good use for the additional comments after the ``---`` marker is for
-a ``diffstat``, to show what files have changed, and the number of
-inserted and deleted lines per file.  A ``diffstat`` is especially useful
-on bigger patches.  Other comments relevant only to the moment or the
-maintainer, not suitable for the permanent changelog, should also go
-here.  A good example of such comments might be ``patch changelogs``
-which describe what has changed between the v1 and v2 version of the
-patch.
-
-If you are going to include a ``diffstat`` after the ``---`` marker, please
-use ``diffstat`` options ``-p 1 -w 70`` so that filenames are listed from
-the top of the kernel source tree and don't use too much horizontal
-space (easily fit in 80 columns, maybe with some indentation).  (``git``
-generates appropriate diffstats by default.)
+changelog, so should make sense to a competent reader who has long since
+forgotten the immediate details of the discussion that might have led to
+this patch. Including symptoms of the failure which the patch addresses
+(kernel log messages, oops messages, etc.) are especially useful for
+people who might be searching the commit logs looking for the applicable
+patch. The text should be written in such detail so that when read
+weeks, months or even years later, it can give the reader the needed
+details to grasp the reasoning for **why** the patch was created.
+
+If a patch fixes a compile failure, it may not be necessary to include
+_all_ of the compile failures; just enough that it is likely that
+someone searching for the patch can find it. As in the ``summary
+phrase``, it is important to be both succinct as well as descriptive.
+
+The ``---`` marker line serves the essential purpose of marking for
+patch handling tools where the changelog message ends.
+
+One good use for the additional comments after the ``---`` marker is
+for a ``diffstat``, to show what files have changed, and the number of
+inserted and deleted lines per file. A ``diffstat`` is especially useful
+on bigger patches. If you are going to include a ``diffstat`` after the
+``---`` marker, please use ``diffstat`` options ``-p 1 -w 70`` so that
+filenames are listed from the top of the kernel source tree and don't
+use too much horizontal space (easily fit in 80 columns, maybe with some
+indentation). (``git`` generates appropriate diffstats by default.)
+
+Other comments relevant only to the moment or the maintainer, not
+suitable for the permanent changelog, should also go here. A good
+example of such comments might be ``patch changelogs`` which describe
+what has changed between the v1 and v2 version of the patch.
+
+Please put this information **after** the ``---`` line which separates
+the changelog from the rest of the patch. The version information is
+not part of the changelog which gets committed to the git tree. It is
+additional information for the reviewers. If it's placed above the
+commit tags, it needs manual interaction to remove it. If it is below
+the separator line, it gets automatically stripped off when applying the
+patch::
+
+  <commit message>
+  ...
+  Signed-off-by: Author <author@mail>
+  ---
+  V2 -> V3: Removed redundant helper function
+  V1 -> V2: Cleaned up coding style and addressed review comments
+
+  path/to/file | 5+++--
+  ...
 
 See more details on the proper patch format in the following
 references.
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
