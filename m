Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5283F4330A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhJSIHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234720AbhJSIGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA636613A0;
        Tue, 19 Oct 2021 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630667;
        bh=1WPjARHvGnN051Pn6x7+eG/yGDmMvFIt+wb9ri9pG3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JuOAZrjEiLsYboDw16mKZ2Hs0pwPcnlEOLH81kXi0hp63iTFvZHCNKe7Dj8ALjsdb
         ynJ1KhdacREI+NZBAa6LZ1pj8RkiXvl/Zsm4+i3NEIdDc3DKUMyuiAjmOxZqTNU7ZJ
         I07BAKxvGMe92a8NsJ/yj6JE1htABh4gjgOQOevLzvqgDH+mzoWo6i2xPfCoHk1BZl
         3AbxbcczepdbEEofXXm+2DaLUJwgBbdFT1EsdQqgpK4nJiwQjOZeaTWpTPHQBsI1SI
         xbPHqcUvnQq9TANKxYDq3vPD8+oDCSv5GVMFhB9FaEI1SfAHU3UkXP3Tp5N/ihFrtw
         +1cvEeRem+Cuw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oIx-1Y; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Mel Gorman <mgorman@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Kitt <steve@sk2.org>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/23] docs: accounting: update delay-accounting.rst reference
Date:   Tue, 19 Oct 2021 09:04:02 +0100
Message-Id: <2b8432e5506f7f2882b91cdbbfe8052babc89ad1.1634630485.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file name: accounting/delay-accounting.rst
should be, instead: Documentation/accounting/delay-accounting.rst.

Also, there's no need to use doc:`foo`, as automarkup.py will
automatically handle plain text mentions to Documentation/
files.

So, update its cross-reference accordingly.

Fixes: fcb501704554 ("delayacct: Document task_delayacct sysctl")
Fixes: c3123552aad3 ("docs: accounting: convert to ReST")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 Documentation/admin-guide/sysctl/kernel.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 426162009ce9..0e486f41185e 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1099,7 +1099,7 @@ task_delayacct
 ===============
 
 Enables/disables task delay accounting (see
-:doc:`accounting/delay-accounting.rst`). Enabling this feature incurs
+Documentation/accounting/delay-accounting.rst. Enabling this feature incurs
 a small amount of overhead in the scheduler but is useful for debugging
 and performance tuning. It is required by some tools such as iotop.
 
-- 
2.31.1

