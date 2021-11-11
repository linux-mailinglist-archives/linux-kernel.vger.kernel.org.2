Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752D844D33A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhKKIep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:34:45 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:24413 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhKKIen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:34:43 -0500
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 11 Nov 2021 00:31:49 -0800
Received: from sc-dbc2135.eng.vmware.com (sc-dbc2135.eng.vmware.com [10.182.28.35])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id F11A42043B;
        Thu, 11 Nov 2021 00:31:54 -0800 (PST)
From:   Bryan Tan <bryantan@vmware.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <Pv-drivers@vmware.com>, <gregkh@linuxfoundation.org>,
        <vdasa@vmware.com>, Bryan Tan <bryantan@vmware.com>
Subject: [PATCH RESEND] MAINTAINERS: Update for VMware PVRDMA driver
Date:   Thu, 11 Nov 2021 00:31:43 -0800
Message-ID: <1636619503-45163-1-git-send-email-bryantan@vmware.com>
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

