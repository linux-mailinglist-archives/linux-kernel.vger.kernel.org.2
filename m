Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305F23379B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhCKQl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhCKQla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615480889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsITyOiHG8sZT6fImLghXS0y6X8Glr5m582sfHNQHmU=;
        b=KM6dQD5gWRn3HVKLf7FsnwQ0MsnaTwAWhaAFep03RQIkcU6J6O4cq07k/9K6PGtNz3WXJE
        dzptw5pQZMMNzbh8bF/T4z9qpJKlddXKXs12Y8oY4m6jy4/LQQiylphDlJtBTEOgnszdZt
        Ix2qk6MFfBFpbYjoRbN31Y/6ifA9xxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-aNlLOjZjOIanJlsdFfNpQw-1; Thu, 11 Mar 2021 11:41:26 -0500
X-MC-Unique: aNlLOjZjOIanJlsdFfNpQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B519E800D55;
        Thu, 11 Mar 2021 16:41:24 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A39F10013D6;
        Thu, 11 Mar 2021 16:41:23 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH 2/2] audit: document /proc/PID/sessionid
Date:   Thu, 11 Mar 2021 11:40:51 -0500
Message-Id: <b8a16198e196bf8acc07f8c6701d9870d72f967c.1615414262.git.rgb@redhat.com>
In-Reply-To: <cover.1615414262.git.rgb@redhat.com>
References: <cover.1615414262.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the /proc/PID/loginuid interface in Documentation/ABI/stable that
was added 2008-03-13 in commit 1e0bd7550ea9 ("[PATCH] export sessionid
alongside the loginuid in procfs")

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 Documentation/ABI/stable/procfs-audit_loginuid | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/stable/procfs-audit_loginuid b/Documentation/ABI/stable/procfs-audit_loginuid
index fae63bef2970..175ee6ec3695 100644
--- a/Documentation/ABI/stable/procfs-audit_loginuid
+++ b/Documentation/ABI/stable/procfs-audit_loginuid
@@ -13,3 +13,15 @@ Description:
 		AUDIT_FEATURE_LOGINUID_IMMUTABLE is enabled.  It cannot be
 		unset if AUDIT_FEATURE_ONLY_UNSET_LOGINUID is enabled.
 
+
+What:		Audit Login Session ID
+Date:		2008-03-13
+KernelVersion:	2.6.25-rc7 1e0bd7550ea9 ("[PATCH] export sessionid alongside the loginuid in procfs")
+Contact:	linux-audit@redhat.com
+Format:		u32
+Users:		auditd, libaudit, audit-testsuite, login
+Description:
+		The /proc/$pid/sessionid pseudofile is read to get the
+		audit login session ID of process $pid.  It is set
+		automatically, serially assigned with each new login.
+
-- 
2.27.0

