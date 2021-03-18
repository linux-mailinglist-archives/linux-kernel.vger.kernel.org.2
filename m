Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C5733FCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 02:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhCRBuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 21:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230484AbhCRBto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 21:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616032184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ONLmJAW9Rh0WKtlY0Inezc9QcGi9/m/+UrMbYHkTOv0=;
        b=PqBGYxQpGy7OOmqVd6iKIeD0rfwcXJnlN723y62XFfgthc9zoWugdSlJk9koQx2Vge8UnJ
        quJFq4R0WpELyQ81+zRUEL9yzUMNgmvxEf/LQF8Z3ZQVkDkvbl7ndhIZ9DlLopqTVRq1n9
        Wqu4BU8F6uk+L3fac5Q4sXIt6jCd6/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-Pxcjs03SPu2GfyWTatAX0A-1; Wed, 17 Mar 2021 21:49:38 -0400
X-MC-Unique: Pxcjs03SPu2GfyWTatAX0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFCCB1084D68;
        Thu, 18 Mar 2021 01:49:36 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 289386F991;
        Thu, 18 Mar 2021 01:49:26 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v2] MAINTAINERS: update audit files
Date:   Wed, 17 Mar 2021 21:48:59 -0400
Message-Id: <0a26adc249e782ad9de04e047af7c2f65c2bc7c7.1615946851.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add files maintaned by the audit subsystem.

Files from arch/*/*/*audit*.[ch] and arch/x86/include/asm/audit.h were not
added due to concern of the list not holding up over time.  There exist
already exceptions that caused the need for this specificity.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..1249655459d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2979,9 +2979,11 @@ L:	linux-audit@redhat.com (moderated for non-subscribers)
 S:	Supported
 W:	https://github.com/linux-audit
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
+F:	include/asm-generic/audit_*.h
 F:	include/linux/audit.h
 F:	include/uapi/linux/audit.h
 F:	kernel/audit*
+F:	lib/*audit.c
 
 AUXILIARY DISPLAY DRIVERS
 M:	Miguel Ojeda <ojeda@kernel.org>
-- 
2.27.0

