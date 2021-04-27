Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3136C86E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbhD0PN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:13:26 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:31896
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235466AbhD0PNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:13:24 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AeBYrFK+ZqKpHeebpqA9uk+GUdb1zdoIgy1kn?=
 =?us-ascii?q?xilNYDZSddGVkN3rge8S0gX6hC1UVHYrn92BP6foewKhybde544NMbC+GBT3oW?=
 =?us-ascii?q?fAFvAe0aLO4R3FXwL/8/NQzs5bHZRWJf/RKRxBjcj86BSlCNpI+ri62Y2hmOu2?=
 =?us-ascii?q?9QYXcShGa7t46R14FwacFQlQQhRHCpoyHIed4M0CmjzIQwVvUu2VHX8ANtKzwO?=
 =?us-ascii?q?HjsJ79exYJC1oG5WC1/FaVwZr7FxTd4RsESTNIxt4ZgAz4ujf07KmirP23oyW0?=
 =?us-ascii?q?vwS4gvg46biRqOdrPtCGicQeN1zX+36VTblmMofy2gwdkaWF7kosmtWJngwpNc?=
 =?us-ascii?q?Zy7H2UXma7p3LWqnPd+Qdr1H/41UXdu3Hqpsv0SVsBa/Z8uQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,254,1613430000"; 
   d="scan'208";a="379825595"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Apr 2021 17:12:39 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4] coccinelle: api: semantic patch to use pm_runtime_resume_and_get
Date:   Tue, 27 Apr 2021 16:19:45 +0200
Message-Id: <20210427141946.2478411-1-Julia.Lawall@inria.fr>
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
count is unlikely to be needed in the failure case.  Specifically, the
change is only done when pm_runtime_get_sync is followed immediately
by an if and when the branch of the if is immediately a call to
pm_runtime_put_noidle (like in the definition of
pm_runtime_resume_and_get) or something that is likely a print
statement followed by a pm_runtime_put_noidle call.  The patch
case appears somewhat more complicated, because it also deals with the
cases where {}s need to be removed.

pm_runtime_resume_and_get was introduced in
commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
deal with usage counter")

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
v4: s/pm_runtime_resume_and_get/pm_runtime_put_noidle/ as noted by John Hovold
v3: add the people who signed off on commit dd8088d5a896, expand the log message
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

