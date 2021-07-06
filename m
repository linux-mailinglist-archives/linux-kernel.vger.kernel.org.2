Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCFB3BD872
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhGFOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232480AbhGFOlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCrvxPw+Nwpkc0pV2h5Y7IKrcS+5F+fO/S3TOjQ55Y4=;
        b=iTTK3Gp+U1FIzJLmgUapxze5PZxInfNm0Uoj/6H8bb5spbuCGKq33dYhWqJe3MhEduWbSC
        FuWncOZUoCivispLltG85RVL/uYcR6mTs+Fqo2dyrtFY7ophYRzZAiaAhjs+5I8XG39ipN
        3MZTnCWuo1iLGxV7WshvocqRn+2E4Q0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-Mpkjz_9_OHC-0_DzkcOtrA-1; Tue, 06 Jul 2021 10:26:44 -0400
X-MC-Unique: Mpkjz_9_OHC-0_DzkcOtrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9ED90800C78;
        Tue,  6 Jul 2021 14:26:42 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-113-20.ams2.redhat.com [10.36.113.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 311F869CB8;
        Tue,  6 Jul 2021 14:26:41 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH 1/2] tools: Remove lockdep.h and its include from spinlock.h
Date:   Tue,  6 Jul 2021 16:26:31 +0200
Message-Id: <20210706142632.670483-2-eperezma@redhat.com>
In-Reply-To: <20210706142632.670483-1-eperezma@redhat.com>
References: <20210706142632.670483-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 58d6ea3085f2 ("xarray: Add XArray unconditional store
operations") adds this file at the same time that xarray and xarray
tests. However, xarray tests and other tools/ works with no problem
without this file.

The motivation for the deletion is that vhost tests/tools need to use
spinlock.h mock file, but at the moment it includes lockdep.h that is
only available under tools/testing/radix-tree.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 tools/include/linux/spinlock.h           |  2 --
 tools/testing/radix-tree/linux/lockdep.h | 11 -----------
 2 files changed, 13 deletions(-)
 delete mode 100644 tools/testing/radix-tree/linux/lockdep.h

diff --git a/tools/include/linux/spinlock.h b/tools/include/linux/spinlock.h
index c934572d935c..622266b197d0 100644
--- a/tools/include/linux/spinlock.h
+++ b/tools/include/linux/spinlock.h
@@ -37,6 +37,4 @@ static inline bool arch_spin_is_locked(arch_spinlock_t *mutex)
 	return true;
 }
 
-#include <linux/lockdep.h>
-
 #endif
diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/radix-tree/linux/lockdep.h
deleted file mode 100644
index 565fccdfe6e9..000000000000
--- a/tools/testing/radix-tree/linux/lockdep.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef _LINUX_LOCKDEP_H
-#define _LINUX_LOCKDEP_H
-struct lock_class_key {
-	unsigned int a;
-};
-
-static inline void lockdep_set_class(spinlock_t *lock,
-					struct lock_class_key *key)
-{
-}
-#endif /* _LINUX_LOCKDEP_H */
-- 
2.27.0

