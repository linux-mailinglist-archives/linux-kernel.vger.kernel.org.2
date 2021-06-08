Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CBB39F7F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhFHNlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232771AbhFHNlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623159547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YPEs2BmRjgx9g9QFJpd6q3Ix4xUqzYCzviDHIJ0QF+M=;
        b=h1zN0g/bk9Yw78sFtVF9EMrza7eh8FhXdeq9JTBO7XIDuIHo84rF4katPXiwFCkON8kSnS
        PZQL4YgvzxE6IrMnJQQZM7grCSKMnF8HvTfE1lPWqrgB268DwZMSd/+zYC4NHDJPoXq9fX
        9SOtZqFA8iFWPmkUgagCzUv8GF+9bOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-PN8ax6qCOA2b1bLIGTmxWg-1; Tue, 08 Jun 2021 09:39:06 -0400
X-MC-Unique: PN8ax6qCOA2b1bLIGTmxWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80CFB101F7D7;
        Tue,  8 Jun 2021 13:39:04 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-132.ams2.redhat.com [10.36.115.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C862019C66;
        Tue,  8 Jun 2021 13:38:56 +0000 (UTC)
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
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 0/2] memory-hotplug.rst: complete admin-guide overhaul
Date:   Tue,  8 Jun 2021 15:38:53 +0200
Message-Id: <20210608133855.20397-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of the memory hot(un)plug admin-guide overhaul.

v1 -> v2:
- Added "memory-hotplug.rst: remove locking details from admin-guide"
- Incorporated all feedback from Mike and Michal (thanks!)
- Compressed some lines to make full use of 80 chars.
- Added details regarding 64bit/supported archs to the introduction.
- Added KASAN to the list of sizing considerations.

David Hildenbrand (2):
  memory-hotplug.rst: remove locking details from admin-guide
  memory-hotplug.rst: complete admin-guide overhaul

 .../admin-guide/mm/memory-hotplug.rst         | 793 ++++++++++--------
 1 file changed, 448 insertions(+), 345 deletions(-)

-- 
2.31.1

