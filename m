Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DFC459C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 07:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhKWGdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 01:33:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229579AbhKWGdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 01:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637649044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=cii2kRzstpP0Wa5dFMjB3RasugaBI7WNxmALXxa/4dQ=;
        b=KdFtbUDzoixoPeR7OJ7IVmLt13DnRqgcBDtKadoEoTq9sagkaXV9KMbmcHd5JhNV2Po6UM
        ptWlX6F1P7USS7r4m+i4iJO1nwKghGI/CbqPEodkZkoAWmSP/cOW5SN+v3f7F5M0IKt5y0
        9UHh2RkC/zEoce++xKQOlYA+upLs7xo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-476-6bm2IOxlNsCS7_SeAclxdg-1; Tue, 23 Nov 2021 01:30:40 -0500
X-MC-Unique: 6bm2IOxlNsCS7_SeAclxdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF90D102CB29;
        Tue, 23 Nov 2021 06:30:39 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-248.pek2.redhat.com [10.72.12.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CBE9101E592;
        Tue, 23 Nov 2021 06:30:37 +0000 (UTC)
Date:   Tue, 23 Nov 2021 14:30:34 +0800
From:   Dave Young <dyoung@redhat.com>
To:     bhe@redhat.com, kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, vgoyal@redhat.com
Subject: [PATCH] MAINTAINERS: update kdump maintainers
Message-ID: <YZyKilzKFsWJYdgn@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove myself from kdump maintainers as I have no enough time to
maintain it now. But I can review patches on demand though.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-x86/MAINTAINERS
===================================================================
--- linux-x86.orig/MAINTAINERS
+++ linux-x86/MAINTAINERS
@@ -10122,9 +10122,9 @@ F:	lib/Kconfig.kcsan
 F:	scripts/Makefile.kcsan
 
 KDUMP
-M:	Dave Young <dyoung@redhat.com>
 M:	Baoquan He <bhe@redhat.com>
 R:	Vivek Goyal <vgoyal@redhat.com>
+R:	Dave Young <dyoung@redhat.com>
 L:	kexec@lists.infradead.org
 S:	Maintained
 W:	http://lse.sourceforge.net/kdump/

