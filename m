Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF9F41DC92
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351962AbhI3Onc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21403 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351223AbhI3On0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633012903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUT00SFFMSyhOoEnBK2kV8REPmBQWV8bxInejpzsCM8=;
        b=GOog1+z7lwhP92VVcAFQB9Z6IRoAGyHuWaE4Z3bJJVHMVN8Qjoh3tx6R+Sn4aTWecwKIEa
        rRJ4dJZnz+nQTL9YDAzjc7gXIyoZl+Mr4LwD5Sqb0770VYSXU6nD95SlhAu4qYKVYFmtH/
        Cm3z4k2QC588FFEL8cMRfFNvERwKSzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-smQ_FliiOb2-9HcSse2r-w-1; Thu, 30 Sep 2021 10:41:42 -0400
X-MC-Unique: smQ_FliiOb2-9HcSse2r-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5208F835DE0;
        Thu, 30 Sep 2021 14:41:41 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F8535F4E0;
        Thu, 30 Sep 2021 14:41:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 2/3] memory-hotplug.rst: fix wrong /sys/module/memory_hotplug/parameters/ path
Date:   Thu, 30 Sep 2021 16:41:16 +0200
Message-Id: <20210930144117.23641-3-david@redhat.com>
In-Reply-To: <20210930144117.23641-1-david@redhat.com>
References: <20210930144117.23641-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We accidentially added a superfluous "s".

Fixes: ac3332c44767 ("memory-hotplug.rst: complete admin-guide overhaul")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/memory-hotplug.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 27d748cb6ee0..ee00b70dedde 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -410,7 +410,7 @@ them with ``memory_hotplug.`` such as::
 
 and they can be observed (and some even modified at runtime) via::
 
-	/sys/modules/memory_hotplug/parameters/
+	/sys/module/memory_hotplug/parameters/
 
 The following module parameters are currently defined:
 
-- 
2.31.1

