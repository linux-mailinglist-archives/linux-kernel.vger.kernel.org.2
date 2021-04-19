Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB5B364C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243151AbhDSUsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 16:48:37 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:13723
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238209AbhDSUpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:45:53 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AyxeUNqxKDhwB/4lm/b6yKrPw571zdoIgy1kn?=
 =?us-ascii?q?xilNYDZeG/b0q+mFmvMH2RjozAsLUHY7ltyafIWGS3XQ9Zl6iLNhXouKcQH6tA?=
 =?us-ascii?q?KTQ71KwpDlx1TbcBHW0s54+eNef7NlCNv2ZGIbse/f7BOjG9gthPmLmZrHuc7k?=
 =?us-ascii?q?w31gTR5nZshbhm9EIzyGGU57ThQuP/YEPaebj/AsmxOQPVAebsG2HRA+PtT+mw?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,235,1613430000"; 
   d="scan'208";a="379100915"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Apr 2021 22:45:20 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] Coccinelle: drop context *s
Date:   Mon, 19 Apr 2021 21:58:07 +0200
Message-Id: <20210419195807.2362029-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Context mode is not supported, so the *s are just confusing to people
who use the rule outside of make coccicheck.  So, drop the *s.

Fixes: 6dd9379e8f32 ("coccinelle: also catch kzfree() issues")
Reported-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 scripts/coccinelle/free/kfree.cocci |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/coccinelle/free/kfree.cocci b/scripts/coccinelle/free/kfree.cocci
index 168568386034..9b6e2037c2a9 100644
--- a/scripts/coccinelle/free/kfree.cocci
+++ b/scripts/coccinelle/free/kfree.cocci
@@ -22,9 +22,9 @@ position p1;
 @@
 
 (
-* kfree@p1(E)
+ kfree@p1(E)
 |
-* kfree_sensitive@p1(E)
+ kfree_sensitive@p1(E)
 )
 
 @print expression@
@@ -66,9 +66,9 @@ position ok;
 
 while (1) { ...
 (
-* kfree@ok(E)
+ kfree@ok(E)
 |
-* kfree_sensitive@ok(E)
+ kfree_sensitive@ok(E)
 )
   ... when != break;
       when != goto l;
@@ -84,9 +84,9 @@ position free.p1!=loop.ok,p2!={print.p,sz.p};
 @@
 
 (
-* kfree@p1(E,...)
+ kfree@p1(E,...)
 |
-* kfree_sensitive@p1(E,...)
+ kfree_sensitive@p1(E,...)
 )
 ...
 (

