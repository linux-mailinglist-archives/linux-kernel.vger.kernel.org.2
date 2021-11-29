Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3CC460DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 04:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352759AbhK2Dur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 22:50:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376850AbhK2Dsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 22:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638157528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8p56QpohrBGhOjuC6AEkfeOKtDYYUZyNF+bODc3oeOY=;
        b=NB+uXAKyOkszSY2bBiqfC0O1Ke8ewEPFLXsV+scgqZs8aHZSFDLNAJKxKofEYEr/5VxAsT
        eJMFMQDMqgX6PuG8Xc9rb2XlPoXwjHcxwPiIMMqp0meqrASPX5fsjtsQyIsSMCWfcAdZyJ
        n9wAAtxvbQ0WOpWS5ae/ag0Z5GWG3CI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-QHAXEoEhPnygZBLZOa5-Sg-1; Sun, 28 Nov 2021 22:45:26 -0500
X-MC-Unique: QHAXEoEhPnygZBLZOa5-Sg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51AC383DD20;
        Mon, 29 Nov 2021 03:45:25 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1592F60BF1;
        Mon, 29 Nov 2021 03:45:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/2] kobject: don't delay to cleanup module kobject
Date:   Mon, 29 Nov 2021 11:45:08 +0800
Message-Id: <20211129034509.2646872-2-ming.lei@redhat.com>
In-Reply-To: <20211129034509.2646872-1-ming.lei@redhat.com>
References: <20211129034509.2646872-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_KOBJECT_RELEASE is used for debugging kobject release and
cleanup issue. The module kobject is released after module_exit() returns.
If this kobject is delayed too much, and may cause other kobjects cleaned
up a bit earlier before freeing module, then real issue is hidden.

So don't delay module kobject's cleanup, meantime module kobject is
always cleaned up synchronously, and CONFIG_DEBUG_KOBJECT_RELEASE is
actually needless for module kobject.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/kobject.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index 4a56f519139d..b81319b0bd5a 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -16,6 +16,7 @@
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/module.h>
 
 /**
  * kobject_namespace() - Return @kobj's namespace tag.
@@ -727,6 +728,19 @@ static void kobject_release(struct kref *kref)
 	struct kobject *kobj = container_of(kref, struct kobject, kref);
 #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
 	unsigned long delay = HZ + HZ * (get_random_int() & 0x3);
+
+	/*
+	 * Don't delay to release module kobject so that we can detect late
+	 * kobject release more effectively because module unloading waits
+	 * for completion of module kobject release, see mod_kobject_put.
+	 *
+	 * Meantime mod_kobject_put() always waits for completion of module
+	 * kobject's release, CONFIG_DEBUG_KOBJECT_RELEASE is basically
+	 * useless for debugging module kobject's release.
+	 */
+	if (kobj->ktype == &module_ktype)
+		delay = 0;
+
 	pr_info("kobject: '%s' (%p): %s, parent %p (delayed %ld)\n",
 		 kobject_name(kobj), kobj, __func__, kobj->parent, delay);
 	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
-- 
2.31.1

