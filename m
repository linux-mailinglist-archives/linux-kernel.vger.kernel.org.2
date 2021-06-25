Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F8E3B39D5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 01:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhFXXtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 19:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232903AbhFXXs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 19:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624578399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bl9881E5iqPq37Z6X5bKMAB1SU1ciCHAnLiuEXiOTY4=;
        b=cyMobv22D6f5rzXl+kYU+BpNrvdLUEKB6gWldEr3mgIG/4inz9T/R9/9Vj30K6c+zE4Wxd
        jPOlNSph/2OfCo/OzLO1NuSrbGnZzfOK8OKjXZ2ErDmxNkyDuThie05+yK4OL7+0N1Qn/N
        oc5yMyVRvlSs4/D0+5qdVGII8CDluIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-fABV1JA3OOqePA-Z2swUcA-1; Thu, 24 Jun 2021 19:46:35 -0400
X-MC-Unique: fABV1JA3OOqePA-Z2swUcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D0A3804141;
        Thu, 24 Jun 2021 23:46:34 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2788960871;
        Thu, 24 Jun 2021 23:46:23 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        david@redhat.com, mst@redhat.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v4 0/4] mm/page_reporting: Make page reporting work on arm64 with 64KB page size
Date:   Fri, 25 Jun 2021 09:47:06 +0800
Message-Id: <20210625014710.42954-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

   PATCH[1/4] Fix some coding style in __page_reporting_request().
   PATCH[2/4] Represents page reporting order with variable so that it can
              be exported as module parameter.
   PATCH[3/4] Allows the device driver (e.g. virtio_balloon) to specify
              the page reporting order when the device info is registered.
   PATCH[4/4] Specifies the page reporting order to 5, corresponding to
              2MB in size on ARM64 when 64KB base page size is used.

Changelog
=========
v4:
   * Set @page_reporting_order to MAX_ORDER. Its value is
     specified by the driver or falls back to @pageblock_order
     when page reporting device is registered.                    (Alex)
   * Include "module.h" in page_reporting.c                       (Andrew)
v3:
   * Avoid overhead introduced by function all                    (Alex)
   * Export page reporting order as module parameter              (Gavin)
v2:
   * Rewrite the patches as Alex suggested                        (Alex)

Gavin Shan (4):
  mm/page_reporting: Fix code style in __page_reporting_request()
  mm/page_reporting: Export reporting order as module parameter
  mm/page_reporting: Allow driver to specify reporting order
  virtio_balloon: Specify page reporting order if needed

 .../admin-guide/kernel-parameters.txt         |  6 ++++++
 drivers/virtio/virtio_balloon.c               | 17 +++++++++++++++++
 include/linux/page_reporting.h                |  3 +++
 mm/page_reporting.c                           | 19 +++++++++++++++----
 mm/page_reporting.h                           |  5 ++---
 5 files changed, 43 insertions(+), 7 deletions(-)

-- 
2.23.0

