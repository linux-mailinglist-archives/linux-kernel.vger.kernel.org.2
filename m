Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4742F349149
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhCYLyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230314AbhCYLyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616673249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUg3LOIHqlA0uZkNm8pmFDkZJ78hOTVD78c+I46/47o=;
        b=Yn4B2AbYpdrsMHt8YvRHRP185vJcfgxyF40PGKxLTgh9Jy4Jdsaxm6aLc6IXTBobuCL2/8
        lu4d+ciybAZ+uzcBeZtQeWrnqegUTXQmLgIHVmWr18VNQThZC+ICfhK+nuyPBU3cFKQWQo
        zILEP9KfNDcMJWf5MVlhO4AOjqrGniM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-lR1Getd6NJi92oihRu_TgQ-1; Thu, 25 Mar 2021 07:54:07 -0400
X-MC-Unique: lR1Getd6NJi92oihRu_TgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E4C91084D6D;
        Thu, 25 Mar 2021 11:54:04 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FE4F60938;
        Thu, 25 Mar 2021 11:53:50 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Oscar Salvador <osalvador@suse.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH v2 2/3] kernel/resource: make walk_mem_res() find all busy IORESOURCE_MEM resources
Date:   Thu, 25 Mar 2021 12:53:25 +0100
Message-Id: <20210325115326.7826-3-david@redhat.com>
In-Reply-To: <20210325115326.7826-1-david@redhat.com>
References: <20210325115326.7826-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It used to be true that we can have system RAM (IORESOURCE_SYSTEM_RAM |
IORESOURCE_BUSY) only on the first level in the resource tree. However,
this is no longer holds for driver-managed system RAM (i.e., added via
dax/kmem and virtio-mem), which gets added on lower levels, for example,
inside device containers.

IORESOURCE_SYSTEM_RAM is defined as IORESOURCE_MEM | IORESOURCE_SYSRAM
and just a special type of IORESOURCE_MEM.

The function walk_mem_res() only consideres the first level and is
used in arch/x86/mm/ioremap.c:__ioremap_check_mem() only. We currently
fail to identify System RAM added by dax/kmem and virtio-mem as
"IORES_MAP_SYSTEM_RAM", for example, allowing for remapping of such
"normal RAM" in __ioremap_caller().

Let's find all IORESOURCE_MEM | IORESOURCE_BUSY resources, making the
function behave similar to walk_system_ram_res().

Fixes: ebf71552bb0e ("virtio-mem: Add parent resource for all added "System RAM"")
Fixes: c221c0b0308f ("device-dax: "Hotplug" persistent memory for use like normal RAM")
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: x86@kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 4efd6e912279..16e0c7e8ed24 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -470,7 +470,7 @@ int walk_mem_res(u64 start, u64 end, void *arg,
 {
 	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 
-	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, true,
+	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, false,
 				     arg, func);
 }
 
-- 
2.29.2

