Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B379330057
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 12:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhCGLe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 06:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhCGLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 06:33:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8D6C061760;
        Sun,  7 Mar 2021 03:33:57 -0800 (PST)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lIrfT-0002Ox-DZ; Sun, 07 Mar 2021 12:33:51 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] docs: reporting-issues: a easier process for reporting stable regressions
Date:   Sun,  7 Mar 2021 12:33:48 +0100
Message-Id: <cover.1615116592.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1615116837;e43d2063;
X-HE-SMSGID: 1lIrfT-0002Ox-DZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series creates a streamlined process for users wanting to report
regressions within a stable and longterm kernel series. The existing process is
too demanding, complicated and takes too much time for this case.

I didn't CC the stable maintainers here, they need to review the whole document
anyway once the last few details have been sorted out.

v2:
* inital version, starting straight with v2 to avoid confusion, as one of the
patches was submitted earlier already

Thorsten Leemhuis (2):
  docs: reporting-issues.rst: move tainted check upwards
  docs: reporting-issues.rst: shortcut for reporting stable regressions

 .../admin-guide/reporting-issues.rst          | 222 +++++++++++-------
 1 file changed, 135 insertions(+), 87 deletions(-)


base-commit: ba5cb300e0b540a330d579402d72cdd1808e5a8f
-- 
2.29.2

