Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0A44391F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhJYJJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhJYJJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:09:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34621C061745;
        Mon, 25 Oct 2021 02:06:38 -0700 (PDT)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mevwB-0005ei-Se; Mon, 25 Oct 2021 11:06:35 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] docs: submitting-patches: make section about the Link: tag more explicit
Date:   Mon, 25 Oct 2021 11:06:35 +0200
Message-Id: <27105768dc19b395e7c8e7a80d056d1ff9c570d0.1635152553.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635152553.git.linux@leemhuis.info>
References: <cover.1635152553.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1635152798;d914673d;
X-HE-SMSGID: 1mevwB-0005ei-Se
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention the 'Link' tag in the section about adding URLs to the commit
msg, to make it clearer they "_primarily_ [...] should be about
background", as Linus recently stated (see the link below). That makes
the explanation also easier to find with a text search. For the same
reason and to improve comprehensibility provide an example, too.

Slightly improve the text at the same time to make it more obvious
developers are meant to add links to issue reports in mailing list
archives, as those allow regression tracking efforts to automatically
check which bugs got resolved.

Move the section also downwards slightly, to reduce jumping back and
forth between aspects relevant for the top and the bottom part of the
commit msg.

Link: https://lore.kernel.org/lkml/CAHk-=wgBhyLhQLPem1vybKNt7BKP+=qF=veBgc7VirZaXn4FUw@mail.gmail.com/
CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/submitting-patches.rst | 33 +++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index b0f31aa82fcd..cbe9ddbe2775 100644
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
@@ -123,6 +112,28 @@ collisions with shorter IDs a real possibility.  Bear in mind that, even if
 there is no collision with your six-character ID now, that condition may
 change five years from now.
 
+If related discussions or any other background information behind the change
+can be found on the web, add 'Link:' tags pointing to it. In case your patch
+for example fixes a bug, add a tag with a URL referencing the report in the
+mailing list archives or a bug tracker; if the patch is a result of some
+earlier mailing list discussion or something documented on the web, point to
+it.
+
+When linking to mailing list archives, preferably use the lore.kernel.org
+message archiver service. To create the link URL, use the contents of the
+``Message-Id`` header of the message without the surrounding angle brackets.
+For example::
+
+    Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+
+Please check the link to make sure that it is actually working and points
+to the relevant message.
+
+However, try to make your explanation understandable without external
+resources. In addition to giving a URL to a mailing list archive or bug,
+summarize the relevant points of the discussion that led to the
+patch as submitted.
+
 If your patch fixes a bug in a specific commit, e.g. you found an issue using
 ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
 the SHA-1 ID, and the one line summary.  Do not split the tag across multiple
-- 
2.31.1

