Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB7F40D6C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhIPJ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235287AbhIPJ4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:56:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E792611CA;
        Thu, 16 Sep 2021 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631786126;
        bh=lCFQ10/rKoEUoXpgY/RKNlMSo/l4Wf718K79pRH2kXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObqqEZed2gEOjDwwLnMW85WUSshm88SkBEfljKdJ90G8e0EboIVAdazbN/igpn3Rw
         AhzUd/eQ5MFlVLh+jw+R6eH2gmblpo9bFgr30HCMd3PhGGLiOh0+a/o1XB9c/zjewN
         23o9ywRY7YKwkofciGYTt1juluS/0sGwbwLV56XMj9+EeDw3bo/NMV4p5zN7KphiK1
         +KUVMGmGKLrWan2Mn+arKaqYwxM693dSsrxWiYIs35SnIqP1HGMA1xCEGrSkS84PcJ
         EvsDWmypOeGoIsNMMkBmc3I6YDWaU5Wq1whvKzFEjqwbs2/Y/DcAZN2GkFGFbMa54V
         9Wgvm3l9LgLNQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQo72-001vTk-Cm; Thu, 16 Sep 2021 11:55:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mel Gorman <mgorman@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Kitt <steve@sk2.org>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/23] docs: accounting: update delay-accounting.rst reference
Date:   Thu, 16 Sep 2021 11:55:06 +0200
Message-Id: <472ebc3662053a0d52879818354e1742551afbc9.1631785820.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631785820.git.mchehab+huawei@kernel.org>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
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

