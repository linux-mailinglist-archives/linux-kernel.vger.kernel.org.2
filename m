Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A034340E15
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhCRTUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232842AbhCRTTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616095194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1YVGiXImUxO6HQP3BlOowu2qlSAjy9DBhcHqSg1igE=;
        b=T+VbLc6ilg0aKzy8YOJruRhpq4CMNmqGipT199UsdJOcUeptvtt/1sBYxnXnZOh3PZROP0
        Josacribz5v6Flmywu3CwqeH0fkuLw7Ochoee1Cxn5yDD75Uthwbzp8ifXjo/A8Tal+iP+
        6P6hoEOt6hkncjwxtW7x3tC7J61XtLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-P7ImUVHJMdKtqb0AJBSADg-1; Thu, 18 Mar 2021 15:19:53 -0400
X-MC-Unique: P7ImUVHJMdKtqb0AJBSADg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1086101371C;
        Thu, 18 Mar 2021 19:19:51 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40E1B5C1D1;
        Thu, 18 Mar 2021 19:19:50 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v3 2/2] audit: document /proc/PID/sessionid
Date:   Thu, 18 Mar 2021 15:19:11 -0400
Message-Id: <9543e42a75dd86bc0bed1f6cf735edc2169dc0b9.1616095045.git.rgb@redhat.com>
In-Reply-To: <cover.1616095045.git.rgb@redhat.com>
References: <cover.1616095045.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
index e7c100b9ab18..9d55a3ff4b34 100644
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
+Format:		%u
+Users:		audit and login applications
+Description:
+		The /proc/$pid/sessionid pseudofile is read to get the
+		audit login session ID of process $pid.  It is set
+		automatically, serially assigned with each new login.
+
-- 
2.27.0

