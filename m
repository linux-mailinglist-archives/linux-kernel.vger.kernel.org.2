Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE0C4600E4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 19:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbhK0SVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 13:21:02 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:17835 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233052AbhK0STB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 13:19:01 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AzRNkJ6MdzJarbdDvrR0IlcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQO51z8q3jIHmDRJXD2FO6zcNmL3f9pzaoTl9ksDscPXm99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM+X9BDpC79SMljPjSGeKmYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFCtq?=
 =?us-ascii?q?piLf2dCXmQJaCYE7Q2jwPAfHk20cZzsAx+v9T2P40a1pTijzPm9luwdFJnZ22U?=
 =?us-ascii?q?wYgeKPW8AgYe0cFT34jYfMuFLjvZCLXXdao51LHd3/96/RoAls/MYAR9qBwG24?=
 =?us-ascii?q?m3fcXJTRLfAyOr+2zybO/DOJrg6wLJcrzOasbu3d93XTXCusgTZnfQqLMo9hC0?=
 =?us-ascii?q?18YgsFIAOabYs8xaiRmZxeGZAdAUn8TCZQjjKKri2P5fjlwtl2Yv+w07nLVwQg?=
 =?us-ascii?q?316LiWPLeet3MQMRTkUaRoUrU42m/CRYfcteZoRKX/3uoje7njz/2HokVEfuz8?=
 =?us-ascii?q?JZXbPe7roAIIERJDh3i+6D/1B74C48ZMUEKvDEgt+40+VDDczU0ZDXgyFbsg/L?=
 =?us-ascii?q?Wc4M4/zUG1Tyw?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AfQ2HiaP2gCoMvsBcTtqjsMiBIKoaSvp037BN?=
 =?us-ascii?q?7TESdfU1SL36qynApp4mPHPP5Qr5O0tBpTnjAse9qBrnnPYf3WB7B9iftWfd1F?=
 =?us-ascii?q?dAYLsC0bff?=
X-IronPort-AV: E=Sophos;i="5.87,269,1631570400"; 
   d="scan'208";a="6547546"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 19:15:45 +0100
Date:   Sat, 27 Nov 2021 19:15:45 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Matthew Wilcox <willy@infradead.org>
cc:     cgel.zte@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: scripts/coccinelle: drop bugon.cocci
Message-ID: <alpine.DEB.2.22.394.2111271913330.2864@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BUG_ON script was never safe, in that it was not able to check
whether the condition was side-effecting.  At this point, BUG_ON
should be well known, so it has probably outlived its usefuless.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Suggested-by: Matthew Wilcox <willy@infradead.org>

---

diff --git a/scripts/coccinelle/misc/bugon.cocci b/scripts/coccinelle/misc/bugon.cocci
deleted file mode 100644
index 8d595c358408..000000000000
--- a/scripts/coccinelle/misc/bugon.cocci
+++ /dev/null
@@ -1,63 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/// Use BUG_ON instead of a if condition followed by BUG.
-///
-//# This makes an effort to find cases where BUG() follows an if
-//# condition on an expression and replaces the if condition and BUG()
-//# with a BUG_ON having the conditional expression of the if statement
-//# as argument.
-//
-// Confidence: High
-// Copyright: (C) 2014 Himangi Saraogi.
-// Comments:
-// Options: --no-includes --include-headers
-
-virtual patch
-virtual context
-virtual org
-virtual report
-
-//----------------------------------------------------------
-//  For context mode
-//----------------------------------------------------------
-
-@depends on context@
-expression e;
-@@
-
-*if (e) BUG();
-
-//----------------------------------------------------------
-//  For patch mode
-//----------------------------------------------------------
-
-@depends on patch@
-expression e;
-@@
-
--if (e) BUG();
-+BUG_ON(e);
-
-//----------------------------------------------------------
-//  For org and report mode
-//----------------------------------------------------------
-
-@r depends on (org || report)@
-expression e;
-position p;
-@@
-
- if (e) BUG@p ();
-
-@script:python depends on org@
-p << r.p;
-@@
-
-coccilib.org.print_todo(p[0], "WARNING use BUG_ON")
-
-@script:python depends on report@
-p << r.p;
-@@
-
-msg="WARNING: Use BUG_ON instead of if condition followed by BUG.\nPlease make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)"
-coccilib.report.print_report(p[0], msg)
-
