Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D494242D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhJFQjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJFQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:39:34 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FED4C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 09:37:42 -0700 (PDT)
Received: from ip4d14bdef.dynamic.kabel-deutschland.de ([77.20.189.239] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mY9vG-00059a-QZ; Wed, 06 Oct 2021 18:37:38 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] docs: submitting-patches: make section on linking more explicit
Date:   Wed,  6 Oct 2021 18:37:38 +0200
Message-Id: <7dff33afec555fed0bf033c910ca59f9f19f22f1.1633537634.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1633538262;2b26ee72;
X-HE-SMSGID: 1mY9vG-00059a-QZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention the 'Link' tag in the section about adding URLs to the commit
msg, which makes it easier to find their meaning with a text search. For
the same reason and to improve comprehensibility also provide an
example.

Slightly improve the text at the same time to make it more obvious
developers are meant to add links to issue reports in mailing list
archives, as those allow regression tracking efforts to automatically
check which bugs got resolved.

Move the section also downwards slightly, to not jump back and forth
between aspects relevant for the top and the bottom part of the commit
msg.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

---

Lo! The regression tracking bot I'm working on can automatically mark
entries as resolved, if a commit message uses a 'Link' tag to the
report.  Many developers already add them, but it afaics would improve
matters to make this more explicit. Especially as I had missed the
section about it myself at first, as I simply grepped for 'Link:' and
only found an explanation in configure-git.rst.

Konstantin, let me known if I should do a
s!lkml.kernel.org/r/!lore.kernel.org/r/! at the same time. If it is a
good idea, I'll prepare a second patch that does this here and other
places refering to lkml.kernel.org/r/ in a similar fashion.

Ciao, Thorsten
---
 Documentation/process/submitting-patches.rst | 26 +++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 21125d299ce6..0318a8e1dcd6 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -96,17 +96,6 @@ instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
 to do frotz", as if you are giving orders to the codebase to change
 its behaviour.
 
-If the patch fixes a logged bug entry, refer to that bug entry by
-number and URL.  If the patch follows from a mailing list discussion,
-give a URL to the mailing list archive; use the https://lkml.kernel.org/
-redirector with a ``Message-Id``, to ensure that the links cannot become
-stale.
-
-However, try to make your explanation understandable without external
-resources.  In addition to giving a URL to a mailing list archive or
-bug, summarize the relevant points of the discussion that led to the
-patch as submitted.
-
 If you want to refer to a specific commit, don't just refer to the
 SHA-1 ID of the commit. Please also include the oneline summary of
 the commit, to make it easier for reviewers to know what it is about.
@@ -123,6 +112,21 @@ collisions with shorter IDs a real possibility.  Bear in mind that, even if
 there is no collision with your six-character ID now, that condition may
 change five years from now.
 
+Add 'Link:' tags with URLs pointing to related discussions and rationale
+behind the change whenever that makes sense. If your patch for example
+fixes a bug, add a tag with a URL referencing the report in the mailing
+list archives or a bug tracker; if the patch follows from a mailing list
+discussion, point to it. When linking to mailing list archives, use the
+https://lkml.kernel.org/r/ redirector with a ``Message-Id``, to ensure
+that the links cannot become stale. These tags should look like this::
+
+	Link: https://lkml.kernel.org/r/<message-id>
+
+However, try to make your explanation understandable without external
+resources.  In addition to giving a URL to a mailing list archive or
+bug, summarize the relevant points of the discussion that led to the
+patch as submitted.
+
 If your patch fixes a bug in a specific commit, e.g. you found an issue using
 ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
 the SHA-1 ID, and the one line summary.  Do not split the tag across multiple

base-commit: b19511926cb50d59c57189739d03c21df325710f
-- 
2.31.1

