Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0139A42BA04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhJMIR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:17:56 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:50654 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231559AbhJMIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:17:46 -0400
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Oct 2021 04:17:46 EDT
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 13 Oct 2021 01:00:27 -0700
Received: from sc-dbc2135.eng.vmware.com (sc-dbc2135.eng.vmware.com [10.182.28.35])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 14EB2202A3;
        Wed, 13 Oct 2021 01:00:30 -0700 (PDT)
From:   Bryan Tan <bryantan@vmware.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <Pv-drivers@vmware.com>, <gregkh@linuxfoundation.org>,
        <aditr@vmware.com>, <vdasa@vmware.com>,
        Bryan Tan <bryantan@vmware.com>
Subject: [PATCH] MAINTAINERS: Update for VMware PVRDMA driver
Date:   Wed, 13 Oct 2021 00:59:36 -0700
Message-ID: <1634111976-21283-1-git-send-email-bryantan@vmware.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: bryantan@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update maintainer info for the VMware PVRDMA driver.

Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Bryan Tan <bryantan@vmware.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index abdcbcfef73d..b3b5b8b0e207 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20022,7 +20022,8 @@ F:	arch/x86/include/asm/vmware.h
 F:	arch/x86/kernel/cpu/vmware.c
 
 VMWARE PVRDMA DRIVER
-M:	Adit Ranadive <aditr@vmware.com>
+M:	Bryan Tan <bryantan@vmware.com>
+M:	Vishnu Dasa <vdasa@vmware.com>
 M:	VMware PV-Drivers <pv-drivers@vmware.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
-- 
2.14.1

