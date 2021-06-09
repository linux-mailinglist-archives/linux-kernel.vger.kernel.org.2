Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044993A0E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbhFIIAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235417AbhFIIAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623225486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nlX5Q+2DzD0tH8iiIBHTsugJFJXGJze9zF4zU747aOQ=;
        b=NF53BojjB3K38rkBNelu+Hr2zDCt64JM97x//zhR226N7fQ60rooZWLWncGzYRKBqJSaZY
        N+J5jfdLMKEj+10qZbthhM9YqP/0wYbo05pDWlAq+7yxmLQSUsKoavQdBqfh1zM2+z5x5T
        QxG5kYoDsYxU/rqa1y2Wr1GENCxH9i0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-zAiDhkZfPO2stKepXVe3sA-1; Wed, 09 Jun 2021 03:58:02 -0400
X-MC-Unique: zAiDhkZfPO2stKepXVe3sA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2A67802575;
        Wed,  9 Jun 2021 07:57:59 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-217.ams2.redhat.com [10.36.114.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 009A019C45;
        Wed,  9 Jun 2021 07:57:52 +0000 (UTC)
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
Subject: [PATCH v3 0/2] memory-hotplug.rst: complete admin-guide overhaul
Date:   Wed,  9 Jun 2021 09:57:50 +0200
Message-Id: <20210609075752.4596-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v3 of the memory hot(un)plug admin-guide overhaul.

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

-- 
2.31.1

