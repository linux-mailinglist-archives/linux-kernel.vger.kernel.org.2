Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D3342632
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCST2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCST1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:27:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C025C061761;
        Fri, 19 Mar 2021 12:27:53 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lNKmj-0003Lu-Sw; Fri, 19 Mar 2021 20:27:49 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] docs: reporting-issues: streamline process and solve a FIXME
Date:   Fri, 19 Mar 2021 20:27:44 +0100
Message-Id: <cover.1616181657.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616182073;048012f6;
X-HE-SMSGID: 1lNKmj-0003Lu-Sw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series bundle a few patches that piled up for
Documentation/admin-guide/reporting-issues.rst. The main changes are these:

 * patch 2/5: tones down 'test vanilla mainline' a little and mention that
vendor kernel might be find in some cases if they are close to vanilla. Gets rid
of a "FIXME" box.

 * patch 5/5: creates a streamlined process for users wanting to report
regressions within a stable and longterm kernel series. The existing process is
too demanding, complicated and takes too much time for this case. I didn't CC
the stable maintainers here, they need to review the whole document anyway once
the last few details have been sorted out.

Patch 1/5 are just small fixes I wanted to keep separated. Patch 3/4 and 4/5 are
mainly there to make the diff in the last patch of this series easier to read in
the review phase. They can easily be squashed into the patches that follow them.

v3:
* add patch to fix a typo and an existing style-issue that came up during review
that until now handled separately
* add related patch that tones down 'test vanilla mainline' a bit
* add another patch to make the diff easier to read

v2: https://lore.kernel.org/linux-doc/cover.1615116592.git.linux@leemhuis.info/
* initial version, starting straight with v2 to avoid confusion, as one of the
patches was submitted earlier already

Thorsten Leemhuis (5):
  docs: reporting-issues.rst: fix small typos and style issues
  docs: reporting-issues.rst: tone down 'test vanilla mainline' a little
  docs: reporting-issues.rst: reorder some steps
  docs: reporting-issues.rst: duplicate sections for reviewing purposes
  docs: reporting-issues.rst: improved process esp. for stable
    regressions

 .../admin-guide/reporting-issues.rst          | 832 ++++++++++--------
 1 file changed, 471 insertions(+), 361 deletions(-)


base-commit: a8f2a68e42d19e6fc1e0eb6eaef548ef07b19d75
-- 
2.30.2

