Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA593AFCBF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 07:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhFVFvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 01:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhFVFvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 01:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624340929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xxLPkIPUcsKXQ9diXtN8yoW1MRfwqf/tH+VKrSqwwVo=;
        b=CbJtkIpVJRuvbNXW3/WRKEQGeCUDbgZl4vb3D6V8mg7081qFwGxVLChYM91Aq2ot35Nw3S
        C6rsMDforI5He+gA9vhBViI2Vx5Gf5l14yRMnf0NRQE9DrBNMr6jAKZp4UQ1atWe2CPCX8
        l4jsXA2rkML5HgmTT4IQlr6+TWyP1DQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-EmFo63mAMSiy1E8A1NaIAw-1; Tue, 22 Jun 2021 01:48:44 -0400
X-MC-Unique: EmFo63mAMSiy1E8A1NaIAw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 393BD1005E4C;
        Tue, 22 Jun 2021 05:48:43 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FBD15D9DE;
        Tue, 22 Jun 2021 05:48:32 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        david@redhat.com, mst@redhat.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 0/3] mm/page_reporting: Make page reporting work on arm64 with 64KB page size
Date:   Tue, 22 Jun 2021 15:49:23 +0800
Message-Id: <20210622074926.333223-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

   PATCH[1/3] Fix some coding style in __page_reporting_request().
   PATCH[2/3] Allows the device driver (e.g. virtio_balloon) to specify
              the page reporting order when the device info is registered.
   PATCH[3/3] Specifies the page reporting order to 5, corresponding to
              2MB in size on ARM64 when 64KB base page size is used.

Changelog
=========
v2:
   * Rewrite the patches to let device driver specify the page reporting
     order.                                                    (Alex)

Gavin Shan (3):
  mm/page_reporting: Fix code style in __page_reporting_request()
  mm/page_reporting: Allow driver to specify threshold
  virtio_balloon: Specify page reporting order if needed

 drivers/virtio/virtio_balloon.c | 17 +++++++++++++++++
 include/linux/page_reporting.h  |  3 +++
 mm/page_reporting.c             | 18 ++++++++++++------
 mm/page_reporting.h             | 10 ++--------
 4 files changed, 34 insertions(+), 14 deletions(-)

-- 
2.23.0

