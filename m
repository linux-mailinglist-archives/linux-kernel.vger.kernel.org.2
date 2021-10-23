Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD5E43843A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 18:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhJWQDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 12:03:43 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:62242 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229901AbhJWQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 12:03:39 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AzIMypaDLAM1XahVW/+fhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fAFbrgWt212EExjQdDWCFM/iKYmL1f95zPoS39RsC6JaAx9UxeLYW3SE0HigS8?=
 =?us-ascii?q?aIpJvzAcxyuZ3vKRiH7ofMOA/w2MrEsF+hpCC+DzvuRGuK59yAljfvTHuCU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+6UzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8tA9+?=
 =?us-ascii?q?/k7v9GqEIau6Pe1bezCMMAu773UMqSi8ai87XMNIedENWgnONls94zNFltJqqS?=
 =?us-ascii?q?A5vMLekdOE1CkMHTn0hVUFB0PqdSZSliuSRyEDua3b2yPVjFwc9Oohw0u1wCmp?=
 =?us-ascii?q?P3ecJLSgEKBGFneO/hryhIsFoh8I+PIzoMZkZt3VI0z7UF7AlTIrFTqGM4sVXt?=
 =?us-ascii?q?ArcLOgm8e32PpVCL2M1NVKeM1sfZxENBYx4h+mywH/yb1VlRJuujfJfywDuIMZ?=
 =?us-ascii?q?ZidAB6OboR+E=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATJQFKKjwVy2/2hEGfoMgt/eb3HBQXscji2hC?=
 =?us-ascii?q?6mlwRA09TyXPra6TdZMgtSMc5wxhOk3I8+rrBEDtewK4yXcX2+gs1MmZLWrbUQ?=
 =?us-ascii?q?KTRekIgLcKqAeOJ8SRzIJg6Zs=3D?=
X-IronPort-AV: E=Sophos;i="5.87,175,1631570400"; 
   d="scan'208";a="127547"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2021 18:01:19 +0200
Date:   Sat, 23 Oct 2021 18:01:18 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     cocci@inria.fr, linux-kernel@vger.kernel.org
Subject: update Coccinelle entry
Message-ID: <alpine.DEB.2.22.394.2110231758550.2967@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update mailing list and website.  Drop Michal Marek as a maintainer, who
has not participated in a long time.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---

For information.  This will be in my tree.

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d46f03e5037..8746149b6623 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4594,10 +4594,9 @@ COCCINELLE/Semantic Patches (SmPL)
 M:	Julia Lawall <Julia.Lawall@inria.fr>
 M:	Gilles Muller <Gilles.Muller@inria.fr>
 M:	Nicolas Palix <nicolas.palix@imag.fr>
-M:	Michal Marek <michal.lkml@markovi.net>
-L:	cocci@systeme.lip6.fr (moderated for non-subscribers)
+L:	cocci@inria.fr (moderated for non-subscribers)
 S:	Supported
-W:	http://coccinelle.lip6.fr/
+W:	https://coccinelle.gitlabpages.inria.fr/website/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild.git misc
 F:	Documentation/dev-tools/coccinelle.rst
 F:	scripts/coccicheck
