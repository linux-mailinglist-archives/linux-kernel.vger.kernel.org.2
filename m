Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDCD349142
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhCYLyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhCYLxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616673229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OKm/yMe9JPqkg6bnMU/NOUh68uziwvUbg4w2huISSCU=;
        b=h61kaHWzfdsmi2kF2GBYKQhrA5VHzZ5OXfSsGi46qqBsGh41FfdCO/S9IHWcLpWhWGgQ5a
        tAuCka/kIonmE1j3CChKCATMaXPKmMvE8izWOD9048KFPXFWzVXy4jMUQDz2kOm1OQDAR/
        ZeQaREbLV6BaLxVbMWHOa23j7NVOw2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-q4xul75oP0-WnyZJqub_zw-1; Thu, 25 Mar 2021 07:53:45 -0400
X-MC-Unique: q4xul75oP0-WnyZJqub_zw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 067BE81620;
        Thu, 25 Mar 2021 11:53:42 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7007860855;
        Thu, 25 Mar 2021 11:53:27 +0000 (UTC)
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
Subject: [PATCH v2 0/3] kernel/resource: make walk_system_ram_res() and walk_mem_res() search the whole tree
Date:   Thu, 25 Mar 2021 12:53:23 +0100
Message-Id: <20210325115326.7826-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

v1 -> v2:
- Added fixes tags to patch #1 and #2
- Refined the patch descriptions
- Added acks/rbs

David Hildenbrand (3):
  kernel/resource: make walk_system_ram_res() find all busy
    IORESOURCE_SYSTEM_RAM resources
  kernel/resource: make walk_mem_res() find all busy IORESOURCE_MEM
    resources
  kernel/resource: remove first_lvl / siblings_only logic

 kernel/resource.c | 45 ++++++++++++---------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)


base-commit: 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b
-- 
2.29.2

