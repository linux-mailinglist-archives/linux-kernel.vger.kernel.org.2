Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D1E4589DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 08:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbhKVHgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 02:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhKVHgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:36:51 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1C8C061574;
        Sun, 21 Nov 2021 23:33:45 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mp3pf-0008OQ-4R; Mon, 22 Nov 2021 08:33:43 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     workflows@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH v1 0/1] Create 'Reported:' and 'Reviewed:' tags for links in commit messages
Date:   Mon, 22 Nov 2021 08:33:41 +0100
Message-Id: <cover.1637566224.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1637566425;c0e439ea;
X-HE-SMSGID: 1mp3pf-0008OQ-4R
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch proposes to create two new tags for mentioning links in
commit messages. They are meant to make it obvious what provided links are
about, which is useful for both users and scripts studying commits.

The new tag 'Reported:' is meant to be used for linking to bug reports, while
'Reviewed:' should point to the last review of the patch in question. They
supplement 'Link:', which until now has been used for these two as well as other
purposes; it stays around for the latter use case, for example for links to PDFs
or webpages with background information relevant for the patch.

This submission partly got indirectly triggered by regzbot, my Linux kernel
regression tracking bot (https://linux-regtracking.leemhuis.info/regzbot/ ). It
automatically marks a tracked regression as resolved when it notices a commit
with a 'Link:' pointing to the report of the tracked regression. In preparation
for this I recently improved the kernel's documentation on 'Link:' to the best
of my understanding in commit 1f57bd42b77c
(https://git.kernel.org/linus/1f57bd42b77c ). I also started pointing out that
usage to various people when I noticed the links were missing. Some didn't know
that 'Link:' was supposed to be like this, while developers from the DRM
subsystem were using 'References:' instead; some developer also simply used
footnotes style and there are also quite a few developers unaware they are
supposed to add links to bug reports.

I could continue down that path and further educating developers, no big deal.
But I wondered if I was making a problem worse, as I always found it a bit
confusing that 'Link:' is used for different purposes and thus ambiguous. The
situation thus made me wonder if this wouldn't be a good time to improve the
whole situation by going a step further. That's how the proposed patch (still a
bit rough) came to light.

Obviously such a change will force developers and maintainers to adjust, so it's
nothing that should be done lighthearted. But I guess in the long-run it's worth
it. And for 'Review:' the conversion shouldn't be much work for people, as many
just need to update their `git am` hook or switch to a hypothetical new version
of b4 that was adjusted to place 'Reviewed:' tags instead of 'Link:'. It's a bit
more of a hassle when it comes to 'Reported:', as some people will need to
update their muscle memory. But the similarity to the 'Reported-by:' tag (to be
used in the same situation) should help here; and quite a bit of education in
this area is needed anyway (see above).

In both use cases there is no real harm done if it takes the world a while to
adapt, as 'Link:' stays around.

I won't mind at all if this bold move gets rejected, if that's the case I'll
simply modify the patch a bit to properly describe the 'Link:' tag in
Documentation/process/5.Posting.rst, as it's not mentioning it at all right now.
But I think proposing this was worth a shot, as having distant tags for various
types of links might be handy for other purposes in the long-run as well.

Ciao, Thorsten

P.S.: I'm sending v1/RFC to workflows list and LKML only to test the waters and
hopefully collect some supportive arguments. If this doesn't get shot down there
I'll post a v2/RFC to wider audience including Linus and Greg; not sure yet if
I'll to Cc ksummit then as well, as it would be abusing the list somewhat, but
OTOH is a good way to reach a lot of core people that might care about this.

Thorsten Leemhuis (1):
  docs: add the new commit-msg tags 'Reported:' and 'Reviewed:'

 Documentation/maintainer/configure-git.rst   |  6 +--
 Documentation/process/5.Posting.rst          | 54 ++++++++++++++------
 Documentation/process/submitting-patches.rst | 22 ++++----
 3 files changed, 53 insertions(+), 29 deletions(-)


base-commit: b96ff02ab2be1791248237b1bf318aaf62e8b701
-- 
2.31.1

