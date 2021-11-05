Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA6C445FC7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 07:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhKEGlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 02:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42048 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231142AbhKEGlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 02:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636094307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vr5d1d5dKmCiHsZxguaRfIn40DOa1ayX2bZMqY41cjg=;
        b=ZPAnXymCRvxecN9TH3MCTI79rNiKRPTLMz1RZktywV4MyV9hNdbc37ge4taBYgKO6jRuUA
        6W0Q9p/VazJF08FVgLNxjJZhCuzkrbmuNOTC8OeOWwboJgkUDuINM0sk8kJejtprhzVbUR
        heGiiJAEWK2hKKOJpjGYiYt4hjrx180=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-9InuQrQlM0mVGQFJzOWd5g-1; Fri, 05 Nov 2021 02:38:22 -0400
X-MC-Unique: 9InuQrQlM0mVGQFJzOWd5g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECC771006AAD;
        Fri,  5 Nov 2021 06:38:20 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28C53100E12D;
        Fri,  5 Nov 2021 06:38:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] kobject: don't delay to cleanup module kobject
Date:   Fri,  5 Nov 2021 14:37:09 +0800
Message-Id: <20211105063710.4092936-2-ming.lei@redhat.com>
In-Reply-To: <20211105063710.4092936-1-ming.lei@redhat.com>
References: <20211105063710.4092936-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_KOBJECT_RELEASE is used for debugging kobject release/cleanup
issue. The module kobject is released after module_exit() returns. If
this kobject is delayed too much, and may cause other kobject's
cleaned up a bit earlier before freeing module, then real issue is
hidden.

So don't delay module kobject's cleanup, meantime module kobject is
always cleaned up synchronously, and we needn't module kobject's
cleanup.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/kobject.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index ea53b30cf483..4c0dbe11be3d 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -16,6 +16,7 @@
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/module.h>
 
 /**
  * kobject_namespace() - Return @kobj's namespace tag.
@@ -727,6 +728,10 @@ static void kobject_release(struct kref *kref)
 	struct kobject *kobj = container_of(kref, struct kobject, kref);
 #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
 	unsigned long delay = HZ + HZ * (get_random_int() & 0x3);
+
+	if (kobj->ktype == &module_ktype)
+		delay = 0;
+
 	pr_info("kobject: '%s' (%p): %s, parent %p (delayed %ld)\n",
 		 kobject_name(kobj), kobj, __func__, kobj->parent, delay);
 	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
-- 
2.31.1

