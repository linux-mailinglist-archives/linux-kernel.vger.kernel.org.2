Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070EA3379A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCKQlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:41:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhCKQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615480866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xJESAeQz6DGrY68rLLz3pZFEqvM4LGTvG2kOC7I61oY=;
        b=F4tJBFils0VlGN/YnnNoHAQyX2ftfWq5T6f6JXqSthBABHRyHnrBA8eJzyN9///PycaPKx
        vFOgGn4YUIpTYj8qInVj3LHFABqEAqDy9H465jPcYXDje7s/emCw8hH2QF19v7KVWbjee3
        X6Jz49tGBH/x8kpzKfSYHN3Y4KZ40sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-eue9AEpyPiCt64mFjMndpw-1; Thu, 11 Mar 2021 11:41:02 -0500
X-MC-Unique: eue9AEpyPiCt64mFjMndpw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED9048F9DD3;
        Thu, 11 Mar 2021 16:40:35 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C24910016FC;
        Thu, 11 Mar 2021 16:40:16 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH] MAINTAINERS: update audit files
Date:   Thu, 11 Mar 2021 11:39:52 -0500
Message-Id: <69f51dfe3ad24840ea1ef1f38cfe033f0fc62080.1615411783.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add files maintaned by the audit subsystem.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..a17532559665 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3015,9 +3015,13 @@ L:	linux-audit@redhat.com (moderated for non-subscribers)
 S:	Supported
 W:	https://github.com/linux-audit
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
+F:	arch/*/*/*audit*.[ch]
+F:	arch/x86/include/asm/audit.h
+F:	include/asm-generic/audit_*.h
 F:	include/linux/audit.h
 F:	include/uapi/linux/audit.h
 F:	kernel/audit*
+F:	lib/*audit.c
 
 AUXILIARY DISPLAY DRIVERS
 M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
-- 
2.27.0

