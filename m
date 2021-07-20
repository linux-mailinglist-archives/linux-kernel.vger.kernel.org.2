Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF93CF84A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 12:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbhGTKGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 06:06:08 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:19279 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237434AbhGTKAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:00:23 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jul 2021 06:00:23 EDT
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 20 Jul 2021 03:25:25 -0700
Received: from sc-dbc2166.eng.vmware.com (sc-dbc2166.eng.vmware.com [10.182.28.66])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 3EE6120293;
        Tue, 20 Jul 2021 03:25:27 -0700 (PDT)
From:   Jorgen Hansen <jhansen@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH] MAINTAINERS: Update for VMCI driver
Date:   Tue, 20 Jul 2021 03:25:27 -0700
Message-ID: <1626776727-8180-1-git-send-email-jhansen@vmware.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: jhansen@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer info for the VMware VMCI driver.

Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a61f4f3..7e7c6fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19792,6 +19792,14 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/ptp/ptp_vmw.c
 
+VMWARE VMCI DRIVER
+M:	Jorgen Hansen <jhansen@vmware.com>
+M:	Vishnu Dasa <vdasa@vmware.com>
+M:	"VMware, Inc." <pv-drivers@vmware.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/misc/vmw_vmci/
+
 VMWARE VMMOUSE SUBDRIVER
 M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
-- 
2.6.2

