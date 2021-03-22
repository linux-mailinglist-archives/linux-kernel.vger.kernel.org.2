Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2497A344A31
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhCVQDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230196AbhCVQCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616428964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OgSSnWKGscYsapR0+NLAGjTG3+Bg1qLlRc5vidLzwP0=;
        b=UCK7Wbu/+uf7J4JbXOfxMnHByiIvo4d8qscteGJNfMwNFe53jyZSBhtw+4snI03MIvkdTw
        L3NwIMgbDvkyERkj7ieEdwL0hGsC5VQ6vV6xZJt/+Rigs+OQZphWSG/meJKhNGkI0/Dmyg
        Y/A6Xop7otxqwZUy/jwfIMGaDOeeHtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-Sn3hzdKdM_-yFzw8dtSnqg-1; Mon, 22 Mar 2021 12:02:39 -0400
X-MC-Unique: Sn3hzdKdM_-yFzw8dtSnqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1327107B768;
        Mon, 22 Mar 2021 16:02:36 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 832E15946C;
        Mon, 22 Mar 2021 16:02:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
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
Subject: [PATCH v1 2/3] kernel/resource: make walk_mem_res() find all busy IORESOURCE_MEM resources
Date:   Mon, 22 Mar 2021 17:01:59 +0100
Message-Id: <20210322160200.19633-3-david@redhat.com>
In-Reply-To: <20210322160200.19633-1-david@redhat.com>
References: <20210322160200.19633-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It used to be true that we can have system RAM only on the first level
in the resourc tree. However, this is no longer holds for driver-managed
system RAM (i.e., dax/kmem and virtio-mem).

The function walk_mem_res() only consideres the first level and is
used in arch/x86/mm/ioremap.c:__ioremap_check_mem() only. We currently
fail to identify System RAM added by dax/kmem and virtio-mem as
"IORES_MAP_SYSTEM_RAM", for example, allowing for remapping of such
"normal RAM" in __ioremap_caller().

Let's find all busy IORESOURCE_MEM resources, making the function
behave similar to walk_system_ram_res().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Signed-off-by: David Hildenbrand <david@redhat.com>
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

