Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D73BE394
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhGGHfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230312AbhGGHe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625643138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nUiesUcA0XvjRpX84M1tcKVMHGxkRN9jKPnpDjfpfoY=;
        b=Fh2UI1EEzIk3YSX6dQrynsx1dsU/j6t+b1L8JRoZgP9M+kZU7vBvdmr7NWt5i2haeKKBmX
        uxtJtwKnG/bouTwtvkZhty+oyOWCxiwrabLuSsCgukcuBTDt76sCJ20KgClfgNNn9eneVw
        ITfl5lexa6Fb8Q4Om98xjMinqQ4OhFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-FK33FKdXOQG7z7vaQrtkHg-1; Wed, 07 Jul 2021 03:32:17 -0400
X-MC-Unique: FK33FKdXOQG7z7vaQrtkHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB2D7801107;
        Wed,  7 Jul 2021 07:32:14 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-110.ams2.redhat.com [10.36.114.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38D4C60CC9;
        Wed,  7 Jul 2021 07:32:05 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH resend v3 0/2] memory-hotplug.rst: complete admin-guide overhaul
Date:   Wed,  7 Jul 2021 09:32:03 +0200
Message-Id: <20210707073205.3835-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v3 of the memory hot(un)plug admin-guide overhaul, rebased to
current mainline -- it's a simple resend, because all prereq patches are
now upstream.

v2 -> v3:
- Added ACKs and RBs (thanks!)
- s/aarch64/arm64/
- Refine error handling when onlining/offlining
- s/memory hotplug/memory offlining/ in the vmemmap optimization section
  for huge pages

v1 -> v2:
- Added "memory-hotplug.rst: remove locking details from admin-guide"
- Incorporated all feedback from Mike and Michal (thanks!)
- Compressed some lines to make full use of 80 chars.
- Added details regarding 64bit/supported archs to the introduction.
- Added KASAN to the list of sizing considerations.


David Hildenbrand (2):
  memory-hotplug.rst: remove locking details from admin-guide
  memory-hotplug.rst: complete admin-guide overhaul

 .../admin-guide/mm/memory-hotplug.rst         | 800 ++++++++++--------
 1 file changed, 455 insertions(+), 345 deletions(-)


base-commit: 77d34a4683b053108ecd466cc7c4193b45805528
-- 
2.31.1

