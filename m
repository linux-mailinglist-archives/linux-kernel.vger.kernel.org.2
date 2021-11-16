Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C73453C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 23:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhKPWkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 17:40:20 -0500
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:33691 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232034AbhKPWkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 17:40:19 -0500
Received: from [128.177.79.46] (helo=[10.118.101.22])
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1mn74q-000ITT-Gd; Tue, 16 Nov 2021 17:37:20 -0500
Subject: [PATCH v4 1/3] MAINTAINERS: Update maintainers for paravirt ops and
 VMware hypervisor interface
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     jgross@suse.com, x86@kernel.org, pv-drivers@vmware.com
Cc:     Alexey Makhalov <amakhalov@vmware.com>,
        Deep Shah <sdeep@vmware.com>, sdeep@vmware.com,
        vithampi@vmware.com, amakhalov@vmware.com, keerthanak@vmware.com,
        srivatsab@vmware.com, anishs@vmware.com,
        linux-kernel@vger.kernel.org, namit@vmware.com, joe@perches.com,
        kuba@kernel.org, rostedt@goodmis.org, srivatsa@csail.mit.edu
Date:   Tue, 16 Nov 2021 14:40:38 -0800
Message-ID: <163710242548.123451.17033714292638014317.stgit@csail.mit.edu>
In-Reply-To: <163710239472.123451.5004514369130059881.stgit@csail.mit.edu>
References: <163710239472.123451.5004514369130059881.stgit@csail.mit.edu>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

Deep has decided to transfer maintainership of the VMware hypervisor
interface to Srivatsa, and the joint-maintainership of paravirt ops in
the Linux kernel to Srivatsa and Alexey. Update the MAINTAINERS file
to reflect this change.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Acked-by: Alexey Makhalov <amakhalov@vmware.com>
Acked-by: Deep Shah <sdeep@vmware.com>
Acked-by: Juergen Gross <jgross@suse.com>
---

 MAINTAINERS |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..75a2c783ed6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14409,7 +14409,7 @@ F:	include/uapi/linux/ppdev.h
 
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
-M:	Deep Shah <sdeep@vmware.com>
+M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 L:	x86@kernel.org
@@ -20309,10 +20309,13 @@ S:	Maintained
 F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
-M:	Deep Shah <sdeep@vmware.com>
+M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
+M:	Alexey Makhalov <amakhalov@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
+L:	x86@kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vmware
 F:	arch/x86/include/asm/vmware.h
 F:	arch/x86/kernel/cpu/vmware.c
 


