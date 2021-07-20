Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD37D3CF85B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 12:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbhGTKIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 06:08:52 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:38177 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236868AbhGTKDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:03:53 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 20 Jul 2021 03:28:59 -0700
Received: from sc-dbc2166.eng.vmware.com (sc-dbc2166.eng.vmware.com [10.182.28.66])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 86F0C200DE;
        Tue, 20 Jul 2021 03:29:01 -0700 (PDT)
From:   Jorgen Hansen <jhansen@vmware.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <gregkh@linuxfoundation.org>, <pv-drivers@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH] MAINTAINERS: Update for VMCI driver
Date:   Tue, 20 Jul 2021 03:29:01 -0700
Message-ID: <1626776941-9163-1-git-send-email-jhansen@vmware.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: jhansen@vmware.com does not
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

