Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCD741F581
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355879AbhJATMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 15:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355653AbhJATMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 15:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633115417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=pz0wmXCAvE18wwAJ1895fO0ypCJsx+A6451tOW6KYDw=;
        b=cF/0OLIplnztAU4uFt/zLvBt6ORpm1D9Ym/3DU1iYUq4aLcz8KCM8LdS0D0YlO0I9OoikG
        1z1mahKVCIf3dDv0XE9zxwnxSCSsPR8GDSLZdW0aCqDK2iZZRyLf+iV7h0XDCPDNVjsz1J
        DR2Tf59DsXUyWe/SY35J2tafDXtiy6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-QGudS05OPlKGxLcJjEBuEw-1; Fri, 01 Oct 2021 15:10:14 -0400
X-MC-Unique: QGudS05OPlKGxLcJjEBuEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EB6F107B0F3;
        Fri,  1 Oct 2021 19:10:12 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B8DE652A4;
        Fri,  1 Oct 2021 19:10:04 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/3] mm, memcg: Miscellaneous cleanups
Date:   Fri,  1 Oct 2021 15:09:35 -0400
Message-Id: <20211001190938.14050-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains a number of miscellaneous cleanup for memcg. It
is based on the next-20211001 branch.

Waiman Long (3):
  mm, memcg: Don't put offlined memcg into local stock
  mm, memcg: Remove obsolete memcg_free_kmem()
  mm, memcg: Ensure valid memcg from objcg within a RCU critical section

 mm/memcontrol.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

-- 
2.18.1

