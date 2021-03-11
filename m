Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECE23379B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCKQlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:41:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229639AbhCKQl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615480886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3CN53jkduvdji2wLprSRs5qfdjtoV/DNponO/XVCBx8=;
        b=OfzT90KVye+bjYfEGxGY5aKvjjbPopQdl4l/vD8LStJAS429Nzz6Rqp8RBqMr8QdPLqMGY
        SI47iwN2A8X02kPk1CUskwYw4T1cj7xvtn5zvYfVABSPbKLmUzizVPMkl5R9iAdYpe5f/r
        FnxhyS2fislU/VkqqQ4MR166cn/Od7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-Z0J5a3g9PIaZia7QF3UnNg-1; Thu, 11 Mar 2021 11:41:24 -0500
X-MC-Unique: Z0J5a3g9PIaZia7QF3UnNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 141BA760C1;
        Thu, 11 Mar 2021 16:41:23 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEAA010013D6;
        Thu, 11 Mar 2021 16:41:21 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH 1/2] audit: document /proc/PID/loginuid
Date:   Thu, 11 Mar 2021 11:40:50 -0500
Message-Id: <df2ca2e9817140dd5c4ff97297b60700b96cb898.1615414262.git.rgb@redhat.com>
In-Reply-To: <cover.1615414262.git.rgb@redhat.com>
References: <cover.1615414262.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the /proc/PID/loginuid interface in Documentation/ABI/stable that
was added 2005-02-01 by commit 1e2d1492e178 ("[PATCH] audit: handle
loginuid through proc")

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 Documentation/ABI/stable/procfs-audit_loginuid | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/ABI/stable/procfs-audit_loginuid

diff --git a/Documentation/ABI/stable/procfs-audit_loginuid b/Documentation/ABI/stable/procfs-audit_loginuid
new file mode 100664
index 000000000000..fae63bef2970
--- /dev/null
+++ b/Documentation/ABI/stable/procfs-audit_loginuid
@@ -0,0 +1,15 @@
+What:		Audit Login UID
+Date:		2005-02-01
+KernelVersion:	2.6.11-rc2 1e2d1492e178 ("[PATCH] audit: handle loginuid through proc")
+Contact:	linux-audit@redhat.com
+Format:		u32
+Users:		auditd, libaudit, audit-testsuite, login
+Description:
+		The /proc/$pid/loginuid pseudofile is written to set and
+		read to get the audit login UID of process $pid.  If it is
+		unset, permissions are not needed to set it.  The accessor must
+		have CAP_AUDIT_CONTROL in the initial user namespace to write
+		it if it has been set.  It cannot be written again if
+		AUDIT_FEATURE_LOGINUID_IMMUTABLE is enabled.  It cannot be
+		unset if AUDIT_FEATURE_ONLY_UNSET_LOGINUID is enabled.
+
-- 
2.27.0

