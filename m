Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE095340E14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhCRTUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232838AbhCRTTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616095192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZFfjoGLVYxxsuuze31+XXPkXCGsDVEpi6PXPd3B7gBQ=;
        b=SltsuyOnrrrEEku3rzvYzunp28iUppyIJDaOpZH2ZiAnqOKfRLDFtTMOk0MN51cVRkXeLX
        /vmiVbCqPcBQv/EjyHGKGU1rT65d/IyE2F3ELuvgT2ryY75Yo3yBsTx1t4BHGg7ugKn7Vs
        V0q+d9KtA++ul9HeFlCkQXxiFe6qPJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-fS7HEYhuMpSMz-ApQDSdpg-1; Thu, 18 Mar 2021 15:19:51 -0400
X-MC-Unique: fS7HEYhuMpSMz-ApQDSdpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DADC5801817;
        Thu, 18 Mar 2021 19:19:49 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D9805C1D1;
        Thu, 18 Mar 2021 19:19:48 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v3 1/2] audit: document /proc/PID/loginuid
Date:   Thu, 18 Mar 2021 15:19:10 -0400
Message-Id: <14139c54992a4b50448fbbf07ebbfed743e09f3a.1616095045.git.rgb@redhat.com>
In-Reply-To: <cover.1616095045.git.rgb@redhat.com>
References: <cover.1616095045.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
new file mode 100644
index 000000000000..e7c100b9ab18
--- /dev/null
+++ b/Documentation/ABI/stable/procfs-audit_loginuid
@@ -0,0 +1,15 @@
+What:		Audit Login UID
+Date:		2005-02-01
+KernelVersion:	2.6.11-rc2 1e2d1492e178 ("[PATCH] audit: handle loginuid through proc")
+Contact:	linux-audit@redhat.com
+Format:		%u
+Users:		audit and login applications
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

