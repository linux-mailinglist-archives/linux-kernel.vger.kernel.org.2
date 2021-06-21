Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700103AE1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 05:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFUDNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 23:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229877AbhFUDNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 23:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624245084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=i27wgNcN3kQte2V8oJS17CMizgvdFEAQpqjhBT32l/w=;
        b=YtpzskQPHwoNmOF53Oxc4kDnLtQEesqsTTTWdhuWXpuXcMaa8ZKLJ3F8Gu3DmoS/KhzVsm
        GPTHNx9CNoW8342SrcSE+aFv6EQyTg3WgmsToN+C3l7eVM7MlMugtW0P1mXqkKanunjIXd
        61TDrDZEPbjLtMzzXruOeG+y/bH0VgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-HHjuNSRUNsuQQwdiEylpHA-1; Sun, 20 Jun 2021 23:11:23 -0400
X-MC-Unique: HHjuNSRUNsuQQwdiEylpHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 729CE100B3B2;
        Mon, 21 Jun 2021 03:11:21 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE1CA60C9D;
        Mon, 21 Jun 2021 03:11:14 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        akpm@linux-foundation.org, david@redhat.com,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH 0/3] mm/page_reporting: Make page reporting work on arm64 with 64KB page size
Date:   Mon, 21 Jun 2021 13:11:49 +0800
Message-Id: <20210621051152.305224-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page reporting threshold is currently equal to @pageblock_order, which
is 13 and 512MB on arm64 with 64KB base page size selected. The page
reporting won't be triggered if the freeing page can't come up with a free
area like that huge. The condition is hard to be met, especially when the
system memory becomes fragmented.

This series intends to solve the issue by having page reporting threshold
as 5 (2MB) on arm64 with 64KB base page size. The patches are organized as:

   PATCH[1/3] introduces variable (@page_reporting_order) to replace original
              macro (PAGE_REPORTING_MIN_ORDER). It's also exported so that it
              can be adjusted at runtime.
   PATCH[2/3] renames PAGE_REPORTING_MIN_ORDER with PAGE_REPORTING_ORDER and
              allows architecture to specify its own version.
   PATCH[3/3] defines PAGE_REPORTING_ORDER to 5, corresponding to 2MB in size,
              on arm64 when 64KB base page size is selected. It's still same
              as to @pageblock_order for other architectures and cases.

Gavin Shan (3):
  mm/page_reporting: Allow to set reporting order
  mm/page_reporting: Allow architecture to select reporting order
  arm64: mm: Specify smaller page reporting order

 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 arch/arm64/include/asm/page.h                   | 13 +++++++++++++
 mm/page_reporting.c                             |  8 ++++++--
 mm/page_reporting.h                             | 10 +++++++---
 4 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.23.0

