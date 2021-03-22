Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B583344A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhCVQCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230293AbhCVQCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616428944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W0IDIfX6AJuXdpUONxZchTMRUur8djK38Sbs7ocWmH4=;
        b=EA/xubv4Abk7uDEXB7xrmHgLVH3WtnVQt6U9j0qOxeF/kyGEIsJf3N/sNBzz04AD9zs/9Q
        ukqAdaj6QHf1naaPf/Qg2NFpr3aWTpLnb3DYZ8i71dYW3mlUTOxfTh0ScvuDKqyoALmrdO
        /VI+gr8sgGheRo+kBGElr7An7duQ/5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-voatCJxPPuOKF6jAy4Xecw-1; Mon, 22 Mar 2021 12:02:20 -0400
X-MC-Unique: voatCJxPPuOKF6jAy4Xecw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6725C81746C;
        Mon, 22 Mar 2021 16:02:16 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E5752C15A;
        Mon, 22 Mar 2021 16:02:01 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v1 0/3] kernel/resource: make walk_system_ram_res() and walk_mem_res() search the whole tree
Date:   Mon, 22 Mar 2021 17:01:57 +0100
Message-Id: <20210322160200.19633-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Playing with kdump+virtio-mem I noticed that kexec_file_load() does not
consider System RAM added via dax/kmem and virtio-mem when preparing the
elf header for kdump. Looking into the details, the logic used in
walk_system_ram_res() and walk_mem_res() seems to be outdated.

walk_system_ram_range() already does the right thing, let's change
walk_system_ram_res() and walk_mem_res(), and clean up.

Loading a kdump kernel via "kexec -p -s" ... will result in the kdump
kernel to also dump dax/kmem and virtio-mem added System RAM now.

Note: kexec-tools on x86-64 also have to be updated to consider this
memory in the kexec_load() case when processing /proc/iomem.

Against next-20210322.

David Hildenbrand (3):
  kernel/resource: make walk_system_ram_res() find all busy
    IORESOURCE_SYSTEM_RAM resources
  kernel/resource: make walk_mem_res() find all busy IORESOURCE_MEM
    resources
  kernel/resource: remove first_lvl / siblings_only logic

 kernel/resource.c | 45 ++++++++++++---------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

-- 
2.29.2

