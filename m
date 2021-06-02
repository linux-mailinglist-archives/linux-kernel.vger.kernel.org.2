Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BDD398F1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhFBPpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232374AbhFBPpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:45:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C7D361412;
        Wed,  2 Jun 2021 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622648602;
        bh=cSLcm2mPxKPQ28RL9Wts8oJokCrE7RrCLtsCxNxWcvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrXfghpbxNdoL6WY/Ne9BysSunWtBs2LzbXm3Im2c+jjEvUiN3MPeQAjvj8b5ei3W
         uhTSks+/MK6Sj3odPAmr5iH4xHjjmlHGopQH0KzFkmvazKXNWnO0o4jrZqdk2sQFuO
         iUz2c4fA7J0mM5mTyJtdgij8440C41NzRTH3HrUucQYbWne7o1wXV9z6yCTbhFWqRE
         r/bryVAiQ93F4rAAScDE+MwbS9J9BLvvcXxV7j3t6HWF3wy53XAEuoUZWE3QWCizXI
         TuMU7yFcFf5Ap2KjuySw/QOFoNItdJbTSHgaPA86FDWzkRvxOL0mUmXqja0fQRVAhp
         n94+xptekdenA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1loT1b-006Xbz-HS; Wed, 02 Jun 2021 17:43:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Lepton Wu <ytht.net@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Kitt <steve@sk2.org>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] docs: accounting: update delay-accounting.rst reference
Date:   Wed,  2 Jun 2021 17:43:13 +0200
Message-Id: <629b0bd21d02c8faef9a6d17d9eee8ff612715e0.1622648507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622648507.git.mchehab+huawei@kernel.org>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When :doc: is used, the .rst should be removed. Also, the patches
are relative to the current directory.

So, the right reference should be:

	:doc:`/accounting/delay-accounting`

Fixes: fcb501704554 ("delayacct: Document task_delayacct sysctl")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index b2057173fe07..7f36cba3204b 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1097,7 +1097,7 @@ task_delayacct
 ===============
 
 Enables/disables task delay accounting (see
-:doc:`accounting/delay-accounting.rst`). Enabling this feature incurs
+:doc:`/accounting/delay-accounting`). Enabling this feature incurs
 a small amount of overhead in the scheduler but is useful for debugging
 and performance tuning. It is required by some tools such as iotop.
 
-- 
2.31.1

