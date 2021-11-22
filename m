Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA84589DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 08:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbhKVHgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 02:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbhKVHgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:36:51 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E644EC061714;
        Sun, 21 Nov 2021 23:33:45 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mp3pf-0008OQ-A9; Mon, 22 Nov 2021 08:33:43 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     workflows@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:' and 'Reviewed:'
Date:   Mon, 22 Nov 2021 08:33:42 +0100
Message-Id: <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637566224.git.linux@leemhuis.info>
References: <cover.1637566224.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1637566426;a7fd88d1;
X-HE-SMSGID: 1mp3pf-0008OQ-A9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the tags 'Reported:' and 'Reviewed:' in addition to 'Link:',
as the latter is overloaded and hence doesn't indicate what the provided
URL is about. Documenting these also provides clarity, as a few
developers have used 'References:' to point to problem reports;
nevertheless 'Reported:' was chosen for this purpose, as it perfectly
matches up with the 'Reported-by:' tag commonly used already and needed
in this situation already.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
To: workflows@vger.kernel.org
---
v1/RFC:
- first, *rough version* to see how this idea is received in the
  community
---
 Documentation/maintainer/configure-git.rst   |  6 +--
 Documentation/process/5.Posting.rst          | 54 ++++++++++++++------
 Documentation/process/submitting-patches.rst | 22 ++++----
 3 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
index 80ae5030a590..8429d45d661c 100644
--- a/Documentation/maintainer/configure-git.rst
+++ b/Documentation/maintainer/configure-git.rst
@@ -40,12 +40,12 @@ Creating commit links to lore.kernel.org
 The web site http://lore.kernel.org is meant as a grand archive of all mail
 list traffic concerning or influencing the kernel development. Storing archives
 of patches here is a recommended practice, and when a maintainer applies a
-patch to a subsystem tree, it is a good idea to provide a Link: tag with a
+patch to a subsystem tree, it is a good idea to provide a Reviewed: tag with a
 reference back to the lore archive so that people that browse the commit
 history can find related discussions and rationale behind a certain change.
 The link tag will look like this:
 
-    Link: https://lore.kernel.org/r/<message-id>
+    Reviewed: https://lore.kernel.org/r/<message-id>
 
 This can be configured to happen automatically any time you issue ``git am``
 by adding the following hook into your git:
@@ -56,7 +56,7 @@ by adding the following hook into your git:
 	$ cat >.git/hooks/applypatch-msg <<'EOF'
 	#!/bin/sh
 	. git-sh-setup
-	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
+	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Reviewed: https://lore.kernel.org/r/$1|g;' "$1"
 	test -x "$GIT_DIR/hooks/commit-msg" &&
 		exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
 	:
diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index 855a70b80269..c5d7c982a373 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -197,53 +197,75 @@ the build process, for example, or editor backup files) in the patch.  The
 file "dontdiff" in the Documentation directory can help in this regard;
 pass it to diff with the "-X" option.
 
-The tags mentioned above are used to describe how various developers have
-been associated with the development of this patch.  They are described in
-detail in
-the :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
-document; what follows here is a brief summary.  Each of these lines has
-the format:
+The tags already briefly mentioned above are used to provide insights how
+the patch came into being. They are described in detail in the
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+document; what follows here is a brief summary.
 
-::
+One tag is used to refer to earlier commits which had problems fixed by
+the patch::
+
+	Fixes: 1f2e3d4c5b6a ("The first line of the commit specified by the first 12 characters of its SHA-1 ID")
+
+A second kind of tags is used to link webpages with additional details. There
+are three different tags of this sort which all use the following format::
+
+	Reported: https://example.com/somewhere.html  optional-other-stuff
+
+The tags in common use are:
+
+ - ``Reported:`` points to a report of a problem fixed by this patch. The
+   provided URL thus might point to a entry in a bug tracker or a mail in a
+   mailing list archive. Typically this tag is followed by a "Reported-by:"
+   tag (see below).
+
+ - ``Link:`` points to websites providing additional backgrounds or details,
+   for example a document with a specification implemented by the patch.
+
+ - ``Reviewed:`` ignore this, as maintainers add it when applying a patch, to
+   make the commit point to the latest public review of the patch.
+
+A third kind of tags are used to document which developers were involved in
+the development of the patch. Each of these uses this format::
 
 	tag: Full Name <email address>  optional-other-stuff
 
 The tags in common use are:
 
