Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8547236BA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbhDZTrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:47:09 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:22372 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241071AbhDZTrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:47:07 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AY/9ikKPgjrBfqsBcTkGjsMiAIKoaSvp033AC?=
 =?us-ascii?q?y112QwdEa9Hwra+Ttd4c0gL5jytUfXkml8yJNqXoewK6ybde544NMbC+GDT3oW?=
 =?us-ascii?q?fAFvAH0aLOyyDtchefysdzzqFlGpITNPTRChxAgd/+8E2EFb8bsby62YSJocub?=
 =?us-ascii?q?8Ht3VwFtbMhbnmVEIyKWCFd/SgUDJbdRLvuhz+xdqTKmeWcec8S8ARA+MdTrnN?=
 =?us-ascii?q?HAmJL4bRNuPXdO1CC0gTyl87L8GRSDty1ybxp03bwg/WLZ+jaT2oyftZiAoCP0?=
 =?us-ascii?q?63Xe9NB/ltfn17J4da+xtvQ=3D?=
X-IronPort-AV: E=Sophos;i="5.82,252,1613430000"; 
   d="scan'208";a="505149600"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Apr 2021 21:46:24 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] coccinelle: api: semantic patch to use pm_runtime_resume_and_get
Date:   Mon, 26 Apr 2021 20:54:04 +0200
Message-Id: <20210426185404.2466195-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync keeps a reference count on failure, which can lead
to leaks.  pm_runtime_resume_and_get drops the reference count in the
failure case.  This rule very conservatively follows the definition of
pm_runtime_resume_and_get to address the cases where the reference
count is unlikely to be needed in the failure case.

pm_runtime_resume_and_get was introduced in
commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
deal with usage counter")

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
v2: better keyword

 scripts/coccinelle/api/pm_runtime_resume_and_get.cocci |  153 +++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
new file mode 100644
index 000000000000..3387cb606f9b
--- /dev/null
+++ b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Use pm_runtime_resume_and_get.
+/// pm_runtime_get_sync keeps a reference count on failure,
+/// which can lead to leaks.  pm_runtime_resume_and_get
+/// drops the reference count in the failure case.
+/// This rule addresses the cases where the reference count
+/// is unlikely to be needed in the failure case.
+///
+// Confidence: High
+// Copyright: (C) 2021 Julia Lawall, Inria
+// URL: https://coccinelle.gitlabpages.inria.fr/website
+// Options: --include-headers --no-includes
+// Keywords: pm_runtime_get_sync
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@r0 depends on patch && !context && !org && !report@
+expression ret,e;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+-     if (ret < 0)
+-             pm_runtime_put_noidle(e);
+
+@r1 depends on patch && !context && !org && !report@
+expression ret,e;
+statement S1,S2;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+      if (ret < 0)
+-     {
+-             pm_runtime_put_noidle(e);
+	      S1
+-     }
+      else S2
+
+@r2 depends on patch && !context && !org && !report@
+expression ret,e;
+statement S;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+      if (ret < 0) {
+-             pm_runtime_put_noidle(e);
+	      ...
+      } else S
+
+@r3 depends on patch && !context && !org && !report@
+expression ret,e;
+identifier f;
+constant char[] c;
+statement S;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+      if (ret < 0)
+-     {
+              f(...,c,...);
+-             pm_runtime_put_noidle(e);
+-     }
+      else S
+
+@r4 depends on patch && !context && !org && !report@
+expression ret,e;
+identifier f;
+constant char[] c;
+statement S;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+      if (ret < 0) {
+              f(...,c,...);
+-             pm_runtime_put_noidle(e);
+	      ...
+      } else S
+
+// ----------------------------------------------------------------------------
+
+@r2_context depends on !patch && (context || org || report)@
+statement S;
+expression e, ret;
+position j0, j1;
+@@
+
+*     ret@j0 = pm_runtime_get_sync(e);
+      if (ret < 0) {
+*             pm_runtime_put_noidle@j1(e);
+	      ...
+      } else S
+
+@r3_context depends on !patch && (context || org || report)@
+identifier f;
+statement S;
+constant char []c;
+expression e, ret;
+position j0, j1;
+@@
+
+*     ret@j0 = pm_runtime_get_sync(e);
+      if (ret < 0) {
+              f(...,c,...);
+*             pm_runtime_put_noidle@j1(e);
+	      ...
+      } else S
+
+// ----------------------------------------------------------------------------
+
+@script:python r2_org depends on org@
+j0 << r2_context.j0;
+j1 << r2_context.j1;
+@@
+
+msg = "WARNING: opportunity for pm_runtime_get_sync"
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+@script:python r3_org depends on org@
+j0 << r3_context.j0;
+j1 << r3_context.j1;
+@@
+
+msg = "WARNING: opportunity for pm_runtime_get_sync"
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+// ----------------------------------------------------------------------------
+
+@script:python r2_report depends on report@
+j0 << r2_context.j0;
+j1 << r2_context.j1;
+@@
+
+msg = "WARNING: opportunity for pm_runtime_get_sync on line %s." % (j0[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+@script:python r3_report depends on report@
+j0 << r3_context.j0;
+j1 << r3_context.j1;
+@@
+
+msg = "WARNING: opportunity for pm_runtime_get_sync on %s." % (j0[0].line)
+coccilib.report.print_report(j0[0], msg)
+

