Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE944288A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhJKIX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235057AbhJKIXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633940469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sW0c/i55Fq/6yP7efJE25J35ulCCGirElLMMcE6B1RM=;
        b=JjeViFQHJx5Ip706ru4o77hRFeE6b8vFzoTsH3CLgluuMqlb6p9g8t5owNmT7gfynADPGe
        aUv0zQEIHZBq1QpjAHKo4khvCpz6C7eXUebbNMN/K5/wTSJdBA3ivDmXh38pOMOo0kTxUr
        z5LGqHvSDyX81wtb5jl5axVXcpp6s9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-LTi1WtWpNJeuc-CurDKgZg-1; Mon, 11 Oct 2021 04:21:06 -0400
X-MC-Unique: LTi1WtWpNJeuc-CurDKgZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5926100B702;
        Mon, 11 Oct 2021 08:21:04 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27BAC5C232;
        Mon, 11 Oct 2021 08:20:59 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 0/3] memory-hotplug.rst: document the "auto-movable" online policy
Date:   Mon, 11 Oct 2021 10:20:55 +0200
Message-Id: <20211011082058.6076-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As promised, now that the memory-hotplug.rst overhaul is upstream, proper
documentation for the "auto-movable" online policy, documenting all new
toggles and options. Along, two fixes for the original overhaul.

v1 -> v2:
- "memory-hotplug.rst: document the "auto-movable" online policy"
-- Add a pointer to generic command line parameter documentation
-- Explain relationship of "auto-movable" and "movable_node" command
   line parameter, also indicating in which setups "auto-movable" doesn't
   really make sense.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-mm@kvack.org

David Hildenbrand (3):
  memory-hotplug.rst: fix two instances of "movablecore" that should be
    "movable_node"
  memory-hotplug.rst: fix wrong /sys/module/memory_hotplug/parameters/
    path
  memory-hotplug.rst: document the "auto-movable" online policy

 .../admin-guide/mm/memory-hotplug.rst         | 143 +++++++++++++++---
 1 file changed, 122 insertions(+), 21 deletions(-)


base-commit: 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc
-- 
2.31.1

