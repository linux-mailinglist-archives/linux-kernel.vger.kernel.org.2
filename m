Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C420351F5C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhDATLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234598AbhDATLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617304284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LSADTp/Fd90DKce/OenmcfdPFDDzrRnnS2F/ziWBzhk=;
        b=al3HdJoe5wz1VulmboHQoIzkWJyc0iEusFTI1aSjpZQdxXQJhcwoiq910VIpxzin9l9wTd
        +vOAQrync94ALEn88gpLCbBvkSkc/+iGQRZKyxTYB6F9Ob2IVCZU6IGsZhQ53hkwCb8PuM
        E/1VhMkyZJRyVFziNRdSevHldir2dVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-wkM34qpdPL6GMzHFJ4PoZQ-1; Thu, 01 Apr 2021 15:11:20 -0400
X-MC-Unique: wkM34qpdPL6GMzHFJ4PoZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A48C5501FE;
        Thu,  1 Apr 2021 19:11:19 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B65217BB6;
        Thu,  1 Apr 2021 19:11:07 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH] audit: drop /proc/PID/loginuid documentation Format field
Date:   Thu,  1 Apr 2021 15:10:27 -0400
Message-Id: <ea7f2e3b49b1cae523b58f128c8419c9b8565d9d.1617303032.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the "Format:" field from the /proc/PID/loginuid documentation and
integrate the information into the Description field since it is not
recognized by the "./scripts/get_abi.pl validate" command which causes a
warning.  Documentation/ABI/README describes the valid fields.

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 .../ABI/stable/procfs-audit_loginuid          | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/stable/procfs-audit_loginuid b/Documentation/ABI/stable/procfs-audit_loginuid
index 9d55a3ff4b34..cda405178391 100644
--- a/Documentation/ABI/stable/procfs-audit_loginuid
+++ b/Documentation/ABI/stable/procfs-audit_loginuid
@@ -2,26 +2,26 @@ What:		Audit Login UID
 Date:		2005-02-01
 KernelVersion:	2.6.11-rc2 1e2d1492e178 ("[PATCH] audit: handle loginuid through proc")
 Contact:	linux-audit@redhat.com
-Format:		%u
 Users:		audit and login applications
 Description:
 		The /proc/$pid/loginuid pseudofile is written to set and
-		read to get the audit login UID of process $pid.  If it is
-		unset, permissions are not needed to set it.  The accessor must
-		have CAP_AUDIT_CONTROL in the initial user namespace to write
-		it if it has been set.  It cannot be written again if
-		AUDIT_FEATURE_LOGINUID_IMMUTABLE is enabled.  It cannot be
-		unset if AUDIT_FEATURE_ONLY_UNSET_LOGINUID is enabled.
-
+		read to get the audit login UID of process $pid as a
+		decimal unsigned int (%u, u32).  If it is unset,
+		permissions are not needed to set it.  The accessor must
+		have CAP_AUDIT_CONTROL in the initial user namespace to
+		write it if it has been set.  It cannot be written again
+		if AUDIT_FEATURE_LOGINUID_IMMUTABLE is enabled.  It
+		cannot be unset if AUDIT_FEATURE_ONLY_UNSET_LOGINUID is
+		enabled.
 
 What:		Audit Login Session ID
 Date:		2008-03-13
 KernelVersion:	2.6.25-rc7 1e0bd7550ea9 ("[PATCH] export sessionid alongside the loginuid in procfs")
 Contact:	linux-audit@redhat.com
-Format:		%u
 Users:		audit and login applications
 Description:
 		The /proc/$pid/sessionid pseudofile is read to get the
-		audit login session ID of process $pid.  It is set
-		automatically, serially assigned with each new login.
+		audit login session ID of process $pid as a decimal
+		unsigned int (%u, u32).  It is set automatically,
+		serially assigned with each new login.
 
-- 
2.27.0

