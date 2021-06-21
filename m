Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B163C3AE1CF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 05:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFUDNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 23:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230272AbhFUDNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 23:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624245093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TUHwq3+l03GTyIDpnKgDIPCQG1MUSgfAyGc38vFf/1c=;
        b=K2bS2y0dg4Tuo4HNxrJvmx+nCTjgE27yGMiJWsTDZbz0P9CYWdn9IPVJabcfhoxAE/F9cB
        xEwKz45K+Ae/aiVoM8Bdpfmi7xlSNb4uEZNkNpuzGyH1IqtkhIOyRogxH/Hcxh5dUa0ZCn
        ivGErXoaijqxgZRKUMobsjZRC3ggF+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-xNm_0FnJOkW7oQ5MbfG4VQ-1; Sun, 20 Jun 2021 23:11:32 -0400
X-MC-Unique: xNm_0FnJOkW7oQ5MbfG4VQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5AB88015F8;
        Mon, 21 Jun 2021 03:11:30 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 333D860C9D;
        Mon, 21 Jun 2021 03:11:24 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        akpm@linux-foundation.org, david@redhat.com,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH 2/3] mm/page_reporting: Allow architecture to select reporting order
Date:   Mon, 21 Jun 2021 13:11:51 +0800
Message-Id: <20210621051152.305224-3-gshan@redhat.com>
In-Reply-To: <20210621051152.305224-1-gshan@redhat.com>
References: <20210621051152.305224-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This renames PAGE_REPORTING_MIN_ORDER to PAGE_REPORTING_ORDER, to
match with the variable name (@page_reporting_order). Its value is
stick to @pageblock_order if architecture doesn't specify it. This
is going to be used by arm64 when 64KB base page size is selected.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/page_reporting.c | 2 +-
 mm/page_reporting.h | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 759b29f6e845..d4d9f5265d6b 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -10,7 +10,7 @@
 #include "page_reporting.h"
 #include "internal.h"
 
-unsigned int page_reporting_order = PAGE_REPORTING_MIN_ORDER;
+unsigned int page_reporting_order = PAGE_REPORTING_ORDER;
 module_param(page_reporting_order, uint, 0644);
 MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
 
diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index 19d58a590cc2..91688dd30abe 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -10,9 +10,12 @@
 #include <linux/pgtable.h>
 #include <linux/scatterlist.h>
 
-#define PAGE_REPORTING_MIN_ORDER	pageblock_order
-
 #ifdef CONFIG_PAGE_REPORTING
+
+#ifndef PAGE_REPORTING_ORDER
+#define PAGE_REPORTING_ORDER pageblock_order
+#endif
+
 DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
 extern unsigned int page_reporting_order;
 void __page_reporting_notify(void);
-- 
2.23.0

