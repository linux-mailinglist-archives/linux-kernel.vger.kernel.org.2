Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38CE33FCDF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 02:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhCRBvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 21:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230020AbhCRBvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 21:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616032294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tzh8iVERozBJ4vax/U6WoN6ULQ6gPPm1xDKqOUTjwP4=;
        b=enMLzZyiYPbRlBjKGjmkwu3oeIyL0sElVHK23Aqa2Zplg9Ui9kc0lhEDipDuGE/k/i5LDJ
        KbFf/xbTEJLNVSXa04WJmViZT4W5lcXc2IoVL5dM8n+jVysdTcauK7PdH9evaZWbSJkwLb
        PUl8MhU5U78TSw1IYBAtPHXCBV+qeGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-laBHNe3EMc6zNw5oNYK9Gw-1; Wed, 17 Mar 2021 21:51:31 -0400
X-MC-Unique: laBHNe3EMc6zNw5oNYK9Gw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F52A108BC7B;
        Thu, 18 Mar 2021 01:51:20 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5234650332;
        Thu, 18 Mar 2021 01:51:18 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v2 2/2] audit: document /proc/PID/sessionid
Date:   Wed, 17 Mar 2021 21:50:50 -0400
Message-Id: <0e77d290bb50232d9ec9317645106f1330bd2d54.1616008065.git.rgb@redhat.com>
In-Reply-To: <cover.1616008065.git.rgb@redhat.com>
References: <cover.1616008065.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index 013bc1d74854..5d09637a4ae2 100644
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
+Format:		%u (u32)
+Users:		auditd, libaudit, audit-testsuite, login
+Description:
+		The /proc/$pid/sessionid pseudofile is read to get the
+		audit login session ID of process $pid.  It is set
+		automatically, serially assigned with each new login.
+
-- 
2.27.0