- - Signed-off-by: this is a developer's certification that he or she has
+ - ``Signed-off-by:`` is a developer's certification that he or she has
    the right to submit the patch for inclusion into the kernel.  It is an
    agreement to the Developer's Certificate of Origin, the full text of
    which can be found in :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
    Code without a proper signoff cannot be merged into the mainline.
 
- - Co-developed-by: states that the patch was co-created by several developers;
+ - ``Co-developed-by:`` states that the patch was co-created by several developers;
    it is a used to give attribution to co-authors (in addition to the author
    attributed by the From: tag) when multiple people work on a single patch.
    Every Co-developed-by: must be immediately followed by a Signed-off-by: of
    the associated co-author.  Details and examples can be found in
    :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`.
 
- - Acked-by: indicates an agreement by another developer (often a
+ - ``Acked-by:`` indicates an agreement by another developer (often a
    maintainer of the relevant code) that the patch is appropriate for
    inclusion into the kernel.
 
- - Tested-by: states that the named person has tested the patch and found
+ - ``Tested-by:`` states that the named person has tested the patch and found
    it to work.
 
- - Reviewed-by: the named developer has reviewed the patch for correctness;
+ - ``Reviewed-by:`` the named developer has reviewed the patch for correctness;
    see the reviewer's statement in :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
    for more detail.
 
- - Reported-by: names a user who reported a problem which is fixed by this
+ - ``Reported-by:`` names a user who reported a problem which is fixed by this
    patch; this tag is used to give credit to the (often underappreciated)
    people who test our code and let us know when things do not work
    correctly.
 
- - Cc: the named person received a copy of the patch and had the
+ - ``Cc:`` the named person received a copy of the patch and had the
    opportunity to comment on it.
 
-Be careful in the addition of tags to your patches: only Cc: is appropriate
-for addition without the explicit permission of the person named.
+Be careful when adding this sort of tags to your patches: only Cc: is
+appropriate for addition without the explicit permission of the person named.
 
 
 Sending the patch
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index da085d63af9b..b7c9155da9bd 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -112,20 +112,22 @@ collisions with shorter IDs a real possibility.  Bear in mind that, even if
 there is no collision with your six-character ID now, that condition may
 change five years from now.
 
-If related discussions or any other background information behind the change
-can be found on the web, add 'Link:' tags pointing to it. In case your patch
-fixes a bug, for example, add a tag with a URL referencing the report in the
-mailing list archives or a bug tracker; if the patch is a result of some
-earlier mailing list discussion or something documented on the web, point to
-it.
+Add tags linking to any related discussions or background information behind
+the change on the web. For example, if your patch fixes a bug, add a
+`Reported:` tag pointing to the report in the mailing list archives or a bug
+tracker::
 
-When linking to mailing list archives, preferably use the lore.kernel.org
-message archiver service. To create the link URL, use the contents of the
-``Message-Id`` header of the message without the surrounding angle brackets.
-For example::
+    Reported: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+
+If the patch is a related to some earlier mailing list discussion or something
+documented on the web, point to it using a `Link:` tag::
 
     Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
 
+When linking to mailing list archives, preferably use the lore.kernel.org
+message archiver service. To create the link URL, use the contents of the
+``Message-Id`` header of the message without the surrounding angle brackets,
+e.g. "30th.anniversary.repost@klaava.Helsinki.FI" in the two examples above.
 Please check the link to make sure that it is actually working and points
 to the relevant message.
 
-- 
2.31.1

