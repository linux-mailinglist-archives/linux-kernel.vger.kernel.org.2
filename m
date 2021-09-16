Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D6740D5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhIPJRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235504AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 699CC61244;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=lCFQ10/rKoEUoXpgY/RKNlMSo/l4Wf718K79pRH2kXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kA11uYK63CNyCHPsXZO55zhW7NFb5J+mpI4JXMF5IZvQ2BCwBrQhpKQ0QqSTedZNt
         i9N7s8kvqKe8JGlm2n/VZeW5oZ87Fh4scAyGbQ0Y6rFUF1e3MPtex6gh1IXBhu7r4F
         +YMG6US77zZ/ULtDwr/CqKmiNBxCsX8ldsZQGFTxLRlWe4LLvIJxwLLyanFCEdTRIR
         YxodEvW5JBYwzCkniDMd5QtTD+a2zEqcLRP5+pyeS6ijDO1fIpXJUkwd2vfTeOY/lg
         sFMHuYtkSTrMvk/VwauWI9H70ulS8x8+ttjgb2ZLPIq6dookzIYMNzOKch/rE5N/4U
         VGLnj3UL/3LJA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTH-001sL1-Gv; Thu, 16 Sep 2021 11:14:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Mel Gorman <mgorman@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Kitt <steve@sk2.org>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/24] docs: accounting: update delay-accounting.rst reference
Date:   Thu, 16 Sep 2021 11:14:00 +0200
Message-Id: <8442e5e4e206f50b34c0089aa5f9dafa49302f95.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file name: accounting/delay-accounting.rst
should be, instead: Documentation/accounting/delay-accounting.rst.

Update its cross-reference accordingly.

Fixes: fcb501704554 ("delayacct: Document task_delayacct sysctl")
Fixes: c3123552aad3 ("docs: accounting: convert to ReST")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 426162009ce9..2b03422ef5f7 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1099,7 +1099,7 @@ task_delayacct
 ===============
 
 Enables/disables task delay accounting (see
-:doc:`accounting/delay-accounting.rst`). Enabling this feature incurs
+:doc:`Documentation/accounting/delay-accounting.rst`). Enabling this feature incurs
 a small amount of overhead in the scheduler but is useful for debugging
 and performance tuning. It is required by some tools such as iotop.
 
-- 
2.31.1

