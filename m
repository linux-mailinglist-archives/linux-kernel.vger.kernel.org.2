Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D0244F22F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 09:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbhKMIlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 03:41:24 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:40353 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhKMIlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 03:41:23 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1636792709;
        bh=oUFtQ64Cm+17GAUy1q4rYvKGNoMzMADVbvq6kqHCI3I=;
        h=From:To:Cc:Subject:Date:From;
        b=IVv6RVqZLUq1cdNfpOznglmn97XUhItFa/Mu1oo42XBzbALjHyi23d89q10snve0g
         WeAxMLbAclVWrMHA072X4griCtu+sxUFoiIkJRLbzGjy+/w4sNtIim4XqbM8ldDr1u
         pKdM0DyNsfxEbsoNzkKC6r9Poz3/JIk70OCmv7Qo=
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xen/privcmd: make option visible in Kconfig
Date:   Sat, 13 Nov 2021 09:38:21 +0100
Message-Id: <20211113083821.71060-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration option provides a misc device as an API to userspace.
Make this API usable without having to select the module as a transitive
dependency.

This also fixes an issue where localyesconfig would select
CONFIG_XEN_PRIVCMD=m because it was not visible and defaulted to
building as module.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

Note: If CONFIG_XEN_PRIVCMD really is only meant to be selected by
XENFS, then the issue can be fixed by removing its "default m"
definition.
---
 drivers/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index a1b11c62da9e..c14d8631b8f6 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -259,7 +259,7 @@ config XEN_SCSI_BACKEND
 	  if guests need generic access to SCSI devices.
 
 config XEN_PRIVCMD
-	tristate
+	tristate "Xen privileged domain-0 commands"
 	depends on XEN
 	default m
 

base-commit: 66f4beaa6c1d28161f534471484b2daa2de1dce0
-- 
2.33.1

