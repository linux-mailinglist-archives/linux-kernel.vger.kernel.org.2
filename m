Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E861330583C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhA0KWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:22:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235776AbhA0KT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611742705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=No5FubTAWDBcMhAWtS3VeHEUbSxgS4aJN3+PeklSkVg=;
        b=Qvc9XTMkA4fyzOaLhinUnPxUaBlv29X0lY/CnwdeKxSiS+t+UCoSUm1w6juPdfwfnB/fG+
        IxUhoXA5NIZpW5Ak0NjnjEFaJ2P0ZPCVv1qEhHTGXdN56RQeqzpbkInasYqylOwzgkzJfD
        pi4XQSEhAhk3kYzm2CqEW7OD2Nw7yjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-mw2KyrrNPjO04-FM_U2OCg-1; Wed, 27 Jan 2021 05:18:21 -0500
X-MC-Unique: mw2KyrrNPjO04-FM_U2OCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B38C801AAB;
        Wed, 27 Jan 2021 10:18:19 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A4236EF55;
        Wed, 27 Jan 2021 10:18:14 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 0/2] mm/cma: better error handling and count pages per zone
Date:   Wed, 27 Jan 2021 11:18:11 +0100
Message-Id: <20210127101813.6370-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two improvements for CMA:
1. When activation of a CMA area fails, hand back all pages to the buddy
2. Count CMA pages per zone and print them in /proc/zoneinfo

David Hildenbrand (2):
  mm/cma: expose all pages to the buddy if activation of an area fails
  mm/page_alloc: count CMA pages per zone and print them in
    /proc/zoneinfo

 include/linux/mmzone.h |  4 ++++
 mm/cma.c               | 43 +++++++++++++++++++++---------------------
 mm/page_alloc.c        |  1 +
 mm/vmstat.c            |  6 ++++--
 4 files changed, 30 insertions(+), 24 deletions(-)

-- 
2.29.2

