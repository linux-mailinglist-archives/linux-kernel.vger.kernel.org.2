Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8582C424E8B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 10:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbhJGIHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 04:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbhJGIG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 04:06:58 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2683FC061755;
        Thu,  7 Oct 2021 01:05:05 -0700 (PDT)
Received: from ip4d14bdef.dynamic.kabel-deutschland.de ([77.20.189.239] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mYOOk-0004cv-Ew; Thu, 07 Oct 2021 10:05:02 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] docs: submitting-patches: make section about the Link: tag more explicit
Date:   Thu,  7 Oct 2021 10:05:01 +0200
Message-Id: <d97daa2791a7598a6ee4e853d3c6b536919191d5.1633593385.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633593385.git.linux@leemhuis.info>
References: <cover.1633593385.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1633593905;9ee3c910;
X-HE-SMSGID: 1mYOOk-0004cv-Ew
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention the 'Link' tag in the section about adding URLs to the commit
msg, which makes it easier to find its meaning with a text search. For
the same reason and to also improve comprehensibility provide an
example.

Slightly improve the text at the same time to make it more obvious
developers are meant to add links to issue reports in mailing list
archives, as those allow regression tracking efforts to automatically
check which bugs got resolved.

Move the section also downwards slightly, to reduce jumping back and
forth between aspects relevant for the top and the bottom part of the
commit msg.

CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/submitting-patches.rst | 32 +++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index b0f31aa82fcd..8ba69332322f 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -96,17 +96,6 @@ instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
 to do frotz", as if you are giving orders to the codebase to change
 its behaviour.
 
-If the patch fixes a logged bug entry, refer to that bug entry by
-number and URL.  If the patch follows from a mailing list discussion,
-give a URL to the mailing list archive; use the https://lore.kernel.org/
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
@@ -123,6 +112,27 @@ collisions with shorter IDs a real possibility.  Bear in mind that, even if
 there is no collision with your six-character ID now, that condition may
 change five years from now.
 
+Add 'Link:' tags with URLs pointing to related discussions and rationale
+behind the change whenever that makes sense. If your patch for example
+fixes a bug, add a tag with a URL referencing the report in the mailing
+list archives or a bug tracker; if the patch was discussed on a mailing
+list or originated in some discussion, point to it.
+
+When linking to mailing list archives, preferably use the lore.kernel.org
+message archiver service. To create the link URL, use the contents of the
+``Message-Id`` header of the message without the surrounding angle brackets.
+For example::
+
+    Link: https://lore.kernel.org/r/git-send-email.555-1234@example.org
+
+Please check the link to make sure that it is actually working and points
+to the relevant message.
+
+However, try to make your explanation understandable without external
+resources.  In addition to giving a URL to a mailing list archive or
+bug, summarize the relevant points of the discussion that led to the
+patch as submitted.
+
 If your patch fixes a bug in a specific commit, e.g. you found an issue using
 ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
 the SHA-1 ID, and the one line summary.  Do not split the tag across multiple
-- 
2.31.1

